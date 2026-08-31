use crate::kernel::vfs::{PermissionSet, VfsResult, DirEntry};

use super::ObjectHandle;

use super::{ 
    Object,
    super::super::ObjectKind
};

use alloc::string::String;
use alloc::sync::Arc;
use alloc::vec::Vec;

#[allow(unused)]
pub trait DirectoryHandle: ObjectHandle + Send + Sync {
    // Новые методы для чтения содержимого (перенесены из DirectoryObject)
    fn lookup(&self, name: String) -> VfsResult<Arc<dyn Object>>;
    fn entries(&self) -> VfsResult<Vec<DirEntry>>;

    // Методы модификации
    fn create(&self, name: String, kind: ObjectKind, permission: &PermissionSet) -> VfsResult<Arc<dyn Object>>;
    fn delete(&self, name: String) -> VfsResult<()>;
    fn rename(&self, old_name: String, new_name: String) -> VfsResult<()>;
}