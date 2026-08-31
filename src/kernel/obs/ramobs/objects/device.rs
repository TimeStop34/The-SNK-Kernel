use spin::RwLock;
use alloc::{sync::Arc};
use crate::kernel::{arch::device::Device, obs::ramobs::handles::RamobsDeviceHandle, vfs::{OpenFlags, PermissionContext, SuperObject, VfsResult, objects::{DeviceObject, Object, handles::ObjectHandle, metadata::Metadata}}};

#[derive(Debug)]
pub struct RamobsDeviceObject {
    superobject: Arc<dyn SuperObject>,
    device: Arc<RwLock<Option<Arc<RwLock<dyn Device>>>>>,
    metadata: Arc<RwLock<Metadata>>
}

impl RamobsDeviceObject {
    pub fn new(superobject: Arc<dyn SuperObject>, metadata: Arc<RwLock<Metadata>>) -> Self{
        Self {
            superobject,
            device: Arc::new(RwLock::new(None)),
            metadata
        }
    }
}

impl DeviceObject for RamobsDeviceObject {}

impl Object for RamobsDeviceObject {
    fn metadata(&self) -> Arc<RwLock<Metadata>> {
        self.metadata.clone()
    }
    
    fn open(self: Arc<Self>, flags: OpenFlags, ctx: &PermissionContext) 
    -> VfsResult<Arc<dyn ObjectHandle>> {
        let dh = RamobsDeviceHandle::new(
            self.clone(),
            &flags.clone(),
            self.device.clone(),
            ctx
        );
        Ok(Arc::new(dh))
    }

    fn as_device_object(self: Arc<Self>) -> Option<Arc<dyn DeviceObject>> { Some(self) }
    
    fn superblock(&self) -> Arc<dyn crate::kernel::vfs::SuperObject> {
        self.superobject.clone()
    }
}