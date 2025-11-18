#include "serial.h"
#include "../io.h"
#include "../stdarg.h"

#define COM1_PORT 0x3F8

void serial_init(void) {
    // Отключаем прерывания
    outb(COM1_PORT + 1, 0x00);
    // Устанавливаем скорость (115200 baud)
    outb(COM1_PORT + 3, 0x80);
    outb(COM1_PORT + 0, 0x01);
    outb(COM1_PORT + 1, 0x00);
    // 8 бит, no parity, 1 stop bit
    outb(COM1_PORT + 3, 0x03);
    // Включаем FIFO
    outb(COM1_PORT + 2, 0xC7);
    // Включаем IRQ
    outb(COM1_PORT + 4, 0x0B);
}

void serial_putchar(char c) {
    // Ждём пока порт освободится
    while ((inb(COM1_PORT + 5) & 0x20) == 0);
    outb(COM1_PORT, c);
}

void serial_puts(const char* str) {
    while (*str) serial_putchar(*str++);
}

void serial_printf(const char* fmt, ...) {
    char buffer[256];
    va_list args;
    va_start(args, fmt);
    
    // Простая реализация - выводим в буфер, затем в serial
    char* p = buffer;
    while (*fmt) {
        if (*fmt == '%') {
            fmt++;
            switch (*fmt) {
                case 's': {
                    char* str = va_arg(args, char*);
                    while (*str) *p++ = *str++;
                    break;
                }
                case 'd': {
                    int num = va_arg(args, int);
                    if (num == 0) {
                        *p++ = '0';
                    } else {
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
                        while (t > temp) *p++ = *--t;
                    }
                    break;
                }
                case 'x': {
                    uint32_t num = va_arg(args, uint32_t);
                    const char* hex = "0123456789ABCDEF";
                    *p++ = '0';
                    *p++ = 'x';
                    for (int i = 28; i >= 0; i -= 4) {
                        *p++ = hex[(num >> i) & 0xF];
                    }
                    break;
                }
                default:
                    *p++ = '%';
                    *p++ = *fmt;
                    break;
            }
        } else {
            *p++ = *fmt;
        }
        fmt++;
    }
    *p = '\0';
    va_end(args);
    
    serial_puts(buffer);
}