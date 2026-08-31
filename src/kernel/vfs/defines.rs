use hashbrown::HashMap;

use super::objects::Object;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Permission(u8);

impl Permission {
    // Константы прав
    pub const READ: Self = Self(0b0000_0001);
    pub const WRITE: Self = Self(0b0000_0010);
    pub const EXECUTE: Self = Self(0b0000_0100);
    pub const DELETE: Self = Self(0b0000_1000);
    pub const RENAME: Self = Self(0b0001_0000);
    pub const RULESET: Self = Self(0b0010_0000);
    pub const LOCK: Self = Self(0b0100_0000);
    pub const APPEND: Self = Self(0b1000_0000);

    pub const ALL: Self = Self(0b1111_1111);
    pub const NONE: Self = Self(0);

    pub fn has(self, right: Self) -> bool {
        (self.0 & right.0) != 0
    }

    pub fn with(self, right: Self) -> Self {
        Self(self.0 | right.0)
    }

    pub fn without(self, right: Self) -> Self {
        Self(self.0 & !right.0)
    }

    pub fn bits(self) -> u8 {
        self.0
    }
}

impl From<u8> for Permission {
    fn from(bits: u8) -> Self {
        Self(bits)
    }
}

impl From<Permission> for u8 {
    fn from(permission: Permission) -> Self {
        permission.0
    }
}


use core::ops::BitOr;

impl BitOr for Permission {
    type Output = Self;

    fn bitor(self, other: Self) -> Self {
        Self(self.0 | other.0)
    }
}

#[derive(Clone, Debug)]
#[allow(unused)]
pub struct PermissionSet {
    pub uid: u16, 
    pub role_rights: HashMap<u16, Permission>,
    pub default_rights: Permission,
}

use alloc::vec::Vec;
#[allow(unused)]
#[derive(Clone, Debug)]
pub struct PermissionContext {
    uid: u16,
    rid: Vec<u16>,
    pub root: Arc<dyn Object>,  // корневой объект для этого контекста
}

impl PermissionContext {
    #[allow(unused)]
    pub fn new(uid: u16, rid: Vec<u16>, root: Arc<dyn Object>) -> Self {
        Self {
            uid, rid, root
        }
    }

    #[allow(unused)]
    pub fn uid(&self) -> u16 {
        return self.uid.clone();
    }

    #[allow(unused)]
    pub fn rid(&self) -> Vec<u16> {
        return self.rid.clone();
    }

    #[allow(unused)]
    pub fn root(&self) -> &Arc<dyn Object> { &self.root }
}

#[allow(unused)]
pub enum SeekWhence {
    Set = 0,
    Cur = 1,
    End = 2,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[allow(unused)]
pub enum VfsError {
    NotFound,           // Объект не найден
    PermissionDenied,   // Нет прав
    AlreadyExists,      // Уже существует
    IsDirectory,        // Ожидался файл, а это каталог
    NotDirectory,       // Ожидался каталог, а это файл
    NotEmpty,           // Каталог не пуст (при удалении)
    IoError,            // Ошибка ввода-вывода
    NoSpace,            // Нет места
    InvalidArgument,    // Некорректный параметр
    WouldBlock,         // Операция заблокирована (для неблокирующих вызовов)
    Unsupported,        // Операция не поддерживается
    LockConflict,       // Конфликт блокировок
    NotSymlink,         // Ожидалась символьная ссылка
    TooLong,            // Слишком длинный путь или имя
    OutOfMemory,        // Недостаточно памяти (для аллокаций)
    OutOfFile,          // Позиция за границами файла
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct OpenFlags(u8);

impl OpenFlags {
    pub const READ: Self = Self(0b0000_0001);
    pub const WRITE: Self = Self(0b0000_0010);
    pub const APPEND: Self = Self(0b0000_0100);
    pub const TRUNCATE: Self = Self(0b0000_1000);
    pub const CREATE: Self = Self(0b0001_0000);
    pub const EXCL: Self = Self(0b0010_0000);   // exclusive create
    pub const NONBLOCK: Self = Self(0b0100_0000);
    pub const SYNC: Self = Self(0b1000_0000);   // синхронная запись

    pub fn has(self, flag: Self) -> bool {
        (self.0 & flag.0) != 0
    }

    pub fn bits(self) -> u8 {
        self.0
    }
}

impl From<u8> for OpenFlags {
    fn from(bits: u8) -> Self {
        Self(bits)
    }
}

impl From<OpenFlags> for u8 {
    fn from(flags: OpenFlags) -> Self {
        flags.0
    }
}

use alloc::string::String;
use alloc::sync::Arc;

#[derive(Debug, Clone)]
#[allow(unused)]
pub struct DirEntry {
    pub name: String,
    pub inode: u32,
    pub kind: ObjectKind,
}

impl DirEntry {
    pub fn new(name: impl Into<String>, inode: u32, kind: ObjectKind) -> Self {
        Self {
            name: name.into(),
            inode,
            kind,
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[allow(unused)]
pub enum ObjectKind {
    File,
    Directory,
    Symlink,
    Device,
    //Socket,
    //Fifo,
    // для SnkObS
    //Container,
    //State,
    // задел
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct SnkObSFlags(u32);

#[allow(unused)]
impl SnkObSFlags {
    pub const VERSIONED: Self = Self(0x0000_0001);   // поддержка версионирования
    pub const COMPRESSED: Self = Self(0x0000_0002);  // сжатие данных
    pub const ENCRYPTED: Self = Self(0x0000_0004);   // шифрование
    pub const IMMUTABLE: Self = Self(0x0000_0008);   // неизменяемый объект
    pub const APPEND_ONLY: Self = Self(0x0000_0010); // только добавление
    pub const NODUMP: Self = Self(0x0000_0020);      // не включать в дампы
    pub const SYNC: Self = Self(0x0000_0040);        // синхронизация на диск
    pub const NONE: Self = Self(0x0000_0000);

    pub fn has(self, flag: Self) -> bool {
        (self.0 & flag.0) != 0
    }

    pub fn bits(self) -> u32 {
        self.0
    }
}

impl From<u32> for SnkObSFlags {
    fn from(bits: u32) -> Self {
        Self(bits)
    }
}

impl From<SnkObSFlags> for u32 {
    fn from(flags: SnkObSFlags) -> Self {
        flags.0
    }
}

#[derive(Debug, Clone, Copy)]
#[allow(unused)]
pub struct FsStats {
    pub total_blocks: u64,
    pub free_blocks: u64,
    pub total_inodes: u64,
    pub free_inodes: u64,
}

use super::{ MountFlags, SuperObject };

#[allow(unused)]
pub trait ObjectSystem: Send + Sync {
    /// Создать SuperBlock для данной ФС (монтирование)
    fn mount(&self, source: String, flags: MountFlags, options: &[String]) -> VfsResult<Arc<dyn SuperObject>>;

    /// Имя ФС
    fn name(&self) -> String;
}

pub type VfsResult<T> = Result<T, VfsError>;

#[derive(Debug, Clone)]
pub struct SeekPolicy {
    pub disable_negative: bool,
    pub allow_out_of_file: bool
}
