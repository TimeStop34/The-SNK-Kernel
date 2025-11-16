ENTRY(kmain)

SECTIONS
{


  /* Для GRUB */
  .multiboot :{
    *(.multiboot)
  }


  /* Специальная память | Special memory */

  . = 1M;
  .init_section : {
    *(.init_section)
  }


  /* Основной код и данные ОС */
  . = 2M;
  .text : {
    *(.text)
  }

  .rodata : {
    *(.rodata*)
  }

  .data : {
    *(.data)
  }

  .bss : {
    *(.bss)
    *(COMMON)
  }

  .drivers : {
    /* Создаем символы-маркеры начала и конца секции */
    __start_drivers = .;
    *(.drivers)      /* Все, что в секции .drivers */
    __stop_drivers = .;
  }

  . = 0x30000;
    .file_system : {
        *(.file_system)
    }
  
  /*

  .rodata (Read-Only Data) - константы, строки и любые данные, которые НЕ ИЗМЕНЯЮТСЯ во время работы программы.
  .data (Initialized Data) - переменные, которым присвоено начальное значение.
  .bss (Uninitialized Data) - переменные без начального значение (не инициализированные или инициализированные нулём).

  */


}
