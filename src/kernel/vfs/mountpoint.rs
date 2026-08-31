use alloc::{
    string::{String, ToString},
    sync::Arc
};
use hashbrown::HashMap;
use spin::RwLock;

use crate::kernel::vfs::VfsResult;

use super::{ SuperObject, VfsError };

#[derive(Clone)]
#[allow(unused)]
pub struct MountPoint {
    pub fs_type: String,
    pub superblock: Arc<dyn SuperObject>,
    pub flags: MountFlags,
}

pub struct MountTable(RwLock<HashMap<String, MountPoint>>);

#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct MountFlags(u16);

impl MountFlags {
    pub const READONLY: Self = Self(0b0000_0000_0000_0001);
    pub const NOEXEC: Self   = Self(0b0000_0000_0000_0010);
    pub const NOSUID: Self   = Self(0b0000_0000_0000_0100);
    pub const NODEV: Self    = Self(0b0000_0000_0000_1000);
    pub const SYNC: Self     = Self(0b0000_0000_0001_0000);
    pub const NOATIME: Self  = Self(0b0000_0000_0010_0000);
    pub const REMOUNT: Self  = Self(0b0000_0000_0100_0000);
    pub const BIND: Self     = Self(0b0000_0000_1000_0000);

    pub fn has(self, flag: Self) -> bool {
        (self.0 & flag.0) != 0
    }

    pub fn bits(self) -> u16 {
        self.0
    }
}

#[allow(unused)]
impl MountTable {
    /// Создаёт новую пустую таблицу монтирования
    pub fn new() -> Self {
        Self(RwLock::new(HashMap::new()))
    }

    /// Монтирует ФС в указанную точку
    pub fn mount(&self, path: &str, superblock: Arc<dyn SuperObject>, flags: MountFlags) -> VfsResult<()> {
        let mut table = self.0.write();
        if table.contains_key(path) {
            return Err(VfsError::AlreadyExists);
        }
        let mount_point = MountPoint {
            fs_type: superblock.fs_type().to_string(),
            superblock,
            flags,
        };
        table.insert(path.to_string(), mount_point);
        Ok(())
    }

    /// Размонтирует ФС по указанной точке
    pub fn unmount(&self, path: &str) -> VfsResult<()> {
        let mut table = self.0.write();
        if table.remove(path).is_none() {
            return Err(VfsError::NotFound);
        }
        Ok(())
    }

    /// Возвращает SuperBlock для точки монтирования, если есть
    pub fn get(&self, path: &str) -> Option<Arc<dyn SuperObject>> {
        let table = self.0.read();
        table.get(path).map(|mp| mp.superblock.clone())
    }

    /// Проверяет, является ли путь точкой монтирования
    pub fn is_mount_point(&self, path: &str) -> bool {
        let table = self.0.read();
        table.contains_key(path)
    }

    /// Возвращает итератор по всем точкам монтирования (для отладки)
    pub fn entries(&self) -> alloc::vec::Vec<(String, MountPoint)> {
        let table = self.0.read();
        table.iter().map(|(k, v)| (k.clone(), v.clone())).collect()
    }
}

impl From<u16> for MountFlags {
    fn from(bits: u16) -> Self {
        Self(bits)
    }
}

impl From<MountFlags> for u16 {
    fn from(flags: MountFlags) -> Self {
        flags.0
    }
}