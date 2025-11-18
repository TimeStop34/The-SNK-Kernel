#pragma once

#include "../../libs/types.h"

#include "../../libs/multiboot/multiboot.h"
#include "../../libs/spinlock/spinlock.h"

// Frame - часть физической памяти компьютера, обычно 4KB - так как ровно такой стандарт i386(x86) архитектуры

#define PAGE_SIZE 4096 // Размер Страницы/Фрейма (Размер страница кратен размеру фрейма, стандарт - использование такого же размера как и фрейм)

typedef struct {
    uint32_t total_frames;    // Всего фреймов в системе
    uint32_t used_frames;     // Занятых фреймов
    uint32_t total_memory;    // Всего памяти в байтах
    
    uint32_t* bitmap;         // Указатель на битовую карту
    uint32_t bitmap_size;     // Размер bitmap в 32-битных словах
    
    uintptr_t bitmap_physical;// ФИЗИЧЕСКИЙ адрес bitmap (важно!)
    spinlock_t lock;          // Защита от многопоточного доступа
} pmm_state_t;

typedef struct {
    uint32_t total_frames;
    uint32_t used_frames;
    uint32_t free_frames;
    uint32_t total_memory;
    uint32_t used_memory;
    uint32_t free_memory;
} pmm_stats_t;

extern pmm_state_t pmm_state;

/*
    Инициализация Physical Memory Manager (Сокращенно - PMM)
*/
void pmm_init(multiboot_info_t* mb_info);

/*
    Узнаем размер памяти из multiboot memory-map
*/
uint32_t get_memory_size(multiboot_info_t* mb_info);

/*
    Находим свободный регион, 
        который будет достаточен
            для помещения туда данных размером с size
*/
uintptr_t find_free_memory_region(multiboot_info_t* mb_info, uint32_t size);

/*
    Преобразуем multiboot memory-map в bitmap-регионную map памяти(которую будем контролировать уже мы)
*/
void pmm_parse_memory_map(multiboot_info_t* mb_info);

/*
    Помечает регион физической памяти как свободный в битовой карте PMM
*/
void pmm_mark_region_as_free(uintptr_t base, uint32_t length);

/*
    Помечает регион физической памяти как занятый в битовой карте PMM
    Используется для: ядра, битовой карты PMM, зарезервированных областей
*/
void pmm_mark_region_as_used(uintptr_t base, uint32_t length);

/*
    Пометить фрейм как занятый
*/ 
static void pmm_set_frame_used(uint32_t frame);

/*
    Пометить фрейм как свободный  
*/ 
static void pmm_set_frame_free(uint32_t frame);

/*
    Проверяет, доступен ли frame или нет
*/
static bool pmm_is_frame_free(uint32_t frame);

/* ====================== API ====================== */
/*
    Выделить один фрейм (4КБ) 
*/
uintptr_t pmm_alloc_frame(void);
/*
    Освободить фрейм
*/ 
void pmm_free_frame(uintptr_t frame);
/*
    Выделить несколько рядом стоящих(смежных) фреймов
*/
uintptr_t pmm_alloc_frames(uint32_t count);

/*
    Получить статистику памяти
*/ 
void pmm_get_stats(pmm_stats_t* stats);