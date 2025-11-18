#define ATA_BASE 0x1F0

#include "ata.h"
#include "../device.h"
#include "../../../libs/asm.h"
#include "../disk.h"  // Добавляем для регистрации дисков

// Операции диска для disk системы
static struct disk_operations ata_disk_ops;

void ata_interrupt_handler(){
    
}

// стандартная задержка для ATA
void ata_delay(){
    inb(ATA_BASE + 7);
    inb(ATA_BASE + 7);
    inb(ATA_BASE + 7);
    inb(ATA_BASE + 7);
}

// Ожидание готовности принятия или отдачи данных и проверяет Занято ли устройство
int ata_wait_ready() {
    int timeout = 1000000;
    while (timeout-- > 0) {
        unsigned char status = inb(ATA_BASE + 7);

        if ((status & 0b10000000) == 0) {       // BSY=0
            {
                if (status & 0x01) return -1; // ERR
                if (status & 0x20) return -1; // Device Fault
                if (status & 0b00001000) return 0;  // DRQ}
            }
            return 0;
        }
        in_out_wait();

    }
    return -1; // Timeout
}

int ata_get_err(){
    unsigned char status = inb(ATA_BASE + 7);
    if (status & 0x01) return -1; // ERR
    if (status & 0x20) return -1; // DF
    else return 0; // ok
}

// Читаем данные с диска
// Читаем 512 байт (один сектор)
void ata_read(unsigned short* buffer){
    for (int i = 0; i < 256; i++) {
        unsigned short word = inw(ATA_BASE);
        buffer[i] = word;
    }
}

// Записываем данные на диск
// Записываем 512 байт (один сектор)
void ata_write(unsigned short* src){
    for (int i = 0; i < 256; i++) {
        unsigned short word = src[i];
        outw(ATA_BASE, word);
    }
}

// Функции для disk системы
static int ata_disk_read_sectors(unsigned int dev_id, unsigned int lba, unsigned int count, void* buffer) {
    unsigned char* buf = (unsigned char*)buffer;
    for (unsigned int i = 0; i < count; i++) {
        if (ata_driver_read_sector(lba + i, buf + (i * 512)) != 0) {
            return DISK_STATUS_ERROR;
        }
    }
    return DISK_STATUS_OK;
}

static int ata_disk_write_sectors(unsigned int dev_id, unsigned int lba, unsigned int count, void* buffer) {
    unsigned char* buf = (unsigned char*)buffer;
    for (unsigned int i = 0; i < count; i++) {
        if (ata_driver_write_sector(lba + i, buf + (i * 512)) != 0) {
            return DISK_STATUS_ERROR;
        }
    }
    return DISK_STATUS_OK;
}

static int ata_disk_get_info(unsigned int dev_id, struct disk_dev_params* info) {
    // Для простоты возвращаем информацию о первом диске
    // В будущем можно добавить поддержку нескольких дисков
    if (dev_id == 0) {
        // Получаем информацию из device системы
        struct dev_info dev_info;
        if (device_get(dev_id, &dev_info) == 0 && dev_info.params) {
            struct disk_dev_params* params = (struct disk_dev_params*)dev_info.params;
            *info = *params;
            return DISK_STATUS_OK;
        }
    }
    return DISK_STATUS_ERROR;
}

// Есть ли диск
// 0 - ok, -1 - not found
int ata_driver_find_master_disks(){
    // Проверяем подключен ли вообще диск
    outb(ATA_BASE + 6, 0xA0); // Выбираем диск (Master)
    outb(ATA_BASE + 2, 0);
    outb(ATA_BASE + 3, 0);
    outb(ATA_BASE + 4, 0);
    outb(ATA_BASE + 5, 0);
    ata_delay();
    unsigned char status = inb(ATA_BASE + 7); // Читаем подключено ли
    if (status == 0xFF || status == 0x00){
        return -1; // нет
    }

    // Если подключено то ждем пока диск ответит
    int is_timeout = ata_wait_ready();
    if (is_timeout == -1){
        return -1; // timeout
    }

    // IDENTIFY command
    outb(ATA_BASE + 7, 0xEC);
    ata_delay();

    // Get status
    status = inb(ATA_BASE + 7);
    if (status == 0){
        return -1; // не существует
    }

    if (ata_wait_ready() == -1){
        return -1;
    }
    else{
        // Читаем IDENTIFY
        unsigned short ident_buffer[256];
        ata_read(ident_buffer);

        // Модель диска
        char model[41];

        // Чтение модели из регистров 27-46
        for (int i = 27; i <= 46; i++) {
            model[(i-27)*2] = ident_buffer[i] & 0x00FF;         // Младший байт
            model[(i-27)*2 + 1] = (ident_buffer[i] >> 8) & 0x00FF; // Старший байт
        }
        model[40] = '\0';

        // Количество секторов на диске
        unsigned int sector_count = (unsigned int)(ident_buffer[60] & 0x0000FFFF) | (unsigned int)((ident_buffer[61] << 16) & 0xFFFF0000);

        void* disk_params = kmalloc(sizeof(struct disk_dev_params));
        struct disk_dev_params* params = (struct disk_dev_params*)disk_params;
        params->flag = MASTER_DISK;
        params->num_of_sectors = sector_count;
        params->type = ata;

        // Регистрируем диск в device системе
        int dev_id = device_reg(disk, model, 41, params);
        
        // РЕГИСТРИРУЕМ ДИСК В DISK СИСТЕМЕ
        if (dev_id >= 0) {
            // Инициализируем операции диска
            ata_disk_ops.read_sectors = ata_disk_read_sectors;
            ata_disk_ops.write_sectors = ata_disk_write_sectors;
            ata_disk_ops.get_info = ata_disk_get_info;
            
            // Регистрируем диск в disk системе (это вызовет авто-монтирование в VFS)
            disk_register(dev_id, &ata_disk_ops);
            
            kernel_log("ATA: Disk registered in disk system with ID ");
            // kernel_log(itos(dev_id, buffer));
            while(1) cpu_pause();
            kernel_log("\n");
        }

        return dev_id;
    }

    return -1;
}

// Инициализация ATA драйвера


// Чтение определенного сектора
// lba - номер сектора
// buffer - буффер
int ata_driver_read_sector(unsigned int lba, unsigned char* buffer) {
    // Проверяем и ждем готовность диска
    if (ata_wait_ready() < 0) return -1;

    // Выбираем диск Master + LBA (старший байт)
    outb(ATA_BASE + 6, 0xE0 | ((lba >> 24) & 0x0F));

    // Параметры
    outb(ATA_BASE + 2, 1);              // кол-во секторов: 1
    outb(ATA_BASE + 3, lba & 0xFF);     // LBA 0-7
    outb(ATA_BASE + 4, (lba >> 8) & 0xFF);  // LBA 8-15
    outb(ATA_BASE + 5, (lba >> 16) & 0xFF); // LBA 16-23

    // Команда чтения
    outb(ATA_BASE + 7, 0x20);

    // Проверяем и ждем готовность диска
    if (ata_wait_ready() < 0) return -1;

    // Читаем 512 байт (один сектор)
    unsigned short temp[256];
    ata_read(temp);

    // переводим из массива short
    for (int i = 0; i < 256; i++) {
        buffer[i*2] = temp[i] & 0xFF; // младший байт
        buffer[i*2 + 1] = (temp[i] >> 8) & 0xFF; // старший байт
    }

    // Возвращаем статус ошибки: 0 ок, -1 ошибка
    return ata_get_err();
}

int ata_driver_write_sector(unsigned int lba, unsigned char* src){
    // Проверяем и ждем готовность диска
    if (ata_wait_ready() < 0) return -1;

    // Выбираем диск Master + LBA (старший байт)
    outb(ATA_BASE + 6, 0xE0 | ((lba >> 24) & 0x0F));

    // Параметры
    outb(ATA_BASE + 2, 1);              // кол-во секторов: 1
    outb(ATA_BASE + 3, lba & 0xFF);     // LBA 0-7
    outb(ATA_BASE + 4, (lba >> 8) & 0xFF);  // LBA 8-15
    outb(ATA_BASE + 5, (lba >> 16) & 0xFF); // LBA 16-23

    // Команда записи
    outb(ATA_BASE + 7, 0x30);

    // Проверяем и ждем готовность диска
    if (ata_wait_ready() < 0) return -1;

    // переводим в массив short
    unsigned short temp[256];
    for (int i = 0; i < 256; i++) {
        temp[i] = src[i*2] | (src[i*2 + 1] << 8);  // младший байт | старший байт
    }

    // Записываем 512 байт (один сектор)
    ata_write(temp);

    // Проверяем и ждем готовность диска
    if (ata_wait_ready() < 0) return -1;

    // Возвращаем статус ошибки: 0 ок, -1 ошибка
    return ata_get_err();
}

// ОБНОВЛЯЕМ МАКРОС DRIVER - ДОБАВЛЯЕМ ИНИЦИАЛИЗАЦИЮ
DRIVER(ata, NULL, NULL, FLAG_NONE);