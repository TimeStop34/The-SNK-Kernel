section .boot
global early_gdt_init

early_gdt:
    ; Нулевой дескриптор (не используется): Index = 0
    dd 0x00000000
    dd 0x00000000
    ; Сегмент кода (для привилегий 0, 32-битный): Index = 1
    dd 0x0000FFFF
    dd 0x00CF9A00
    ; Сегмент данных (для привилегий 0, 32-битный): Index = 2
    dd 0x0000FFFF
    dd 0x00CF9200


early_gdt_info:
    dw early_gdt_info - early_gdt - 1   ; Размер GDT (должен быть на 1 меньше)
    dd early_gdt                  ; Адрес GDT (32-битный)

early_gdt_init:
    lgdt [early_gdt_info]         ; Загружаем GDT


    ; Перезагружаем сегментные регистры
    mov ax, 0x10            ; Селектор сегмента данных (просто математика: 2 << 3 = 0x10 - 2 это индекс)
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Делаем дальний прыжок для обновления CS
    jmp 0x08:.early_reload_cs     ; 0x08 - селектор кода (просто математика: 1 << 3 = 0x08 - 1 это индекс)


.early_reload_cs:
    ret
