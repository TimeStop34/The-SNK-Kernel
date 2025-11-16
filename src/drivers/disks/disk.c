#include "disk.h"

// Максимальное количество зарегистрированных дисков
#define MAX_DISKS 16

// Таблица зарегистрированных дисков
struct disk_entry {
    unsigned int dev_id;
    struct disk_operations ops;
    int present;
} disk_table[MAX_DISKS];

// Количество зарегистрированных дисков
unsigned int disk_count = 0;

// Инициализация системы дисков
int disk_system_init() {
    for (int i = 0; i < MAX_DISKS; i++) {
        disk_table[i].present = 0;
        disk_table[i].dev_id = 0;
    }
    disk_count = 0;
    return DISK_STATUS_OK;
}

// Регистрация диска
int disk_register(unsigned int dev_id, struct disk_operations* ops) {
    if (disk_count >= MAX_DISKS) return DISK_STATUS_ERROR;
    
    // Проверяем, не зарегистрирован ли уже этот dev_id
    for (int i = 0; i < disk_count; i++) {
        if (disk_table[i].dev_id == dev_id) return DISK_STATUS_ERROR;
    }
    
    // Регистрируем новый диск
    disk_table[disk_count].dev_id = dev_id;
    disk_table[disk_count].ops = *ops;
    disk_table[disk_count].present = 1;
    disk_count++;
    
    return DISK_STATUS_OK;
}

// Поиск диска в таблице
static struct disk_entry* find_disk(unsigned int dev_id) {
    for (int i = 0; i < disk_count; i++) {
        if (disk_table[i].dev_id == dev_id && disk_table[i].present) {
            return &disk_table[i];
        }
    }
    return 0;
}

// Чтение секторов
int disk_read_sectors(unsigned int dev_id, unsigned int lba, unsigned int count, void* buffer) {
    struct disk_entry* disk = find_disk(dev_id);
    if (!disk) return DISK_STATUS_NO_DEVICE;
    if (!disk->ops.read_sectors) return DISK_STATUS_ERROR;
    
    return disk->ops.read_sectors(dev_id, lba, count, buffer);
}

// Запись секторов
int disk_write_sectors(unsigned int dev_id, unsigned int lba, unsigned int count, void* buffer) {
    struct disk_entry* disk = find_disk(dev_id);
    if (!disk) return DISK_STATUS_NO_DEVICE;
    if (!disk->ops.write_sectors) return DISK_STATUS_ERROR;
    
    return disk->ops.write_sectors(dev_id, lba, count, buffer);
}

// Получение информации о диске
int disk_get_info(unsigned int dev_id, struct disk_dev_params* info) {
    struct disk_entry* disk = find_disk(dev_id);
    if (!disk) return DISK_STATUS_NO_DEVICE;
    if (!disk->ops.get_info) return DISK_STATUS_ERROR;
    
    return disk->ops.get_info(dev_id, info);
}

// Утилиты
unsigned int disk_get_sector_size(unsigned int dev_id) {
    // Стандартный размер сектора
    return 512;
}

unsigned int disk_get_total_sectors(unsigned int dev_id) {
    struct disk_dev_params info;
    if (disk_get_info(dev_id, &info) == DISK_STATUS_OK) {
        return info.num_of_sectors;
    }
    return 0;
}

int disk_is_present(unsigned int dev_id) {
    return find_disk(dev_id) != 0;
}

// Поиск первого доступного диска
int disk_find_first_available() {
    for (int i = 0; i < disk_count; i++) {
        if (disk_table[i].present) {
            return disk_table[i].dev_id;
        }
    }
    return -1;
}

int disk_get_count() {
    return disk_count;
}