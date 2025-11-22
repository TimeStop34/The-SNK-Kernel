// GRUB header
__attribute__((section(".multiboot")))
const unsigned int multiboot_header[] = {
	0x1BADB002,
	0,
	-(0x1BADB002)
};


// libs
//#include "libs/string.h"
// #include "libs/time.h"
// #include "libs/io.h"
#include "kernel/libs/asm/asm.h"
// #include "libs/memory.h"

// Kernel
#include "kernel/gdt/gdt.h"
#include "kernel/idt/IDT_PIC.h"
#include "kernel/memory/memory_system.h"

#include "kernel/libs/io/io.h"

// drivers
// #include "drivers/drivers.h"
// #include "drivers/keyboard/keyboard.h"
// #include "drivers/display/display.h"
// #include "drivers/pit/pit.h"
// #include "drivers/vfs/vfs.h"
// #include "drivers/disks/disk.h"
#include "kernel/drivers/drivers.h"
#include "kernel/drivers/devices.h"

// api
// include "api/api.h" <- not implemented


struct multiboot_struct{
	unsigned int flags;
	unsigned int mem_lower;
	unsigned int mem_upper;
	unsigned int boot_device;
	unsigned int cmdline;
	unsigned int mods_count;
	unsigned int mods_addr;
	unsigned char syms[12];
	unsigned int mmap_length;
	unsigned int mmap_addr;
	// Дальше не надо
} __attribute__((packed));

struct multiboot_mmap_struct {
	unsigned int size;      // размер структуры, обычно 20
	unsigned long addr;      // физический адрес начала области
	unsigned long len;       // длина области в байтах
	unsigned int type;      // тип области: 1 доступная (ram), 2 резерв, 3 acpi reclaimable, 4 acpi NVS, 5 bad memory (поврежденная)
} __attribute__((packed));


// For kernel logs
// Without new line!
// void kernel_log(unsigned char* text){
// 	for (short i = 0; text[i] != '\0'; i++)
// 		display_print_symbol(text[i], DISPLAY_CURSOR_POS_X, DISPLAY_CURSOR_POS_Y, 7, 0);
// }

// Panic Mode
// where_function - в какой функции произошла ошибка
// text - текст ошибки
// void kernel_panic(unsigned char* where_function, unsigned char* text, int code) {
//     interrupt_disable();
//
//     DISPLAY_CURSOR_POS_X = 0;
//     DISPLAY_CURSOR_POS_Y = 0;
//     kernel_log(" - - SNK Panic - - ");
//     display_new_line();
//
//     kernel_log(where_function);
//     kernel_log("(): ");
//     kernel_log(text);
//  
//     // Выводим код
//     unsigned char code_buffer[16];
//     itos(code, code_buffer);
//     kernel_log(" ");
//     kernel_log(code_buffer);
//  
//     display_new_line();
//     while(1) cpu_pause();
// }

// Initialization Section  (Old: Kernel Loop)
void init_section(void) {
	kprintf("Control has been transferred to the initialization system");
	while(1) cpu_pause();
} __attribute__((section(".init_section")))


// Check System: memory, disks
// void check_system(){

// 	// Devices
// 	char disk_flag = 0;
// 	for(int i = 0; i < DEVICE_COUNT; i++){
// 		struct dev_info devinfo = DEVICES_INFO[i];

// 		// Диск, размер больше 16 МБ
// 		if (devinfo.dev_type == 1 && devinfo.option1 >= 32768){
// 			disk_flag = 1;
// 		}
// 	}

// 	if (!disk_flag) kernel_panic("check_system", "The drive was not found or does not meet the requirements!");
// }

// Main
void kmain(void){
	terminal_initialize();
    kprintf("SNK Booted! Starting initialization...\n");

	// GDT table init
	gdt_init();

	// Get Multiboot Info
	struct multiboot_struct* multiboot_info_addr = get_ebx();
	struct multiboot_struct multiboot_info = *multiboot_info_addr;
	// Shared memory init
	// shared_memory_init(); <- deprecated, new realization:
	init_memory(multiboot_info_addr);
	
	// IDT setup
	PIC_remap();
	IDT_load();

	devices_find();

	driver_manager();

	// Endless loop
	init_section();

	//drivers_shutdown_all();
	//critical_drivers_shutdown();

	kpanic("Kernel init-tion finished!");
}
