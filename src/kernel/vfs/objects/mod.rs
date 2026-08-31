pub mod metadata;

use metadata::*;

use spin::RwLock;
use alloc::sync::Arc;

mod file;
pub use file::*;

mod directory;
pub use directory::*;

mod symlink;
pub use symlink::*;

mod device;
pub use device::*;

// mod handler;
// use handler::*;

pub mod handles;
use handles::*;

use alloc::fmt::Debug;

use crate::kernel::vfs::{PermissionContext, SuperObject};

use super::defines::{OpenFlags,VfsResult};

#[allow(unused)]
pub trait Object: Send + Sync + Debug {
    fn metadata(&self) -> Arc<RwLock<Metadata>>;
    fn open(self: Arc<Self>, flags: OpenFlags, ctx: &PermissionContext) -> VfsResult<Arc<dyn ObjectHandle>>;  // изменено с Box на Arc
    fn superblock(&self) -> Arc<dyn SuperObject>;
    
    // Приведение к конкретным типам
    fn as_file(self: Arc<Self>) -> Option<Arc<dyn FileObject>> { None }
    fn as_directory(self: Arc<Self>) -> Option<Arc<dyn DirectoryObject>> { None }
    fn as_symlink(self: Arc<Self>) -> Option<Arc<dyn SymlinkObject>> { None }
    fn as_device_object(self: Arc<Self>) -> Option<Arc<dyn DeviceObject>> { None }
}