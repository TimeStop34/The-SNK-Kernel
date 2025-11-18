// device.h
#ifndef DEVICE_H
#define DEVICE_H

#include <stddef.h>
#include <stdint.h>

// Типы устройств
typedef enum {
    DEVICE_TYPE_CHAR = 1,
    DEVICE_TYPE_BLOCK,
    DEVICE_TYPE_NETWORK,
    DEVICE_TYPE_OTHER
} device_type_t;

// Структура устройства С полем next
typedef struct device {
    unsigned char name[32];
    device_type_t type;
    uint32_t major;
    uint32_t minor;
    void* private_data;
    struct driver* driver;
    
    // ДОБАВЛЯЕМ поле next для связного списка
    struct device* next;
    
    // Операции устройства
    int (*read)(struct device* dev, void* buffer, size_t size, uint64_t offset);
    int (*write)(struct device* dev, const void* buffer, size_t size, uint64_t offset);
    int (*ioctl)(struct device* dev, uint32_t request, void* arg);
    int (*probe)(struct device* dev);
    int (*remove)(struct device* dev);
} device_t;

// Структура драйвера ТАКЖЕ нуждается в поле next
typedef struct driver {
    unsigned char name[32];
    device_type_t type;
    uint32_t major;
    
    // Операции драйвера
    int (*init)(struct driver* drv);
    void (*exit)(struct driver* drv);
    int (*probe)(device_t* dev);
    int (*remove)(device_t* dev);
    
    // Список устройств этого драйвера
    device_t* devices;
    
    // ДОБАВЛЯЕМ поле next для списка драйверов
    struct driver* next;
} driver_t;

// Функции менеджера драйверов
int driver_register(driver_t* driver);
int driver_unregister(driver_t* driver);
int device_register(device_t* device);
int device_unregister(device_t* device);
device_t* device_find(const unsigned char* name);
driver_t* driver_find(const unsigned char* name);

#endif