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

make_iso:
	cp output/kernel.elf iso/boot/
	grub2-mkrescue -o output/os.iso ./iso/

run:
	qemu-system-i386 -no-reboot -no-shutdown -serial stdio -m 10M \
	-drive file=output/os.iso,format=raw,if=ide,index=1,media=cdrom \
	-boot d


real_all: build make_iso run

.PHONY: all run build make_iso objects real_all