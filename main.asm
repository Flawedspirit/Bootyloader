org 0x7c00                  ;Memory address all bootloaders need to start at
bits 16                     ;We in 16-bit real mode, son!

section .text
    global start

start:
    cli                     ;Prevent interrupts while we initialize
    jmp 0x0000:init         ;Perform initialization of memory spaces

init:
    xor ax, ax
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov sp, start
    cld                     ;Make sure execution starts from lowest address
    sti                     ;Re-enable interrupts

    ;Reset disk
    xor ax, ax
    mov dl, 0x80            ;Set read mode to hard disk
    int 0x13                ;Poke said hard disk

    mov si, STR_0
    call print_l

    mov dl, 0x80
    mov al, 1               ;Read only one sector
    mov cl, 2               ;Start at second sector - first is this bootloader
    call load

    jmp $                   ;Halt system if nothing happens

%include './inc/strings.asm'
%include './inc/load.asm'
%include './inc/printh.asm'
%include './inc/printl.asm'

times 510-($-$$) db 0       ;Padding to make the file EXACTLY 512 bytes
dw 0xaa55                   ;Magic number - the reason for the season
