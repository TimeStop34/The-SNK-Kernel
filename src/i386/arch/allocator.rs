use crate::ArchAllocator;
use core::alloc::Layout;
use core::cell::Cell;

pub struct SimpleAllocator {
    start: *mut u8,
    size: usize,
    current: Cell<usize>,
}

unsafe impl ArchAllocator for SimpleAllocator {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        let align = layout.align();
        let size = layout.size();

        let cur_off = self.current.get();
        let addr_usize = self.start as usize + cur_off;

        // Ручное выравнивание (без align_offset)
        let align_offset = if addr_usize % align == 0 {
            0
        } else {
            align - (addr_usize % align)
        };
        let aligned_off = cur_off + align_offset;
        let new_off = aligned_off + size;

        // Проверка границ
        if new_off > self.size {
            return 0 as *mut u8; // null через литерал
        }

        self.current.set(new_off);
        let addr = (self.start as usize + aligned_off) as *mut u8;

        addr
    }

    unsafe fn dealloc(&self, _ptr: *mut u8, _layout: Layout) {
        // Ничего не делаем
    }
}

impl SimpleAllocator {
    pub fn new(start: *mut u8, size: usize) -> Self {
        SimpleAllocator {
            start,
            size,
            current: Cell::new(0),
        }
    }

    #[allow(unused)]
    pub fn reset(&self) {
        self.current.set(0);
    }
}