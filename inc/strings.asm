;Format: <string>, 0a (line feed), 0d (carriage return), 0 (null terminator)
STR_M0: db 'Started bootloader...', 0x0a, 0x0d, 0
STR_E0: db 'Error reading boot disk!', 0x0a, 0x0d, 0
STR_E1: db 'No A20 support. Exiting.', 0x0a, 0x0d, 0
STR_E2: db 'No long mode support. Exiting.', 0x0a, 0x0d, 0