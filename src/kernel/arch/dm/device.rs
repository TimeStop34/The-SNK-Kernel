use alloc::string::String;
use alloc::fmt::Debug;

pub enum DeviceType {
    Char,
    Block,
    Network
}

pub enum CharType {
    Input,
    Output
}

pub enum StreamType {
    Stream,
    Buffer
}

pub type DeviceResult<T> = Result<T, DeviceError>;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DeviceError {
    IoError,
    InvalidParam,
    NotReady,
    NoMemory,
    PermissionDenied,
    Unsupported,
    AlreadyInUse,
    WrongCharIOMethod,
}

pub trait Device: Debug + Send + Sync {
    fn name(&self) -> String;
    fn id(&self) -> (u32, u32); // major.minor

    fn dtype(&self) -> DeviceType;
}

pub trait CharDevice: Device {
    fn dtype(&self) -> DeviceType 
        { DeviceType::Char }

    fn ctype(&self) -> CharType;
    fn stype(&self) -> StreamType;

    // Функция настройки
    fn ioctl(&self, cmd: u32, arg: usize) -> DeviceResult<isize>;

    // CharOutput функция
    fn write(&self, buf: &[u8]) -> DeviceResult<usize>;

    // CharInput функции
    fn read(&self, buf: &mut [u8], size: usize) 
        -> DeviceResult<usize>; 
        // Читает ровно size байт с начала потока, **не блокирует** 
        // если данных больше - курсор смещаеться
    fn available(&self) -> DeviceResult<usize>;
    // (Блокировки на уровне ядра быть не может, 
    // блокировка добавляеться на прикладном уровне: на уровне VFS)
    
    fn seek(&self, offset: usize) -> DeviceResult<usize>;
    // Метод смены позиции в буфере ОС
    // Для непотоковых устройств - смена в буфере устройств
    // Для потоковых - 
    //    смена в буфере полученных данных, из которых читает read
}

#[allow(unused)]
pub trait CharInputDevice: CharDevice {
    fn ctype(&self) -> CharType { CharType::Input }
    fn stype(&self) -> StreamType { StreamType::Buffer }

    fn write(&self, buf: &[u8]) -> DeviceResult<usize> {
        Err(DeviceError::WrongCharIOMethod)
    }
}

#[allow(unused)]
pub trait CharOutputDevice: CharDevice {
    fn ctype(&self) -> CharType { CharType::Output }
    fn stype(&self) -> StreamType { StreamType::Buffer }

    fn read(&self, buf: &mut [u8], size: usize) -> DeviceResult<usize> 
        { Err(DeviceError::WrongCharIOMethod) }

    fn available(&self) -> DeviceResult<usize> 
        { Err(DeviceError::WrongCharIOMethod) }
}

#[allow(unused)]
pub trait CharStreamInputDevice: CharDevice {
    fn ctype(&self) -> CharType { CharType::Input }
    fn stype(&self) -> StreamType { StreamType::Stream }

    fn write(&self, buf: &[u8]) -> DeviceResult<usize> {
        Err(DeviceError::WrongCharIOMethod)
    }
}

#[allow(unused)]
pub trait CharStreamOutputDevice: CharOutputDevice {
    fn ctype(&self) -> CharType { CharType::Output }
    fn stype(&self) -> StreamType { StreamType::Stream }

    fn read(&self, buf: &mut [u8], size: usize) -> DeviceResult<usize> 
        { Err(DeviceError::WrongCharIOMethod) }

    fn available(&self) -> DeviceResult<usize> 
        { Err(DeviceError::WrongCharIOMethod) }

    fn seek(&self, offset: usize) -> DeviceResult<usize> 
        { Err(DeviceError::Unsupported) }
}

pub trait BlockDevice: Device {
    fn dtype(&self) -> DeviceType 
        { DeviceType::Block }

    fn block_size(&self) -> usize;

    fn num_blocks(&self) -> u64;

    fn read_block(&self, block_num: u64, buf: &mut [u8]) -> DeviceResult<()>;

    fn write_block(&self, block_num: u64, buf: &[u8]) -> DeviceResult<()>;

    fn sync(&self) -> DeviceResult<()>;
}

pub trait NetworkDevice: Device {
    fn dtype(&self) -> DeviceType 
        { DeviceType::Network }
}