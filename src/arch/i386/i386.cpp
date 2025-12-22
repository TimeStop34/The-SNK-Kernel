#include <arch/custom/i386/i386.hpp>
#include <arch/custom/i386/driverManager.hpp>

#include <arch/custom/i386/i386.hpp>
#include <arch/custom/i386/driverManager.hpp>

// Правильный placement new
void* operator new(size_t, void* ptr) noexcept;
void* operator new[](size_t, void* ptr) noexcept;

i386Arch::i386Arch(bootsystem_struct* bootsystem) {
    this->bs = bootsystem;
    
    // Сразу создаем указатель правильного типа
    static uint8_t driver_manager_storage[sizeof(i386DriverManager)];
    
    // Явно вызываем конструктор через placement new
    this->dm = new ((void*)driver_manager_storage) i386DriverManager(*bootsystem);
}

void i386Arch::finalize_setup() {
    // Реализация
}

DriverManager* i386Arch::get_driver_manager() {
    return dm;
}

bootsystem_struct i386Arch::get_bootsystem_struct() {
    return *(this->bs);
}