#Copyright (C) 2018 Matthew Anderson

IMGName=floppy.img

all: object IMG

object: stage1.asm
	nasm -f bin $< -o stage1.bin

IMG: object
	dd if=/dev/zero of=$(IMGName) count=2880 bs=512
	dd if=stage1.bin of=$(IMGName) count=1 conv=notrunc

clean:
		rm -rf *.bin *.img
