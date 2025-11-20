#pragma once
#include "../../../libs/types.h"
#include "../../../libs/io/io.h"
#include "../../../idt/IDT_PIC.h"
#include "../../simple_operations.h"
#include "../../pmm/pmm.h"

typedef struct pde {
    uint32_t frame_addr : 20;
    
    // Standard x86 flags
    uint32_t present    : 1;  // P - Page present in memory
    uint32_t writable   : 1;  // R/W - Read/Write permission
    uint32_t user       : 1;  // U/S - User/Supervisor
    uint32_t pwt        : 1;  // PWT - Write-Through caching
    uint32_t pcd        : 1;  // PCD - Cache disable
    uint32_t accessed   : 1;  // A - Accessed
    uint32_t dirty      : 1;  // D - Dirty (for PTE) (Not writable)
    uint32_t page_size  : 1;  // PS - Page size (0=4KB, 1=4MB for PDE)
    uint32_t global     : 1;  // G - Global page
    
    // Available for OS (For OS-specific purposes)
    uint32_t os1        : 1;  
    uint32_t os2        : 1;  
    uint32_t os3        : 1;  
} page_directory_entry_t;

typedef struct pte {
    uint32_t frame_addr : 20;

    // Standard x86 flags
    uint32_t present    : 1;
    uint32_t writable   : 1; 
    uint32_t user       : 1;
    uint32_t pwt        : 1;
    uint32_t pcd        : 1;
    uint32_t accessed   : 1;
    uint32_t dirty      : 1;  // Not writable
    uint32_t pat        : 1;  // PAT - Page Attribute Table
    uint32_t global     : 1;

    // Available for OS (For OS-specific purposes)
    uint32_t os1        : 1;
    uint32_t os2        : 1; 
    uint32_t os3        : 1;
} page_table_entry_t;

// Инвалидация TLB для конкретной PTE по номеру
extern void invalidate_table_TLB(unsigned int pte_index);

// Инвалидация TLB для конкретной PDE по номеру  
extern void invalidate_directory_TLB(unsigned int pde_index);

// Полная инвалидация TLB
void invalidate_TLB(void);

extern page_directory_entry_t* current_space; 

void initialize_current_space_from_cr3();

void paging_init();

/* =================================== API =================================== */

// Создание новой page directory
page_directory_entry_t* paging_create_directory();

// Установка текущей page directory
void paging_switch_directory(page_directory_entry_t* directory);

// Получение текущей page directory
page_directory_entry_t* paging_get_current_directory();

// Клонирование page directory (для создания адресного пространства процесса)
page_directory_entry_t* paging_clone_directory(page_directory_entry_t* src);

// Флаги для страниц
#define PAGING_PRESENT    (1 << 0)
#define PAGING_WRITABLE   (1 << 1)
#define PAGING_USER       (1 << 2)
#define PAGING_PWT        (1 << 3)
#define PAGING_PCD        (1 << 4)
#define PAGING_GLOBAL     (1 << 5)

// Отображение физической страницы на виртуальный адрес (4KB)
bool paging_map_page(page_directory_entry_t* directory, void* virtual_addr, void* physical_addr, uint32_t flags);

// Отображение большого блока (4MB)
bool paging_map_large_page(page_directory_entry_t* directory, void* virtual_addr, void* physical_addr, uint32_t flags);

// Разотображение страницы
bool paging_unmap_page(page_directory_entry_t* directory, void* virtual_addr);

// Получение физического адреса по виртуальному
void* paging_get_physical_address(page_directory_entry_t* directory, void* virtual_addr);

// Проверка отображена ли страница
bool paging_is_mapped(page_directory_entry_t* directory, void* virtual_addr);


// Установка флагов страницы
void paging_set_flags(page_directory_entry_t* directory, void* virtual_addr, uint32_t flags);

// Получение флагов страницы
uint32_t paging_get_flags(page_directory_entry_t* directory, void* virtual_addr);

// Изменение прав доступа
bool paging_set_permissions(page_directory_entry_t* directory, void* virtual_addr, bool writable, bool user);

// Пометить страницу как глобальную
void paging_set_global(page_directory_entry_t* directory, void* virtual_addr, bool global);

// Создание новой page table
page_table_entry_t* paging_create_table();

// Получение entry из таблицы
page_table_entry_t* paging_get_table_entry(page_directory_entry_t* directory, uint32_t pde_index, uint32_t pte_index);

// Резервирование таблицы в directory
bool paging_allocate_table(page_directory_entry_t* directory, uint32_t pde_index, uint32_t flags);

// Инициализация фреймов для page directory/table
void paging_initialize_frame(page_directory_entry_t* directory, uint32_t pde_index);

// Дамп информации о mapping
void paging_dump_mapping(page_directory_entry_t* directory, void* virtual_addr);

// Проверка целостности структур
bool paging_validate_directory(page_directory_entry_t* directory);

// Освобождение всех ресурсов directory
void paging_destroy_directory(page_directory_entry_t* directory);

extern void asm_page_fault_handler();

//void page_fault_handler();