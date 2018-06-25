//Copyright (C) 2018 Matthew Anderson. mattanderson65@outlook.com
//This source code is released under the MIT License, See LICENSE file.

//this file includes functions that are critical to the initial loading of the
//OS kernel, directly called by the assembler file kernelinit.asm


#include "apic.h"
#include "consoleIO/console.h"

#if !defined(__i386__)
    #error "Can only compile to an 32-bit system."
#endif


void kernelMain()
{
  consoleInit();
  char *character = "LOADED SUCCESSFULLY!";
  consolePrint(character, 0xFF00);
  return;
}
