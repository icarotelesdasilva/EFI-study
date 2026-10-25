
section .text
global _start

BITS 16
_start:
    cli

    in al, 0x92
    or al, 2
    out 0x92, al

    lgdt [gdt_descriptor]
    
    mov eax, cr0
    or al, 1
    mov cr0, eax

    jmp dword 0x08:protect_mode

[bits 32]
protect_mode:
    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov esp, 0x90000

    mov byte [0xB8000], 'A'
    mov byte [0xB8001], 0x09

.hang:
    jmp .hang

align 4

gdt_start:
gdt_null:
    dq 0x0000000000000000

gdt_code:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 11001111b
    db 0x00

gdt_data:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00
gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start
