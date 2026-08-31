use super::super:: {
    PermissionSet, SnkObSFlags, ObjectKind
};

use spin::RwLock;

pub type Timestamp = i64;

#[derive(Debug)]
#[allow(unused)]
pub struct Metadata {
    // Неизменяемые поля (не требуют блокировки)
    pub inode_num: u32,
    pub kind: ObjectKind,

    // Все изменяемые поля — под одной блокировкой
    pub inner: RwLock<MetadataInner>,
}

#[derive(Debug)]
#[allow(unused)]
pub struct MetadataInner {
    pub uid: u16, // Владелец
    pub size: u32,
    pub atime: Timestamp,
    pub mtime: Timestamp,
    pub ctime: Timestamp,
    pub permissions: PermissionSet,
    pub flags: SnkObSFlags,
}

#[allow(unused)]
pub struct FileStat {
    pub inode_num: u32,
    pub kind: ObjectKind,
    pub size: u32,
    pub atime: Timestamp,
    pub mtime: Timestamp,
    pub ctime: Timestamp,
    pub permissions: PermissionSet,
    pub flags: SnkObSFlags,
}