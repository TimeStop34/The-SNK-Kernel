#ifndef _TYPES_H
#define _TYPES_H

// ==================== СТАНДАРТНЫЕ ЦЕЛОЧИСЛЕННЫЕ ТИПЫ ====================

// 8-битные беззнаковые
typedef unsigned char       uint8_t;
typedef unsigned char       u8;

// 8-битные знаковые  
typedef signed char         int8_t;
typedef signed char         i8;

// 16-битные беззнаковые
typedef unsigned short      uint16_t;
typedef unsigned short      u16;

// 16-битные знаковые
typedef signed short        int16_t;
typedef signed short        i16;

// 32-битные беззнаковые
typedef unsigned int        uint32_t;
typedef unsigned int        u32;

// 32-битные знаковые
typedef signed int          int32_t;
typedef signed int          i32;

// 64-битные беззнаковые (если компилятор поддерживает)
#ifdef __GNUC__
typedef unsigned long long  uint64_t;
typedef unsigned long long  u64;

// 64-битные знаковые
typedef signed long long    int64_t;
typedef signed long long    i64;
#else
// Заглушки если нет поддержки 64-бит
typedef uint32_t            uint64_t;
typedef uint32_t            u64;
typedef int32_t             int64_t;
typedef int32_t             i64;
#endif

// ==================== СИМВОЛЬНЫЕ ТИПЫ ====================
typedef unsigned char       byte_t;
typedef char                char_t;

// ==================== БУЛЕВЫЙ ТИП (замена stdbool.h) ====================
typedef uint8_t             bool;
#define true                1
#define false               0

// ==================== РАЗМЕРНЫЕ ТИПЫ ====================
typedef uint32_t            size_t;     // Для размеров объектов
typedef uint32_t            usize_t;    // Беззнаковый размер
typedef int32_t             ssize_t;    // Знаковый размер (может быть -1)

// ==================== АДРЕСНЫЕ ТИПЫ ====================
typedef uint32_t            uintptr_t;  // Целое, способное хранить указатель
typedef int32_t             intptr_t;   // Знаковый аналог

// ==================== СПЕЦИАЛЬНЫЕ ТИПЫ ДЛЯ ЯДРА ====================
typedef uint32_t            paddr_t;    // Физический адрес
typedef uint32_t            vaddr_t;    // Виртуальный адрес

// ==================== СТАНДАРТНЫЕ КОНСТАНТЫ ====================
#define NULL                ((void*)0)
#define UINT32_MAX          (0xFFFFFFFFU)
#define INT32_MAX           (0x7FFFFFFF)
#define INT32_MIN           (-0x7FFFFFFF - 1)

// Макрос для выравнивания
#define ALIGN_UP(addr, align)    (((addr) + (align) - 1) & ~((align) - 1))
#define ALIGN_DOWN(addr, align)  ((addr) & ~((align) - 1))

// Макрос для упакованных структур (без выравнивания)
#define PACKED              __attribute__((packed))

#endif // _TYPES_H