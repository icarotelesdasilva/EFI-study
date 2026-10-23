
main: main.c
	gcc -ffreestanding -fPIC -fshort-wchar -mno-red-zone -c main.c -o kernel.o && ld -shared -Bsymbolic -nostdlib -T linker.ld kernel.o -o kernel.so && objcopy --target=efi-app-x86_64 kernel.so kernel.efi

