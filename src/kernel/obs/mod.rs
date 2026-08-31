/// Модуль включения реализаций obs/fs, с регистрацией в глобальном менеджере

pub mod ramobs;
use ramobs::*;


use alloc::sync::Arc;
use crate::kernel::vfs::{
    ObjectSystem, VFS,
    VfsResult};

pub fn register_all() -> VfsResult<()>{
    let ramobs = Arc::new(RamObS::new());

    VFS::register_obs(ramobs as Arc<dyn ObjectSystem>)?;
    Ok(())
}