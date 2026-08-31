/*
 * Copyright (C) 2026 TimeStop34
 * The SNK Kernel
 * 
 * "Второй уровень загрузчика" главного ядра, 
 * 
 * Из старого C++ проекта взята идея
 * поддержки и Multiboot1 и его второй версии
 */

use crate::kmain;
use super::{I386RawArch, SimpleAllocator};
use core::mem::MaybeUninit;
use core::cell::UnsafeCell;
use core::alloc::Layout;

// panic_handler специально для kboot модуля
pub fn panic(description: &str, position: &str) -> ! {
    let mut ptr = 0xB8000 as *mut u16;
    let color = 0x0C00u16; // ярко-красный на чёрном

    // Вспомогательная функция
    fn write_str(mut ptr: *mut u16, s: &str, color: u16) -> *mut u16 {
        let bytes = s.as_bytes();
        let mut i = 0;
        while i < bytes.len() {
            let b = bytes[i];
            unsafe { 
                *ptr = color | (b as u16); 
            }
            ptr = ((ptr as usize) + 2) as *mut u16;
            i += 1;
        }
        ptr
    }

    ptr = write_str(ptr, "Error (", color);
    ptr = write_str(ptr, position, color);
    ptr = write_str(ptr, "): ", color);
    write_str(ptr, description, color);

    loop {}
}

unsafe extern "C" {
    static __kernel_bss_end: u8;
}

// Обёртка над UnsafeCell, которая вручную реализует Sync
struct AllocatorCell(UnsafeCell<MaybeUninit<SimpleAllocator>>);
unsafe impl Sync for AllocatorCell {}

static ALLOCATOR: AllocatorCell = AllocatorCell(UnsafeCell::new(MaybeUninit::uninit()));

#[unsafe(no_mangle)]
#[unsafe(link_section = ".text")]
pub unsafe extern "C" fn kboot(magic: u32, _addr: usize) -> ! {
    #[allow(unused_variables)]
    let multibootv: u8 = match magic {
        0x2BADB002 => 1,
        0x36D76289 => 2,
        _ => panic("Unknown multiboot version", "Multiboot version detection")
    };

    /*
     * Архитектурный сетап:
     * - Настройка работы с памятью 
     *      и создание глоб. статичного аллокатора
     * - Настройка структуры,  
     *      реализующая трейт архитектуры SNK, а именно:
     * - Создание метода finalize_setup, который занимается:
     * 1. Созданием менеджера устройств и драйверов (на будущее)
     * 2. Созданием менеджера api для ядра SNK (настройка syscall'ов) (на будущее)
     * 3. Созданием планировщика
     */
    
    unsafe {
        // Получаем сырой указатель на MaybeUninit внутри UnsafeCell
        let alloc_ptr = ALLOCATOR.0.get(); // *mut MaybeUninit<SimpleAllocator>

        // Инициализируем аллокатор
        let bss_end = &__kernel_bss_end as *const u8 as *mut u8;
        (*alloc_ptr).write(SimpleAllocator::new(bss_end, 8192));

        // Берём ссылку &'static на инициализированный объект
        let alloc_ref = (*alloc_ptr).assume_init_ref();

        let arch = I386RawArch {
            allocator: alloc_ref
        };
        
        kmain(&arch);
    }

}

#[alloc_error_handler]
pub fn oom(_layout: Layout) -> ! {
    panic("OOM!", "oom somewhere");
}