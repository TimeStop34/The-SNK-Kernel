use spin::RwLock;
use alloc::{sync::Arc};
use crate::kernel::{
    arch::{BlockDM, CharDM, NetworkDM, device::{BlockDevice, CharDevice, Device, DeviceError, NetworkDevice}}, globals, obs::ramobs::objects::RamobsDeviceObject, vfs::{OpenFlags, PermissionContext, objects::{Object, handles::{DeviceHandle, DeviceObjectError, DeviceVfsResult, ObjectHandle}}}};

#[derive(Debug)]
pub struct RamobsDeviceHandle {
    object: Arc<RamobsDeviceObject>,
    flags: OpenFlags,
    device: Arc<RwLock<Option<Arc<RwLock<dyn Device>>>>>,
    ctx: PermissionContext
}

impl RamobsDeviceHandle {
    pub fn new(object: Arc<RamobsDeviceObject>, flags: &OpenFlags, device: Arc<RwLock<Option<Arc<RwLock<dyn Device>>>>>, ctx: &PermissionContext) -> Self{
        Self {
            object, 
            flags: flags.clone(),
            device,
            ctx: ctx.clone()
        }
    }
}

impl DeviceHandle for RamobsDeviceHandle {
    fn as_char_device(&self) -> DeviceVfsResult<dyn crate::kernel::arch::device::CharDevice> {
        let cdm: Arc<dyn CharDM> = match globals::char_dm() {
            Some(c) => c.clone(),
            None => return Err(DeviceObjectError::Device(DeviceError::NotReady))
        };

        let curr_device = self.device.read().clone().ok_or(DeviceObjectError::Device(DeviceError::NotReady))?;

        let device: Arc<RwLock<dyn CharDevice>> = cdm.get_by_device(curr_device).ok_or(DeviceObjectError::Device(DeviceError::PermissionDenied))?;

        Ok(device)
    }

    fn as_block_device(&self) -> DeviceVfsResult<dyn crate::kernel::arch::device::BlockDevice> {
        let bdm: Arc<dyn BlockDM> = match globals::block_dm() {
            Some(b) => b.clone(),
            None => return Err(DeviceObjectError::Device(DeviceError::NotReady))
        };

        let curr_device = self.device.read().clone().ok_or(DeviceObjectError::Device(DeviceError::NotReady))?;

        let device: Arc<RwLock<dyn BlockDevice>> = bdm.get_by_device(curr_device).ok_or(DeviceObjectError::Device(DeviceError::PermissionDenied))?;

        Ok(device)
    }

    fn as_network_device(&self) -> DeviceVfsResult<dyn NetworkDevice> {
        let ndm: Arc<dyn NetworkDM> = match globals::network_dm() {
            Some(n) => n.clone(),
            None => return Err(DeviceObjectError::Device(DeviceError::NotReady))
        };

        let curr_device = self.device.read().clone().ok_or(DeviceObjectError::Device(DeviceError::NotReady))?;

        let device: Arc<RwLock<dyn NetworkDevice>> = ndm.get_by_device(curr_device).ok_or(DeviceObjectError::Device(DeviceError::PermissionDenied))?;

        Ok(device)
    }

    fn as_device(&self) -> DeviceVfsResult<dyn crate::kernel::arch::device::Device> {
        let curr_device = self.device.read().clone().ok_or(DeviceObjectError::Device(DeviceError::NotReady))?;
        Ok(curr_device)
    }

    fn set_device(&self, device: Arc<RwLock<dyn Device>>) -> Result<(), DeviceObjectError> {
        let mut writer = self.device.write();
        *writer = Some(device);
        Ok(())
    }
}

impl ObjectHandle for RamobsDeviceHandle {
    fn object(&self) -> Arc<dyn Object> {
        self.object.clone()
    }

    fn flags(&self) -> OpenFlags {
        self.flags.clone()
    }

    fn as_device_handle(self: Arc<Self>) -> Option<Arc<dyn DeviceHandle>> {
        Some(self.clone())
    }
    
    fn context(&self) -> PermissionContext {
        self.ctx.clone()
    }
}