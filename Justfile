build: clean
    cargo build --release
    cp target/x86_64-unknown-none/release/libkernel.a .
    nasm -f elf64 multiboot_header.asm
    ld -n -o kernel.bin -T linker.ld multiboot_header.o loader.o libkernel.a
    cp kernel.bin isofiles/boot/kernel.bin

clean:
    rm -rf libkernel.a multiboot_header.o os.iso

build-iso: build
    grub2-mkrescue -o os.iso isofiles

test: build-iso
    qemu-system-x86_64 -cdrom os.iso 
