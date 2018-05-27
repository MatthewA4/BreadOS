; Copyright (C) 2018 Matthew Anderson. mattanderson65@outlook.com

; inspired by the bootloader and operating system tutorials at
; http://brokenthorn.com . I thank the author so much if he ever reads this.
; Also I want to thank the wiki contributors at OSDev.org for the resources they
; have on there.

bits 16
org 0x0

happyBeginning:	jmp start

OEMblock:		         db "mkdosfs "
bytesPerSector:		   dw 512
sectorsPerCluster: 	 db 1
reservedSectors: 	   dw 1
numberOfFATs:		     db 2
numRootEntries:		   dw 224
totalLogicalSectors: dw 2880
mediaType:		       db 0xF8
sectorsPerFAT:		   dw 9
sectorsPerTrack: 	   dw 18
HeadsPerCylinder: 	 dw 2
hiddenSectors: 		   dd 0
totalSectors: 		   dd 0
driveNumber: 		     db 0x00
driveFlags:			     db 0
signature: 		       db 0x29
volumeID: 		       dd 0xdeadbeef
volumeLabelString: 	 db "BREAD OS   "
sysIdentifierString: db "FAT12   "

; print function, prints what SI is currently pointing to until it reaches
; null
; be sure to save th value of BX before calling print if need to preserve.

print:
  xor bx, bx ; make sure both BH and BL are 0
  .print:
    lodsb   ; load the next character being pointed to by SI into AL
    or al, al ; if it's 0, then we have reached the terminator for the string.
    jz .done
    mov ah, 0eh ; interrupt to tack on a character to screen.
    int 10h
    jmp .print
    .done:
    ret

; https://en.wikipedia.org/wiki/Logical_block_addressing#CHS_conversion
; CHS to LBA:
; LBA = (CylinderNum * HeadsPerCylinder + HeadNumber) * sectorsPerTrack +
; (SectorNum - 1)
; AX: cylinder number
; BX: head number
; CX: sector number
; result is stored in AX
chsToLBA:



lbaToCHS:


start:


times 510-$+$$ db 0
dw 0xAA55
