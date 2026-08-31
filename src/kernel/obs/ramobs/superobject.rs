use alloc::{string::{String, ToString}, sync::Arc};
use hashbrown::HashMap;
use spin::{RwLock};

use crate::kernel::{obs::ramobs::objects::{RamobsDeviceObject, RamobsFileObject, RamobsSymlinkObject}, vfs::{FsStats, ObjectKind, Permission, PermissionSet, SnkObSFlags, SuperObject, VfsError, VfsResult, objects::{Object, metadata::{Metadata, MetadataInner}}}};
use super::objects::RamobsDirectoryObject;

#[derive(Debug)]
#[allow(unused)]
pub struct RamobsSuperObject {
    root: u32,
    inodes: Arc<RwLock<HashMap<u32, Arc<dyn Object>>>>,
    counter: RwLock<u32>,
    max: u32
}

impl RamobsSuperObject {
    #[allow(unused)]
    pub fn new(max_inodes: u32) -> Arc<Self> {
        let mut hm: HashMap<u32, Arc<dyn Object>> = HashMap::new();

        let selfs = Arc::new(Self {
            root: 0,
            inodes: Arc::new(RwLock::new(hm)),
            counter: RwLock::new(0),
            max: max_inodes
        });

        let mut rights: HashMap<u16, Permission> = HashMap::new();
        rights.insert(0, Permission::ALL);

        let pm = PermissionSet {
            uid: 0,
            role_rights:  rights,
            default_rights: Permission::NONE
        };

        selfs.clone().create_inode(
            ObjectKind::Directory,
            pm
        );
        
        selfs
    }
}

impl SuperObject for RamobsSuperObject {
    fn fs_type(&self) -> String {
        "ramobs".to_string()
    }

    fn root_inode(&self) -> VfsResult<Arc<dyn Object>>  {
        self.get_inode(0)
    }

    fn stats(&self) -> VfsResult<FsStats> {
        let t = self.inodes.read().len() as u32;
        let f = self.max - t;
        Ok(
            FsStats {
                total_blocks: 0,
                free_blocks: 0,
                total_inodes: t as u64,
                free_inodes: f as u64
            }
        )
    }

    fn sync(&self) -> VfsResult<()> {
        Ok(()) // RamObS не нуждаеться в sync'е
    }

    fn unmount(self: Arc<Self>) -> VfsResult<()> {
        drop(self);
        Ok(())
    }
    
    fn get_inode(&self, inode_num: u32) -> VfsResult<Arc<dyn Object>> {
        Ok(self.inodes.read().get(&inode_num).cloned().ok_or(VfsError::NotFound)?)
    }
    
    fn create_inode(self: Arc<Self>, kind: crate::kernel::vfs::ObjectKind, permissions: crate::kernel::vfs::PermissionSet) -> VfsResult<Arc<dyn Object>> {
        let mut c = self.counter.write();

        if *c + 1 > self.max {
            return Err(VfsError::NoSpace);
        }
        
        let metadata = Metadata {
            inode_num: *c,
            kind: kind.clone(),
            inner: RwLock::new(MetadataInner {
                uid: permissions.uid,
                size: 0,
                atime: 0,
                mtime: 0,
                ctime: 0,
                permissions: permissions,
                flags: SnkObSFlags::NONE
            })
        }; 

        let obj = match kind {
            ObjectKind::File => {
                let obj = RamobsFileObject::new(self.clone(), Arc::new(RwLock::new(metadata)));
                Arc::new(obj) as Arc<dyn Object>
            },

            ObjectKind::Directory => {
                let obj = RamobsDirectoryObject::new(self.clone(), Arc::new(RwLock::new(metadata)));
                Arc::new(obj) as Arc<dyn Object>
            },

            ObjectKind::Symlink => {
                let obj = RamobsSymlinkObject::new(self.clone(), Arc::new(RwLock::new(metadata)));
                Arc::new(obj) as Arc<dyn Object>
            },

            ObjectKind::Device => {
                let obj = RamobsDeviceObject::new(self.clone(), Arc::new(RwLock::new(metadata)));
                Arc::new(obj) as Arc<dyn Object>
            }
        };

        self.inodes.write().insert(*c, obj.clone());

        *c = *c + 1;

        Ok(obj)
    }

    fn delete_inode(&self, inode_num: u32) -> VfsResult<()> {
        if !self.inodes.read().contains_key(&inode_num){
            return Err(VfsError::NotFound);
        }

        self.inodes.write().remove(&inode_num);

        Ok(())
    }
}