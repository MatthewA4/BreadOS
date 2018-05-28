#Copyright (C) 2018 Matthew Anderson

IMGName=floppy.img

all: stage1 sst2ldr.sys IMG

stage1: stage1.asm
	nasm -f bin $< -o stage1.bin

sst2ldr.sys: sst2ldr.asm
	nasm -f bin $< -o sst2ldr.sys

IMG: stage1
	dd if=/dev/zero of=$(IMGName) count=2880 bs=512
	dd if=stage1.bin of=$(IMGName) count=1 conv=notrunc
	mcopy -i floppy.img sst2ldr.sys ::/

clean:
		rm -rf *.bin *.sys *.img
