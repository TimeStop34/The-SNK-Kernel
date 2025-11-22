DRIVER_NAME = Kernel_Driver_API
OBJ_DIR = ../../../../output/drivers/$(DRIVER_NAME)

CC = gcc
CFLAGS = -w -ffreestanding -m32 -fno-pie -nostdlib

NSM = nasm
NSMFLAGS = -f elf32

all:
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c kapi.c -o $(OBJ_DIR)/kapi.o
