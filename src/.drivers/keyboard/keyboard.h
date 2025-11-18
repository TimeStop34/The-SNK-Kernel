#pragma once

#define KEY_STATE_NONE 0
#define KEY_STATE_PRESSED 1
#define KEY_STATE_RELEASED 2
#define KEY_STATE_HOLD 3

// Буфер для обычных клавиш
struct keybuffer {
    // Буквы
    int a_state; int b_state; int c_state; int d_state; int e_state;
    int f_state; int g_state; int h_state; int i_state; int j_state;
    int k_state; int l_state; int m_state; int n_state; int o_state;
    int p_state; int q_state; int r_state; int s_state; int t_state;
    int u_state; int v_state; int w_state; int x_state; int y_state;
    int z_state;
    
    // Цифры
    int key_0_state; int key_1_state; int key_2_state; int key_3_state;
    int key_4_state; int key_5_state; int key_6_state; int key_7_state;
    int key_8_state; int key_9_state;
    
    // Символьные клавиши
    int space_state; int enter_state; int esc_state; int backspace_state;
    int tab_state; int minus_state; int equal_state; int lbracket_state;
    int rbracket_state; int backslash_state; int semicolon_state;
    int quote_state; int backquote_state; int comma_state; int period_state;
    int slash_state;
    
    // Функциональные клавиши
    int f1_state; int f2_state; int f3_state; int f4_state; int f5_state;
    int f6_state; int f7_state; int f8_state; int f9_state; int f10_state;
    int f11_state; int f12_state;
    
    // Клавиши навигации
    int insert_state; int home_state; int pageup_state; int delete_state;
    int end_state; int pagedown_state; int up_state; int down_state;
    int left_state; int right_state;
    
    // Дополнительные
    int printscreen_state; int scrolllock_state; int pause_state;
    int numlock_state;
};

// Буфер для специальных клавиш (флаги)
struct special_keys {
    int shift_l_pressed;
    int shift_r_pressed;
    int ctrl_l_pressed;
    int ctrl_r_pressed;
    int alt_l_pressed;
    int alt_r_pressed;
    int win_l_pressed;      // Left Windows/Super
    int win_r_pressed;      // Right Windows/Super
    int menu_pressed;       // Context Menu
    int caps_lock;          // Только как флаг, не как состояние
    int num_lock;           // Только как флаг
    int scroll_lock;        // Только как флаг
};

int keyboard_is_shift_pressed();
int keyboard_is_ctrl_pressed();
int keyboard_is_alt_pressed();
int keyboard_is_win_pressed();

extern struct keybuffer* KEYBOARD_KEYBUFFER;

extern struct special_keys* KEYBOARD_SPECIAL;

extern unsigned char* BUFFER;