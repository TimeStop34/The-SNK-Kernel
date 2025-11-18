ENTRY(early_boot)

__physical_base = 0x10000;
__virtual_base = 0xC0000000;

SECTIONS
{
  /* Для GRUB */
  .multiboot : {
    *(.multiboot)
  }

  /* Boot section по фиксированному адресу */
  . = __physical_base;
  
  .boot : AT(__physical_base) {
    *(.boot)
  }

  /* Переходим к следующему физическому адресу для .text */
  . = 0x20000;

  /* Виртуальные адреса начинаются с 0xC0000000 */
  . = __virtual_base + 0x20000;

  .text : AT(ADDR(.text) - __virtual_base) {
    *(.text)
  }

  .init_section : AT(ADDR(.init_section) - __virtual_base) {
    *(.init_section)
  }

  .rodata : AT(ADDR(.rodata) - __virtual_base) {
    *(.rodata*)
  }

  .data : AT(ADDR(.data) - __virtual_base) {
    *(.data)
  }

  .bss : AT(ADDR(.bss) - __virtual_base) {
    *(.bss)
    *(COMMON)
  }

  __kernel_end = .;
  
  /*
  .rodata (Read-Only Data) - константы, строки и любые данные, которые НЕ ИЗМЕНЯЮТСЯ во время работы программы.
  .data (Initialized Data) - переменные, которым присвоено начальное значение.
  .bss (Uninitialized Data) - переменные без начального значение (не инициализированные или инициализированные нулём).
  */
}