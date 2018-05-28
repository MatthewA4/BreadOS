; Copyright (C) 2018 Matthew Anderson. mattanderson65@outlook.com

; inspired by the bootloader and operating system tutorials at
; http://brokenthorn.com . I thank the author so much if he ever reads this.
; Also I want to thank the wiki contributors at OSDev.org for the resources they
; have on there.

bits 16
org 0x0

happyBeginning:	jmp start

oemBlock:		         db "mkdosfs "
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

;***************************************************************************
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
;***************************************************************************


;***************************************************************************
; https://en.wikipedia.org/wiki/Logical_block_addressing#CHS_conversion
; CHS to LBA:
; LBA = (CylinderNum * HeadsPerCylinder + HeadNumber) * sectorsPerTrack +
; (SectorNum - 1)
; AX := cylinder number
; BX := head number
; CX := sector number
; result is stored in AX
chsToLBA:
  mul word [HeadsPerCylinder]
  add ax, bx
  mul word [sectorsPerTrack]
  add ax, cx
  dec ax
  ret
;***************************************************************************

; LBA to CHS:
; Cylinder/Head/Sector to Logical Block Addressing
; https://en.wikipedia.org/wiki/Logical_block_addressing#CHS_conversion
;
; Cylinder = LBA * (HeadsPerCylinder * sectorsPerTrack)
; Head = (LBA / sectorsPerTrack) modulus HeadsPerCylinder
; sector = (LBA modulus sectorsPerTrack) + 1
;
; input
;      AX := LBA
; output:
;      chsCylinder := cylinder number
;      chsHead := head number
;      chsSector := sector number
lbaToCHS:
    mov word [lba], ax
    mul word [HeadsPerCylinder]
    mul word [sectorsPerTrack]
    mov word [chsCylinder], ax

    mov ax, word [lba]
    div word [sectorsPerTrack]
    mov ax, dx
    div word [HeadsPerCylinder]
    mov word [chsHead],  dx

    mov ax, word [lba]
    div word [sectorsPerTrack]
    add dx, 1
    mov word [chsSector], dx
    ret
;***************************************************************************

;***************************************************************************
; Reads sectors from the floppy disk.
; AX := number of sectors to read
; BX := starting sector (LBA)
; DX := memory location to write read sectors too.
readSectors:


;***************************************************************************

start:


stage2Filename: db "SST2LDR SYS", 0
stage1LoadedCorrectlyMessage: db "[+] Stage 1 Loaded Correctly...", 0

lbaSector: db 0

lba: dw 0

curSector: dw 0
chsCylinder: dw 0
chsHead:     dw 0
chsSector:   dw 0

times 510-$+$$ db 0
dw 0xAA55
