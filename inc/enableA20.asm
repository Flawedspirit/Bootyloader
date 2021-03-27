enableA20:
    pusha

;BIOS METHOD
    mov ax, 0x2401
    int 0x15                ;BIOS interrupt

    call testA20
    cmp ax, 1
    je .exit
    ret

;KEYBOARD CONTROLLER METHOD
    cli

    call wait_control
    mov al, 0xad            ;Disable keyboard
    out 0x64, al            ;Send command to keyboard controller

    call wait_control
    mov al, 0xd0            ;Read output port
    out 0x64, al

    call wait_data
    in al, 0x60             ;Input from keyboard data port
    push ax

    call wait_control
    mov al, 0xd1            ;Write to output port
    out 0x64, al

    call wait_control
    pop ax
    or al, 2                ;Mask out first bit
    out 0x60, al            ;Send second bit (which enables A20) out

    call wait_control
    mov al, 0xae            ;Enable keyboard
    out 0x64, al

    sti

    call testA20
    cmp ax, 1
    je .exit
    ret

;FASTA20 METHOD
    in al, 0x92             ;Chipset interrupt
    or al, 2
    out 0x92, al

    call testA20
    cmp ax, 1
    je .exit

;IF EVERYTHING FAILS
    mov si, STR_E1
    call print_l
    jmp $                   ;Halt and catch fire

.exit:
    popa
    mov ax, 1
    ret

wait_control:
    in al, 0x64             ;Input from keyboard command port
    test al, 2              ;Look at second bit
    jnz wait_control        ;If not 0, controller is busy - wait
    ret

wait_data:
    in al, 0x64
    test al, 1              ;Look at first bit
    jz wait_data            ;If 0, data is ready to be read
    ret