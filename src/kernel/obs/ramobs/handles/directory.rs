use alloc::{string::String, sync::Arc, vec::Vec};
use hashbrown::HashMap;
use spin::RwLock;
use crate::kernel::{obs::ramobs::objects::RamobsDirectoryObject, vfs::{DirEntry, OpenFlags, Permission, PermissionContext, PermissionSet, VFS, VfsError, VfsResult, objects::{Object, handles::{DirectoryHandle, ObjectHandle}}}};

#[derive(Debug)]
pub struct RamobsDirectoryHandle {
    object: Arc<RamobsDirectoryObject>,
    flags: OpenFlags,
    map: Arc<RwLock<HashMap<String, DirEntry>>>,
    ctx: PermissionContext
}

impl RamobsDirectoryHandle {
    pub fn new(object: Arc<RamobsDirectoryObject>, flags: &OpenFlags, map: Arc<RwLock<HashMap<String, DirEntry>>>, ctx: &PermissionContext) -> Self{
        Self {
            object, 
            flags: flags.clone(),
            map,
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

impl DirectoryHandle for RamobsDirectoryHandle {
    fn create(&self, name: String, kind: crate::kernel::vfs::ObjectKind, permissions: &PermissionSet) -> VfsResult<Arc<dyn Object>> {
        self.check_write()?;
        if self.map.read().contains_key(&name) {
            return Err(VfsError::AlreadyExists)
        }

        let obj = self.object.superblock().create_inode(kind, permissions.clone())?;

        let inode_num = obj.metadata().read().inode_num;

        let dir_entry = DirEntry::new(&name, inode_num, kind);
        
        self.map.write().insert(name, dir_entry);

        Ok(obj.clone())
    }

    fn delete(&self, name: String) -> VfsResult<()> {
        self.check_write()?;

        let inode_num = self.map.read().get(&name).ok_or(VfsError::NotFound)?.inode;
        let obj = self.object.superblock().get_inode(inode_num)?;
        let ctx = self.context();
        if !VFS::check_permission_on_object(obj.clone(), &ctx.clone(), Permission::DELETE) {
            return Err(VfsError::PermissionDenied);
        }

        self.map.write().remove(&name).ok_or(VfsError::NotFound)?;
        self.object.superblock().delete_inode(inode_num)?;
        Ok(())
    }

    fn rename(&self, old_name: String, new_name: String) -> VfsResult<()> {
        self.check_write()?;

        let inode_num = self.map.read().get(&old_name).ok_or(VfsError::NotFound)?.inode;
        let obj = self.object.superblock().get_inode(inode_num)?;
        let ctx = self.context();
        if !VFS::check_permission_on_object(obj.clone(), &ctx.clone(), Permission::RENAME) {
            return Err(VfsError::PermissionDenied);
        }

        let mut writer = self.map.write();
        if !writer.contains_key(&old_name) {
            return Err(VfsError::NotFound);
        }

        if writer.contains_key(&new_name) {
            return Err(VfsError::AlreadyExists);
        }

        let mut dr = writer.get(&old_name).ok_or(VfsError::IoError)?.clone();

        dr.name = new_name.clone();

        writer.insert(new_name, dr);

        writer.remove(&old_name);

        Ok(())
    }

    fn lookup(&self, name: String) -> VfsResult<Arc<dyn Object>> {
        self.check_read()?;
        let reader = self.map.read();
        let dir_entry = reader.get(&name).ok_or(VfsError::NotFound)?;
        self.object.superblock().get_inode(dir_entry.inode)
    }

    fn entries(&self) -> VfsResult<Vec<DirEntry>> {
        self.check_read()?;
        Ok(self.map.read().values().cloned().collect())
    }
}

impl ObjectHandle for RamobsDirectoryHandle {
    fn object(&self) -> Arc<dyn Object> {
        self.object.clone()
    }

    fn flags(&self) -> OpenFlags {
        self.flags.clone()
    }

    fn as_directory_handle(self: Arc<Self>) -> Option<Arc<dyn DirectoryHandle>> {
        Some(self)
    }
    
    fn context(&self) -> PermissionContext {
        self.ctx.clone()
    }
}