all:
	mkdir -p tmp/iso/boot/grub
	cargo build
	cp target/i686-none/debug/snk-new-port tmp/iso/boot/kernel.bin
	( echo 'set timeout=5'; \
		echo 'set default=0'; \
		echo 'menuentry "My Kernel Multiboot2" {'; \
		echo '    multiboot2 /boot/kernel.bin'; \
		echo '}'; \
		echo 'menuentry "My Kernel Multiboot1" {'; \
		echo '    multiboot /boot/kernel.bin'; \
		echo '}' ) > tmp/iso/boot/grub/grub.cfg
	grub-mkrescue -o tmp/my_kernel.iso tmp/iso/

run: all
	qemu-system-i386 -m 4G -cdrom tmp/my_kernel.iso -no-reboot -no-shutdown -d int

clean:
	cargo clean
	rm -rf tmp