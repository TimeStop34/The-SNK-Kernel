section .boot

global early_enable_paging, save_multiboot

save_multiboot:
    mov [0x2000], eax

    ; Сохраняем EBX по адресу 0x2004  
    mov [0x2004], ebx
    ret

early_enable_paging:
    mov eax, 0x1000      ; PDE по адресу 0x1000
    mov cr3, eax
    
    ; Включаем пейджинг
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax

    ret