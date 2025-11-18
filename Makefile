CC = gcc
ASM = nasm

CFLAGS = -w -ffreestanding -m32 -Wall -Wextra -fno-pie -nostdlib -fno-asynchronous-unwind-tables
ASMFLAGS = -f elf32
LDFLAGS = -m elf_i386 -T src/linker.ld --oformat elf32-i386

SRCDIR = src
OBJDIR = output

# C файлы
C_SOURCES = \
    src/boot.c \
    src/kernel.c \
    src/kernel/libs/spinlock/spinlock.c \
    src/kernel/libs/io/io.c \
    src/kernel/libs/io/serial/serial.c \
    src/kernel/libs/string/string.c \
    src/kernel/idt/IDT_PIC.c \
    src/kernel/memory/memory_system.c \
    src/kernel/memory.c \
    src/kernel/memory/pmm/pmm.c \
    src/kernel/memory/simple_operations.c

# ASM файлы
ASM_SOURCES = \
    src/kernel/gdt/gdt.asm \
    src/kernel/libs/asm/asm.asm \
    src/boot.asm

OBJECTS = $(C_SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/c/%.o)
ASM_OBJECTS = $(ASM_SOURCES:$(SRCDIR)/%.asm=$(OBJDIR)/asm/%.o)

# Все объектные файлы
ALL_OBJECTS = $(OBJECTS) $(ASM_OBJECTS)

all: real_all

$(OBJDIR):
	mkdir -p $(OBJDIR)

# Правило компиляции C файлов
$(OBJDIR)/c/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Правило для .asm файлов
$(OBJDIR)/asm/%.o: $(SRCDIR)/%.asm | $(OBJDIR)
	mkdir -p $(dir $@)
	$(ASM) $(ASMFLAGS) $< -o $@

# Основные цели
objects: $(ALL_OBJECTS)

build: objects
	ld $(LDFLAGS) -o output/kernel.elf $(ALL_OBJECTS)

# Остальная часть остается как у тебя...
build_programs:
	mkdir -p ./output/programs/
	mkdir -p ./output/programs/term2/
	mkdir -p ./output/programs/uptime/
	mkdir -p ./output/programs/colorama/

	nasm -f elf32 src/libs/asm.S -o output/programs/asm.o

	# Term2
	gcc -w -m32 -ffreestanding -fno-pie -fno-pic -nostdlib -c programs/term2/term2.c -o output/programs/term2/term2.o
	ld -m elf_i386 -T programs/program_linker.ld -o output/programs/term2/term2.elf output/programs/asm.o output/programs/term2/term2.o output/libs/io.o output/libs/string.o output/libs/time.o output/libs/programs.o output/libs/ata.o
	{ \
		printf "%s" "__iamelfprogramm__"; \
		cat output/programs/term2/term2.elf; \
		printf "%s" "__enfofelfprogramm__"; \
	} > output/programs/term2/term2.bin

	# Uptime
	gcc -w -m32 -ffreestanding -fno-pie -fno-pic -nostdlib -c programs/uptime/uptime.c -o output/programs/uptime/uptime.o
	ld -m elf_i386 -T programs/program_linker.ld -o output/programs/uptime/uptime.elf output/programs/asm.o output/programs/uptime/uptime.o output/libs/io.o output/libs/string.o
	{ \
		printf "%s" "__iamelfprogramm__"; \
		cat output/programs/uptime/uptime.elf; \
		printf "%s" "__enfofelfprogramm__"; \
	} > output/programs/uptime/uptime.bin

	# Colorama
	gcc -w -m32 -ffreestanding -fno-pie -fno-pic -nostdlib -c programs/colorama/colorama.c -o output/programs/colorama/colorama.o
	ld -m elf_i386 -T programs/program_linker.ld -o output/programs/colorama/colorama.elf output/programs/asm.o output/programs/colorama/colorama.o output/libs/io.o output/libs/string.o output/libs/time.o
	{ \
		printf "%s" "__iamelfprogramm__"; \
		cat output/programs/colorama/colorama.elf; \
		printf "%s" "__enfofelfprogramm__"; \
	} > output/programs/colorama/colorama.bin

make_iso:
	cp output/kernel.elf iso/boot/
	grub2-mkrescue -o output/os.iso ./iso/

make_disk:
	{ \
		printf "%s" "__iamfile__"; \
		printf "%s" "my_filename\0"; \
		printf "%hhu" 1; \
		printf "%s" "__enfoffile__"; \
	} > output/test.bin
	dd if=output/test.bin of=output/disk.img bs=512 seek=20 conv=notrunc

run:
	qemu-system-i386 -no-reboot -no-shutdown -serial stdio -m 10M \
	-drive file=output/os.iso,format=raw,if=ide,index=1,media=cdrom \
	-boot d


real_all: build make_iso run

.PHONY: all run make_disk build_programs build run make_iso objects real_all