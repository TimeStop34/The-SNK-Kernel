#include "pit.h"
#include "../drivers.h"

#define PIT_CMD  0x43
#define PIT_CH0  0x40
#define PIT_INPUT_FREQ 1193182UL

unsigned long long* TICKSR;
#define TICKS *TICKSR

extern void asm_tick_handler(void);

static void pit_init(void) {
    IDT_reg_handler(32, 0x08, 0x80 | 0x0E, asm_tick_handler);
    TICKSR = kmalloc(sizeof(unsigned long long));
    PIT_init(1000);
}

void PIT_init(unsigned int freq_hz) {

    // Выставляем заданную в freq_hz частоту (количество тиков в секунду)

    unsigned int divisor = (unsigned int)(PIT_INPUT_FREQ / freq_hz); // 1193182 / freq
    unsigned char lo = divisor & 0xFF;
    unsigned char hi = (divisor >> 8) & 0xFF;

    // Mode 3 (square wave), access lobyte/hibyte, channel 0
    outb(PIT_CMD, 0x36);

    // write divisor low then high
    outb(PIT_CH0, lo);
    outb(PIT_CH0, hi);
}

static void pit_shutdown(void) {
    // Отключаем прерывания таймера
}

// Обработчик прерывания PIT
void tick_handler(){
	TICKS++;
	outb(0x20, 0x20);
}

DRIVER(pit, pit_init, pit_shutdown, 
       FLAG_CRITICAL);