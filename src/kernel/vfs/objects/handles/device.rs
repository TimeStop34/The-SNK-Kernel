use super::ObjectHandle;

use alloc::sync::Arc;
use spin::RwLock;

use crate::kernel::{arch::device::{
    BlockDevice, CharDevice, 
    Device, DeviceError, 
    NetworkDevice
}, vfs::VfsError};

#[derive(Debug, Clone)]
#[allow(unused)]
pub enum DeviceObjectError {
    Vfs(VfsError),
    Device(DeviceError),
}

#[allow(unused)]
pub type DeviceVfsResult<T> = Result<Arc<RwLock<T>>, DeviceObjectError>;

#[allow(unused)]
pub trait DeviceHandle: ObjectHandle + Send + Sync {
    fn as_char_device(&self) -> DeviceVfsResult<dyn CharDevice>;
    fn as_block_device(&self) -> DeviceVfsResult<dyn BlockDevice>;
    fn as_network_device(&self) -> DeviceVfsResult<dyn NetworkDevice>;
    fn as_device(&self) -> DeviceVfsResult<dyn Device>;

    fn set_device(&self, device: Arc<RwLock<dyn Device>>) -> Result<(), DeviceObjectError>;
}
