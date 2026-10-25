

all:
	nasm -f bin boot.asm -o boot.bin
	nasm -f elf32 entry.asm -o entry.o	
	ld -m elf_i386 -Ttext 0x8000 entry.o -o entry.bin --oformat binary
	cat boot.bin entry.bin > boot.img
	truncate -s 1474560 boot.img

clean:

	rm -rf *.o *.bin *.img

run:

	qemu-system-i386 -fda boot.img 


.PHONY: clean run