#pragma once
#include "types.hpp"


typedef struct multiboot_info {
    uint32_t flags;            // Flags indicating which fields are valid
    uint32_t mem_lower;        // Amount of lower memory (below 1 MB) in KB
    uint32_t mem_upper;        // Amount of upper memory (above 1 MB) in KB
    uint32_t boot_device;      // Boot device (BIOS disk device)
    uint32_t cmdline;          // Pointer to the command line string
    uint32_t mods_count;       // Number of modules loaded
    uint32_t mods_addr;        // Pointer to the first module structure
    uint32_t syms[4];          // Symbol table information (deprecated)
    uint32_t mmap_length;      // Size of the memory map
    uint32_t mmap_addr;        // Pointer to the memory map
    uint32_t drives_length;    // Size of the BIOS drive information
    uint32_t drives_addr;      // Pointer to the BIOS drive information
    uint32_t config_table;     // Pointer to the ROM configuration table
    uint32_t boot_loader_name; // Pointer to the bootloader name string
    uint32_t apm_table;        // Pointer to the APM (Advanced Power Management) table
    uint32_t vbe_control_info; // VBE (VESA BIOS Extensions) control information
    uint32_t vbe_mode_info;    // VBE mode information
    uint16_t vbe_mode;         // VBE mode number
    uint16_t vbe_interface_seg; // VBE interface segment
    uint16_t vbe_interface_off; // VBE interface offset
    uint16_t vbe_interface_len; // VBE interface length
} multiboot_info_t;

typedef struct memory_region {
    uintptr_t start;
    uintptr_t end;
    uint32_t size;
    bool used;
} memory_region_t;

typedef struct multiboot_memory_map {
    uint32_t size;          // Размер этой структуры (без этого поля)
    uint64_t addr;          // Начальный адрес региона
    uint64_t len;           // Длина региона в байтах
    uint32_t type;          // Тип региона
    uint32_t zero;          // Зарезервировано - должно быть 0
} __attribute__((packed)) multiboot_memory_map_t;

// Типы регионов памяти
#define MULTIBOOT_MEMORY_AVAILABLE              1
#define MULTIBOOT_MEMORY_RESERVED               2
#define MULTIBOOT_MEMORY_ACPI_RECLAIMABLE       3
#define MULTIBOOT_MEMORY_NVS                    4
#define MULTIBOOT_MEMORY_BADRAM                 5

#define MULTIBOOT_OS_MAGIC 0x1BADB002
#define MULTIBOOT_BOOTLOADER_MAGIC 0x2BADB002