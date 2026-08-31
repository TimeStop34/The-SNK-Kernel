use crate::kernel::arch::device::*;
use crate::kernel::arch::BlockDM;
use alloc::sync::Arc;
use alloc::vec::Vec;
use spin::RwLock;

/// Конкретный менеджер блочных устройств для i386.
pub struct I386BlockDM {
    devices: Vec<Arc<RwLock<dyn BlockDevice>>>,
}

impl I386BlockDM {
    pub fn new() -> Self {
        Self {
            devices: Vec::new(),
        }
    }

    /// Регистрирует новое блочное устройство.
    #[allow(unused)]
    pub fn register(&mut self, dev: Arc<RwLock<dyn BlockDevice>>) {
        self.devices.push(dev);
    }
}

impl BlockDM for I386BlockDM {
    fn list(&self) -> Vec<Arc<RwLock<dyn BlockDevice>>> {
        self.devices.clone()
    }

    fn init(&self) {
        
    }

    fn get_by_id(&self, id: (u32, u32)) -> Option<Arc<RwLock<dyn BlockDevice>>> {
        self.devices
            .iter()
            .find(|dev| dev.read().id() == id)
            .cloned()
    }
}

unsafe impl Sync for I386BlockDM {}
unsafe impl Send for I386BlockDM {}