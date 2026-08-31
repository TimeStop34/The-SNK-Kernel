use alloc::{string::String, sync::Arc};
use spin::RwLock;
use crate::kernel::{obs::ramobs::objects::RamobsSymlinkObject, vfs::{OpenFlags, PermissionContext, VfsError, VfsResult, objects::{Object, handles::{ObjectHandle, SymlinkHandle}}}};

#[derive(Debug)]
pub struct RamobsSymlinkHandle {
    object: Arc<RamobsSymlinkObject>,
    flags: OpenFlags,
    target: Arc<RwLock<String>>,
    ctx: PermissionContext
}

impl RamobsSymlinkHandle {
    pub fn new(object: Arc<RamobsSymlinkObject>, flags: &OpenFlags, target: Arc<RwLock<String>>, ctx: &PermissionContext) -> Self{
        Self {
            object, 
            flags: flags.clone(),
            target,
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
        if !self.flags.has(OpenFlags::WRITE) {
            return Err(VfsError::PermissionDenied);
        }
        Ok(())
    }
}

impl SymlinkHandle for RamobsSymlinkHandle {
    fn read_target(&self) -> VfsResult<String> {
        self.check_read()?;
        Ok(self.target.read().clone())
    }

    fn set_target(&self, target: String) -> VfsResult<()> {
        self.check_write()?;
        let mut guard = self.target.write();
        *guard = target;
        Ok(())
    }
}

impl ObjectHandle for RamobsSymlinkHandle {
    fn object(&self) -> Arc<dyn Object> {
        self.object.clone()
    }

    fn flags(&self) -> OpenFlags {
        self.flags.clone()
    }

    fn as_symlink_handle(self: Arc<Self>) -> Option<Arc<dyn SymlinkHandle>> {
        Some(self)
    }

    fn context(&self) -> PermissionContext {
        self.ctx.clone()
    }
}