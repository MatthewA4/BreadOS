ENTRY(_start)

SECTIONS
{

  . = 1M;

  .text BLOCK(4096) : ALIGN(4096)
  {
    *(.multiboot)
    *(.text)
  }

  .rodata BLOCK(4096) : ALIGN(4096)
  {
    *(.rodata)
  }

  .data BLOCK(4096) : ALIGN(4096)
  {
    *(.data)
  }

  .bss BLOCK(4096) : ALIGN(4096)
  {
    *(COMMON)
    *(.bss)
  }

}
