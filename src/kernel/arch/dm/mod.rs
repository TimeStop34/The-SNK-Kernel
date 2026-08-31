// mod bdm;
// mod cdm;

// pub use bdm::*;
// pub use cdm::*;

pub mod device;

use device::*;

use alloc::sync::Arc;
use alloc::vec::Vec;
use spin::RwLock;

pub trait DeviceManager: Send + Sync {
    fn init(&self) -> ();

    fn char_dm(&self) -> Arc<dyn CharDM>;

    fn block_dm(&self) -> Arc<dyn BlockDM>;

    fn network_dm(&self) -> Arc<dyn NetworkDM>;

    fn list(&self) -> Vec<Arc<RwLock<dyn Device>>>;

    fn list_by_type(&self, dtype: DeviceType) -> Vec<Arc<RwLock<dyn Device>>>;
}

pub trait CharDM: Send + Sync {
    fn list(&self) -> Vec<Arc<RwLock<dyn CharDevice>>>;

    fn init(&self) -> ();

    fn get_by_id(&self, id: (u32, u32)) -> Option<Arc<RwLock<dyn CharDevice>>>;

    fn get_by_device(&self, device: Arc<RwLock<dyn Device>>) -> Option<Arc<RwLock<dyn CharDevice>>> {
        let id = device.read().id();
        self.get_by_id(id)
    }
}

pub trait BlockDM: Send + Sync {
    fn list(&self) -> Vec<Arc<RwLock<dyn BlockDevice>>>;

    fn init(&self) -> ();

    fn get_by_id(&self, id: (u32, u32)) -> Option<Arc<RwLock<dyn BlockDevice>>>;

    fn get_by_device(&self, device: Arc<RwLock<dyn Device>>) -> Option<Arc<RwLock<dyn BlockDevice>>> {
        let id = device.read().id();
        self.get_by_id(id)
    }
}

pub trait NetworkDM: Send + Sync {
    fn list(&self) -> Vec<Arc<RwLock<dyn NetworkDevice>>>;

    fn init(&self) -> ();

    fn get_by_id(&self, id: (u32, u32)) -> Option<Arc<RwLock<dyn NetworkDevice>>>;

    fn get_by_device(&self, device: Arc<RwLock<dyn Device>>) -> Option<Arc<RwLock<dyn NetworkDevice>>> {
        let id = device.read().id();
        self.get_by_id(id)
    }
}

