use crate::kernel::vfs::PermissionContext;

use super::{
    Object, OpenFlags
};

use alloc::sync::Arc;

mod file;
pub use file::*;

mod device;
pub use device::*;

mod directory;
pub use directory::*;

mod symlink;
pub use symlink::*;

#[allow(unused)]
pub trait ObjectHandle: Send + Sync {
    fn object(&self) -> Arc<dyn Object>;
    fn context(&self) -> PermissionContext;
    fn flags(&self) -> OpenFlags;

    fn as_file_handle(self: Arc<Self>) -> Option<Arc<dyn FileHandle>>  { None }
    fn as_directory_handle(self: Arc<Self>) -> Option<Arc<dyn DirectoryHandle>>  { None }
    fn as_device_handle(self: Arc<Self>) -> Option<Arc<dyn DeviceHandle>> { None }
    fn as_symlink_handle(self: Arc<Self>) -> Option<Arc<dyn SymlinkHandle>> { None }
}