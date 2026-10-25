
disk:
    xor ax, ax
    mov es, ax
    mov bx, 0x8000

; NOTE: I had to use CHS for the time being due to technical errors and issues with LBA, but this is temporary.

    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov dh, 0
    mov cl, 2
    mov dl, [boot_drive]

    int 0x13

    jc .disk_error

    jmp 0x0000:0x8000


.disk_error:
    mov ah, 0x0E
    mov al, 'E'
    int 0x10

.loop:
    cli
    hlt
    jmp .loop
