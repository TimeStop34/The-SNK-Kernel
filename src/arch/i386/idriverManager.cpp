#include <arch/custom/i386/driverManager.hpp>

i386DriverManager::i386DriverManager(bootsystem_struct bs) {
    this->bs = bs;
    
}

void i386DriverManager::setup_devices() {
    find_devices();
}

void i386DriverManager::find_devices(){
    find_legacy_devices();
    find_pci_devices();
}

void i386DriverManager::find_legacy_devices(){
    // ...
}

void i386DriverManager::find_pci_devices(){
    // ...
}