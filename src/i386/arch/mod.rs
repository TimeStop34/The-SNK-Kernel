mod allocator;
pub use allocator::*;

mod dm;
pub use dm::*;

use crate::kernel::arch::{
    Arch, RawArch, ArchAllocator, 
    DeviceManager
};
use alloc::sync::Arc;
use alloc::boxed::Box;

pub struct I386RawArch {
    pub allocator: &'static SimpleAllocator // стадия -- Ярик,
}

impl RawArch for I386RawArch {
    fn get_arch_allocator(&self) -> &'static dyn ArchAllocator {
        self.allocator as &'static dyn ArchAllocator
    }

    fn finalize_setup(&self) -> Box<dyn Arch> {
        
        let cdm: I386CharDM = I386CharDM::new();
        let bdm: I386BlockDM = I386BlockDM::new();
        let ndm: I386NetworkDM = I386NetworkDM::new();

        let dm = I386DeviceManager::new(
            Arc::new(cdm), 
            Arc::new(bdm), 
            Arc::new(ndm)
        );

        let arch = I386Arch::new(
            Arc::new(dm)
        );
        Box::new(arch)
    }
}

pub struct I386Arch {
    dm: Arc<I386DeviceManager>
}

impl I386Arch {
    pub fn new(dm: Arc<I386DeviceManager>) -> Self {
        Self {
            dm: dm
        }
    }
}

impl Arch for I386Arch {
    fn device_manager(&self) -> Arc<dyn DeviceManager> {
        self.dm.clone() as Arc<dyn DeviceManager>
    }
}