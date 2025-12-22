#pragma once
#include <arch/driverManager.hpp>
#include <libs/manybootloader_system.hpp>

class Arch {
public:

    virtual void finalize_setup() = 0;
    virtual DriverManager* get_driver_manager() = 0;

    virtual bootsystem_struct get_bootsystem_struct() = 0;

    virtual ~Arch() {};
};