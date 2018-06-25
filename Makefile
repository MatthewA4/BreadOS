#Copyright (C) 2018 Matthew Anderson. mattanderson65@outlook.com
#This source code is released under the MIT License, See LICENSE file.

CC=gcc
ASM=nasm
CFLAGS=-c -m32 -ffreestanding -nostdlib -O2 -Wall -Wextra
ASM_FLAGS=-f elf32

BUILD_OBJS := Build/Obj/src/kernel.o \
						 Build/Obj/src/kernelinit.o

LNKR=gcc
LNKR_FLAGS=-m32 -T kernel/src/link.ld -ffreestanding -O2 -nostdlib

INC := kernel/include

all: Build/Bin/bread.elf

clean:
	rm -rf Build/*

#main kernel linkage

Build/Bin/bread.elf: $(BUILD_OBJS)
	mkdir -p $(@D)
	$(LNKR) $(LNKR_FLAGS) $< -o $@


Build/Obj/src/%.o: kernel/src/%.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@ -I $(INC)

Build/Obj/src/%.o: kernel/src/%.asm
	mkdir -p $(@D)
	$(ASM) $(ASM_FLAGS) $< -o $@

#*****************************************************************************
