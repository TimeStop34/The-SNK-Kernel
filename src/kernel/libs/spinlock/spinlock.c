#include "spinlock.h"

// Атомарная установка значения
static inline uint32_t atomic_xchg(volatile uint32_t* ptr, uint32_t value) {
    uint32_t old_value;
    asm volatile (
        "lock xchgl %0, %1"
        : "=r"(old_value), "+m"(*ptr)
        : "0"(value)
        : "memory"
    );
    return old_value;
}

// Инициализация спинлока
void spinlock_init(spinlock_t* lock) {
    lock->locked = 0;
}

// Захват спинлока
void spinlock_lock(spinlock_t* lock) {
    // Просто крутимся в цикле пока не получим блокировку
    while (atomic_xchg(&lock->locked, 1) != 0) {
        // Ждём освобождения
        asm volatile("pause");
    }
}

// Освобождение спинлока
void spinlock_unlock(spinlock_t* lock) {
    // Просто атомарно сбрасываем в 0
    atomic_xchg(&lock->locked, 0);
}