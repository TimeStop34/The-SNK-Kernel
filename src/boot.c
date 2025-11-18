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
    unsigned int *pde = (unsigned int*)0x1000;
    unsigned int *pte_identity = (unsigned int*)0x2000;  // PTE для identity mapping
    unsigned int *pte_kernel = (unsigned int*)0x3000;    // PTE для kernel mapping
    
    // Очищаем PDE и PTE
    for(int i = 0; i < 1024; i++) {
        pde[i] = 0;
        if(i < 1024) pte_identity[i] = 0;
        if(i < 1024) pte_kernel[i] = 0;
    }
    
    // 1. Identity mapping первых 4MB (0x00000000 -> 0x00000000)
    for(int i = 0; i < 1024; i++) {
        pte_identity[i] = (i * 0x1000) | 0x003;
    }
    
    // 2. Higher half mapping (0xC0000000 -> 0x00000000)
    for(int i = 0; i < 1024; i++) {
        pte_kernel[i] = (i * 0x1000) | 0x003;
    }
    
    // Настраиваем PDE:
    // PDE[0] - identity mapping первых 4MB
    pde[0] = (unsigned int)pte_identity | 0x003;
    
    // PDE[768] - higher half kernel mapping (0xC0000000)
    // 768 = 0xC0000000 >> 22
    pde[768] = (unsigned int)pte_kernel | 0x003;
}

__attribute__((section(".boot")))
void higher_half_kernel_init(){
    setup_higher_half_mapping();
    early_enable_paging();
    *(unsigned short*)0xB8000 = 0x2F4F;
    *(unsigned short*)0xB8002 = 0x2F4B;
    kmain();
}