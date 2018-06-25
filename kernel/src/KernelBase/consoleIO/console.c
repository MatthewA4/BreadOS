//Copyright (C) 2018 Matthew Anderson. mattanderson65@outlook.com
//This source code is released under the MIT License, See LICENSE file.

#include "consoleIO/console.h"


int consolePrint(char *character, uint16_t color)
{
    uint16_t *position = (primary.termBufPos);
    int i=0;
    int j = primary.Pos;
    while (character[i] != '\0')
    {
      position[j] = (position[j] & color) | character[i];
      i++;
      j += 2;
    }
    primary.Pos = j;
    return i;
}

void consoleInit()
{
  primary.Pos = 0;
  primary.pagePos = 0;
  primary.termBufPos = (uint16_t*)0xB8000;
  return;
}
