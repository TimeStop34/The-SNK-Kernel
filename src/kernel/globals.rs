// src/kernel/globals.rs

use alloc::sync::Arc;
use spin::Once;

use crate::kernel::arch::{CharDM, BlockDM, NetworkDM, DeviceManager};

static CHAR_DM: Once<Arc<dyn CharDM>> = Once::new();
static BLOCK_DM: Once<Arc<dyn BlockDM>> = Once::new();
static NETWORK_DM: Once<Arc<dyn NetworkDM>> = Once::new();
static DEVICE_MANAGER: Once<Arc<dyn DeviceManager>> = Once::new();

/// Инициализирует глобальные менеджеры (вызывается один раз в kmain)
pub fn init_globals(
    char_dm: Arc<dyn CharDM>,
    block_dm: Arc<dyn BlockDM>,
    network_dm: Arc<dyn NetworkDM>,
    device_manager: Arc<dyn DeviceManager>,
) {
    CHAR_DM.call_once(|| char_dm);
    BLOCK_DM.call_once(|| block_dm);
    NETWORK_DM.call_once(|| network_dm);
    DEVICE_MANAGER.call_once(|| device_manager);
}

/// Возвращает ссылку на глобальный CharDM, если он инициализирован
pub fn char_dm() -> Option<&'static Arc<dyn CharDM>> {
    CHAR_DM.get()
}

/// Возвращает ссылку на глобальный BlockDM, если он инициализирован
pub fn block_dm() -> Option<&'static Arc<dyn BlockDM>> {
    BLOCK_DM.get()
}

/// Возвращает ссылку на глобальный NetworkDM, если он инициализирован
pub fn network_dm() -> Option<&'static Arc<dyn NetworkDM>> {
    NETWORK_DM.get()
}

/// Возвращает ссылку на глобальный DeviceManager, если он инициализирован
#[allow(unused)]
pub fn device_manager() -> Option<&'static Arc<dyn DeviceManager>> {
    DEVICE_MANAGER.get()
}