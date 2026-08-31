use alloc::sync::Arc;
use alloc::string::String;

use crate::kernel::vfs::{
    ObjectKind, PermissionSet,
    VfsResult
};

use super::objects::Object;
use super::FsStats;

use alloc::fmt::Debug;

#[allow(unused)]
pub trait SuperObject: Send + Sync + Debug {
    /// Тип файловой системы (например, "tmpfs", "snkobs", "ext2")
    fn fs_type(&self) -> String;

    /// Корневой Inode (корень ФС)
    fn root_inode(&self) -> VfsResult<Arc<dyn Object>>;

    /// Синхронизировать все изменения на диск (если есть)
    fn sync(&self) -> VfsResult<()>;

    /// Получить статистику ФС (свободное место, общий размер и т.д.)
    fn stats(&self) -> VfsResult<FsStats>;

    /// Размонтировать ФС (освободить ресурсы)
    fn unmount(self: Arc<Self>) -> VfsResult<()>;

    /// Получить Inode по номеру
    fn get_inode(&self, inode_num: u32) -> VfsResult<Arc<dyn Object>>;

    /// Создать Inode
    fn create_inode(self: Arc<Self>, kind: ObjectKind, permissions: PermissionSet) -> VfsResult<Arc<dyn Object>>;

    // Удалить Inode по номеру
    fn delete_inode(&self, inode_num: u32) -> VfsResult<()>;
}