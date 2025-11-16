#include "device.h"

unsigned int* DEVICE_COUNTR;
struct dev_info* DEVICES_INFO;

#define DEVICE_COUNT *DEVICE_COUNTR


int device_reg(unsigned int dev_type, unsigned char* name, unsigned int name_size, void* dev_params){

    struct dev_info devinfo;
    devinfo.id = DEVICE_COUNT;
    devinfo.dev_type = dev_type;
    memcpy(&(devinfo.name), name, name_size);
    devinfo.params = dev_params;

    DEVICES_INFO[DEVICE_COUNT] = devinfo;
    DEVICE_COUNT++;

}


// Получить информацию о устройстве по id, в dst
int device_get(unsigned int dev_id, struct dev_info* dst){
    for(int i = 0; i < DEVICE_COUNT; i++){
        if (DEVICES_INFO[i].id == dev_id){
            dst->id = DEVICES_INFO[i].id;
            dst->dev_type = DEVICES_INFO[i].dev_type;
            dst->id = DEVICES_INFO[i].name;
            memcpy(dst->name, DEVICES_INFO[i].name, 41);
            dst->params = DEVICES_INFO[i].params;
            return 0; // Found
        }
    }
    return -1; // Not found
}

void device_init() {
    DEVICE_COUNTR = kmalloc(sizeof(unsigned int));
    DEVICES_INFO = kmalloc(sizeof(struct dev_info));
}

DRIVER(device, device_init, NULL,
        FLAG_CRITICAL);