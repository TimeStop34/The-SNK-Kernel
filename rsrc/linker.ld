ENTRY(early_boot)

__virtual_base = 0xC0000000;

SECTIONS
{
  . = 1M;

  .multiboot : {
    KEEP(*(.multiboot))
  }

  . = ALIGN(4096);

  .multiboot2 : {
    KEEP(*(.multiboot2))
  }

  . = ALIGN(4096);

  .boot : {
    *(.boot)
  }

  . = ALIGN(4096);

  .boot_data : {
    *(.boot_data)
  }

  . = ALIGN(4096);

  . += __virtual_base;

  PROVIDE(__kernel_start = .);

  .text : AT(ADDR(.text) - __virtual_base) {
    *(.text*)             /* захватываем все подсекции .text */
  }

  

  .rodata : AT(ADDR(.rodata) - __virtual_base) {
    *(.rodata*)           /* все .rodata* */
  }

  . = ALIGN(4096);

  .data : AT(ADDR(.data) - __virtual_base) {
    *(.data*)             /* все .data* */
  }

  . = ALIGN(4096);

  .bss : AT(ADDR(.bss) - __virtual_base) {
    *(.bss*)
    *(COMMON)
  }

  . = ALIGN(4096);
  PROVIDE(__kernel_end = .);

    /* ===== Символы для Multiboot1 ===== */
  PROVIDE(__multiboot_start = ADDR(.multiboot));               /* физический адрес заголовка */
  PROVIDE(__kernel_load_start = ADDR(.multiboot));             /* начало загрузки (1 МБ) */
  PROVIDE(__kernel_load_end   = ADDR(.bss) - __virtual_base);  /* конец загружаемых данных (начало .bss) */
  PROVIDE(__kernel_bss_end    = ADDR(.bss) + SIZEOF(.bss) - __virtual_base); /* конец BSS */
  PROVIDE(__kernel_entry      = early_boot);                  /* точка входа (физический адрес) */
}