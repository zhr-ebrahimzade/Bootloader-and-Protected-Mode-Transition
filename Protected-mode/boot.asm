;specifying our assembly origin
ORG 0x7c00

;16bit arch
BITS 16

CODE_SEG equ gdt_code-gdt_start
DATA_SEG equ gdt_data-gdt_start

_start:
    jmp short start
    nop

times 33 db 0 ;33 bytes 

start: 

    jmp 0:step0


step0:
;the address of the label into register 
    cli
    ;data segment
    mov ax, 0x00
    mov ds,ax
    mov es,ax
    ; mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00
    sti
    ; jmp $ 

.load_protcted:
    cli
    lgdt[gdt_des]
    mov eax, cr0
    or eax, 0x1
    mov cr0,eax
    jmp CODE_SEG:load32

;Global Descriptor Table 
gdt_start:

gdt_null:
    dd 0x0
    dd 0x0

;Offsetting 0x8
gdt_code:
    dw 0xffff ;0-15 bits
    dw 0 ;base
    db 0 ;16-23 bits
    db 0x9a ;Acss
    db 11001111b 
    db 0 ; 24-31
    
;offsettinng 0x10
gdt_data:
    dw 0xffff
    dw 0 ;base
    db 0 ;16-23 bits
    db 0x92 ;Acss
    db 11001111b 
    db 0 ; 24-31
 
 gdt_end:

 gdt_des:
    dw gdt_end - gdt_start -1 ;gives the size
    dd gdt_start ;offset

[BITS 32]
load32:
    mov ax,DATA_SEG
    mov ds,ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0x00200000
    mov esp, ebp
    jmp $

times 510 -($ -$$) db 0 
dw 0xAA55

