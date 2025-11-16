#pragma once

#include "device.h"

// Статусы операций
#define DISK_STATUS_OK 0
#define DISK_STATUS_ERROR 1
#define DISK_STATUS_NO_DEVICE 2
#define DISK_STATUS_TIMEOUT 3
#define DISK_STATUS_INVALID_PARAM 4

// Флаги диска
#define DISK_FLAG_MASTER MASTER_DISK
#define DISK_FLAG_PRESENT (1ULL << 2)

// Структура для работы с диском
struct disk_operations {
    int (*read_sectors)(unsigned int dev_id, unsigned int lba, unsigned int count, void* buffer);
    int (*write_sectors)(unsigned int dev_id, unsigned int lba, unsigned int count, void* buffer);
    int (*get_info)(unsigned int dev_id, struct disk_dev_params* info);
};

// Инициализация системы дисков
int disk_system_init();

// Регистрация диска
int disk_register(unsigned int dev_id, struct disk_operations* ops);

// Базовые операции
int disk_read_sectors(unsigned int dev_id, unsigned int lba, unsigned int count, void* buffer);
int disk_write_sectors(unsigned int dev_id, unsigned int lba, unsigned int count, void* buffer);
int disk_get_info(unsigned int dev_id, struct disk_dev_params* info);

// Утилиты
unsigned int disk_get_sector_size(unsigned int dev_id);
unsigned int disk_get_total_sectors(unsigned int dev_id);
int disk_is_present(unsigned int dev_id);

// Поиск дисков
int disk_find_first_available();
int disk_get_count();