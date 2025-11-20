global outb, outw, outl, inb, inw, inl, in_out_wait

global in_ah, in_al, in_bh, in_bl, in_ch, in_cl, in_dh, in_dl
global in_ax, in_bx, in_cx, in_dx, in_si
global in_ebx, in_edx, in_esi

global get_ah, get_al, get_bh, get_bl, get_ch, get_cl, get_dh, get_dl
global get_ax, get_bx, get_cx, get_dx, get_si
global get_ebx, get_edx, get_esi

global clear_ah, clear_al, clear_bh, clear_bl, clear_ch, clear_cl, clear_dh, clear_dl
global clear_ax, clear_bx, clear_cx, clear_dx

global get_cr0, get_cr2, get_cr3, get_cr4
global set_cr0, set_cr2, set_cr3, set_cr4

global get_cs, get_ds, get_es, get_fs, get_gs, get_ss
global set_cs, set_ds, set_es, set_fs, set_gs, set_ss

global get_dr0, get_dr1, get_dr2, get_dr3, get_dr6, get_dr7
global set_dr0, set_dr1, set_dr2, set_dr3, set_dr6, set_dr7

global get_tr6, get_tr7, set_tr6, set_tr7

section .text


outb:
    push    ebp
    mov     ebp, esp
    ; [ebp+8] = port (16-bit)
    ; [ebp+12] = byte (8-bit)
    mov     dx, WORD [ebp+8]
    mov     al,  BYTE [ebp+12]
    out     dx, al
    pop     ebp
    ret

outw:
    push    ebp
    mov     ebp, esp
    mov     dx, WORD [ebp+8]
    mov     ax, WORD [ebp+12]
    out     dx, ax
    pop     ebp
    ret

outl:
    push    ebp
    mov     ebp, esp
    ; [ebp+8] = port (16-bit)
    ; [ebp+12] = byte (8-bit)
    mov     dx, WORD [ebp+8]
    mov     eax,  DWORD [ebp+12]
    out     dx, eax
    pop     ebp
    ret

inb:
    push    ebp
    mov     ebp, esp
    mov     dx, WORD [ebp+8]
    xor     eax, eax
    in      al, dx
    pop     ebp
    ret

inw:
    push    ebp
    mov     ebp, esp
    mov     dx, WORD [ebp+8]
    xor     eax, eax
    in      ax, dx
    pop     ebp
    ret

inl:
    push    ebp
    mov     ebp, esp
    mov     dx, WORD [ebp+8]
    xor     eax, eax
    in      eax, dx
    pop     ebp
    ret

in_out_wait:
    mov dx, 0x80
    mov ax, 0
    out dx, ax



; Write 8-bit registers

in_ah:
    mov ah, [esp+4]
    ret

in_al:
    mov al, [esp+4]
    ret

in_bh:
    mov bh, [esp+4]
    ret

in_bl:
    mov bl, [esp+4]
    ret

in_ch:
    mov ch, [esp+4]
    ret

in_cl:
    mov cl, [esp+4]
    ret

in_dh:
    mov dh, [esp+4]
    ret

in_dl:
    mov dl, [esp+4]
    ret

; Write 16-bit registers

in_ax:
    mov ax, [esp+4]
    ret

in_bx:
    mov bx, [esp+4]
    ret

in_cx:
    mov cx, [esp+4]
    ret

in_dx:
    mov dx, [esp+4]
    ret

in_si:
    mov si, [esp+4]
    ret

; Write 32-bit registers

in_ebx:
    mov ebx, [esp+4]
    ret

in_edx:
    mov edx, [esp+4]
    ret

in_esi:
    mov esi, [esp+4]
    ret

; Read 8-bit registers

get_ah:
    movzx eax, ah
    ret

get_al:
    movzx eax, al
    ret

get_bh:
    movzx eax, bh
    ret

get_bl:
    movzx eax, bl
    ret

get_ch:
    movzx eax, ch
    ret

get_cl:
    movzx eax, cl
    ret

get_dh:
    movzx eax, dh
    ret

get_dl:
    movzx eax, dl
    ret

; Read 16-bit registers

get_ax:
    movzx eax, ax
    ret

get_bx:
    movzx eax, bx
    ret

get_cx:
    movzx eax, cx
    ret

get_dx:
    movzx eax, dx
    ret

get_si:
    movzx eax, si
    ret

; Read 32-bit registers

get_ebx:
    mov eax, ebx
    ret

get_edx:
    mov eax, edx
    ret

get_esi:
    mov eax, esi
    ret

; Clear 8-bit registers

clear_ah:
    xor ah, ah
    ret

clear_al:
    xor al, al
    ret

clear_bh:
    xor bh, bh
    ret

clear_bl:
    xor bl, bl
    ret

clear_ch:
    xor ch, ch
    ret

clear_cl:
    xor cl, cl
    ret

clear_dh:
    xor dh, dh
    ret

clear_dl:
    xor dl, dl
    ret

; Clear 16-bit registers

clear_ax:
    xor ax, ax
    ret

clear_bx:
    xor bx, bx
    ret

clear_cx:
    xor cx, cx
    ret

clear_dx:
    xor dx, dx
    ret

; Control Registers
get_cr0:
    mov eax, cr0
    ret

get_cr2:
    mov eax, cr2
    ret

get_cr3:
    mov eax, cr3
    ret

get_cr4:
    mov eax, cr4
    ret

set_cr0:
    mov eax, [esp + 4]
    mov cr0, eax
    ret

set_cr2:
    mov eax, [esp + 4]
    mov cr2, eax
    ret

set_cr3:
    mov eax, [esp + 4]
    mov cr3, eax
    ret

set_cr4:
    mov eax, [esp + 4]
    mov cr4, eax
    ret

; Segment Registers - Get
get_cs:
    mov ax, cs
    ret

get_ds:
    mov ax, ds
    ret

get_es:
    mov ax, es
    ret

get_fs:
    mov ax, fs
    ret

get_gs:
    mov ax, gs
    ret

get_ss:
    mov ax, ss
    ret

; Segment Registers - Set
set_cs:
    mov ax, [esp + 4]
    mov cs, ax
    ret

set_ds:
    mov ax, [esp + 4]
    mov ds, ax
    ret

set_es:
    mov ax, [esp + 4]
    mov es, ax
    ret

set_fs:
    mov ax, [esp + 4]
    mov fs, ax
    ret

set_gs:
    mov ax, [esp + 4]
    mov gs, ax
    ret

set_ss:
    mov ax, [esp + 4]
    mov ss, ax
    ret

; Debug Registers - Get
get_dr0:
    mov eax, dr0
    ret

get_dr1:
    mov eax, dr1
    ret

get_dr2:
    mov eax, dr2
    ret

get_dr3:
    mov eax, dr3
    ret

get_dr6:
    mov eax, dr6
    ret

get_dr7:
    mov eax, dr7
    ret

; Debug Registers - Set
set_dr0:
    mov eax, [esp + 4]
    mov dr0, eax
    ret

set_dr1:
    mov eax, [esp + 4]
    mov dr1, eax
    ret

set_dr2:
    mov eax, [esp + 4]
    mov dr2, eax
    ret

set_dr3:
    mov eax, [esp + 4]
    mov dr3, eax
    ret

set_dr6:
    mov eax, [esp + 4]
    mov dr6, eax
    ret

set_dr7:
    mov eax, [esp + 4]
    mov dr7, eax
    ret

; Test Registers - Get
get_tr6:
    mov eax, tr6
    ret

get_tr7:
    mov eax, tr7
    ret

; Test Registers - Set
set_tr6:
    mov eax, [esp + 4]
    mov tr6, eax
    ret

set_tr7:
    mov eax, [esp + 4]
    mov tr7, eax
    ret