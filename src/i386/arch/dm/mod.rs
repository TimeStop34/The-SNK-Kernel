use crate::kernel::arch::{
    DeviceManager,
    CharDM,
    BlockDM,
    NetworkDM,
};
use crate::kernel::arch::device::*;

use alloc::sync::Arc;
use alloc::vec::Vec;
use spin::RwLock;

mod bdm;
mod cdm;
mod ndm;

pub use bdm::*;
pub use cdm::*;
pub use ndm::*;

pub struct I386DeviceManager {
    char_dm: Arc<I386CharDM>,
    block_dm: Arc<I386BlockDM>,
    net_dm: Arc<I386NetworkDM>,
}

impl I386DeviceManager {
    pub fn new(cdm: Arc<I386CharDM>, bdm: Arc<I386BlockDM>, ndm: Arc<I386NetworkDM>) -> Self {
        Self {
            char_dm: cdm,
            block_dm: bdm,
            net_dm: ndm
        }
    }
}

impl DeviceManager for I386DeviceManager {
    fn init(&self) {
        self.char_dm.init();
        self.block_dm.init();
        self.net_dm.init();
    }

    fn char_dm(&self) -> Arc<dyn CharDM> {
        self.char_dm.clone() as Arc<dyn CharDM>
    }

    fn block_dm(&self) -> Arc<dyn BlockDM> {
        self.block_dm.clone() as Arc<dyn BlockDM>
    }

    fn network_dm(&self) -> Arc<dyn NetworkDM> {
        self.net_dm.clone() as Arc<dyn NetworkDM>
    }

    fn list(&self) -> Vec<Arc<RwLock<dyn Device>>> {
        let mut all = Vec::new();

        for dev in self.char_dm.list() {
            all.push(dev as Arc<RwLock<dyn Device>>);
        }
        for dev in self.block_dm.list() {
            all.push(dev as Arc<RwLock<dyn Device>>);
        }
        for dev in self.net_dm.list() {
            all.push(dev as Arc<RwLock<dyn Device>>);
        }

        all
    }

    fn list_by_type(&self, dtype: DeviceType) -> Vec<Arc<RwLock<dyn Device>>> {
        match dtype {
            DeviceType::Char => self.char_dm.list()
                .into_iter()
                .map(|dev| dev as Arc<RwLock<dyn Device>>)
                .collect(),
            DeviceType::Block => self.block_dm.list()
                .into_iter()
                .map(|dev| dev as Arc<RwLock<dyn Device>>)
                .collect(),
            DeviceType::Network => self.net_dm.list()
                .into_iter()
                .map(|dev| dev as Arc<RwLock<dyn Device>>)
                .collect(),
        }
    }
}