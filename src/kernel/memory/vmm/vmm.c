#include "vmm.h"

page_directory_entry_t* kernel_page_dir;

void vmm_init() {
    // 1. Создаем Пустую Page Directory для ядра
    kernel_page_dir = create_empty_page_directory();
    
    // 2. Отображаем нижние 4MB идентично (ядро работает здесь)
    for (uint32_t i = 0; i < 1024; i++) {
        map_page(kernel_page_dir, i * 0x1000, i * 0x1000, 
                 PRESENT | WRITABLE);
    }
    
    // 3. Включаем пейджинг
    enable_paging(kernel_page_dir);
}