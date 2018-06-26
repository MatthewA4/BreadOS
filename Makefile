#Copyright (C) 2018 Matthew Anderson. mattanderson65@outlook.com
#This source code is released under the MIT License, See LICENSE file.

CC=gcc
ASM=nasm
LNKR=gcc

CFLAGS=-c -m32 -ffreestanding -nostdlib -O2 -Wall -Wextra
ASM_FLAGS=-O99 -f elf32
LNKR_FLAGS=-m32 -T kernel/src/link.ld -ffreestanding -O2 -nostdlib


BUILD_OBJS := Build/Obj/src/kernel.o \
						 Build/Obj/src/kernelinit.o \
						 Build/Obj/src/KernelBase/consoleIO/console.o \


INC := kernel/include

all: Build/Bin/bread.elf

clean:
	rm -rf Build/*

#main kernel linkage

Build/Bin/bread.elf: $(BUILD_OBJS)
	mkdir -p $(@D)
	$(LNKR) $(LNKR_FLAGS) $^ -o $@


Build/Obj/src/%.o: kernel/src/%.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@ -I $(INC)

Build/Obj/src/%.o: kernel/src/%.asm
	mkdir -p $(@D)
	$(ASM) $(ASM_FLAGS) $< -o $@

Build/Obj/src/KernelBase/consoleIO/%.o: kernel/src/KernelBase/consoleIO/%.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@ -I $(INC)

#*****************************************************************************
