#include "vmm.h"

void vmm_init(multiboot_info_t *mb_info) {
    pmm_init(mb_info);
    paging_init();
}