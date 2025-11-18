#pragma once

#include "../types.h"

// Самая простая структура спинлока
typedef struct {
    volatile uint32_t locked;  // 0 = свободен, 1 = занят
} spinlock_t;

// Базовые функции
void spinlock_init(spinlock_t* lock);
void spinlock_lock(spinlock_t* lock);
void spinlock_unlock(spinlock_t* lock);