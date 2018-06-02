;Copyright (C) 2018 Matthew Anderson.
;This code is released under the MIT License, see LICENSE file.

bits 16

org 0x0


start:
	mov si, stage2LoadedMessage
	call print

	cli
	hlt

print:
	lodsb
	or	al, al
	jz	.end
	mov	ah, 0eh
	int	10h
	jmp	print
.end:
	ret



stage2LoadedMessage: db "STAGE2 found and loaded", 0
