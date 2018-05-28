#Copyright (C) 2018 Matthew Anderson

DEBUG=0
CC=gcc
export CC
ifeq($(DEBUG),1)
			CFLAGS=-g -m64 -std=gnu99 -O2 -ffreestanding -Wall -Wextra
else
			CFLAGS= -m64 -std=gnu99 -O2 -ffreestanding -Wall -Wextra
endif
export CFLAGS
ASBLR=nasm
export ASBLR

ifeq($(DEBUG),1)
	ASBLR_FLAGS=-g -f elf64
else
	ASBLR_FLAGS=-f elf64
endif
export ASBLR_FLAGS

all:
	$(MAKE) -C boot
	$(MAKE) -C kernel

clean:
	rm -rf Build/*.img Build/*.obj Build/*.elf
