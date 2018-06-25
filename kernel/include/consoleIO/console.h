//Copyright (C) 2018 Matthew Anderson. mattanderson65@outlook.com
//This source code is released under the MIT License, See LICENSE file.


#ifndef CONSOLE_H_
#define CONSOLE_H_

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

//80x25
#define CONSOLE_VGA_WIDTH 80
#define CONSOLE_VGA_HEIGHT 25


struct CONSOLE {
  uint16_t Pos;
  uint16_t pagePos;
  uint16_t *termBufPos;
} primary;

//Returns number of characters printed
//Should use 0xFF00 for default color
int consolePrint(char *character, uint16_t color);

void consoleInit();

#endif
