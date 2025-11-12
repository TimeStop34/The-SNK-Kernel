ENTRY(_start)

SECTIONS {
    . = 1M;

    .boot :
    {
        /* в начале оставим заголовк мультизагрузки */
        *(.multiboot_header)
    }

    .text :
    {
        *(.text)
    }
}