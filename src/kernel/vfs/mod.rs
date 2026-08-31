pub mod objects;

mod defines;
pub use defines::*;

mod mountpoint;
pub use mountpoint::*;

mod superobject;
pub use superobject::*;

pub mod register;

use alloc::string::{String, ToString};
use alloc::sync::Arc;
use alloc::vec;
use alloc::vec::Vec;

use objects::handles::{ObjectHandle};
use objects::Object;
use objects::metadata::FileStat;

use alloc::format;

pub struct VFS {
    mount_table: MountTable,
}

#[allow(unused)]
impl VFS {
    pub fn new() -> Self {
        Self {
            mount_table: MountTable::new(),
        }
    }

    fn global_root(&self) -> VfsResult<Arc<dyn Object>> {
        Ok(self.mount_table
            .get("/")
            .ok_or(VfsError::NotFound)?
            .root_inode().or(Err(VfsError::IoError))?)
    }


    pub fn mount(
        &self,
        obs_id: String,
        path: String,
        source: String,
        flags: Option<MountFlags>,
        options: Option<&[String]>,
    ) -> VfsResult<()> {
        let obs = register::get(&obs_id).ok_or(VfsError::NotFound)?;
        let mountflags = flags.unwrap_or_default();
        let options = options.unwrap_or(&[]);
        let sb = obs.mount(source, mountflags, options)?;
        self.mount_table.mount(&path, sb, mountflags)
    }

    pub fn register_obs(obs: Arc<dyn ObjectSystem>) -> VfsResult<()> {
        register::register(obs)
    }

    pub fn open(&self, path: &str, flags: OpenFlags) -> VfsResult<Arc<dyn ObjectHandle>> {
        let ctx = self.default_context()?;
        self.open_with_ctx(path, flags, &ctx)
    }

    pub fn lookup(&self, path: &str) -> VfsResult<Arc<dyn Object>> {
        let ctx = self.default_context()?;
        self.lookup_with_ctx(path, &ctx)
    }

    pub fn readdir(&self, path: &str) -> VfsResult<Vec<DirEntry>> {
        let ctx = self.default_context()?;
        self.readdir_with_ctx(path, &ctx)
    }

    pub fn readdir_with_ctx(&self, path: &str, ctx: &PermissionContext) -> VfsResult<Vec<DirEntry>> {
        let handle = self.open_with_ctx(path, OpenFlags::READ, ctx)?;
        let dir_handle = handle.as_directory_handle()
            .ok_or(VfsError::NotDirectory)?;
        dir_handle.entries()
    }

    pub fn readlink(&self, path: &str) -> VfsResult<String> {
        let ctx = self.default_context()?;
        self.readlink_with_ctx(path, &ctx)
    }

    pub fn stat(&self, path: &str) -> VfsResult<FileStat> {
        let ctx = self.default_context()?;
        self.stat_with_ctx(path, &ctx)
    }

    pub fn chmod(&self, path: &str, permissions: PermissionSet) -> VfsResult<()> {
        let ctx = self.default_context()?;
        self.chmod_with_ctx(path, permissions, &ctx)
    }

    pub fn chown(&self, path: &str, uid: u16) -> VfsResult<()> {
        let ctx = self.default_context()?;
        self.chown_with_ctx(path, uid, &ctx)
    }

    pub fn open_with_ctx(
        &self,
        path: &str,
        flags: OpenFlags,
        ctx: &PermissionContext,
    ) -> VfsResult<Arc<dyn ObjectHandle>> {
        let obj = self.resolve_path_with_ctx(path, ctx)?;

        // Определяем необходимые права в зависимости от флагов и типа объекта
        let mut needed = Permission::NONE;
        if flags.has(OpenFlags::READ) {
            needed = needed.with(Permission::READ);
        }
        if flags.has(OpenFlags::WRITE) || flags.has(OpenFlags::APPEND) {
            needed = needed.with(Permission::WRITE);
        }

        // Для директорий при открытии требуется EXECUTE (возможность войти)
        if obj.clone().as_directory().is_some() {
            needed = needed.with(Permission::EXECUTE);
        }

        // Для симлинков: разрешено открытие только с READ (или без флагов), но не WRITE/APPEND
        if obj.clone().as_symlink().is_some() {
            if flags.has(OpenFlags::WRITE) || flags.has(OpenFlags::APPEND) || flags.has(OpenFlags::TRUNCATE) {
                return Err(VfsError::PermissionDenied);
            }
        }

        if !Self::check_permission_on_object(obj.clone(), ctx, needed) {
            return Err(VfsError::PermissionDenied);
        }

        obj.open(flags, &ctx.clone())
    }

    pub fn lookup_with_ctx(
        &self,
        path: &str,
        ctx: &PermissionContext,
    ) -> VfsResult<Arc<dyn Object>> {
        self.resolve_path_with_ctx(path, ctx)
    }

    pub fn readlink_with_ctx(
        &self,
        path: &str,
        ctx: &PermissionContext,
    ) -> VfsResult<String> {
        let handle = self.open_with_ctx(path, OpenFlags::READ, ctx)?;
        let sym_handle = handle.as_symlink_handle()
            .ok_or(VfsError::NotSymlink)?;
        sym_handle.read_target()
    }

    pub fn stat_with_ctx(
        &self,
        path: &str,
        ctx: &PermissionContext,
    ) -> VfsResult<FileStat> {
        let obj = self.resolve_path_with_ctx(path, ctx)?;
        let rw = obj.metadata();
        let meta = rw.read();
        let inner = &meta.inner.read();
        Ok(FileStat {
            inode_num: meta.inode_num,
            kind: meta.kind,
            size: inner.size,
            atime: inner.atime,
            mtime: inner.mtime,
            ctime: inner.ctime,
            permissions: inner.permissions.clone(),
            flags: inner.flags,
        })
    }

    pub fn chmod_with_ctx(
        &self,
        path: &str,
        permissions: PermissionSet,
        ctx: &PermissionContext,
    ) -> VfsResult<()> {
        let obj = self.resolve_path_with_ctx(path, ctx)?;
        let meta = obj.metadata();
        {
            let reader = meta.read();
            let perm = &reader.inner.read().permissions;
            let is_root = ctx.uid() == 0 || ctx.rid().iter().any(|&r| r == 0);
            if !is_root {
                let is_owner = ctx.uid() == perm.uid;
                let has_ruleset = ctx.rid().iter().any(|rid| {
                    perm.role_rights
                        .get(rid)
                        .map_or(false, |rights| rights.has(Permission::RULESET))
                });
                if !is_owner && !has_ruleset {
                    return Err(VfsError::PermissionDenied);
                }
            }
        }
        let writer = meta.write();
        writer.inner.write().permissions = permissions;
        Ok(())
    }

    pub fn chown_with_ctx(
        &self,
        path: &str,
        uid: u16,
        ctx: &PermissionContext,
    ) -> VfsResult<()> {
        let obj = self.resolve_path_with_ctx(path, ctx)?;
        let meta = obj.metadata();
        {
            let reader = meta.read();
            let perm = &reader.inner.read().permissions;
            let is_root = ctx.uid() == 0 || ctx.rid().iter().any(|&r| r == 0);
            if !is_root {
                let is_owner = ctx.uid() == perm.uid;
                let has_ruleset = ctx.rid().iter().any(|rid| {
                    perm.role_rights
                        .get(rid)
                        .map_or(false, |rights| rights.has(Permission::RULESET))
                });
                if !is_owner && !has_ruleset {
                    return Err(VfsError::PermissionDenied);
                }
            }
        }
        let writer = meta.write();
        writer.inner.write().uid = uid;
        Ok(())
    }

    pub fn chroot(&self, path: &str, ctx: &mut PermissionContext) -> VfsResult<()> {
        if ctx.uid() != 0 && !ctx.rid().iter().any(|&r| r == 0) {
            return Err(VfsError::PermissionDenied);
        }
        let new_root = self.resolve_path_with_ctx(path, ctx)?;
        if new_root.clone().as_directory().is_none() {
            return Err(VfsError::NotDirectory);
        }
        ctx.root = new_root;
        Ok(())
    }

    fn default_context(&self) -> VfsResult<PermissionContext> {
        let root = self.global_root()?;
        Ok(PermissionContext::new(0, vec![0], root))
    }

    fn resolve_path_with_ctx(
        &self,
        path: &str,
        ctx: &PermissionContext,
    ) -> VfsResult<Arc<dyn Object>> {
        if !path.starts_with('/') {
            return Err(VfsError::InvalidArgument);
        }
        if path.contains("/../") || path.ends_with("/..") || path.contains("/./") || path.ends_with("/.") {
            return Err(VfsError::InvalidArgument);
        }

        let mut current = ctx.root().clone();
        if path == "/" {
            return Ok(current);
        }

        let mut current_path = String::from("/");
        for component in path.split('/').filter(|&c| !c.is_empty()) {
            current_path = format!("{}/{}", current_path, component);

            // Проверка монтирования (глобальная таблица)
            if let Some(sb) = self.mount_table.get(&current_path) {
                current = sb.root_inode().or(Err(VfsError::IoError))?;
                continue;
            }

            // Проверяем, что current - это директория
            let dir = current.clone()
                .as_directory()
                .ok_or(VfsError::NotDirectory)?;
            
            // Для входа в каталог нужны EXECUTE и READ
            if !Self::check_permission_on_object(current.clone(), ctx, Permission::EXECUTE) {
                return Err(VfsError::PermissionDenied);
            }
            if !Self::check_permission_on_object(current.clone(), ctx, Permission::READ) {
                return Err(VfsError::PermissionDenied);
            }

            // Открываем директорию для поиска внутри
            let dir_handle = current.clone().open(OpenFlags::READ, &ctx.clone())?;
            let dir_handle = dir_handle.as_directory_handle()
                .ok_or(VfsError::NotDirectory)?;
            
            // Используем lookup через хендл (с проверкой флагов)
            let next = dir_handle.lookup(component.to_string())?;
            current = next;
        }

        Ok(current)
    }

    // Проверка, есть ли у контекста право `needed` на объекте
    pub fn check_permission_on_object(obj: Arc<dyn Object>, ctx: &PermissionContext, needed: Permission) -> bool {
        // root (uid=0 или rid содержит 0) имеет все права
        if ctx.uid() == 0 || ctx.rid().iter().any(|&r| r == 0) {
            return true;
        }

        let meta = obj.metadata();
        let meta_read = meta.read();
        let perm = &meta_read.inner.read().permissions;

        // Если владелец – разрешаем всё
        if ctx.uid() == perm.uid {
            return true;
        }

        // Проверяем права ролей
        for rid in ctx.rid() {
            if let Some(rights) = perm.role_rights.get(&rid) {
                if rights.has(needed) {
                    return true;
                }
            }
        }

        // Проверяем права по умолчанию
        perm.default_rights.has(needed)
    }
}