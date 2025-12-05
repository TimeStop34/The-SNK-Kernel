#ifndef _TYPES_H
#define _TYPES_H

// ==================== СТАНДАРТНЫЕ ЦЕЛОЧИСЛЕННЫЕ ТИПЫ ====================

// 8-битные беззнаковые
typedef unsigned char       uint8_t;
typedef volatile unsigned char       vuint8_t;

// 8-битные знаковые  
typedef signed char         int8_t;
typedef volatile signed char         vint8_t;

// 16-битные беззнаковые
typedef unsigned short      uint16_t;
typedef volatile unsigned short      vuint16_t;

// 16-битные знаковые
typedef signed short        int16_t;
typedef volatile signed short        vint16_t;

// 32-битные беззнаковые
typedef unsigned int        uint32_t;
typedef volatile unsigned int        vuint32_t;

// 32-битные знаковые
typedef signed int          int32_t;
typedef volatile signed int          vint32_t;

// 64-битные беззнаковые (если компилятор поддерживает)
#ifdef __GNUC__
typedef unsigned long long  uint64_t;
typedef volatile unsigned long long  vuint64_t;

// 64-битные знаковые
typedef signed long long    int64_t;
typedef volatile signed long long    vint64_t;
#else
// Заглушки если нет поддержки 64-бит
typedef uint32_t            uint64_t;
typedef vuint32_t            vuint64_t;
typedef int32_t             int64_t;
typedef vint32_t             vint64_t;
#endif

// ==================== СИМВОЛЬНЫЕ ТИПЫ ====================
typedef unsigned char       byte_t;
typedef char                char_t;

typedef volatile unsigned char       vbyte_t;
typedef volatile char                vchar_t;

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