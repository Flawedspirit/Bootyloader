print_l:
    pusha

str_loop:
    mov al, [si]
    cmp al, 0
    jne print_char
    popa
    ret

print_char:
    mov ah, 0x0e            ;Signal BIOS to begin outputting characters
    int 0x10                ;BIOS video interrupt, aka print
    add si, 1
    jmp str_loop