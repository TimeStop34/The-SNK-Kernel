#pragma once
class DriverManager {
public:
    virtual ~DriverManager() {}

    virtual void setup_devices() = 0;
    /*
        register_driver();
        setup_drivers();

        get_char_devices_manager() = 0;
        get_block_devices_manager() = 0;
        get_network_devices_manager() = 0;

        get_all_devices() = 0;
        get_subgroup_dev_manager() = 0;

    */
};