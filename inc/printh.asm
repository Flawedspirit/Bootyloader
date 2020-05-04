print_h:
    push cx
    push di
    push bx

    mov si, PATTERN
    mov cl, 12
    mov di, 2

.run:
    mov bx, dx
    shr bx, cl
    and bx, 0x000f
    mov bx, [bx+VALUES]
    mov [PATTERN+di], bl
    sub cl, 4
    inc di

    cmp di, 6
    je .exit
    jmp .run

.exit:
    call print_l

    pop bx
    pop di
    pop cx
    ret

PATTERN: db '0x****', 0x0a, 0x0d, 0
VALUES: db '0123456789abcdef'