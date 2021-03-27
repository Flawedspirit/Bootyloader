check_lm:
    pusha
    pushfd
    pop eax
    mov ecx, eax            ;Copy this into ECX as well as a backup

    xor eax, 1 << 21        ;If bit 21 on EAX is not 1, make it 1

    push eax
    popfd                   ;Restore our "new" flags into EFLAGS

    pushfd
    pop eax

    cmp eax, ecx            ;Check if bit 21 was forced back to 0
    jz .error_noLM

    mov eax, 0x80000000     ;Return highest value function CPUID supports
    cpuid
    cmp eax, 0x80000001     ;Check if extended cpu info exists
    jb .error_noLM

    mov eax, 0x80000001
    cpuid
    test edx, 1 << 29       ;If bit 29 of edx is 1, we have long mode support
    jz .error_noLM
    popa
    ret

.error_noLM:
    popa
    mov si, STR_E2
    call print_l
    jmp $                   ;Halt and catch fire