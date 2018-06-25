;Copyright (C) 2018 Matthew Anderson
;This source code is released under the MIT License, See LICENSE file.

;Implements multiboot.

[bits 32]

memoryInfo equ 1 << 1
alignPageBoundary equ 1 << 0
multibootFlags equ alignPageBoundary | memoryInfo
magicNumber equ 0x1BADB002
checksum equ -(magicNumber + multibootFlags)

section .multiboot
align 4
    dd magicNumber
    dd multibootFlags
    dd checksum

section .bss
align 16 ; 16 bit alined.

bottomStack:
resb (16*1024) ;24 kilobyte reserve.
topStack:

section .text
global _start
extern kernelMain

_start:
    mov esp, topStack
    call kernelMain
    cli
    hlt
