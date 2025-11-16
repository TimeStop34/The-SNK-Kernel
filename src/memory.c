// Структура блока памяти
struct mem_block {
    unsigned int size;
    unsigned int owner;  // 0 = свободно, 1 = ядро, >1 = ID процесса
    struct mem_block* next;
    unsigned char data[1];
};

// Глобальные переменные
static struct mem_block* heap_start = 0;
static unsigned char* memory_base = 0;
static unsigned int memory_total = 0;
static unsigned int memory_used = 0;
static unsigned int memory_free = 0;

// Статистика - динамический массив
static unsigned int* process_memory = 0;
static unsigned int max_processes = 0;

void memory_init(unsigned char* mmap, unsigned int total_size, unsigned int max_procs) {
    memory_base = mmap;
    memory_total = total_size;
    memory_used = 0;
    memory_free = total_size;
    heap_start = 0;
    max_processes = max_procs;
    
    // Инициализируем массив статистики процессов
    process_memory = (unsigned int*)mmap;
    unsigned int stats_size = max_processes * sizeof(unsigned int);
    
    // Обнуляем статистику
    for (unsigned int i = 0; i < max_processes; i++) {
        process_memory[i] = 0;
    }
    
    // Первый блок памяти начинается после массива статистики
    unsigned char* block_start = mmap + stats_size;
    unsigned int block_size = total_size - stats_size;
    
    if (block_size >= sizeof(struct mem_block)) {
        heap_start = (struct mem_block*)block_start;
        heap_start->size = block_size - sizeof(struct mem_block);
        heap_start->owner = 0;  // свободно
        heap_start->next = 0;
    }
}

// Вспомогательная функция для разделения блока
void split_block(struct mem_block* block, unsigned int needed_size) {
    unsigned int remaining = block->size - needed_size;
    if (remaining >= sizeof(struct mem_block) + 8) {  // минимальный полезный размер
        struct mem_block* new_block = (struct mem_block*)((unsigned char*)block + sizeof(struct mem_block) + needed_size);
        new_block->size = remaining - sizeof(struct mem_block);
        new_block->owner = 0;  // свободно
        new_block->next = block->next;
        block->next = new_block;
        block->size = needed_size;
    }
}

void* kmalloc(unsigned int size) {
    if (size == 0) return 0;
    
    // Ищем подходящий свободный блок
    struct mem_block* current = heap_start;
    struct mem_block* prev = 0;
    
    while (current != 0) {
        if (current->owner == 0 && current->size >= size) {
            // Нашли свободный блок
            split_block(current, size);
            current->owner = 1;  // ядро
            
            // Обновляем статистику
            memory_used += size + sizeof(struct mem_block);
            memory_free -= size + sizeof(struct mem_block);
            if (1 < max_processes) process_memory[1] += size;
            
            return current->data;
        }
        prev = current;
        current = current->next;
    }
    
    return 0;  // нет свободной памяти
}

void* ualloc(unsigned int size, unsigned int process) {
    if (size == 0 || process <= 1) return 0;  // process должен быть >1
    
    // Ищем подходящий свободный блок
    struct mem_block* current = heap_start;
    struct mem_block* prev = 0;
    
    while (current != 0) {
        if (current->owner == 0 && current->size >= size) {
            // Нашли свободный блок
            split_block(current, size);
            current->owner = process;
            
            // Обновляем статистику
            memory_used += size + sizeof(struct mem_block);
            memory_free -= size + sizeof(struct mem_block);
            if (process < max_processes) process_memory[process] += size;
            
            return current->data;
        }
        prev = current;
        current = current->next;
    }
    
    return 0;  // нет свободной памяти
}

void kfree(void* ptr) {
    if (ptr == 0) return;
    
    struct mem_block* block = (struct mem_block*)((unsigned char*)ptr - sizeof(struct mem_block));
    
    // Ядро может освобождать только свою память (owner = 1)
    if (block->owner == 1) {
        unsigned int size = block->size;
        block->owner = 0;  // помечаем как свободно
        
        // Обновляем статистику
        memory_used -= size + sizeof(struct mem_block);
        memory_free += size + sizeof(struct mem_block);
        if (1 < max_processes) process_memory[1] -= size;
        
        merge_free_blocks();
    }
}

void ufree(void* ptr) {
    if (ptr == 0) return;
    
    struct mem_block* block = (struct mem_block*)((unsigned char*)ptr - sizeof(struct mem_block));
    
    // Процессы могут освобождать только свою память (owner > 1)
    if (block->owner > 1) {
        unsigned int owner = block->owner;
        unsigned int size = block->size;
        block->owner = 0;  // помечаем как свободно
        
        // Обновляем статистику
        memory_used -= size + sizeof(struct mem_block);
        memory_free += size + sizeof(struct mem_block);
        if (owner < max_processes) process_memory[owner] -= size;
        
        merge_free_blocks();
    }
}

void merge_free_blocks() {
    struct mem_block* current = heap_start;
    
    while (current != 0 && current->next != 0) {
        // Проверяем, являются ли текущий и следующий блоки свободными и соседними
        if (current->owner == 0 && current->next->owner == 0) {
            // Проверяем, что блоки действительно соседние в памяти
            unsigned char* expected_next = (unsigned char*)current + sizeof(struct mem_block) + current->size;
            if ((unsigned char*)current->next == expected_next) {
                // Объединяем блоки
                current->size += sizeof(struct mem_block) + current->next->size;
                current->next = current->next->next;
                // Продолжаем проверять с этого же блока, так как он теперь больше
                continue;
            }
        }
        current = current->next;
    }
}

// Функции для получения статистики
unsigned int get_total_memory() { return memory_total; }
unsigned int get_used_memory() { return memory_used; }
unsigned int get_free_memory() { return memory_free; }
unsigned int get_kernel_memory() { return (1 < max_processes) ? process_memory[1] : 0; }
unsigned int get_process_memory(unsigned int process) { 
    return (process < max_processes) ? process_memory[process] : 0; 
}

void memory_defragment() {
    merge_free_blocks();
}

unsigned int get_free_block_count() {
    unsigned int count = 0;
    struct mem_block* current = heap_start;
    
    while (current != 0) {
        if (current->owner == 0) {
            count++;
        }
        current = current->next;
    }
    return count;
}

// Функция для получения размера самого большого свободного блока
unsigned int get_largest_free_block() {
    unsigned int largest = 0;
    struct mem_block* current = heap_start;
    
    while (current != 0) {
        if (current->owner == 0 && current->size > largest) {
            largest = current->size;
        }
        current = current->next;
    }
    return largest;
}

// Базовая структура элемента multiboot mmap
struct multiboot_mmap_entry {
    unsigned int size;
    unsigned long long addr;
    unsigned long long len;
    unsigned int type;
} __attribute__((packed));

// Функция преобразования MBI в массив mmap entries
struct multiboot_mmap_entry* make_mmap_array(unsigned int mbi_addr, unsigned int mbi_len, unsigned int* count) {
    struct multiboot_mmap_entry* entry = (struct multiboot_mmap_entry*)mbi_addr;
    unsigned int end = mbi_addr + mbi_len;
    unsigned int entry_count = 0;
    
    // Сначала считаем количество записей
    struct multiboot_mmap_entry* temp = entry;
    while ((unsigned int)temp < end) {
        entry_count++;
        temp = (struct multiboot_mmap_entry*)((unsigned int)temp + temp->size + 4);
    }
    
    // Создаем массив
    struct multiboot_mmap_entry* mmap_array = (struct multiboot_mmap_entry*)kmalloc(entry_count * sizeof(struct multiboot_mmap_entry));
    
    // Копируем записи
    for (unsigned int i = 0; i < entry_count; i++) {
        mmap_array[i] = *entry;
        entry = (struct multiboot_mmap_entry*)((unsigned int)entry + entry->size + 4);
    }
    
    *count = entry_count;
    return mmap_array;
}

#define MEMORY_MIN_ADDR  0x100000    // 1MB - минимальный адрес
#define MEMORY_MAX_ADDR  0xFFFFFFFF  // 4GB - максимальный адрес в 32-bit
#define MIN_BLOCK_SIZE   0x100000    // 1MB - минимальный размер блока

unsigned char* create_mmap_from_entries(struct multiboot_mmap_entry* entries, 
                                      unsigned int entry_count, 
                                      unsigned int* total_size) {
    unsigned long long largest_block = 0;
    unsigned char* best_block = 0;
    
    for (unsigned int i = 0; i < entry_count; i++) {
        // Проверяем что память доступна и находится в нужном диапазоне
        if (entries[i].type == 1) {  // AVAILABLE
            unsigned long long start_addr = entries[i].addr;
            unsigned long long end_addr = start_addr + entries[i].len;
            unsigned long long block_size = entries[i].len;
            
            // Обрезаем блок если он начинается ниже 1MB
            if (start_addr < MEMORY_MIN_ADDR) {
                unsigned long long new_start = MEMORY_MIN_ADDR;
                if (end_addr > new_start) {
                    block_size = end_addr - new_start;
                    start_addr = new_start;
                } else {
                    continue; // Весь блок ниже 1MB - пропускаем
                }
            }
            
            // Обрезаем блок если он выходит за 4GB
            if (end_addr > MEMORY_MAX_ADDR) {
                block_size = MEMORY_MAX_ADDR - start_addr;
            }
            
            // Проверяем что блок достаточно большой (хотя бы 1MB)
            if (block_size >= MIN_BLOCK_SIZE && block_size > largest_block) {
                largest_block = block_size;
                best_block = (unsigned char*)(unsigned long)start_addr;
            }
        }
    }
    
    if (largest_block == 0) {
        *total_size = 0;
        return 0;
    }
    
    // Ограничиваем размер 4GB (хотя это маловероятно для одного блока)
    unsigned int usable_size = (largest_block > 0xFFFFFFFF) ? 0xFFFFFFFF : (unsigned int)largest_block;
    
    *total_size = usable_size;
    return best_block;
}

// Более безопасная версия с дополнительными проверками
unsigned char* create_safe_mmap(struct multiboot_mmap_entry* entries,
                              unsigned int entry_count,
                              unsigned int* total_size) {
    unsigned long long best_size = 0;
    unsigned char* best_addr = 0;
    
    for (unsigned int i = 0; i < entry_count; i++) {
        unsigned long long start = entries[i].addr;
        unsigned long long end = start + entries[i].len;
        unsigned long long size = entries[i].len;
        
        
        if (entries[i].type != 1) continue; // Пропускаем недоступную память
        
        // Корректируем границы блока
        if (start < MEMORY_MIN_ADDR) {
            start = MEMORY_MIN_ADDR;
            size = end - start;
            if (size <= 0) continue;
        }
        
        if (end > MEMORY_MAX_ADDR) {
            end = MEMORY_MAX_ADDR;
            size = end - start;
            if (size <= 0) continue;
        }
        
        // Ищем самый большой блок не менее 1MB
        if (size >= MIN_BLOCK_SIZE && size > best_size) {
            best_size = size;
            best_addr = (unsigned char*)(unsigned long)start;
        }
    }
    
    if (best_size > 0) {
        *total_size = (best_size > 0xFFFFFFFF) ? 0xFFFFFFFF : (unsigned int)best_size;
        return best_addr;
    }
    
    *total_size = 0;
    return 0;
}

// Использование:
void init_memory_system(struct multiboot_mmap_entry* mmap_entries, 
                       unsigned int mmap_count) {
    unsigned int total_size;
    unsigned char* memory_base;
    
    memory_base = create_safe_mmap(mmap_entries, mmap_count, &total_size);
    
    if (memory_base && total_size > 0) {
        memory_init(memory_base, total_size, 256);
    } else {
        // Критическая ошибка - нет подходящей памяти
    }
}

void* memcpy(void* dest, const void* src, unsigned int n) {
    char* d = dest;
    const char* s = src;
    
    while (n--) {
        *d++ = *s++;
    }
    
    return dest;
}