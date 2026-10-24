

all:
	nasm -f bin boot.asm -o boot.bin
	nasm -f bin entry.asm -o entry.bin 
	cat boot.bin entry.bin > boot.img
	dd if=/dev/zero of=boot.img bs=512 count=2880
	dd if=boot.bin of=boot.img conv=notrunc
	dd if=entry.bin of=boot.img bs=512 seek=1 conv=notrunc



clean:

	rm -rf *.o *.bin *.img

run:

	qemu-system-i386 boot.img --nographic


.PHONY: clean run