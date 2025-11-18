#include "drivers.h"

// Внешние ссылки на секцию драйверов
extern const driver_t __start_drivers[];
extern const driver_t __stop_drivers[];

void drivers_init_all(void) {
    const driver_t* driver = __start_drivers;
    
    while (driver < __stop_drivers) {
        
        if (driver->init) {
            driver->init();
        }
        
        driver++;
    }
}

void drivers_shutdown_all(void) {
    const driver_t* driver = __start_drivers;
    
    while (driver < __stop_drivers) {
        // Выключаем только те драйверы, у которых есть shutdown (у критических его просто нет!) 
        if (driver->shutdown && !(driver->flags & FLAG_CRITICAL)) {
            driver->shutdown();
        }
        
        driver++;
    }
}

void critical_drivers_shutdown(){
     const driver_t* driver = __start_drivers;
    
    while (driver < __stop_drivers) {
        // Выключаем только те драйверы, у которых есть shutdown и они критические (у критических его просто нет!) 
        if (driver->shutdown && (driver->flags & FLAG_CRITICAL)) {
            driver->shutdown();
        }
        
        driver++;
    }
}

void drivers_list_all(void) {
    const driver_t* driver = __start_drivers;
    
    while (driver < __stop_drivers) {
        driver++;
    }
}

// Инициализация драйверов до включения прерываний
void drivers_init(){
    drivers_init_all();
}

// Инициализация драйверов после включения прерываний
void drivers_init_late(){

    // . Здесь должен быть поиск всех устройств по PCI
    //   а уже потом их инициализация если устройство определённого типа есть

    // Ищем диск и добавляем в устройства
    ata_driver_find_master_disks();

}