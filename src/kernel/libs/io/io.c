#include "io.h"
#include "serial/serial.h"
#include "stdarg.h"
#include "../string/string.h"

static uint16_t* vga_buffer = (uint16_t*)VGA_BUFFER;
static uint32_t vga_row = 0;
static uint32_t vga_column = 0;
static uint8_t vga_color = 0x0F;
static bool serial_enabled = false;

// Инициализация VGA
void terminal_initialize(void) {
    // Инициализируем VGA
    for (uint32_t y = 0; y < VGA_HEIGHT; y++) {
        for (uint32_t x = 0; x < VGA_WIDTH; x++) {
            const uint32_t index = y * VGA_WIDTH + x;
            vga_buffer[index] = (vga_color << 8) | ' ';
        }
    }
    vga_row = 0;
    vga_column = 0;
    
    // Пытаемся инициализировать serial
    serial_init();
    serial_enabled = true;
    serial_puts("Serial console initialized\n");
}

// Вывод символа
void putchar(char c) {
    // Вывод в VGA
    if (c == '\n') {
        vga_column = 0;
        vga_row++;
    } else {
        const uint32_t index = vga_row * VGA_WIDTH + vga_column;
        vga_buffer[index] = (vga_color << 8) | c;
        vga_column++;
    }

    if (vga_column >= VGA_WIDTH) {
        vga_column = 0;
        vga_row++;
    }

    if (vga_row >= VGA_HEIGHT) {
        for (uint32_t y = 0; y < VGA_HEIGHT - 1; y++) {
            for (uint32_t x = 0; x < VGA_WIDTH; x++) {
                vga_buffer[y * VGA_WIDTH + x] = vga_buffer[(y + 1) * VGA_WIDTH + x];
            }
        }
        for (uint32_t x = 0; x < VGA_WIDTH; x++) {
            vga_buffer[(VGA_HEIGHT - 1) * VGA_WIDTH + x] = (vga_color << 8) | ' ';
        }
        vga_row = VGA_HEIGHT - 1;
    }
    
    // ДУБЛИРОВАНИЕ В SERIAL
    if (serial_enabled) {
        serial_putchar(c);
    }
}

// Вывод строки
static void puts(const char* str) {
    while (*str) putchar(*str++);
}

// Преобразование числа в строку (hex)
static void itoa_hex(uint32_t num, char* buffer) {
    const char* hex_chars = "0123456789ABCDEF";
    char* p = buffer;
    
    *p++ = '0';
    *p++ = 'x';
    
    for (int i = 28; i >= 0; i -= 4) {
        *p++ = hex_chars[(num >> i) & 0xF];
    }
    *p = '\0';
}

// Преобразование числа в строку (decimal)
static void itoa_dec(int num, char* buffer) {
    char* p = buffer;
    
    if (num == 0) {
        *p++ = '0';
        *p = '\0';
        return;
    }
    
    if (num < 0) {
        *p++ = '-';
        num = -num;
    }
    
    char temp[32];
    char* t = temp;
    
    while (num > 0) {
        *t++ = '0' + (num % 10);
        num /= 10;
    }
    
    while (t > temp) {
        *p++ = *--t;
    }
    *p = '\0';
}

static void itoa_hex64(uint64_t num, char* buffer) {
    const char* hex_chars = "0123456789ABCDEF";
    
    // Разбиваем 64-битное число на два 32-битных
    uint32_t high = (uint32_t)(num >> 32);
    uint32_t low = (uint32_t)(num & 0xFFFFFFFF);
    
    buffer[0] = '0';
    buffer[1] = 'x';
    
    // Выводим старшую часть
    for (int i = 0; i < 8; i++) {
        buffer[2 + i] = hex_chars[(high >> (28 - i * 4)) & 0xF];
    }
    // Выводим младшую часть
    for (int i = 0; i < 8; i++) {
        buffer[10 + i] = hex_chars[(low >> (28 - i * 4)) & 0xF];
    }
    buffer[18] = '\0';
}

// Упрощённый вывод 64-битных decimal чисел (только для небольших чисел)
static void itoa_dec64(uint64_t num, char* buffer) {
    // Для простоты - выводим только если число помещается в 32 бита
    if (num <= 0xFFFFFFFF) {
        itoa_dec((uint32_t)num, buffer);
    } else {
        // Для больших чисел просто выводим hex
        itoa_hex64(num, buffer);
    }
}


// Обновляем kprintf
void kprintf(const char* fmt, ...) {
    va_list args;
    va_start(args, fmt);
    
    while (*fmt) {
        if (*fmt == '%') {
            fmt++;
            if (*fmt == 'l' && *(fmt + 1) == 'l') {
                // 64-битные спецификаторы: %llx, %llu
                fmt += 2;
                switch (*fmt) {
                    case 'x': {
                        uint64_t num = va_arg(args, uint64_t);
                        char buffer[32];
                        itoa_hex64(num, buffer);
                        puts(buffer);
                        break;
                    }
                    case 'u': {
                        uint64_t num = va_arg(args, uint64_t);
                        char buffer[32];
                        itoa_dec64(num, buffer);
                        puts(buffer);
                        break;
                    }
                    case 'd': {
                        int64_t num = va_arg(args, int64_t);
                        char buffer[32];
                        itoa_dec64((uint64_t)num, buffer);
                        if (num < 0) {
                            putchar('-');
                            puts(buffer);
                        } else {
                            puts(buffer);
                        }
                        break;
                    }
                    default:
                        puts("%ll");
                        putchar(*fmt);
                        break;
                }
            } else {
                // 32-битные спецификаторы
                switch (*fmt) {
                    case 's': {
                        char* str = va_arg(args, char*);
                        puts(str);
                        break;
                    }
                    case 'd': {
                        int num = va_arg(args, int);
                        char buffer[32];
                        itoa_dec(num, buffer);
                        puts(buffer);
                        break;
                    }
                    case 'x': {
                        uint32_t num = va_arg(args, uint32_t);
                        char buffer[32];
                        itoa_hex(num, buffer);
                        puts(buffer);
                        break;
                    }
                    case 'u': {
                        uint32_t num = va_arg(args, uint32_t);
                        char buffer[32];
                        itoa_dec((int)num, buffer);
                        puts(buffer);
                        break;
                    }
                    case 'c': {
                        char c = (char)va_arg(args, int);
                        putchar(c);
                        break;
                    }
                    case '%': {
                        putchar('%');
                        break;
                    }
                    default:
                        putchar('%');
                        putchar(*fmt);
                        break;
                }
            }
        } else {
            putchar(*fmt);
        }
        fmt++;
    }
    
    va_end(args);
}

// Паника - выводит сообщение и останавливает систему
void kpanic(const char* message) {
    kprintf("\n!!! KERNEL PANIC !!!\n");
    kprintf("Reason: %s\n", message);
    kprintf("System halted.\n");
    
    // Бесконечный цикл
    for(;;) {
        asm volatile("hlt");
    }
}
