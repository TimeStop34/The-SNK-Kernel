use hashbrown::HashMap;
use spin::RwLock;
use alloc::{string::String, sync::Arc};
use crate::kernel::{obs::ramobs::handles::RamobsDirectoryHandle, vfs::{DirEntry, OpenFlags, PermissionContext, SuperObject, VfsResult, objects::{DirectoryObject, Object, handles::ObjectHandle, metadata::Metadata}}};

#[derive(Debug)]
pub struct RamobsDirectoryObject {
    map: Arc<RwLock<HashMap<String, DirEntry>>>,
    superobject: Arc<dyn SuperObject>,
    metadata: Arc<RwLock<Metadata>>
}

impl RamobsDirectoryObject {
    pub fn new(superobject: Arc<dyn SuperObject>, metadata: Arc<RwLock<Metadata>>) -> Self{
        let map: Arc<RwLock<HashMap<String, DirEntry>>> = Arc::new(RwLock::new(HashMap::new()));
        Self {
            map,
            superobject,
            metadata
        }
    }
}

impl DirectoryObject for RamobsDirectoryObject {
}

impl Object for RamobsDirectoryObject {
    fn metadata(&self) -> Arc<RwLock<Metadata>> {
        self.metadata.clone()
    }
    
    fn open(self: Arc<Self>, flags: OpenFlags, ctx: &PermissionContext) 
    -> VfsResult<Arc<dyn ObjectHandle>> {
        let dh = RamobsDirectoryHandle::new(
            self.clone(), 
            &flags,
            self.map.clone(),
            ctx
        );
        Ok(Arc::new(dh))
    }

    fn as_directory(self: Arc<Self>) -> Option<Arc<dyn DirectoryObject>> { Some(self) }
    
    fn superblock(&self) -> Arc<dyn crate::kernel::vfs::SuperObject> {
        self.superobject.clone()
    }
}