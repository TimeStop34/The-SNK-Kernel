#pragma once

void display_cursor_update();
void display_new_line();
void display_print_symbol(unsigned char symbol, unsigned short x, unsigned short y, char font_color, char bkgr_color);
void display_clear();
unsigned char display_get_current_symbol(short offset);
void display_delete_current_symbol(short offset);
void display_init();

extern unsigned short* DISPLAY_CURSOR_POS_YR;
extern unsigned short* DISPLAY_CURSOR_POS_XR;

#define DISPLAY_CURSOR_POS_X *DISPLAY_CURSOR_POS_XR
#define DISPLAY_CURSOR_POS_Y *DISPLAY_CURSOR_POS_YR
