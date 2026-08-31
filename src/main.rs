#![no_std]
#![no_main]
#![feature(alloc_error_handler)]
#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    loop {}
}

/*
 *  Секция импортов и модулей (т.к. в Rust мы обязаны это делать в главном файле проекта, 
 *      а заморачиваться с build'ами я пока не собираюсь, 
 *          ведь в c++ это сделать было легко, а тут не так просто)
 */

mod kernel; // Главный модуль ядра


// Загрузчик. К сожалению пока что одноархитектурный :( 
// Точнее система встраивания одноархитектурная
mod i386; 

use kernel::arch::{
    Arch, RawArch, ArchAllocator,
    DeviceManager, CharDM, BlockDM, NetworkDM
};
use kernel::sma;

use kernel::vfs::VFS;

extern crate alloc;
use alloc::boxed::Box;
use alloc::sync::Arc;
use alloc::string::ToString;

use crate::kernel::obs;
use crate::kernel::vfs::OpenFlags;

use kernel::globals;

/*
 * Инициализатор ядра
 */

pub fn kmain(raw_arch: &dyn RawArch) -> ! {
    // Настройка статического аллокатора 
    // на работу с динамическим, 
    // полученным из архитектуры
    unsafe { 
        let mut _allocator: &'static dyn ArchAllocator = raw_arch.get_arch_allocator();
        sma::init_global_allocator(_allocator);
    }

    let arch: Box<dyn Arch> = raw_arch.finalize_setup();
    
    let dm: Arc<dyn DeviceManager> = arch.device_manager();
    dm.init();

    let cdm: Arc<dyn CharDM> = dm.char_dm();
    let bdm: Arc<dyn BlockDM> = dm.block_dm();
    let ndm: Arc<dyn NetworkDM> = dm.network_dm();

    globals::init_globals(cdm, bdm, ndm, dm);

    let vfs: VFS = VFS::new(); // стадия 2
    
    let _ = obs::register_all();

    let _root_result = vfs.mount("ramobs".to_string(), "/".to_string(), "".to_string(), None, None);
    
    {
       vfs.open("/", OpenFlags::READ);
    }

    unsafe { 
        *(0xB8000 as *mut u8) = 'O' as u8;
        *(0xB8002 as *mut u8) = 'K' as u8;
    }

    /*
      Новая реализация загрузки на расте

      let api_manager: Arc<dyn ApiManager> = arch.api_manager(); // стадия 4

      let dm: Arc<dyn DeviceManager> = arch.device_manager();  // стадия 1 - Сделано
      dm.init(); // стадия 1 - Сделано

      let cdm: Arc<dyn CharDM> = dm.char_dm();                 // стадия 1.1 - Сделано кроме устроств
      let bdm: Arc<dyn BlockDM> = dm.block_dm();               // стадия 1.2 - Сделано кроме устроств
      let ndm: Arc<dyn NetworkDM> = dm.network_dm();             // стадия 1.2 (Трейты и реализация, кроме устройств) + Ядро 2.0 (Фактическое использование)

      let vfs: VFS = Vfs::new(); // стадия 2

      let pm: ProgramManager = pm::init(); // стадия 3
      
      setup_kernel_api(); // стадия 4

      pm.initialize_userland(); // стадия 5

      panic!("Init die!");
    
     */

    loop {}
}