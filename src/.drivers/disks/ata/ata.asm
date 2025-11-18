section .text
global asm_ata_interrupt_handler
extern ata_interrupt_handler

asm_ata_interrupt_handler:
    popa
    call ata_interrupt_handler
    pusha
    iretd