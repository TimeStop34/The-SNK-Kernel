#include "pmm.h"
#include "../../libs/io/io.h"

pmm_state_t pmm_state;

extern uint8_t __kernel_end[];

/*
    Инициализация Physical Memory Manager (Сокращенно - PMM)
*/
void pmm_init(multiboot_info_t* mb_info) {
    
    // 1. Получаем размер памяти
    uint32_t memory_size = get_memory_size(mb_info);
    pmm_state.total_memory = memory_size;
    pmm_state.total_frames = memory_size / PAGE_SIZE;
    pmm_state.used_frames = 0;
    
    // 2. Вычисляем размер битовой карты
    pmm_state.bitmap_size = (pmm_state.total_frames + 31) / 32;
    uint32_t bitmap_bytes = pmm_state.bitmap_size * 4;

    
    // 3. Находим место для битовой карты
    uintptr_t bitmap_addr = find_free_memory_region(mb_info, bitmap_bytes);
    pmm_state.bitmap = (uint32_t*)bitmap_addr;
    pmm_state.bitmap_physical = bitmap_addr;
    
    // 4. Инициализируем spinlock
    spinlock_init(&pmm_state.lock);
    
    // 5. Изначально помечаем ВСЮ память как занятую
    memset(pmm_state.bitmap, 0xFF, bitmap_bytes);
    pmm_state.used_frames = pmm_state.total_frames;
    
    // 6. Парсим карту памяти и освобождаем доступные регионы
    pmm_parse_memory_map(mb_info);
    
    // 7. Помечаем саму битовую карту как занятую!
    pmm_mark_region_as_used(bitmap_addr, bitmap_bytes);
    
    // 8. Выводим итоговую статистику
    pmm_stats_t stats;
    pmm_get_stats(&stats);
}

/*
    Узнаем размер памяти из multiboot memory-map
*/
uint32_t get_memory_size(multiboot_info_t* mb_info) {
    // Проверяем что multiboot предоставил информацию о памяти
    if (!(mb_info->flags & 0x01)) {
        kpanic("Multiboot doesn't provide memory information!");
    }
    
    // Вычисляем общий размер памяти
    // mem_lower - память до 1МБ (0-640КБ обычно)
    // mem_upper - память после 1МБ 
    uint32_t total_memory = (mb_info->mem_lower + mb_info->mem_upper + 1024) * 1024;

    return total_memory;
}

/*
    Находим свободный регион, 
        который будет достаточен
            для помещения туда данных размером с size
*/
uintptr_t find_free_memory_region(multiboot_info_t* mb_info, uint32_t size) {
    /*
    Алгоритм поиска:
    1. Проходим по карте памяти от загрузчика
    2. Ищем регионы с типом "available" (доступная RAM)
    3. Внутри доступных регионов ищем достаточно большой непрерывный блок
    4. Предпочтительно размещать после ядра, но до всяких драйверов/данных
    */
    
    if (!(mb_info->flags & 0x40)) {
        kpanic("No memory map available for region finding!");
    }
    
    multiboot_memory_map_t* mmap = (multiboot_memory_map_t*)mb_info->mmap_addr;
    uintptr_t best_candidate = 0;
    uint32_t best_size = 0;
    
    while ((uintptr_t)mmap < mb_info->mmap_addr + mb_info->mmap_length) {
        // Нас интересуют только регионы доступной памяти
        if (mmap->type == MULTIBOOT_MEMORY_AVAILABLE) {
            uintptr_t region_start = (uintptr_t)mmap->addr;
            uintptr_t region_end = region_start + (uintptr_t)mmap->len;
            uint32_t region_size = (uint32_t)mmap->len;
            
            // Проверяем что регион достаточно большой
            if (region_size >= size) {
                // Ищем конкретное место внутри региона
                
                // Стратегия 1: После конца ядра (предпочтительно)
                // Обычно ядро загружается вокруг 1МБ отметки
                uintptr_t kernel_end = (uintptr_t)__kernel_end; // Функция которую мы реализуем
                uintptr_t candidate = ALIGN_UP(kernel_end, PAGE_SIZE);
                
                // Проверяем что candidate внутри этого региона
                // и есть достаточно места от candidate до конца региона
                if (candidate >= region_start && 
                    (candidate + size) <= region_end) {
                    return candidate;
                }
                
                // Стратегия 2: Просто начало региона (выровненное)
                candidate = ALIGN_UP(region_start, PAGE_SIZE);
                if ((candidate + size) <= region_end) {
                    // Запоминаем лучшего кандидата (самый низкий адрес)
                    if (best_candidate == 0 || candidate < best_candidate) {
                        best_candidate = candidate;
                        best_size = region_size;
                    }
                }
            }
        }
        
        // Следующая запись
        mmap = (multiboot_memory_map_t*)((uintptr_t)mmap + mmap->size + sizeof(mmap->size));
    }
    
    if (best_candidate != 0) {
        return best_candidate;
    }
    
    return 0;
}

/*
    Преобразуем multiboot memory-map в bitmap-регионную map памяти(которую будем контролировать уже мы)
*/
void pmm_parse_memory_map(multiboot_info_t* mb_info) {
    
    if (!(mb_info->flags & 0x40)) {
        kpanic("PMM: No memory map provided by bootloader!");
    }

    
    uint32_t total_available_memory = 0;
    uint32_t region_count = 0;
    uint32_t available_region_count = 0;
    
    multiboot_memory_map_t* mmap = (multiboot_memory_map_t*)mb_info->mmap_addr;

    
    while ((uintptr_t)mmap < mb_info->mmap_addr + mb_info->mmap_length) {
        
        
        if (mmap->type == 1) {
            pmm_mark_region_as_free((uintptr_t)mmap->addr, (uint32_t)mmap->len);
            total_available_memory += (uint32_t)mmap->len;
            available_region_count++;
        }
        
        
        region_count++;
        mmap = (multiboot_memory_map_t*)((uintptr_t)mmap + mmap->size + sizeof(mmap->size));
        
    }
    
    
    if (total_available_memory == 0) {
        kpanic("Bootloader or System is not provided memory");
    }
}

/*
    Помечает регион физической памяти как свободный в битовой карте PMM
*/
void pmm_mark_region_as_free(uintptr_t base, uint32_t length) {
    if (length == 0) return;
    
    // Вычисляем начальный и конечный фреймы
    uint32_t start_frame = base / PAGE_SIZE;
    uint32_t end_frame = (base + length + PAGE_SIZE - 1) / PAGE_SIZE;
    
    uint32_t frames_freed = 0;
    
    for (uint32_t frame = start_frame; frame < end_frame; frame++) {
        if (frame >= pmm_state.total_frames) break;
        
        if (!pmm_is_frame_free(frame)) {
            pmm_set_frame_free(frame);
            frames_freed++;
        }
    }  
}

/* 
    Помечает регион физической памяти как занятый в битовой карте PMM
    Используется для: ядра, битовой карты PMM, зарезервированных областей
*/
void pmm_mark_region_as_used(uintptr_t base, uint32_t length) {
    if (length == 0) return;
    
    spinlock_lock(&pmm_state.lock);
    
    // Вычисляем начальный и конечный фреймы
    uint32_t start_frame = base / PAGE_SIZE;
    uint32_t end_frame = (base + length + PAGE_SIZE - 1) / PAGE_SIZE;
    
    // Ограничиваем диапазон общим количеством фреймов
    if (start_frame >= pmm_state.total_frames) {
        spinlock_unlock(&pmm_state.lock);
        return;
    }
    
    if (end_frame > pmm_state.total_frames) {
        end_frame = pmm_state.total_frames;
    }
    
    
    uint32_t frames_used = 0;
    
    // Помечаем все фреймы в регионе как занятые
    for (uint32_t frame = start_frame; frame < end_frame; frame++) {
        if (pmm_is_frame_free(frame)) {
            pmm_set_frame_used(frame);
            frames_used++;
        }
    }
    
    spinlock_unlock(&pmm_state.lock);
}

/*
    Пометить фрейм как занятый
*/ 
static void pmm_set_frame_used(uint32_t frame) {
    if (frame >= pmm_state.total_frames) return;
    uint32_t word = frame / 32;
    uint32_t bit = frame % 32;
    pmm_state.bitmap[word] |= (1 << bit);
    pmm_state.used_frames++;
}

/*
    Пометить фрейм как свободный  
*/ 
static void pmm_set_frame_free(uint32_t frame) {
    if (frame >= pmm_state.total_frames) return;
    uint32_t word = frame / 32;
    uint32_t bit = frame % 32;
    pmm_state.bitmap[word] &= ~(1 << bit);
    pmm_state.used_frames--;
}

/*
    Проверяет, доступен ли frame или нет
*/
static bool pmm_is_frame_free(uint32_t frame) {
    if (frame >= pmm_state.total_frames) return false;
    uint32_t word = frame / 32;
    uint32_t bit = frame % 32;
    return !(pmm_state.bitmap[word] & (1 << bit));
}


/* ====================== API ====================== */
/*
    Выделить один фрейм (4КБ) 
*/
uintptr_t pmm_alloc_frame(void) {
    spinlock_lock(&pmm_state.lock);
    
    static uint32_t last_alloc = 256; // Кэш последнего найденного
    
    // Поиск от последнего найденного
    for(uint32_t i = last_alloc; i < pmm_state.total_frames; i++) {
        if(pmm_is_frame_free(i)) {
            pmm_set_frame_used(i);
            last_alloc = i + 1;
            spinlock_unlock(&pmm_state.lock);
            return i * PAGE_SIZE;
        }
    }
    
    // Если не нашли - поиск с начала
    for(uint32_t i = 256; i < last_alloc; i++) {
        if(pmm_is_frame_free(i)) {
            pmm_set_frame_used(i);
            last_alloc = i + 1;
            spinlock_unlock(&pmm_state.lock);
            return i * PAGE_SIZE;
        }
    }
    
    spinlock_unlock(&pmm_state.lock);
    return 0; // Out of memory
}

/*
    Освободить фрейм
*/ 
void pmm_free_frame(uintptr_t frame) {
    if(frame == 0) return;
    
    spinlock_lock(&pmm_state.lock);
    
    uint32_t frame_num = frame / PAGE_SIZE;
    
    if(frame_num >= pmm_state.total_frames) {
        spinlock_unlock(&pmm_state.lock);
        return;
    }
    
    pmm_set_frame_free(frame_num);
    
    spinlock_unlock(&pmm_state.lock);
    
}

/*
    Выделить несколько рядом стоящих(смежных) фреймов
*/
uintptr_t pmm_alloc_frames(uint32_t count) {
    if (count == 0) return 0;
    if (count == 1) return pmm_alloc_frame();
    
    spinlock_lock(&pmm_state.lock);
    
    uint32_t consecutive = 0;
    uint32_t start_frame = 0;
    
    for(uint32_t i = 256; i < pmm_state.total_frames; i++) {
        if(pmm_is_frame_free(i)) {
            if (consecutive == 0) {
                start_frame = i;
            }
            consecutive++;
            
            if (consecutive == count) {
                for(uint32_t j = 0; j < count; j++) {
                    pmm_set_frame_used(start_frame + j);
                }
                
                uintptr_t physical_addr = start_frame * PAGE_SIZE;
                spinlock_unlock(&pmm_state.lock);
                return physical_addr;
            }
        } else {
            consecutive = 0;
        }
    }
    
    spinlock_unlock(&pmm_state.lock);
    return 0;
}

/*
    Получить статистику памяти
*/ 
void pmm_get_stats(pmm_stats_t* stats) {
    stats->total_frames = pmm_state.total_frames;
    stats->used_frames = pmm_state.used_frames;
    stats->free_frames = pmm_state.total_frames - pmm_state.used_frames;
    stats->total_memory = pmm_state.total_memory;
    stats->used_memory = pmm_state.used_frames * PAGE_SIZE;
    stats->free_memory = stats->free_frames * PAGE_SIZE;
}
