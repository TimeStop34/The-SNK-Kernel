#include "iftype_list.h"

#define driver_interface(type, interface_manager) .type = interface_manager,

#define DRVIFMANLIST \
    driver_interface(Legacy, {}) \
    

driver_interface_managers_list_t global_driver_interface_managers_list = {
    DRVIFMANLIST
};