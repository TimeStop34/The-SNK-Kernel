#pragma once
// Инициализация PS/2 клавиатуры
void ps2_keyboard_init();

// Обработчик прерывания клавиатуры
void ps2_keyboard_handler();

// Добавление скан-кода в буфер
void ps2_keyboard_scancode_add_in_buffer(unsigned char scancode);

// Получение скан-кода из порта
unsigned char ps2_keyboard_get_scancode();

// Обновление состояния обычной клавиши
void ps2_keyboard_update_key_state(int scancode, int state);

// Обновление состояния специальных клавиш
void ps2_keyboard_update_special_keys(int scancode, int pressed);

// Проверка является ли клавиша специальной
char ps2_keyboard_is_special_key(unsigned int scancode);