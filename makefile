all: BOOTX64.EFI

EFI_INC = -I/usr/include/efi -I/usr/include/efi/x86_64 -I/usr/include/efi/protocol
EFI_LIB = /usr/lib
LDSCRIPT = /usr/lib/elf_x86_64_efi.lds

main.o: main.c
	gcc -ffreestanding $(EFI_INC) -fno-stack-protector -fpic -fshort-wchar -mno-red-zone -c main.c -o main.o

BOOTX64.EFI: main.o
	ld -nostdlib -znocombreloc -T $(LDSCRIPT) -shared -Bsymbolic /usr/lib/crt0-efi-x86_64.o main.o -o main.os -L $(EFI_LIB) -lefi -lgnuefi
	objcopy -j .text -j .sdata -j .data -j .rodata -j .dynamic -j .dynsym  -j .rel -j .rela -j .rel.* -j .rela.* -j .reloc --target=efi-app-x86_64 main.os BOOTX64.EFI


clean:
	rm -rf *.o *.so *.os BOOTX64.EFI iso/

run: BOOTX64.EFI

	mkdir -p iso/EFI/BOOT \
	
	cp BOOTX64.EFI iso/EFI/BOOT/ \
	
	qemu-system-x86_64 \
		-drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.fd \
		-net none \
		-drive file=fat:rw:iso,format=raw --nographic 
		

.PHONY: all clean run