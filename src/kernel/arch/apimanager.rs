use alloc::vec::Vec;

#[allow(unused)]
pub struct SysCallArgs {
    ebx: u32,
    ecx: u32,
    edx: u32,
    esi: u32,
    edi: u32
}

#[allow(unused)]
pub struct SysCall {
    vector: u32,
    function: fn(SysCallArgs),
}

#[allow(unused)]
pub trait ApiManager {
    fn list() -> Vec<SysCall>;

    fn register(syscall: SysCall);
    fn delete(vector: u32);
}