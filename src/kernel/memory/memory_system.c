#include "memory_system.h"


void init_memory(multiboot_info_t *mb_info){
    pmm_init(mb_info);
}