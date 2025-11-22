#ifndef INCL_DRIVER_DEVICES
#define INCL_DRIVER_DEVICES

#include "../libs/device/device.h"

extern dev_info_t DEVICES_INFO[256];
extern unsigned int DEVICE_COUNT;

void devices_registration();

int devices_find();

#endif
