load:
    pusha
    mov ah, 0x02
    mov dl, 0x80            ;We will load from a hard drive
    mov ch, 0               ;Select first cylinder
    mov dh, 0               ;Select first head

    push bx
    mov bx, 0
    mov es, bx              ;Segment register cannot be set manually
    pop bx
    mov bx, 0x7e00          ;Offset 512 bytes from start

    int 0x13                ;BIOS disk interrupt
    jc disk_err             ;Oh no!
    popa
    ret

disk_err:
    mov si, STR_E0
    call print_l
    jmp $                   ;Halt and catch fire