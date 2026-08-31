/*  
 * Copyright (C) 2026 TimeStop34
 * The SNK Kernel
 * 
 * "Загрузчик" главного ядра, 
 * подготавливает всё, 
 * для jump в higher half kernel
 * 
 * Из старого C++ проекта взята идея 
 * поддержки и Multiboot1 и его второй версии
 */

/* 
 * Секция основной загрузки
 */

// Переменные в .data, заместо старых фиксированных 0x200X адресов
#[unsafe( no_mangle )]
#[unsafe( link_section = ".boot_data" )]
pub static mut MULTIBOOT_MAGIC: u32 = 0;

#[unsafe( no_mangle )]
#[unsafe( link_section = ".boot_data" )]
pub static mut MULTIBOOT_ADDR: usize = 0;

#[allow(unused)]
#[unsafe( link_section = ".boot" )]
unsafe extern "C" {
    pub fn early_gdt_init();
    pub fn early_enable_paging();
    pub fn save_multiboot();

    pub fn kboot(magic: u32, addr: usize) -> !;
}


#[unsafe( no_mangle )]
#[unsafe( link_section = ".boot" )]
pub extern "C" fn early_boot() -> ! { 
    unsafe {
        core::arch::asm!("mov esp, 0x60000", options(nostack, raw)); // или любой другой адрес

        save_multiboot();
        early_gdt_init();

        higher_half_kernel_init();
    }
}

#[unsafe( link_section = ".boot" )]
unsafe fn higher_half_kernel_init() -> ! {
    unsafe {
        setup_higher_half_mapping();
        //
        
        early_enable_paging();
        //loop{}
        kboot(MULTIBOOT_MAGIC, MULTIBOOT_ADDR)
    }
}

/*
 * Секция памяти
 * Сетап маппинга и статические переменные
 */

#[allow(unused)]
#[repr(align(4096))]
pub struct PageDirectory([u32; 1024]);

// Каталог страниц – выровненный массив из 1024 записей
#[unsafe( no_mangle )]
#[unsafe( link_section = ".boot_data" )]
pub static mut PD: PageDirectory = PageDirectory([0; 1024]);

// Таблицы страниц – массив из 4 таких же структур (каждая выровнена)
#[repr(align(4096))]
pub struct AlignedPageTables([[u32; 1024]; 4]);

#[unsafe( no_mangle )]
#[unsafe( link_section = ".boot_data" )]
pub static mut PAGE_TABLES: AlignedPageTables = AlignedPageTables([[0; 1024]; 4]);

#[unsafe( no_mangle )]
#[unsafe( link_section = ".boot" )]
pub unsafe fn setup_higher_half_mapping() {
    unsafe {
        let pd = &raw mut PD as *mut [u32; 1024];
        let pt0 = &raw mut PAGE_TABLES.0[0] as *mut [u32; 1024];
        let pt1 = &raw mut PAGE_TABLES.0[1] as *mut [u32; 1024];
        let pt2 = &raw mut PAGE_TABLES.0[2] as *mut [u32; 1024];
        let pt3 = &raw mut PAGE_TABLES.0[3] as *mut [u32; 1024];
        let tables = [pt0, pt1, pt2, pt3];

        // Очищаем каталог
        let mut i = 0;
        while i < 1024 {
            (*pd)[i] = 0;
            i += 1;
        }

        // Заполняем таблицы страниц для первых 16 МБ
        let mut table_idx: usize = 0;
        while table_idx < 4 {
            let pt = tables[table_idx];
            let mut entry = 0;
            while entry < 1024 {
                let phys_addr = (table_idx * 1024 + entry) * 4096;
                (*pt)[entry] = phys_addr as u32 | 0x3; // present + write
                entry += 1;
            }
            table_idx += 1;
        }

        // Identity mapping: PDE[0..3] указывают на таблицы
        (*pd)[0] = pt0 as u32 | 0x3;
        (*pd)[1] = pt1 as u32 | 0x3;
        (*pd)[2] = pt2 as u32 | 0x3;
        (*pd)[3] = pt3 as u32 | 0x3;

        // Higher half mapping: для 0xC0000000-0xC0FFFFFF используем те же таблицы
        (*pd)[768] = pt0 as u32 | 0x3;
        (*pd)[769] = pt1 as u32 | 0x3;
        (*pd)[770] = pt2 as u32 | 0x3;
        (*pd)[771] = pt3 as u32 | 0x3;

        // Рекурсивное отображение (для доступа к таблицам из VMM)
        (*pd)[1023] = pd as u32 | 0x3;
    }
}