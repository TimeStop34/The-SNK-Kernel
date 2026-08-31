use alloc::{sync::Arc};
use spin::{RwLock};
use crate::kernel::{obs::ramobs::objects::{RamobsFileData, RamobsFileObject}, vfs::{OpenFlags, PermissionContext, SeekPolicy, SeekWhence, VfsError, VfsResult, objects::{Object, handles::{FileHandle, ObjectHandle}}}};
use memchr::memchr;


#[derive(Debug)]
pub struct RamobsFileHandle {
    object: Arc<RamobsFileObject>,
    flags: OpenFlags,
    data: Arc<RwLock<RamobsFileData>>,
    position: RwLock<u32>,
    seek_policy: RwLock<SeekPolicy>,
    ctx: PermissionContext
}

impl RamobsFileHandle {
    pub fn new(object: Arc<RamobsFileObject>, flags: &OpenFlags, data: Arc<RwLock<RamobsFileData>>, ctx: &PermissionContext) -> Self{
        Self {
            object, 
            flags: flags.clone(),
            data,
            position: RwLock::new(0u32),
            seek_policy: RwLock::new(SeekPolicy { disable_negative: false, allow_out_of_file: false }),
            ctx: ctx.clone()
        }
    }

    fn check_read(&self) -> VfsResult<()> {
        if !self.flags.has(OpenFlags::READ) {
            return Err(VfsError::PermissionDenied);
        }
        Ok(())
    }

    fn check_write(&self) -> VfsResult<()> {
        if !self.flags.has(OpenFlags::WRITE) && !self.flags.has(OpenFlags::APPEND) {
            return Err(VfsError::PermissionDenied);
        }
        Ok(())
    }
}

impl FileHandle for RamobsFileHandle {
    fn size(&self) -> VfsResult<u32> {
        Ok(self.object.metadata().read().inner.read().size)
    }

    fn position(&self) -> VfsResult<u32> {
        Ok(*self.position.read())
    }

    fn seek(&self, offset: i64, seek: SeekWhence) -> VfsResult<u32> {
        let size = self.size()? as i64;

        let SeekPolicy{disable_negative, allow_out_of_file} = self.seek_policy()?;

        let mut position: i64 = match seek {
            SeekWhence::Cur => {
                *self.position.read() as i64 + offset
            },
            SeekWhence::Set => {
                offset
            },
            SeekWhence::End => {
               size + offset
            }
        };

        if position > size && !allow_out_of_file{
            return Err(VfsError::OutOfFile)
        } else {
            position = size;
        }

        if position < 0 && disable_negative{
            return Err(VfsError::OutOfFile)
        } else {
            position = 0;
        }

        let final_position: u32 = position as u32;

        *(self.position.write()) = final_position;
        Ok(final_position)
    }

    fn seek_policy(&self) -> VfsResult<SeekPolicy> {
        Ok(self.seek_policy.read().clone())
    }

    fn set_seek_policy(&self, policy: &SeekPolicy) -> VfsResult<()> {
        let mut writer = self.seek_policy.write();
        *writer = policy.clone();
        Ok(())
    }

    fn read(&self, buf: &mut [u8], size: usize, unblocked: bool) -> VfsResult<usize> {
        self.check_read()?;
        let pos = self.position()?;
        let read_bytes = self.read_at(pos, buf, size, unblocked)?;
        self.seek(read_bytes as i64, SeekWhence::Cur)?;
        Ok(read_bytes)
    }

    fn readlinef(&self, buf: &mut [u8], size: usize, unblocked: bool) -> VfsResult<usize> {
        self.check_read()?;
        let line_len = self.sizeline()? as usize;
        let to_read = line_len.min(size);
        if to_read == 0 {
            return Ok(0);
        }
        self.read(buf, to_read, unblocked)
    }

    fn readline(&self, buf: &mut [u8]) -> VfsResult<usize> {
        self.check_read()?;
        let line_len = self.sizeline()? as usize;
        if line_len == 0 {
            return Ok(0);
        }
        if buf.len() < line_len {
            return Err(VfsError::IoError);
        }
        self.read(buf, line_len, false)
    }

    fn sizeline(&self) -> VfsResult<u32> {
        self.check_read()?;
        let pos = self.position()?;
        self.sizeline_at(pos)
    }

    fn sizeline_at(&self, offset: u32) -> VfsResult<u32> {
        self.check_read()?;
        let reader = self.data.read();
        let file_size = self.size()?;

        if offset > file_size {
            return Err(VfsError::OutOfFile);
        }
        if offset == file_size {
            return Ok(0);
        }

        let data_slice = &reader.data[offset as usize..];

        match memchr(b'\n', data_slice) {
            Some(relative_pos) => {
                // Длина строки = позиция символа + 1, **включая** сам '\n' 
                Ok((relative_pos + 1) as u32)
            }
            None => {
                // Нет перевода строки – вся оставшаяся часть файла
                Ok(file_size - offset)
            }
        }
    }

    fn readfull(&self, buf: &mut [u8]) -> VfsResult<usize> {
        self.check_read()?;
        self.read(buf, buf.len(), false)
    }

    fn readlinef_at(&self, buf: &mut [u8], size: usize, offset: u32, unblocked: bool) -> VfsResult<usize> {
        self.check_read()?;
        let line_len = self.sizeline_at(offset)? as usize;
        let to_read = line_len.min(size);
        if to_read == 0 {
            return Ok(0);
        }
        self.read_at(offset, buf, to_read, unblocked)
    }

    fn readline_at(&self, buf: &mut [u8], offset: u32, unblocked: bool) -> VfsResult<usize> {
        self.check_read()?;
        let line_len = self.sizeline_at(offset)? as usize;
        if line_len == 0 {
            return Ok(0);
        }
        if buf.len() < line_len {
            return Err(VfsError::IoError);
        }
        self.read_at(offset, buf, line_len, unblocked)
    }

    fn read_at(&self, offset: u32, buf: &mut [u8], size: usize, unblocked: bool) -> VfsResult<usize> {
        self.check_read()?;
        let reader = self.data.read();
        let file_size = self.size()?;
        if offset > file_size {
            return Err(VfsError::OutOfFile);
        }
        let available = (file_size - offset) as usize;

        if !unblocked {
            if size > available {
                return Err(VfsError::OutOfFile);
            }
            let start = offset as usize;
            for i in 0..size {
                buf[i] = reader.data[start + i];
            }
            Ok(size)
        } else {
            let to_read = size.min(available);
            let start = offset as usize;
            for i in 0..to_read {
                buf[i] = reader.data[start + i];
            }
            Ok(to_read)
        }
    }

    fn write_at(&self, offset: u32, buf: &[u8]) -> VfsResult<()> {
        self.check_write()?;
        let file_size = self.size()?;
        if offset > file_size {
            return Err(VfsError::OutOfFile);
        }
        let end_offset = offset as usize + buf.len();
        if end_offset > file_size as usize {
            return Err(VfsError::OutOfFile);
        }

        let mut writer = self.data.write();
        let start = offset as usize;
        // копируем данные
        writer.data[start..end_offset].copy_from_slice(buf);
        Ok(())
    }

    fn write(&self, buf: &[u8]) -> VfsResult<()> {
        self.check_write()?;
        let pos = self.position()?;
        self.write_at(pos, buf)?;
        self.seek(buf.len() as i64, SeekWhence::Cur)?;
        Ok(())
    }

    fn truncate(&self, new_size: u32) -> VfsResult<()> {
        self.check_write()?;
        let mut writer = self.data.write();
        writer.data.resize(new_size as usize, 0);
        
        let mut pos = self.position.write();
        if *pos > new_size {
            *pos = new_size;
        }
        Ok(())
    }
}

impl ObjectHandle for RamobsFileHandle {
    fn object(&self) -> Arc<dyn Object> {
        self.object.clone()
    }

    fn flags(&self) -> OpenFlags {
        self.flags.clone()
    }
    
    fn as_file_handle(self: Arc<Self>) -> Option<Arc<dyn FileHandle>> {
        Some(self)
    }
    
    fn context(&self) -> PermissionContext {
        self.ctx.clone()
    }
}