#pragma once

#include "../kernel/idt/IDT_PIC.h"
#include "../memory.h"

void drivers_init();
void drivers_init_late();

#define NULL ((void*)0)
#define FLAG_NONE        0ULL          // 0000000000000000
#define FLAG_CRITICAL (1LL << 0)

// Структура драйвера
typedef struct {
    void (*init)(void);          // Функция инициализации
    void (*shutdown)(void);      // Функция выключения (опционально)
    const char* name;           // Имя драйвера
    unsigned long long flags;    // Флаги драйвера
} __attribute__((packed)) driver_t;

// Макрос для регистрации драйверов
#define DRIVER(_name, _init, _shutdown, _flags) \
    static const driver_t _driver_##_name \
    __attribute__((section("drivers"), used)) = { \
        .init = _init, \
        .shutdown = _shutdown, \
        .name = #_name, \
        .flags = _flags \
    }

// Функции для работы с драйверами
void drivers_init_all(void);
void drivers_shutdown_all(void);
void drivers_list_all(void);
void critical_drivers_shutdown(void);
