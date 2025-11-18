#pragma once
#include "pmm/pmm.h"

/*
    Инициализирует систему памяти: PMM & VMM
*/
void init_memory(multiboot_info_t *mb_info);