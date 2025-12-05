#include "libs/multiboot.hpp"

extern "C" void kmain(int32_t magic, multiboot_info_t* multiboot_info_addr){
    if(magic != MULTIBOOT_BOOTLOADER_MAGIC) {
        for (;;);
    }

    return;
}