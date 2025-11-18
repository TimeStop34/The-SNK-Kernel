#pragma once
#include "../device.h"

// Чтение сектора с диска в buffer
int ata_driver_read_sector(unsigned int lba, unsigned char* buffer);

// Запись src на сектор диска
int ata_driver_write_sector(unsigned int lba, unsigned char* src);

// Если есть мастер диск, то добавляет его в устройства
// * Будет удалён или изменён после реализации поиска устройств через PCI
int ata_driver_find_master_disks();

// ДОБАВЛЯЕМ ОБЪЯВЛЕНИЯ ДЛЯ DISK СИСТЕМЫ
// Функции для работы с disk системой
static int ata_disk_read_sectors(unsigned int dev_id, unsigned int lba, unsigned int count, void* buffer);
static int ata_disk_write_sectors(unsigned int dev_id, unsigned int lba, unsigned int count, void* buffer);
static int ata_disk_get_info(unsigned int dev_id, struct disk_dev_params* info);

// Инициализация ATA драйвера
static void ata_init(void);