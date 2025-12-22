#pragma once
#include <arch/arch.hpp>
#include <libs/manybootloader_system.hpp>
#include "driverManager.hpp"

class i386Arch : public Arch {
private:
    bootsystem_struct* bs;
    i386DriverManager* dm;

public:
    i386Arch(bootsystem_struct* bootsystem);

    void finalize_setup() override;

    DriverManager* get_driver_manager() override;
    bootsystem_struct get_bootsystem_struct() override;

    ~i386Arch() override {}
};