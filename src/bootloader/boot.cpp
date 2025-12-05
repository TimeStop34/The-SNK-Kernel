/*
 * Copyright (C) 2025 TimeStop34
 * The SNK Kernel
 * 
 * "Загрузчик" ядра, подготавливает виртуальную память - простейший identity/higher half маппинг ядра,
 * готовит магию и указатель структуры multiboot/multboot2, инициализирует простую Глобальную Таблицу Дескрипторов(GDT)
 */

#include "libs/multiboot.hpp"

__attribute__((section(".multiboot")))
const unsigned int multiboot_header[] = {
	MULTIBOOT_OS_MAGIC,
	0,
	-(MULTIBOOT_OS_MAGIC)
};


extern "C"{
    void early_gdt_init();
    void kmain(uint32_t magic, uintptr_t multiboot_info_addr);
    void early_enable_paging();
}

void higher_half_kernel_init();


extern "C" __attribute__((section(".boot")))
void early_boot(){
    early_gdt_init();

    higher_half_kernel_init();
}

__attribute__((section(".boot")))
void setup_higher_half_mapping() {
    vuint32_t *pd = (vuint32_t*)0x1000;
    vuint32_t *pte = (vuint32_t*)0x2000;  // PTE для identity/kernel mapping
    
    // Очищаем PDE и PTE
    for(uint32_t i = 0; i < 1024; i++) {
        pd[i] = 0;
        if(i < 1024) pte[i] = 0;
    }
    
    // 1. Identity mapping первых 4MB (0x00000000 -> 0x00000000)
    for(uint32_t i = 0; i < 1024; i++) {
        pte[i] = (i * 0x1000) | 0x03;
    }
    
    // Настраиваем PDE:
    // PDE[0] - identity mapping первых 4MB
    pd[0] = (vuint32_t)pte | 0x03;
    
    // PDE[768] - higher half kernel mapping (0xC0000000)
    // 768 = 0xC0000000 >> 22
    pd[768] = (vuint32_t)pte | 0x03;
    pd[1023] = (vuint32_t)pd | 0x03;
}

__attribute__((section(".boot")))
void higher_half_kernel_init(){
    setup_higher_half_mapping();
    early_enable_paging();
    *(vuint16_t*)0xB8000 = 0x2F4F;
    *(vuint16_t*)0xB8002 = 0x2F4B;

    // Получение данных multiboot/multiboot2(схема таже, регистры таже, но тип магии и таблицы другой, выбирает само ядро)

    uint32_t magic;
    uintptr_t multiboot_info_addr;
    __asm__ volatile ("movl %%eax, %0" : "=r" (magic));
    __asm__ volatile ("movl %%ebx, %0" : "=r" (multiboot_info_addr));
    kmain(magic | 0x03, multiboot_info_addr | 0x03);
}

__attribute__((section(".boot")))
void page_fault_handler() {
    *((vuint16_t*) 0xB8000) = 0x2f41;
    for(;;);
}