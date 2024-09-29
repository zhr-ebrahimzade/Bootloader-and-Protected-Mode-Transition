[BITS 32]
; section .asm

global _start
extern kernel_main

CODE_SEG eq 0x00
DATA_SEG eq 0x10
_start:
    mov ax,DATA_SEG
    mov ds,ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0x00200000
    mov esp, ebp

    ;Enabling
    in al, 0x92
    or al,2
    out 0x92,al

    call kernel_main
    jmp $
times 512 -($ -$$) db 0 
