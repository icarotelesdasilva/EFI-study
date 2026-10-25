section .text
global real_mode



real_mode:

 mov [boot_drive], dl   
 
cli


xor ax, ax
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ss, ax
mov sp, 0x7c00 

 mov dl, [boot_drive]



jmp disk


%include "disk.asm"

boot_drive db 0

times 510-($-$$) db 0
dw 0xAA55
