#include <types.hpp>

// В том же файле или отдельном
extern "C" void* memset(void*, int, size_t);
extern "C" void* memcpy(void*, const void*, size_t);

// Простейшие аллокаторы (на статической памяти)
static uint8_t emergency_heap[4096];
static size_t heap_ptr = 0;

void* operator new(size_t size) {
    void* ptr = &emergency_heap[heap_ptr];
    heap_ptr += (size + 7) & ~7;  // Выравнивание на 8 байт
    return ptr;
}

void* operator new[](size_t size) {
    return operator new(size);
}

void operator delete(void* ptr) noexcept {
    // Не делаем ничего в bare-metal
    (void)ptr;
}

void operator delete(void* ptr, size_t) noexcept {
    (void)ptr;
}

void operator delete[](void* ptr) noexcept {
    (void)ptr;
}

void operator delete[](void* ptr, size_t) noexcept {
    (void)ptr;
}

// Placement new
void* operator new(size_t, void* ptr) noexcept { return ptr; }
void* operator new[](size_t, void* ptr) noexcept { return ptr; }
void operator delete(void*, void*) noexcept {}
void operator delete[](void*, void*) noexcept {}