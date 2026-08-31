use crate::kernel::vfs::VfsResult;

use alloc::string::String;
use super::{ObjectHandle};

#[allow(unused)]
pub trait SymlinkHandle: ObjectHandle + Send + Sync {
    fn read_target(&self) -> VfsResult<String>;  // добавлен
    fn set_target(&self, target: String) -> VfsResult<()>;
}