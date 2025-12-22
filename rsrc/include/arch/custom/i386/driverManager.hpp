#pragma once
#include <arch/driverManager.hpp>
#include <libs/manybootloader_system.hpp>

class i386DriverManager : public DriverManager {
private:
    bootsystem_struct bs;

    void find_devices();

    void find_legacy_devices();

    void find_pci_devices();

public: 
    i386DriverManager(bootsystem_struct bs);

    void setup_devices() override;

    ~i386DriverManager() override {}
};