all: build make_iso run # build_programs  make_disk

build:
	mkdir -p ./output/
	mkdir -p ./output/asm/
	mkdir -p ./output/api/
	mkdir -p ./output/drivers/
	mkdir -p ./output/libs/
	mkdir -p ./output/programs/

	# Assembler
	nasm -f elf32 src/libs/asm.S -o output/asm/asm.o
	nasm -f elf32 src/kernel/gdt/gdt.asm -o output/asm/gdt.o
	nasm -f elf32 src/drivers/keyboard/keyboard.asm -o output/asm/keyboard.o
	nasm -f elf32 src/drivers/pit/pit.asm -o output/asm/pit.o
	nasm -f elf32 src/drivers/disks/ata/ata.asm -o output/asm/ata.o
	# nasm -f elf32 src/api/api.asm -o output/asm/api.o <- not implemented

	# C
	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/kernel.c -o output/kernel.o
	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/kernel/idt/IDT_PIC.c -o output/IDT_PIC.o
	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/memory.c -o output/memory.o

	# gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/api/api.c -o output/api/api.o <- not implemented

	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/drivers/disks/ata/ata.c -o output/drivers/ata.o
	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/drivers/display/display.c -o output/drivers/display.o
	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/drivers/drivers.c -o output/drivers/drivers.o
	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/drivers/keyboard/keyboard.c -o output/drivers/keyboard.o
	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/drivers/keyboard/impl/ps2.c -o output/drivers/ps2.o
	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/drivers/pit/pit.c -o output/drivers/PIT.o
	# gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/drivers/progdetector.c -o output/drivers/progdetector.o <- not implemented
	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/drivers/disks/device.c -o output/drivers/device.o
	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/drivers/vfs/vfs.c -o output/drivers/vfs.o

	# gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/libs/ata.c -o output/libs/ata.o
	# gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/libs/io.c -o output/libs/io.o
	# gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/libs/programs.c -o output/libs/programs.o
	gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/libs/string.c -o output/libs/string.o
	# gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/libs/time.c -o output/libs/time.o
	# gcc -w -ffreestanding -m32 -fno-pie -nostdlib -c src/libs/memory.c -o output/libs/memory.o

	# Linker
	# output/asm/api.o \
	# output/api/api.o \
		# output/drivers/progdetector.o \
		# output/libs/ata.o \
		# output/libs/io.o \
		# output/libs/programs.o \ 
		# 
		# output/libs/time.o \
		# output/libs/memory.o \
	ld -m elf_i386 -T src/linker.ld --oformat elf32-i386 -o output/kernel.elf \
		output/asm/asm.o \
		output/asm/keyboard.o \
		output/asm/pit.o \
		output/asm/ata.o \
		output/asm/gdt.o \
		output/libs/string.o \
		output/kernel.o \
		output/IDT_PIC.o \
		output/memory.o \
		output/drivers/ata.o \
		output/drivers/display.o \
		output/drivers/drivers.o \
		output/drivers/keyboard.o \
		output/drivers/ps2.o \
		output/drivers/PIT.o \
		output/drivers/device.o \
		output/drivers/vfs.o

build_programs:
	mkdir -p ./output/programs/
	mkdir -p ./output/programs/term2/
	mkdir -p ./output/programs/uptime/
	mkdir -p ./output/programs/colorama/

	# NASM
	nasm -f elf32 src/libs/asm.S -o output/programs/asm.o

	# |
	# | Term2
	# |

	# C
	gcc -w -m32 -ffreestanding -fno-pie -fno-pic -nostdlib -c programs/term2/term2.c -o output/programs/term2/term2.o
	# Linker
	ld -m elf_i386 -T programs/program_linker.ld -o output/programs/term2/term2.elf output/programs/asm.o output/programs/term2/term2.o output/libs/io.o output/libs/string.o output/libs/time.o output/libs/programs.o output/libs/ata.o
	{ 
		printf "%s" "__iamelfprogramm__"
		cat output/programs/term2/term2.elf
		printf "%s" "__enfofelfprogramm__"
	} > output/programs/term2/term2.bin

	# |
	# | Uptime
	# |

	gcc -w -m32 -ffreestanding -fno-pie -fno-pic -nostdlib -c programs/uptime/uptime.c -o output/programs/uptime/uptime.o
	ld -m elf_i386 -T programs/program_linker.ld -o output/programs/uptime/uptime.elf output/programs/asm.o output/programs/uptime/uptime.o output/libs/io.o output/libs/string.o
	{
		printf "%s" "__iamelfprogramm__"
		cat output/programs/uptime/uptime.elf
		printf "%s" "__enfofelfprogramm__"
	} > output/programs/uptime/uptime.bin

	# |
	# | Colorama
	# |

	gcc -w -m32 -ffreestanding -fno-pie -fno-pic -nostdlib -c programs/colorama/colorama.c -o output/programs/colorama/colorama.o
	ld -m elf_i386 -T programs/program_linker.ld -o output/programs/colorama/colorama.elf output/programs/asm.o output/programs/colorama/colorama.o output/libs/io.o output/libs/string.o output/libs/time.o
	{
		printf "%s" "__iamelfprogramm__"
		cat output/programs/colorama/colorama.elf
		printf "%s" "__enfofelfprogramm__"
	} > output/programs/colorama/colorama.bin


make_iso:
	# Make ISO
	cp output/kernel.elf iso/boot/
	grub2-mkrescue -o output/os.iso ./iso/

#make_disk:
	# Make hard disk
	# dd if=/dev/zero of=output/disk.img bs=512 count=32768
	# Write programs on the disk
	# dd if=output/programs/term2/term2.bin of=output/disk.img bs=512 seek=2 conv=notrunc
	# dd if=output/programs/colorama/colorama.bin of=output/disk.img bs=512 seek=40 conv=notrunc
	# dd if=output/programs/uptime/uptime.bin of=output/disk.img bs=512 seek=20 conv=notrunc

run:
	qemu-system-i386 -no-reboot -no-shutdown -monitor stdio \
	-drive file=output/disk.img,format=raw,if=ide,index=0,media=disk \
	-drive file=output/os.iso,format=raw,if=ide,index=1,media=cdrom \
	-boot d
