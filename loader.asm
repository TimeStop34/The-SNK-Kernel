bits 64
section .text
    global _start
    extern start

_start:
    ; В 64-битном режиме используем младшие 32 бита 64-битных регистров
    ; Согласно System V AMD64 ABI: 
    ; первый параметр -> edi/rdi, второй параметр -> esi/rsi
    
    mov edi, eax   ; magic -> первый параметр
    mov esi, ebx   ; mb_info_addr -> второй параметр
    call start