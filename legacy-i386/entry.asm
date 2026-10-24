[bits 16]
[org 0x8000]


global entry

entry:
  sti 
  mov ah, 0x0E
    mov al, 'K'
    int 0x10

.hang:
    jmp .hang