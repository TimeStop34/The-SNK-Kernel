#include "paging.h"
#include "../../simple_operations.h"
#include "../../../libs/asm/asm.h"

page_directory_entry_t* current_space;

void invalidate_TLB(){
    __asm__ __volatile__("movl %%cr3,%%eax\n\tmovl %%eax,%%cr3": : :"ax");
}

void initialize_current_space_from_cr3() {
    void* pde_addr = (void*) get_cr3();
    current_space = pde_addr;
}

void disable_init_identity_mapping(){
    current_space[0] = (page_directory_entry_t) {0}; 

    invalidate_directory_TLB(0x0);
}

void paging_init() {
    IDT_reg_handler(0x0E, 0x08, 0x8E, asm_page_fault_handler);

    initialize_current_space_from_cr3(); // Получаем уже заполненую PDE(Ту самую, в которой есть Higher Half Kernel и Identity Mapping 1-4МБ)

    invalidate_TLB(); // Повторная полная инвалидация TLB для защиты 
}

/* =================================== API =================================== */

// 1. Создание новой page directory
page_directory_entry_t* paging_create_directory() {
    // Выделяем фрейм для новой directory
    void* directory_frame = pmm_alloc_frame();
    if (!directory_frame) return NULL;
    
    page_directory_entry_t* new_directory = (page_directory_entry_t*)((uint32_t)directory_frame + 0xC0000000);
    
    // Очищаем directory
    memset(new_directory, 0, 1024 * sizeof(page_directory_entry_t));
    
    // Клонируем kernel mappings (последние 256 записей для higher half)
    for (int i = 768; i < 1024; i++) {
        new_directory[i] = current_space[i];
    }
    
    return new_directory;
}

// 2. Установка текущей page directory
void paging_switch_directory(page_directory_entry_t* directory) {
    uint32_t physical_addr = (uint32_t)directory - 0xC0000000; // Convert to physical
    set_cr3(physical_addr);
    current_space = directory;
}

// 3. Получение текущей page directory  
page_directory_entry_t* paging_get_current_directory() {
    return current_space;
}

// 4. Клонирование page directory (для создания адресного пространства процесса)
page_directory_entry_t* paging_clone_directory(page_directory_entry_t* src) {
    page_directory_entry_t* new_dir = paging_create_directory();
    if (!new_dir) return NULL;
    
    // Клонируем все пользовательские PDE (первые 768 записей)
    for (int i = 0; i < 768; i++) {
        if (src[i].present) {
            if (src[i].page_size) {
                // 4MB page - просто копируем PDE
                new_dir[i] = src[i];
            } else {
                // 4KB page - нужно клонировать всю таблицу страниц
                void* new_table_frame = pmm_alloc_frame();
                if (!new_table_frame) {
                    // TODO: cleanup allocated resources
                    return NULL;
                }
                
                page_table_entry_t* src_table = (page_table_entry_t*)((src[i].frame_addr << 12) + 0xC0000000);
                page_table_entry_t* dst_table = (page_table_entry_t*)((uint32_t)new_table_frame + 0xC0000000);
                
                // Копируем таблицу страниц
                memcpy(dst_table, src_table, 1024 * sizeof(page_table_entry_t));
                
                // Настраиваем PDE
                new_dir[i].frame_addr = (uint32_t)new_table_frame >> 12;
                new_dir[i].present = 1;
                new_dir[i].writable = src[i].writable;
                new_dir[i].user = src[i].user;
                new_dir[i].page_size = 0;
            }
        }
    }
    
    return new_dir;
}

// Вспомогательная функция для получения PTE
static page_table_entry_t* get_pte(page_directory_entry_t* directory, void* virtual_addr, bool create_if_missing, uint32_t flags) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t pde_index = vaddr >> 22;
    uint32_t pte_index = (vaddr >> 12) & 0x3FF;
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present) {
        if (!create_if_missing) {
            return NULL;
        }
        
        // Создаем новую таблицу страниц
        void* table_frame = pmm_alloc_frame();
        if (!table_frame) return NULL;
        
        // Инициализируем PDE
        pde->frame_addr = (uint32_t)table_frame >> 12;
        pde->present = 1;
        pde->writable = (flags & PAGING_WRITABLE) ? 1 : 0;
        pde->user = (flags & PAGING_USER) ? 1 : 0;
        pde->page_size = 0; // 4KB pages
        
        // Очищаем новую таблицу
        page_table_entry_t* table = (page_table_entry_t*)((uint32_t)table_frame + 0xC0000000);
        memset(table, 0, 1024 * sizeof(page_table_entry_t));
    }
    
    // Проверяем что это не large page
    if (pde->page_size) {
        return NULL; // Это 4MB страница, нельзя получить PTE
    }
    
    page_table_entry_t* table = (page_table_entry_t*)((pde->frame_addr << 12) + 0xC0000000);
    return &table[pte_index];
}

// 5. Отображение физической страницы на виртуальный адрес (4KB)
bool paging_map_page(page_directory_entry_t* directory, void* virtual_addr, void* physical_addr, uint32_t flags) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t paddr = (uint32_t)physical_addr;
    
    // Проверяем выравнивание
    if ((vaddr & 0xFFF) != 0 || (paddr & 0xFFF) != 0) {
        return false;
    }
    
    page_table_entry_t* pte = get_pte(directory, virtual_addr, true, flags);
    if (!pte) return false;
    
    // Настраиваем PTE
    pte->frame_addr = paddr >> 12;
    pte->present = 1;
    pte->writable = (flags & PAGING_WRITABLE) ? 1 : 0;
    pte->user = (flags & PAGING_USER) ? 1 : 0;
    pte->pwt = (flags & PAGING_PWT) ? 1 : 0;
    pte->pcd = (flags & PAGING_PCD) ? 1 : 0;
    pte->accessed = 0;
    pte->dirty = 0;
    pte->global = (flags & PAGING_GLOBAL) ? 1 : 0;
    
    // Инвалидируем TLB для этой страницы
    uint32_t pte_index = (vaddr >> 12) & 0x3FF;
    invalidate_table_TLB(pte_index);
    
    return true;
}

// 6. Отображение большого блока (4MB)
bool paging_map_large_page(page_directory_entry_t* directory, void* virtual_addr, void* physical_addr, uint32_t flags) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t paddr = (uint32_t)physical_addr;
    
    // Проверяем выравнивание на 4MB
    if ((vaddr & 0x3FFFFF) != 0 || (paddr & 0x3FFFFF) != 0) {
        return false;
    }
    
    uint32_t pde_index = vaddr >> 22;
    page_directory_entry_t* pde = &directory[pde_index];
    
    // Проверяем что запись не используется для таблицы страниц
    if (pde->present && !pde->page_size) {
        return false; // Уже используется для 4KB страниц
    }
    
    // Настраиваем PDE как large page
    pde->frame_addr = paddr >> 22;
    pde->present = 1;
    pde->writable = (flags & PAGING_WRITABLE) ? 1 : 0;
    pde->user = (flags & PAGING_USER) ? 1 : 0;
    pde->pwt = (flags & PAGING_PWT) ? 1 : 0;
    pde->pcd = (flags & PAGING_PCD) ? 1 : 0;
    pde->accessed = 0;
    pde->dirty = 1; // Для PDE dirty bit имеет другое значение
    pde->page_size = 1; // 4MB page
    pde->global = (flags & PAGING_GLOBAL) ? 1 : 0;
    
    // Инвалидируем TLB для этой директории
    invalidate_directory_TLB(pde_index);
    
    return true;
}

// 7. Разотображение страницы
bool paging_unmap_page(page_directory_entry_t* directory, void* virtual_addr) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t pde_index = vaddr >> 22;
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present) {
        return true; // Уже не отображена
    }
    
    if (pde->page_size) {
        // 4MB страница - очищаем PDE
        pde->present = 0;
        pde->frame_addr = 0;
        invalidate_directory_TLB(pde_index);
        return true;
    } else {
        // 4KB страница - очищаем PTE
        page_table_entry_t* pte = get_pte(directory, virtual_addr, false, 0);
        if (!pte || !pte->present) {
            return true; // Уже не отображена
        }
        
        pte->present = 0;
        pte->frame_addr = 0;
        
        // Инвалидируем TLB
        uint32_t pte_index = (vaddr >> 12) & 0x3FF;
        invalidate_table_TLB(pte_index);
        
        return true;
    }
}

// 8. Получение физического адреса по виртуальному
void* paging_get_physical_address(page_directory_entry_t* directory, void* virtual_addr) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t pde_index = vaddr >> 22;
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present) {
        return NULL;
    }
    
    if (pde->page_size) {
        // 4MB страница
        uint32_t physical_base = pde->frame_addr << 22;
        uint32_t offset = vaddr & 0x3FFFFF;
        return (void*)(physical_base + offset);
    } else {
        // 4KB страница
        page_table_entry_t* pte = get_pte(directory, virtual_addr, false, 0);
        if (!pte || !pte->present) {
            return NULL;
        }
        
        uint32_t physical_base = pte->frame_addr << 12;
        uint32_t offset = vaddr & 0xFFF;
        return (void*)(physical_base + offset);
    }
}

// 9. Проверка отображена ли страница
bool paging_is_mapped(page_directory_entry_t* directory, void* virtual_addr) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t pde_index = vaddr >> 22;
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present) {
        return false;
    }
    
    if (pde->page_size) {
        return true; // 4MB страница отображена
    } else {
        page_table_entry_t* pte = get_pte(directory, virtual_addr, false, 0);
        return (pte && pte->present);
    }
}

// 10. Установка флагов страницы
void paging_set_flags(page_directory_entry_t* directory, void* virtual_addr, uint32_t flags) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t pde_index = vaddr >> 22;
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present) {
        return; // Страница не отображена
    }
    
    if (pde->page_size) {
        // 4MB страница - работаем с PDE
        pde->writable = (flags & PAGING_WRITABLE) ? 1 : 0;
        pde->user = (flags & PAGING_USER) ? 1 : 0;
        pde->pwt = (flags & PAGING_PWT) ? 1 : 0;
        pde->pcd = (flags & PAGING_PCD) ? 1 : 0;
        pde->global = (flags & PAGING_GLOBAL) ? 1 : 0;
        
        invalidate_directory_TLB(pde_index);
    } else {
        // 4KB страница - работаем с PTE
        page_table_entry_t* pte = get_pte(directory, virtual_addr, false, 0);
        if (!pte || !pte->present) {
            return;
        }
        
        pte->writable = (flags & PAGING_WRITABLE) ? 1 : 0;
        pte->user = (flags & PAGING_USER) ? 1 : 0;
        pte->pwt = (flags & PAGING_PWT) ? 1 : 0;
        pte->pcd = (flags & PAGING_PCD) ? 1 : 0;
        pte->global = (flags & PAGING_GLOBAL) ? 1 : 0;
        
        uint32_t pte_index = (vaddr >> 12) & 0x3FF;
        invalidate_table_TLB(pte_index);
    }
}

// 11. Получение флагов страницы
uint32_t paging_get_flags(page_directory_entry_t* directory, void* virtual_addr) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t pde_index = vaddr >> 22;
    uint32_t flags = 0;
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present) {
        return 0; // Страница не отображена
    }
    
    if (pde->page_size) {
        // 4MB страница - читаем из PDE
        if (pde->present) flags |= PAGING_PRESENT;
        if (pde->writable) flags |= PAGING_WRITABLE;
        if (pde->user) flags |= PAGING_USER;
        if (pde->pwt) flags |= PAGING_PWT;
        if (pde->pcd) flags |= PAGING_PCD;
        if (pde->global) flags |= PAGING_GLOBAL;
    } else {
        // 4KB страница - читаем из PTE
        page_table_entry_t* pte = get_pte(directory, virtual_addr, false, 0);
        if (!pte || !pte->present) {
            return 0;
        }
        
        if (pte->present) flags |= PAGING_PRESENT;
        if (pte->writable) flags |= PAGING_WRITABLE;
        if (pte->user) flags |= PAGING_USER;
        if (pte->pwt) flags |= PAGING_PWT;
        if (pte->pcd) flags |= PAGING_PCD;
        if (pte->global) flags |= PAGING_GLOBAL;
    }
    
    return flags;
}

// 12. Изменение прав доступа
bool paging_set_permissions(page_directory_entry_t* directory, void* virtual_addr, bool writable, bool user) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t pde_index = vaddr >> 22;
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present) {
        return false; // Страница не отображена
    }
    
    if (pde->page_size) {
        // 4MB страница
        pde->writable = writable ? 1 : 0;
        pde->user = user ? 1 : 0;
        invalidate_directory_TLB(pde_index);
    } else {
        // 4KB страница
        page_table_entry_t* pte = get_pte(directory, virtual_addr, false, 0);
        if (!pte || !pte->present) {
            return false;
        }
        
        pte->writable = writable ? 1 : 0;
        pte->user = user ? 1 : 0;
        
        uint32_t pte_index = (vaddr >> 12) & 0x3FF;
        invalidate_table_TLB(pte_index);
    }
    
    return true;
}

// 13. Пометить страницу как глобальную
void paging_set_global(page_directory_entry_t* directory, void* virtual_addr, bool global) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t pde_index = vaddr >> 22;
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present) {
        return; // Страница не отображена
    }
    
    if (pde->page_size) {
        // 4MB страница
        pde->global = global ? 1 : 0;
        invalidate_directory_TLB(pde_index);
    } else {
        // 4KB страница
        page_table_entry_t* pte = get_pte(directory, virtual_addr, false, 0);
        if (!pte || !pte->present) {
            return;
        }
        
        pte->global = global ? 1 : 0;
        
        uint32_t pte_index = (vaddr >> 12) & 0x3FF;
        invalidate_table_TLB(pte_index);
    }
}

// 14. Дополнительная функция: Сброс флагов accessed и dirty
void paging_clear_access_flags(page_directory_entry_t* directory, void* virtual_addr) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t pde_index = vaddr >> 22;
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present) {
        return;
    }
    
    if (!pde->page_size) {
        // Только для 4KB страниц можно сбросить accessed/dirty
        page_table_entry_t* pte = get_pte(directory, virtual_addr, false, 0);
        if (pte && pte->present) {
            pte->accessed = 0;
            pte->dirty = 0;
            
            uint32_t pte_index = (vaddr >> 12) & 0x3FF;
            invalidate_table_TLB(pte_index);
        }
    }
    // Для 4MB страниц флаг dirty в PDE имеет другое значение и не сбрасывается
}

// 15. Создание новой page table
page_table_entry_t* paging_create_table() {
    // Выделяем фрейм для новой таблицы
    void* table_frame = pmm_alloc_frame();
    if (!table_frame) return NULL;
    
    // Получаем виртуальный адрес таблицы
    page_table_entry_t* new_table = (page_table_entry_t*)((uint32_t)table_frame + 0xC0000000);
    
    // Очищаем таблицу (все записи не present)
    memset(new_table, 0, 1024 * sizeof(page_table_entry_t));
    
    return new_table;
}

// 16. Получение entry из таблицы
page_table_entry_t* paging_get_table_entry(page_directory_entry_t* directory, uint32_t pde_index, uint32_t pte_index) {
    if (pde_index >= 1024 || pte_index >= 1024) {
        return NULL; // Проверка границ
    }
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present) {
        return NULL; // Таблица не существует
    }
    
    if (pde->page_size) {
        return NULL; // Это 4MB страница, нет таблицы
    }
    
    // Получаем указатель на таблицу
    page_table_entry_t* table = (page_table_entry_t*)((pde->frame_addr << 12) + 0xC0000000);
    
    return &table[pte_index];
}

// 17. Резервирование таблицы в directory
bool paging_allocate_table(page_directory_entry_t* directory, uint32_t pde_index, uint32_t flags) {
    if (pde_index >= 1024) {
        return false; // Проверка границ
    }
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (pde->present) {
        // Таблица уже существует
        if (pde->page_size) {
            return false; // Уже используется для 4MB страницы
        }
        return true; // Таблица уже существует
    }
    
    // Создаем новую таблицу
    page_table_entry_t* new_table = paging_create_table();
    if (!new_table) {
        return false;
    }
    
    // Настраиваем PDE
    uint32_t physical_table_addr = (uint32_t)new_table - 0xC0000000;
    pde->frame_addr = physical_table_addr >> 12;
    pde->present = 1;
    pde->writable = (flags & PAGING_WRITABLE) ? 1 : 0;
    pde->user = (flags & PAGING_USER) ? 1 : 0;
    pde->pwt = (flags & PAGING_PWT) ? 1 : 0;
    pde->pcd = (flags & PAGING_PCD) ? 1 : 0;
    pde->page_size = 0; // 4KB pages
    pde->global = (flags & PAGING_GLOBAL) ? 1 : 0;
    
    // Инвалидируем TLB для этой PDE
    invalidate_directory_TLB(pde_index);
    
    return true;
}

// 18. Дополнительная функция: Освобождение таблицы из directory
bool paging_free_table(page_directory_entry_t* directory, uint32_t pde_index) {
    if (pde_index >= 1024) {
        return false;
    }
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present || pde->page_size) {
        return false; // Нет таблицы или это 4MB страница
    }
    
    // Получаем физический адрес таблицы
    uint32_t physical_table_addr = pde->frame_addr << 12;
    
    // Очищаем PDE
    pde->present = 0;
    pde->frame_addr = 0;
    
    // Освобождаем фрейм таблицы
    pmm_free_frame((void*)physical_table_addr);
    
    // Инвалидируем TLB
    invalidate_directory_TLB(pde_index);
    
    return true;
}

// 19. Дополнительная функция: Получение PDE по индексу
page_directory_entry_t* paging_get_directory_entry(page_directory_entry_t* directory, uint32_t pde_index) {
    if (pde_index >= 1024) {
        return NULL;
    }
    return &directory[pde_index];
}

// 20. Дополнительная функция: Проверка существования таблицы
bool paging_table_exists(page_directory_entry_t* directory, uint32_t pde_index) {
    if (pde_index >= 1024) {
        return false;
    }
    
    page_directory_entry_t* pde = &directory[pde_index];
    return (pde->present && !pde->page_size);
}

// 21. Дополнительная функция: Получение всей таблицы по индексу PDE
page_table_entry_t* paging_get_table(page_directory_entry_t* directory, uint32_t pde_index) {
    if (pde_index >= 1024) {
        return NULL;
    }
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present || pde->page_size) {
        return NULL;
    }
    
    return (page_table_entry_t*)((pde->frame_addr << 12) + 0xC0000000);
}

// 22. Инициализация фреймов для page directory/table
void paging_initialize_frame(page_directory_entry_t* directory, uint32_t pde_index) {
    if (pde_index >= 1024) {
        return;
    }
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present || pde->page_size) {
        return; // Нет таблицы или это 4MB страница
    }
    
    // Получаем таблицу
    page_table_entry_t* table = (page_table_entry_t*)((pde->frame_addr << 12) + 0xC0000000);
    
    // Инициализируем все записи таблицы
    for (uint32_t i = 0; i < 1024; i++) {
        if (table[i].present) {
            // Сбрасываем флаги accessed и dirty
            table[i].accessed = 0;
            table[i].dirty = 0;
        }
    }
    
    // Инвалидируем TLB для всей этой таблицы
    invalidate_directory_TLB(pde_index);
}

// 23. Дамп информации о mapping
void paging_dump_mapping(page_directory_entry_t* directory, void* virtual_addr) {
    uint32_t vaddr = (uint32_t)virtual_addr;
    uint32_t pde_index = vaddr >> 22;
    uint32_t pte_index = (vaddr >> 12) & 0x3FF;
    uint32_t offset = vaddr & 0xFFF;
    
    kprintf("Mapping info for virtual address 0x%08X:\n", vaddr);
    kprintf("  PDE Index: %u (0x%03X)\n", pde_index, pde_index);
    kprintf("  PTE Index: %u (0x%03X)\n", pte_index, pte_index);
    kprintf("  Offset: 0x%03X\n", offset);
    
    page_directory_entry_t* pde = &directory[pde_index];
    
    if (!pde->present) {
        kprintf("  [NOT MAPPED] PDE not present\n");
        return;
    }
    
    if (pde->page_size) {
        // 4MB страница
        uint32_t physical_base = pde->frame_addr << 22;
        uint32_t physical_addr = physical_base + (vaddr & 0x3FFFFF);
        
        kprintf("  4MB Page Mapping:\n");
        kprintf("    Physical Address: 0x%08X\n", physical_addr);
        kprintf("    PDE Flags: P=%d, R/W=%d, U/S=%d, PWT=%d, PCD=%d, A=%d, D=%d, PS=%d, G=%d\n",
               pde->present, pde->writable, pde->user, pde->pwt, pde->pcd,
               pde->accessed, pde->dirty, pde->page_size, pde->global);
    } else {
        // 4KB страница
        page_table_entry_t* pte = paging_get_table_entry(directory, pde_index, pte_index);
        
        if (!pte || !pte->present) {
            kprintf("  [NOT MAPPED] PTE not present\n");
            return;
        }
        
        uint32_t physical_base = pte->frame_addr << 12;
        uint32_t physical_addr = physical_base + offset;
        
        kprintf("  4KB Page Mapping:\n");
        kprintf("    Physical Address: 0x%08X\n", physical_addr);
        kprintf("    PTE Flags: P=%d, R/W=%d, U/S=%d, PWT=%d, PCD=%d, A=%d, D=%d, PAT=%d, G=%d\n",
               pte->present, pte->writable, pte->user, pte->pwt, pte->pcd,
               pte->accessed, pte->dirty, pte->pat, pte->global);
    }
}

// 24. Проверка целостности структур
bool paging_validate_directory(page_directory_entry_t* directory) {
    if (!directory) {
        return false;
    }
    
    // Проверяем kernel mappings (должны быть present)
    for (int i = 768; i < 1024; i++) {
        page_directory_entry_t* pde = &directory[i];
        
        if (!pde->present) {
            kprintf("Paging Validation Error: Kernel PDE %d not present!\n", i);
            return false;
        }
        
        // Если это не large page, проверяем что таблица доступна
        if (!pde->page_size) {
            page_table_entry_t* table = (page_table_entry_t*)((pde->frame_addr << 12) + 0xC0000000);
            
            // Проверяем что таблица не NULL (базовая проверка)
            if (!table) {
                kprintf("Paging Validation Error: Kernel table %d is NULL!\n", i);
                return false;
            }
        }
    }
    
    // Проверяем пользовательские mappings на корректность
    for (int i = 0; i < 768; i++) {
        page_directory_entry_t* pde = &directory[i];
        
        if (pde->present) {
            // Проверяем что user bit установлен для пользовательских страниц
            if (!pde->user) {
                kprintf("Paging Validation Warning: User PDE %d has supervisor privileges\n", i);
            }
            
            // Если это не large page, проверяем таблицу
            if (!pde->page_size) {
                page_table_entry_t* table = (page_table_entry_t*)((pde->frame_addr << 12) + 0xC0000000);
                
                if (!table) {
                    kprintf("Paging Validation Error: User table %d is NULL!\n", i);
                    return false;
                }
                
                // Проверяем несколько случайных записей в таблице
                for (int j = 0; j < 1024; j += 128) { // Проверяем каждую 128-ю запись
                    if (table[j].present && !table[j].user) {
                        kprintf("Paging Validation Warning: User PTE %d:%d has supervisor privileges\n", i, j);
                    }
                }
            }
        }
    }
    
    return true;
}

// 25. Освобождение всех ресурсов directory
void paging_destroy_directory(page_directory_entry_t* directory) {
    if (!directory) {
        return;
    }
    
    // Освобождаем только пользовательские таблицы (первые 768 записей)
    for (uint32_t i = 0; i < 768; i++) {
        page_directory_entry_t* pde = &directory[i];
        
        if (pde->present && !pde->page_size) {
            // Освобождаем таблицу страниц
            uint32_t physical_table_addr = pde->frame_addr << 12;
            pmm_free_frame((void*)physical_table_addr);
            
            // Освобождаем все страницы, на которые ссылается таблица
            page_table_entry_t* table = (page_table_entry_t*)(physical_table_addr + 0xC0000000);
            for (uint32_t j = 0; j < 1024; j++) {
                if (table[j].present) {
                    uint32_t physical_page_addr = table[j].frame_addr << 12;
                    pmm_free_frame((void*)physical_page_addr);
                }
            }
        } else if (pde->present && pde->page_size) {
            // Освобождаем 4MB страницу
            uint32_t physical_page_addr = pde->frame_addr << 22;
            pmm_free_frame((void*)physical_page_addr);
        }
        
        // Очищаем PDE
        pde->present = 0;
        pde->frame_addr = 0;
    }
    
    // Инвалидируем TLB
    invalidate_TLB();
}

// 26. Дополнительная функция: Статистика по directory
void paging_print_stats(page_directory_entry_t* directory) { 
    if (!directory) {
        kprintf("Paging Stats: Invalid directory\n");
        return;
    }
    
    uint32_t user_tables = 0;
    uint32_t user_pages_4kb = 0;
    uint32_t user_pages_4mb = 0;
    uint32_t kernel_tables = 0;
    uint32_t kernel_pages_4kb = 0;
    uint32_t kernel_pages_4mb = 0;
    
    // Анализируем все PDE
    for (uint32_t i = 0; i < 1024; i++) {
        page_directory_entry_t* pde = &directory[i];
        
        if (pde->present) {
            if (i < 768) {
                // User space
                if (pde->page_size) {
                    user_pages_4mb++;
                } else {
                    user_tables++;
                    // Считаем страницы в таблице
                    page_table_entry_t* table = paging_get_table(directory, i);
                    if (table) {
                        for (uint32_t j = 0; j < 1024; j++) {
                            if (table[j].present) {
                                user_pages_4kb++;
                            }
                        }
                    }
                }
            } else {
                // Kernel space
                if (pde->page_size) {
                    kernel_pages_4mb++;
                } else {
                    kernel_tables++;
                    page_table_entry_t* table = paging_get_table(directory, i);
                    if (table) {
                        for (uint32_t j = 0; j < 1024; j++) {
                            if (table[j].present) {
                                kernel_pages_4kb++;
                            }
                        }
                    }
                }
            }
        }
    }
    
    kprintf("Paging Statistics:\n");
    kprintf("  User Space:\n");
    kprintf("    Tables: %u, 4KB Pages: %u, 4MB Pages: %u\n", 
           user_tables, user_pages_4kb, user_pages_4mb);
    kprintf("  Kernel Space:\n");
    kprintf("    Tables: %u, 4KB Pages: %u, 4MB Pages: %u\n", 
           kernel_tables, kernel_pages_4kb, kernel_pages_4mb);
    kprintf("  Total Memory: %u KB\n", 
           (user_pages_4kb + kernel_pages_4kb) * 4 + (user_pages_4mb + kernel_pages_4mb) * 4096);
}


//void page_fault_handler() {
    //kprintf("PAGE FAULT!");
//}