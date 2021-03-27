org 0x7c00                  ;Memory address all bootloaders need to start at
[bits 16]                   ;We in 16-bit real mode, son!

section .text
global start

start:
    cli                     ;Prevent interrupts while we initialize
    jmp 0x0000:init         ;Perform initialization of memory spaces

init:
    xor ax, ax              ;Clear AX register
    mov ss, ax              ;Clear registers by setting them to ax
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

    mov si, STR_M0
    call print_l

    ;mov ax, 0x2400          ;Disable A20 line on purpose
    ;int 0x15

    call enableA20

    
    mov dl, 0x80
    mov al, 1               ;Read only one sector
    mov cl, 2               ;Start at second sector - first is this bootloader
    call load

    jmp sector_two
    
    jmp $                   ;Halt system if nothing happens

%include './inc/strings.asm'
%include './inc/load.asm'
%include './inc/printh.asm'
%include './inc/printl.asm'
%include './inc/testA20.asm'
%include './inc/enableA20.asm'

times 510-($-$$) db 0       ;Padding to make the file 512 bytes minus magic number
dw 0xaa55                   ;Magic number - the reason for the season

;FAKE A SECOND SECTOR OF A BOOT DISK
sector_two:
    mov si, STR_S2
    call print_l

    ;Boot sector is full; doing this in another sector
    call check_lm
    jmp $

    %include './inc/testLM.asm'

    STR_S2: db 'Loading second sector.', 0x0a, 0x0d, 0
    ;STR_M1: db 'Long mode supported.', 0x0a, 0x0d, 0

    times 4096 db 0
