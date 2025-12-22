#include "libs/manybootloader_system.hpp"
#include "arch/arch.hpp"

extern "C" void kmain(Arch* kernel_arch){
    *(vuint16_t*)0xB8000 = 0x3F4B;
    /*
    This is a old C-based kernel initialization system:
    ```c
        gdt_init();

        init_memory(structure_to_memory_initialization);

        BASE_IDT_SETUP(); // -> PIC_remap(); IDT_load();

        kapi_system_init();
        uapi_system_inti();

        init_driver_system();

        uapi_system_lateinit();

        virtual_devices_system_init();

        setup_char_devices();

	    terminal_initialize();

        setup_block_devices();

        vfs_init();

        pm_init();

        init_section();
    ```

    This is a new C++-based kernel initialization system:
    ```cpp
        kernel_arch.finalize_setup();

        DriverManager* dm = kernel_arch.get_driver_manager();

        CharDevicesManager cdm = dm.getCharDevicesManager();
        BlockDevicesManager bdm = dm.getBlockDevicesManager();

        InitializeVirtualTerminalSystem(&cdm);
        kprintf("Terminal initialzied!");
        
        ApiManager uapi;
        register_user_api(&uapi);

        VFS rvfs = *setup_root_vfs();

        ProgramManagmentService pm;

        pm.initialize_userland();`

        kpanic("Init die!");
    ```

    */
   
    kernel_arch->finalize_setup();
    
    DriverManager* dm = kernel_arch->get_driver_manager();
    
    dm->setup_devices();

    for (;;);
    return;
}