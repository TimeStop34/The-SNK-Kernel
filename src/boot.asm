section .boot

global early_enable_paging, asm_page_fault_handler

early_enable_paging:
    mov eax, 0x1000      ; PDE по адресу 0x1000
    mov cr3, eax
    
    ; Включаем пейджинг
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax
    
    ret

extern page_fault_handler
asm_page_fault_handler:
    pushad          ; Сохранить все регистры
    call page_fault_handler
    mov al, 0x20    ; EOI
    out 0x20, al    ; Отправить в ведущий контроллер
    popad           ; Восстановить регистры
    add esp, 4      ; Убрать код ошибки
    iret            ; Вернуться из прерывания