#define KEYBOARD_BUFFER_SIZE 16

#define KEYBOARD_SHIFT_SCANCODE 42
#define KEYBOARD_CTRL_SCANCODE 29
#define KEYBOARD_ALT_SCANCODE 56

#include "ps2.h"
#include "../../../memory.h"
#include "../keyboard.h"

unsigned char* KEYBOARD_BUFFER;
unsigned char* KEYBOARD_BUFFER_PTRR;
#define KEYBOARD_BUFFER_PTR *KEYBOARD_BUFFER_PTRR

// Добавление сканн-кода в буфер клавиатуры (для последующего использования программами)
void ps2_keyboard_scancode_add_in_buffer(unsigned char scancode){
    KEYBOARD_BUFFER[KEYBOARD_BUFFER_PTR] = scancode;
    KEYBOARD_BUFFER_PTR = (KEYBOARD_BUFFER_PTR+1) % KEYBOARD_BUFFER_SIZE;
}

void ps2_keyboard_update_key_state(int scancode, int state) {
    switch(scancode) {
        // Буквы
        case 0x1E: KEYBOARD_KEYBUFFER->a_state = state; break;
        case 0x30: KEYBOARD_KEYBUFFER->b_state = state; break;
        case 0x2E: KEYBOARD_KEYBUFFER->c_state = state; break;
        case 0x20: KEYBOARD_KEYBUFFER->d_state = state; break;
        case 0x12: KEYBOARD_KEYBUFFER->e_state = state; break;
        case 0x21: KEYBOARD_KEYBUFFER->f_state = state; break;
        case 0x22: KEYBOARD_KEYBUFFER->g_state = state; break;
        case 0x23: KEYBOARD_KEYBUFFER->h_state = state; break;
        case 0x17: KEYBOARD_KEYBUFFER->i_state = state; break;
        case 0x24: KEYBOARD_KEYBUFFER->j_state = state; break;
        case 0x25: KEYBOARD_KEYBUFFER->k_state = state; break;
        case 0x26: KEYBOARD_KEYBUFFER->l_state = state; break;
        case 0x32: KEYBOARD_KEYBUFFER->m_state = state; break;
        case 0x31: KEYBOARD_KEYBUFFER->n_state = state; break;
        case 0x18: KEYBOARD_KEYBUFFER->o_state = state; break;
        case 0x19: KEYBOARD_KEYBUFFER->p_state = state; break;
        case 0x10: KEYBOARD_KEYBUFFER->q_state = state; break;
        case 0x13: KEYBOARD_KEYBUFFER->r_state = state; break;
        case 0x1F: KEYBOARD_KEYBUFFER->s_state = state; break;
        case 0x14: KEYBOARD_KEYBUFFER->t_state = state; break;
        case 0x16: KEYBOARD_KEYBUFFER->u_state = state; break;
        case 0x2F: KEYBOARD_KEYBUFFER->v_state = state; break;
        case 0x11: KEYBOARD_KEYBUFFER->w_state = state; break;
        case 0x2D: KEYBOARD_KEYBUFFER->x_state = state; break;
        case 0x15: KEYBOARD_KEYBUFFER->y_state = state; break;
        case 0x2C: KEYBOARD_KEYBUFFER->z_state = state; break;
        
        // Цифры
        case 0x0B: KEYBOARD_KEYBUFFER->key_0_state = state; break;
        case 0x02: KEYBOARD_KEYBUFFER->key_1_state = state; break;
        case 0x03: KEYBOARD_KEYBUFFER->key_2_state = state; break;
        case 0x04: KEYBOARD_KEYBUFFER->key_3_state = state; break;
        case 0x05: KEYBOARD_KEYBUFFER->key_4_state = state; break;
        case 0x06: KEYBOARD_KEYBUFFER->key_5_state = state; break;
        case 0x07: KEYBOARD_KEYBUFFER->key_6_state = state; break;
        case 0x08: KEYBOARD_KEYBUFFER->key_7_state = state; break;
        case 0x09: KEYBOARD_KEYBUFFER->key_8_state = state; break;
        case 0x0A: KEYBOARD_KEYBUFFER->key_9_state = state; break;
        
        // Основные клавиши
        case 0x39: KEYBOARD_KEYBUFFER->space_state = state; break;
        case 0x1C: KEYBOARD_KEYBUFFER->enter_state = state; break;
        case 0x01: KEYBOARD_KEYBUFFER->esc_state = state; break;
        case 0x0E: KEYBOARD_KEYBUFFER->backspace_state = state; break;
        case 0x0F: KEYBOARD_KEYBUFFER->tab_state = state; break;
        
        // Символьные клавиши
        case 0x0C: KEYBOARD_KEYBUFFER->minus_state = state; break;
        case 0x0D: KEYBOARD_KEYBUFFER->equal_state = state; break;
        case 0x1A: KEYBOARD_KEYBUFFER->lbracket_state = state; break;
        case 0x1B: KEYBOARD_KEYBUFFER->rbracket_state = state; break;
        case 0x2B: KEYBOARD_KEYBUFFER->backslash_state = state; break;
        case 0x27: KEYBOARD_KEYBUFFER->semicolon_state = state; break;
        case 0x28: KEYBOARD_KEYBUFFER->quote_state = state; break;
        case 0x29: KEYBOARD_KEYBUFFER->backquote_state = state; break;
        case 0x33: KEYBOARD_KEYBUFFER->comma_state = state; break;
        case 0x34: KEYBOARD_KEYBUFFER->period_state = state; break;
        case 0x35: KEYBOARD_KEYBUFFER->slash_state = state; break;
        
        // Функциональные клавиши
        case 0x3B: KEYBOARD_KEYBUFFER->f1_state = state; break;
        case 0x3C: KEYBOARD_KEYBUFFER->f2_state = state; break;
        case 0x3D: KEYBOARD_KEYBUFFER->f3_state = state; break;
        case 0x3E: KEYBOARD_KEYBUFFER->f4_state = state; break;
        case 0x3F: KEYBOARD_KEYBUFFER->f5_state = state; break;
        case 0x40: KEYBOARD_KEYBUFFER->f6_state = state; break;
        case 0x41: KEYBOARD_KEYBUFFER->f7_state = state; break;
        case 0x42: KEYBOARD_KEYBUFFER->f8_state = state; break;
        case 0x43: KEYBOARD_KEYBUFFER->f9_state = state; break;
        case 0x44: KEYBOARD_KEYBUFFER->f10_state = state; break;
        case 0x57: KEYBOARD_KEYBUFFER->f11_state = state; break;
        case 0x58: KEYBOARD_KEYBUFFER->f12_state = state; break;
        
        // Навигация
        case 0x52: KEYBOARD_KEYBUFFER->insert_state = state; break;
        case 0x47: KEYBOARD_KEYBUFFER->home_state = state; break;
        case 0x49: KEYBOARD_KEYBUFFER->pageup_state = state; break;
        case 0x53: KEYBOARD_KEYBUFFER->delete_state = state; break;
        case 0x4F: KEYBOARD_KEYBUFFER->end_state = state; break;
        case 0x51: KEYBOARD_KEYBUFFER->pagedown_state = state; break;
        case 0x48: KEYBOARD_KEYBUFFER->up_state = state; break;
        case 0x50: KEYBOARD_KEYBUFFER->down_state = state; break;
        case 0x4B: KEYBOARD_KEYBUFFER->left_state = state; break;
        case 0x4D: KEYBOARD_KEYBUFFER->right_state = state; break;
        
        // Дополнительные
        case 0x37: KEYBOARD_KEYBUFFER->printscreen_state = state; break;
        case 0x46: KEYBOARD_KEYBUFFER->scrolllock_state = state; break;
        case 0x45: KEYBOARD_KEYBUFFER->numlock_state = state; break;
        // Pause обрабатывается особо (обычно 0xE1 0x1D 0x45)
    }
}

void ps2_keyboard_update_special_keys(int scancode, int pressed) {
    switch(scancode) {
        case 0x2A: KEYBOARD_SPECIAL->shift_l_pressed = pressed; break;
        case 0x36: KEYBOARD_SPECIAL->shift_r_pressed = pressed; break;
        case 0x1D: KEYBOARD_SPECIAL->ctrl_l_pressed = pressed; break;
        case 0xE01D: KEYBOARD_SPECIAL->ctrl_r_pressed = pressed; break;
        case 0x38: KEYBOARD_SPECIAL->alt_l_pressed = pressed; break;
        case 0xE038: KEYBOARD_SPECIAL->alt_r_pressed = pressed; break;
        case 0xE05B: KEYBOARD_SPECIAL->win_l_pressed = pressed; break;  // Left Win
        case 0xE05C: KEYBOARD_SPECIAL->win_r_pressed = pressed; break;  // Right Win
        case 0xE05D: KEYBOARD_SPECIAL->menu_pressed = pressed; break;   // Context Menu
        
        // Toggle-клавиши
        case 0x3A: if (pressed) KEYBOARD_SPECIAL->caps_lock = !KEYBOARD_SPECIAL->caps_lock; break;
        case 0x45: if (pressed) KEYBOARD_SPECIAL->num_lock = !KEYBOARD_SPECIAL->num_lock; break;
        case 0x46: if (pressed) KEYBOARD_SPECIAL->scroll_lock = !KEYBOARD_SPECIAL->scroll_lock; break;
        default: break;
    }
}

// Возвращает скан-код нажатой клавиши
unsigned char ps2_keyboard_get_scancode(){
    unsigned char keyboard_state = inb(0x64);
    if ((keyboard_state & 0b00000001) == 0b00000001) return inb(0x60);
    else return 0;
}

char ps2_keyboard_is_special_key(unsigned int scancode) {
    switch (scancode) {
        // Базовые специальные клавиши
        case 0x2A: // Left Shift
        case 0x36: // Right Shift
        case 0x1D: // Left Ctrl
        case 0x38: // Left Alt
        // Extended специальные клавиши
        case 0xE01D: // Right Ctrl
        case 0xE038: // Right Alt
        case 0xE05B: // Left Win
        case 0xE05C: // Right Win
        case 0xE05D: // Context Menu
        // Toggle-клавиши (тоже считаем специальными)
        case 0x3A: // Caps Lock
        case 0x45: // Num Lock
        case 0x46: // Scroll Lock
            return 1;
        default:
            return 0;
    }
}

// обрабатывает нажатие клавиши(прерывание, вызванное из под главного класса клавиатуры)
void ps2_keyboard_handler() {
    unsigned char scancode = ps2_keyboard_get_scancode();
    
    if (scancode == 0) return; // Нет данных
    
    int is_released = (scancode & 0x80); // Проверка отпускания (бит 7 установлен)
    int clean_scancode = scancode & 0x7F; // Чистый скан-код без бита отпускания
    int key_state = is_released ? KEY_STATE_RELEASED : KEY_STATE_PRESSED;

    // Обработка extended скан-кодов (0xE0 префикс)
    static int extended_mode = 0;
    
    if (scancode == 0xE0) {
        extended_mode = 1;
        outb(0x20, 0x20); // EOI
        return;
    }
    
    if (scancode == 0xE1) {
        // Обработка Pause/Break (специальная последовательность)
        // Пока пропустим, можно обработать позже
        outb(0x20, 0x20); // EOI
        return;
    }

    // Если в extended mode, добавляем префикс к скан-коду
    if (extended_mode) {
        clean_scancode = 0xE000 | scancode;
        extended_mode = 0;
    }

    // Проверяем специальные клавиши
    int is_special = ps2_keyboard_is_special_key(clean_scancode);
    
    if (is_special) {
        // Обрабатываем специальные клавиши (Shift, Ctrl, Alt, Win, Menu, toggle-клавиши)
        ps2_keyboard_update_special_keys(clean_scancode, !is_released);
    } else {
        // Обычные клавиши - обновляем их состояние
        ps2_keyboard_update_key_state(clean_scancode, key_state);
        
        // Для обратной совместимости - добавляем в старый буфер только при нажатии
        if (!is_released) {
            ps2_keyboard_scancode_add_in_buffer(scancode);
        }
    }
    
    outb(0x20, 0x20); // EOI
}

void ps2_keyboard_init(){
    KEYBOARD_BUFFER = kmalloc(0x10);
    KEYBOARD_BUFFER_PTRR = kmalloc(0x1);

    BUFFER = *KEYBOARD_BUFFER;
}
