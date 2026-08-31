mod allocator;
pub use allocator::*;

mod apimanager;
#[allow(unused)]
pub use apimanager::*;

mod dm;
pub use dm::*;

use alloc::sync::Arc;
use alloc::boxed::Box;

pub trait RawArch {
    fn get_arch_allocator(&self) -> &'static dyn ArchAllocator;

    fn finalize_setup(&self) -> Box<dyn Arch>;
}

pub trait Arch {
    fn device_manager(&self) -> Arc<dyn DeviceManager>;

    // fn api_manager(&self) -> Arc<dyn ApiManager>;
}