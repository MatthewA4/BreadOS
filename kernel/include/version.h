//Copyright (C) 2018 Matthew Anderson. mattanderson65@outlook.com
//This source code is released under the MIT License, See LICENSE file.

#ifndef VERSION_H_
#define VERSION_H_

#if defined(__i386__)
#define VERSION_FULL "BreadOS 0.01a i386"
#define VERSION_ARCH "i386"
#define VERSION_NUMBER "0.01a"
#define BUILD_STATE "Early Alpha"

#else
  #error "Incorrect build target!"
#endif

#endif
