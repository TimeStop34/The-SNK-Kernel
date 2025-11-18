#ifndef _SERIAL_H
#define _SERIAL_H

#include "../../types.h"

void serial_init(void);
void serial_putchar(char c);
void serial_puts(const char* str);
void serial_printf(const char* fmt, ...);

#endif