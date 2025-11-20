section .text
global invalidate_table_TLB, invalidate_directory_TLB, asm_page_fault_handler

; Инвалидация TLB для PTE по индексу
invalidate_table_TLB:
    mov eax, [esp + 4]      ; pte_index
    shl eax, 12             ; * 4096
    invlpg [eax]
    ret

; Инвалидация TLB для PDE по индексу  
invalidate_directory_TLB:
    mov eax, [esp + 4]      ; pde_index
    shl eax, 22             ; * 4MB
    invlpg [eax]
    ret

