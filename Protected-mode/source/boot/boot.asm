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
    dd gdt_start ;offsetb

[BITS 32]
load32:
    mov eax, 1 ;we don't want to load from 0 because that os yhr boot sector
    mov ecx, 100
    mov edi, 0x0100000
    call ata_lba_read 
    jmp CODE_SEG:0x0100000

ata_lba_read:
    mov ebX, eax, ;for the LBA
    
    ;Sending
    shr eax, 24
    or eax, 0xE0 ;master drive 
    mov dx, 0x1F6
    out dx, al
    ;Finishing

    ;Sending to read 
    mov eax, ecx 
    mov dx, 0x1F2
    out dx, al
    ;Finishing  

    ;more bits 
    mov eax, ebX
    mov dx, 0x1F3
    out dx, al  

    mov dx, 0x1F4
    mov eax, ebx ;restoring 
    shr eax, 8
    out dx, al
    ;fininshing

    ; upper 16 bits
    mov dx, 0xF5
    mov eax, ebx 
    shr eax, 16
    out dx, al
    ;Finishing 

    mov dx, 0x1f7
    mov al, 0x20
    out dx, al

.next_sector:
    push ecx

.try_again:
    mov dx, 0x1f7
    in al, dx
    test al,8
    jz .try_again

    ;reading 256 words 
    mov ecx, 256
    mov dx,0xF0
    rep insw
    pop ecx
    loop .next_sector
    ret 

times 510 -($ -$$) db 0 
dw 0xAA55

