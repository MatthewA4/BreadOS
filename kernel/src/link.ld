ENTRY(_start)
OUTPUT_ARCH("i386")
OUTPUT_FORMAT("elf32-i386")

sta = 0x00100000;

SECTIONS
{
  . = sta;

  .__multiboot : AT (ADDR (.__multiboot))
  {
    *(.__multiboot)
  }

  .text BLOCK(4096) : ALIGN(4096)
  {
    code = .;
    *(.text)
    *(.rodata)
  }

  .data BLOCK(4096) : ALIGN(4096)
  {
    data = .;
    *(.data)
  }

  .bss BLOCK(4096) : ALIGN(4096)
  {
    bss = .;
    *(.bss)
    *(COMMON)
  }
  end = .;
}
