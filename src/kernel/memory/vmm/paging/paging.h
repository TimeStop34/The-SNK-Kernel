#pragma once
#include "../../../libs/types.h"
#include "../../simple_operations.h"
#include "../../pmm/pmm.h"

typedef struct pde {
    uint32_t frame_addr : 20;
    
    // Standard x86 flags
    uint32_t present    : 1;  // P - Page present in memory
    uint32_t writable   : 1;  // R/W - Read/Write permission
    uint32_t user       : 1;  // U/S - User/Supervisor
    uint32_t pwt        : 1;  // PWT - Write-Through caching
    uint32_t pcd        : 1;  // PCD - Cache disable
    uint32_t accessed   : 1;  // A - Accessed
    uint32_t dirty      : 1;  // D - Dirty (for PTE) (Not writable)
    uint32_t page_size  : 1;  // PS - Page size (0=4KB, 1=4MB for PDE)
    uint32_t global     : 1;  // G - Global page
    
    // Available for OS (For OS-specific purposes)
    uint32_t os1        : 1;  
    uint32_t os2        : 1;  
    uint32_t os3        : 1;  
} page_directory_entry_t;

typedef struct pte {
    uint32_t frame_addr : 20;

    // Standard x86 flags
    uint32_t present    : 1;
    uint32_t writable   : 1; 
    uint32_t user       : 1;
    uint32_t pwt        : 1;
    uint32_t pcd        : 1;
    uint32_t accessed   : 1;
    uint32_t dirty      : 1;  // Not writable
    uint32_t pat        : 1;  // PAT - Page Attribute Table
    uint32_t global     : 1;

    // Available for OS (For OS-specific purposes)
    uint32_t os1        : 1;
    uint32_t os2        : 1; 
    uint32_t os3        : 1;
} page_table_entry_t;

page_directory_entry_t* create_page_directory();