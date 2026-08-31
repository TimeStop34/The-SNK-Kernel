use crate::kernel::vfs::VfsResult;
use super::super::super::{SeekWhence, SeekPolicy};
use super::ObjectHandle;

#[allow(unused)]
pub trait FileHandle: ObjectHandle + Send + Sync {
    fn position(&self) -> VfsResult<u32>;
    fn seek(&self, offset: i64, seek: SeekWhence) -> VfsResult<u32>;

    fn seek_policy(&self) -> VfsResult<SeekPolicy>;
    fn set_seek_policy(&self, policy: &SeekPolicy) -> VfsResult<()>;

    // Новый метод для получения размера файла (перенесён из FileObject)
    fn size(&self) -> VfsResult<u32>;

    // Если Unblocked если pos + size > end то тогда читаеться всё до end файла, иначе ошибка OutOfFile
    fn read(&self, buf: &mut [u8], size: usize, unblocked: bool) -> VfsResult<usize>; 

    fn readlinef(&self, buf: &mut [u8], size: usize, unblocked: bool) -> VfsResult<usize>;
    fn readline(&self, buf: &mut [u8]) -> VfsResult<usize>;

    fn sizeline(&self) -> VfsResult<u32>;
    fn sizeline_at(&self, offset: u32) -> VfsResult<u32>;

    fn readfull(&self, buf: &mut [u8]) -> VfsResult<usize>;

    fn readlinef_at(&self, buf: &mut [u8], size: usize, offset: u32, unblocked: bool) -> VfsResult<usize>;
    fn readline_at(&self, buf: &mut [u8], offset: u32, unblocked: bool) -> VfsResult<usize>;

    fn write(&self, buf: &[u8]) -> VfsResult<()>;

    fn read_at(&self, offset: u32, buf: &mut [u8], size: usize, unblocked: bool) -> VfsResult<usize>;
    fn write_at(&self, offset: u32, buf: &[u8]) -> VfsResult<()>;
    fn truncate(&self, new_size: u32) -> VfsResult<()>;
}