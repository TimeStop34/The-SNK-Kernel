use crate::kernel::arch::device::*;
use crate::kernel::arch::NetworkDM;
use alloc::sync::Arc;
use alloc::vec::Vec;
use spin::RwLock;

/// Конкретный менеджер сетевых устройств для i386.
pub struct I386NetworkDM {
    devices: Vec<Arc<RwLock<dyn NetworkDevice>>>,
}

impl I386NetworkDM {
    pub fn new() -> Self {
        Self {
            devices: Vec::new(),
        }
    }

    /// Регистрирует новое сетевое устройство.
    #[allow(unused)]
    pub fn register(&mut self, dev: Arc<RwLock<dyn NetworkDevice>>) {
        self.devices.push(dev);
    }
}

impl NetworkDM for I386NetworkDM {
    fn list(&self) -> Vec<Arc<RwLock<dyn NetworkDevice>>> {
        self.devices.clone()
    }

    fn init(&self) {
        // Никаких
    }

    fn get_by_id(&self, id: (u32, u32)) -> Option<Arc<RwLock<dyn NetworkDevice>>> {
        self.devices
            .iter()
            .find(|dev| dev.read().id() == id)
            .cloned()
    }
}

unsafe impl Sync for I386NetworkDM {}
unsafe impl Send for I386NetworkDM {}