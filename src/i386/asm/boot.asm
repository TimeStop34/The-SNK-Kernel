section .boot_data
extern MULTIBOOT_MAGIC, MULTIBOOT_ADDR, PD

section .boot

extern early_boot

global early_enable_paging, save_multiboot

save_multiboot:
    mov [MULTIBOOT_MAGIC], eax   ; сохраняем EAX (magic) в переменную
    mov [MULTIBOOT_ADDR], ebx    ; сохраняем EBX (addr) в переменную
    ret

early_enable_paging:
    mov eax, PD
    mov cr3, eax
    mov eax, cr0
    or  eax, 0x80000000
    mov cr0, eax
    ret


section .multiboot
align 4

; Объявляем внешние символы, определённые в линкер-скрипте (через PROVIDE)
extern __multiboot_start
extern __kernel_load_start
extern __kernel_load_end
extern __kernel_bss_end
extern __kernel_entry

; Магическое число Multiboot 1
dd 0x1BADB002

; Флаги: бит 16 (адресные поля) + бит 0 (выравнивание модулей) + бит 1 (информация о памяти)
dd (1 << 16) | (1 << 0) | (1 << 1)

; Контрольная сумма: -(magic + flags)
dd -(0x1BADB002 + ((1 << 16) | (1 << 0) | (1 << 1)))

; Адресные поля (все пять обязательны, если установлен бит 16)
dd __multiboot_start    ; header_addr – физический адрес самого заголовка
dd __kernel_load_start  ; load_addr – физический адрес начала загрузки (1 МБ)
dd __kernel_load_end    ; load_end_addr – физический адрес конца загружаемых данных (начало BSS)
dd __kernel_bss_end     ; bss_end_addr – физический адрес конца BSS-секции
dd __kernel_entry       ; entry_addr – физический адрес точки входа (early_boot)

section .multiboot2
align 8

; === базовый заголовок ===
dd 0xE85250D6                ; magic
dd 0                         ; architecture (i386)
dd multiboot2_end - multiboot2_start ; total length
dd 0x100000000 - (0xE85250D6 + 0 + (multiboot2_end - multiboot2_start)) ; checksum

multiboot2_start:

; === тег entry address (тип 3) ===
dw 3
dw 0
dd 12
dd early_boot

; === выравнивание до 8 байт ===
align 8

; === завершающий тег (тип 0) ===
dw 0
dw 0
dd 8

multiboot2_end: