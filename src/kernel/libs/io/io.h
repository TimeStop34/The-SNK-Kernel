#ifndef _IO_H
#define _IO_H

#include "../types.h"

void kprintf(const char* fmt, ...);
void kpanic(const char* message);
void putchar(char c);
void terminal_initialize(void);

// VGA константы
#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define VGA_BUFFER 0xB8000

#endif