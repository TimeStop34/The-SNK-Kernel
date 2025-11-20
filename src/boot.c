extern void early_gdt_init();
extern void kmain();
extern void early_enable_paging();

__attribute__((section(".boot")))
void early_boot(){
    early_gdt_init();

    higher_half_kernel_init();
}

__attribute__((section(".boot")))
void setup_higher_half_mapping() {
    unsigned int *pd = (unsigned int*)0x1000;
    unsigned int *pte = (unsigned int*)0x2000;  // PTE для identity/kernel mapping
    
    // Очищаем PDE и PTE
    for(int i = 0; i < 1024; i++) {
        pd[i] = 0;
        if(i < 1024) pte[i] = 0;
    }
    
    // 1. Identity mapping первых 4MB (0x00000000 -> 0x00000000)
    for(int i = 0; i < 1024; i++) {
        pte[i] = (i * 0x1000) | 0x03;
    }
    
    // Настраиваем PDE:
    // PDE[0] - identity mapping первых 4MB
    pd[0] = (unsigned int)pte | 0x03;
    
    // PDE[768] - higher half kernel mapping (0xC0000000)
    // 768 = 0xC0000000 >> 22
    pd[768] = (unsigned int)pte | 0x03;
    pd[1023] = (unsigned int)pd | 0x03;
}

__attribute__((section(".boot")))
void higher_half_kernel_init(){
    setup_higher_half_mapping();
    early_enable_paging();
    *(unsigned short*)0xB8000 = 0x2F4F;
    *(unsigned short*)0xB8002 = 0x2F4B;
    kmain();
}

__attribute__((section(".boot")))
void page_fault_handler() {
    *((unsigned short*) 0xB8000) = 0x2f41;
}