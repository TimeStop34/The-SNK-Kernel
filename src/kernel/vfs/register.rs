extern crate alloc;

use alloc::sync::Arc;
use alloc::string::String;
use hashbrown::HashMap;
use spin::{Once, RwLock};

use crate::kernel::vfs::{VfsError, VfsResult};
use super::ObjectSystem;

static REGISTRY: Once<RwLock<HashMap<String, Arc<dyn ObjectSystem>>>> = Once::new();

fn registry() -> &'static RwLock<HashMap<String, Arc<dyn ObjectSystem>>> {
    REGISTRY.call_once(|| RwLock::new(HashMap::new()))
}

#[allow(unused)]
pub fn register(obj: Arc<dyn ObjectSystem>) -> VfsResult<()> {
    let name = obj.name();
    let mut map = registry().write();
    if map.contains_key(&name) {
        return Err(VfsError::AlreadyExists);
    }
    map.insert(name, obj);
    Ok(())
}

pub fn get(name: &str) -> Option<Arc<dyn ObjectSystem>> {
    registry().read().get(name).cloned()
}