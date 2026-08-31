use core::alloc::{GlobalAlloc, Layout};
use core::ptr::{null_mut, addr_of_mut};
use super::arch::ArchAllocator;

// Глобальный изменяемый указатель.
static mut GLOBAL_ALLOCATOR: Option<&'static dyn ArchAllocator> = None;

pub struct SmartAllocator;

// Инициализация глобального аллокатора.
// Должна быть вызвана ровно один раз до использования `alloc`/`dealloc`.
pub unsafe fn init_global_allocator(alloc: &'static dyn ArchAllocator) {
    unsafe {
        let ptr = addr_of_mut!(GLOBAL_ALLOCATOR);
        if (*ptr).is_some() {
            panic!("Global allocator already initialized");
        }
        *ptr = Some(alloc);
    }
}

unsafe impl GlobalAlloc for SmartAllocator {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        let ptr = addr_of_mut!(GLOBAL_ALLOCATOR);
        unsafe {
            match *ptr {
                Some(alloc) => alloc.alloc(layout),
                None => { null_mut() },
            }
        }
    }

    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        let alloc_ptr = addr_of_mut!(GLOBAL_ALLOCATOR);
        unsafe {
            if let Some(alloc) = *alloc_ptr {
                alloc.dealloc(ptr, layout);
            }
        }
    }
}

#[global_allocator]
static ALLOCATOR: SmartAllocator = SmartAllocator;

