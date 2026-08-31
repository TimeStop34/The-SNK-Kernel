use core::alloc::Layout;

pub unsafe trait ArchAllocator {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8;
    
    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout);
}