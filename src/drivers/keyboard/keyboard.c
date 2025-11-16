#include "../drivers.h"
#include "keyboard.h"
#include "impl/ps2.h"

struct keybuffer* KEYBOARD_KEYBUFFER;

struct special_keys* KEYBOARD_SPECIAL;

unsigned char* BUFFER;

extern void asm_keyboard_handler();

static void keyboard_init(void) {
    KEYBOARD_KEYBUFFER = kmalloc(sizeof(struct keybuffer));
    
    KEYBOARD_SPECIAL = kmalloc(sizeof(struct special_keys));

    IDT_reg_handler(33, 0x08, 0x80 | 0x0E, asm_keyboard_handler);
    keyboard_controller_init();
}

void keyboard_controller_init() {
    ps2_keyboard_init();
    IDT_reg_handler(33, 0x08, 0x80 | 0x0E, asm_keyboard_handler);
}

void keyboard_handler(){
    ps2_keyboard_handler();
}

struct keybuffer get_keys_buffer(){
    return *KEYBOARD_KEYBUFFER;
}

struct special_keys get_special_keys_buffer(){
    return *KEYBOARD_SPECIAL;
}

unsigned char* get_native_keys_buffer() {
    return BUFFER;
}

int keyboard_is_shift_pressed() {
    return KEYBOARD_SPECIAL->shift_l_pressed || KEYBOARD_SPECIAL->shift_r_pressed;
}

// Проверка нажата ли любая Ctrl
int keyboard_is_ctrl_pressed() {
    return KEYBOARD_SPECIAL->ctrl_l_pressed || KEYBOARD_SPECIAL->ctrl_r_pressed;
}

// Проверка нажата ли любая Alt
int keyboard_is_alt_pressed() {
    return KEYBOARD_SPECIAL->alt_l_pressed || KEYBOARD_SPECIAL->alt_r_pressed;
}

// Проверка нажата ли любая Win
int keyboard_is_win_pressed() {
    return KEYBOARD_SPECIAL->win_l_pressed || KEYBOARD_SPECIAL->win_r_pressed;
}


DRIVER(keyboard, keyboard_init, NULL, FLAG_NONE);