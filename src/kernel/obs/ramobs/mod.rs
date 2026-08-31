use alloc::{string::{String, ToString}, sync::Arc};

use crate::kernel::{obs::ramobs::superobject::RamobsSuperObject, vfs::{MountFlags, ObjectSystem, SuperObject, VfsResult}};

mod superobject;

pub mod objects;

pub mod handles;

pub struct RamObS;

impl RamObS {
    #[allow(unused)]
    pub fn new () -> Self { Self }
}

impl ObjectSystem for RamObS {
    fn name(&self) -> String {
        "ramobs".to_string()
    }

    #[allow(unused)]
    fn mount(&self, source: String, flags: MountFlags, options: &[String]) 
    -> VfsResult<Arc<dyn SuperObject>> {
        let max = u32::MAX;

        let sobj = RamobsSuperObject::new(max);

        Ok(sobj as Arc<dyn SuperObject>)
    }
}