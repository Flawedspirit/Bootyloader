section .data
;Format: <string>, 0a (line feed), 0d (carriage return), 0 (null terminator)
STR_0: db 'Started bootloader...', 0x0a, 0x0d, 0
STR_1: db 'A20 line enabled.', 0x0a, 0x0d, 0
STR_E0: db 'Error reading system disk!', 0x0a, 0x0d, 0