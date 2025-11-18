// driver_manager.c
#include "./device.h"
#include "kernel/memory/memory.h"
#include "libs/string.h"

static driver_t* driver_list = NULL;

int driver_register(driver_t* driver) {
    if (!driver || !driver->name[0]) {
        return -1;
    }
    
    // Проверяем, не зарегистрирован ли уже драйвер
    driver_t* curr = driver_list;
    while (curr) {
        if (strcmp(curr->name, driver->name) == 0) {
            return -1;
        }
        curr = curr->next;
    }
    
    // Добавляем в начало списка драйверов
    driver->next = driver_list;
    driver_list = driver;
    
    if (driver->init) {
        return driver->init(driver);
    }
    
    return 0;
}

int device_register(device_t* device) {
    if (!device || !device->driver) {
        return -1;
    }
    
    // ТЕПЕРЬ этот код работает, т.к. device->next существует
    device->next = device->driver->devices;
    device->driver->devices = device;
    
    if (device->probe) {
        return device->probe(device);
    }
    
    return 0;
}