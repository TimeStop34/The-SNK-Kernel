use spin::RwLock;
use alloc::{string::String, sync::Arc};
use crate::kernel::{obs::ramobs::handles::RamobsSymlinkHandle, vfs::{OpenFlags, PermissionContext, SuperObject, VfsResult, objects::{Object, SymlinkObject, handles::ObjectHandle, metadata::Metadata}}};

#[derive(Debug)]
pub struct RamobsSymlinkObject {
    target: Arc<RwLock<String>>,
    superobject: Arc<dyn SuperObject>,
    metadata: Arc<RwLock<Metadata>>
}

impl RamobsSymlinkObject {
    pub fn new(superobject: Arc<dyn SuperObject>, metadata: Arc<RwLock<Metadata>>) -> Self{
        Self {
            metadata, 
            target: Arc::new(RwLock::new(String::new())),
            superobject
        }
    }
}

impl SymlinkObject for RamobsSymlinkObject {
}

impl Object for RamobsSymlinkObject {
    fn metadata(&self) -> Arc<RwLock<Metadata>> {
        self.metadata.clone()
    }
    
    fn open(self: Arc<Self>, flags: OpenFlags, ctx: &PermissionContext) 
    -> VfsResult<Arc<dyn ObjectHandle>> {
        let sh = RamobsSymlinkHandle::new(self.clone(), &flags, self.target.clone(), ctx);
        Ok(Arc::new(sh))
    }

    fn as_symlink(self: Arc<Self>) -> Option<Arc<dyn SymlinkObject>>  { Some(self) }
    
    fn superblock(&self) -> Arc<dyn crate::kernel::vfs::SuperObject> {
        self.superobject.clone()
    }
}