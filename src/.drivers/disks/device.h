#pragma once

#include "../drivers.h"

#define MAX_DEVICE_COUNT 256


enum device_type {
    none = 0,
    disk = 1
};

enum disk_type {
    ata = 1
};

struct dev_params {
    /* Параметры у каждого разные, а пустая структура позволяет хранить указатель на любую другую структуру*/
};

#define DISK_FLAG_NONE 0LL
#define MASTER_DISK (1ULL << 1)

struct disk_dev_params {  // Пример эталлонной реализации параметров устройства: параметров диска
    // Параметр 1:
    // Количество секторов
    unsigned int num_of_sectors;
    // Параметр 2:
    // Флаги: 
    // Бит 0: is_master (является ли диск главным-основным), 1 - да, 0 - нет
    unsigned long long flag;
    // Параметр 3:
    // Диск: тип диска (ATA, и т.д)
    enum disk_type type;
};

// Информация о устройстве
struct dev_info{
    // Общий идентификатор устройства
    unsigned int id;
    // Тип устройства:
    // 1 - диск/накопитель
    enum device_type dev_type;
    // Название-модель
    unsigned char name[41];

    struct dev_params* params;

};

int device_reg(unsigned int dev_type, unsigned char* name, unsigned int name_size, void* dev_params);

int device_get(unsigned int dev_id, struct dev_info* dst);
