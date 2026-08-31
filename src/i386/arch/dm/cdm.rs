use crate::kernel::arch::device::*;
use crate::kernel::arch::CharDM;
use alloc::sync::Arc;
use alloc::vec::Vec;
use spin::RwLock;

/// Конкретный менеджер символьных устройств для i386.
pub struct I386CharDM {
    devices: Vec<Arc<RwLock<dyn CharDevice>>>,
}

impl I386CharDM {
    /// Создаёт новый пустой менеджер.
    pub fn new() -> Self {
        Self {
            devices: Vec::new(),
        }
    }

    /// Регистрирует новое символьное устройство в менеджере.
    /// (Вспомогательный метод, не входящий в трейт.)
    #[allow(unused)]
    pub fn register(&mut self, dev: Arc<RwLock<dyn CharDevice>>) {
        self.devices.push(dev);
    }
}

impl CharDM for I386CharDM {
    fn list(&self) -> Vec<Arc<RwLock<dyn CharDevice>>> {
        self.devices.clone()
    }

    fn init(&self) {
        
    }

    fn get_by_id(&self, id: (u32, u32)) -> Option<Arc<RwLock<dyn CharDevice>>> {
        self.devices
            .iter()
            .find(|dev| dev.read().id() == id)
            .cloned()
    }
}

unsafe impl Sync for I386CharDM {}
unsafe impl Send for I386CharDM {}