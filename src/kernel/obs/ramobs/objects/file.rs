use spin::RwLock;
use alloc::{sync::Arc, vec::Vec};
use crate::kernel::{obs::ramobs::handles::RamobsFileHandle, vfs::{OpenFlags, PermissionContext, SuperObject, VfsResult, objects::{FileObject, Object, handles::ObjectHandle, metadata::Metadata}}};

#[derive(Debug)]
pub struct RamobsFileData {
    pub data: Vec<u8>
}

impl RamobsFileData {
    pub fn new() -> Self {
        Self { data: Vec::new() }
    }
}

#[derive(Debug)]
pub struct RamobsFileObject {
    superobject: Arc<dyn SuperObject>,
    metadata: Arc<RwLock<Metadata>>,
    data: Arc<RwLock<RamobsFileData>>,
}

impl RamobsFileObject {
    pub fn new(superobject: Arc<dyn SuperObject>, metadata: Arc<RwLock<Metadata>>) -> Self {
        Self {
            superobject,
            metadata,
            data: Arc::new(RwLock::new(RamobsFileData::new())),
        }
    }
}

impl FileObject for RamobsFileObject {
}

impl Object for RamobsFileObject {
    fn metadata(&self) -> Arc<RwLock<Metadata>> {
        self.metadata.clone()
    }

    fn open(self: Arc<Self>, flags: OpenFlags, ctx: &PermissionContext) -> VfsResult<Arc<dyn ObjectHandle>> {
        let fh = RamobsFileHandle::new(self.clone(), &flags, self.data.clone(), ctx);
        Ok(Arc::new(fh))
    }

    fn as_file(self: Arc<Self>) -> Option<Arc<dyn FileObject>> {
        Some(self)
    }

    fn superblock(&self) -> Arc<dyn crate::kernel::vfs::SuperObject> {
        self.superobject.clone()
    }
}