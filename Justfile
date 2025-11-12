build: clean
    cargo build --release
    cp target/x86_64-unknown-none/release/libkernel.a tmp/libkernel.a
    nasm -f elf64 src/asm/multiboot_header.asm -o tmp/multiboot_header.o
    nasm -f elf64 src/asm/loader.asm -o tmp/loader.o
    ld -n -o tmp/kernel.bin -T linker.ld tmp/multiboot_header.o tmp/loader.o tmp/libkernel.a
    cp tmp/kernel.bin out/isofiles/boot/kernel.bin
    cp tmp/kernel.bin out/bin/kernel.bin

clean:
    rm -rf tmp/* out/iso/os.iso

build-iso: build
    grub2-mkrescue -o out/iso/os.iso out/isofiles

test: build-iso
    qemu-system-x86_64 -cdrom out/iso/os.iso 