;specifying our assembly origin
ORG 0

;16bit arch
BITS 16

_start:
    jmp short start
    nop

times 33 db 0 ;33 bytes 

start: 

    jmp 0x7c0:step0


; handle_zero:
;     mov ah,0eh
;     mov al,'A'
;     mov bx, 0x00
;     int 0x10
;     ret

; handle_one:
;     mov ah, 0eh
;     mov al,'B'
;     mov bx, 0x00
;     int 0x10
;     iret

step0:
;the address of the label into register 
    cli
    ;data segment
    mov ax, 0x7c0
    mov ds,ax
    mov es,ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00

    sti

    mov ah, 2
    mov al, 1
    mov ch, 0
    mov cl,2
    mov dh, 0
    mov bx, buffer
    int 0x13 ;Invoking
    jc issue
    mov si, buffer
    call print
    jmp $ 

issue:
    mov si, error_message
    call print
    jmp $

    ; int 0

    ;the first two bytes of RAM are the offset for interrup zaro 
    ; mov word [ss:0x00], handle_zero
    ; mov word [ss:0x02], 0x7c0

    ; mov word [ss:0x04], handle_one
    ; mov word [ss:0x06], 0x7c0
    
    ; int 1
    ; ;int 0 -->illigal 

    ; mov ax, 0x00
    ; div ax

    ; mov si,message
    ; call print
    ; jmp $

print:
    mov bx, 0

.loop:
    lodsb
    cmp al,0
    je .done
    call print_char
    jmp .loop

.done:
    ret

print_char: 
    mov ah, 0eh

    ;BIOS
    int 0x10
    ret 



error_message: db 'Error loading sector', 0

; message: db 'Hello Zahra', 0

times 510 -($ -$$) db 0 
dw 0xAA55

buffer:
