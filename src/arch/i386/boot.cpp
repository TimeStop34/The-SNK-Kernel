/*
 * Copyright (C) 2025 TimeStop34
 * The SNK Kernel
 * 
 * Второй уровень "загрузчика ядра"
 */


#include <libs/multiboot.hpp>
#include <arch/custom/i386/i386.hpp>

extern "C" void kmain(Arch* arch);

extern "C" void kboot(uint32_t magic, vaddr_t multiboot_info_addr){
    if(magic != MULTIBOOT_BOOTLOADER_MAGIC) {
       for(;;);
    }

    i386Arch g_arch((bootsystem_struct*)multiboot_info_addr);

    kmain(&g_arch); 
    return;
}