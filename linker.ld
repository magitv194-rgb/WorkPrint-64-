OUTPUT_FORMAT(elf64-x86-64)
OUTPUT_ARCH(i386:x86-64)
ENTRY(_start)

KERNEL_VMA = 0xffffffff80000000;
KERNEL_LMA = 0x00100000;

PHDRS
{
    text    PT_LOAD FLAGS(5);
    rodata  PT_LOAD FLAGS(4);
    requests PT_LOAD FLAGS(6);
    data    PT_LOAD FLAGS(6);
}

SECTIONS
{
    . = KERNEL_VMA;

    .text ALIGN(4K) : AT(ADDR(.text) - KERNEL_VMA + KERNEL_LMA)
    {
        KEEP(*(.text.boot))
        *(.text .text.*)
    } :text

    .rodata ALIGN(4K) : AT(ADDR(.rodata) - KERNEL_VMA + KERNEL_LMA)
    {
        *(.rodata .rodata.*)
    } :rodata

    .limine_requests ALIGN(4K) : AT(ADDR(.limine_requests) - KERNEL_VMA + KERNEL_LMA)
    {
        KEEP(*(.limine_requests_start))
        KEEP(*(.limine_requests))
        KEEP(*(.limine_requests_end))
    } :requests

    .data ALIGN(4K) : AT(ADDR(.data) - KERNEL_VMA + KERNEL_LMA)
    {
        *(.data .data.*)
    } :data

    .bss ALIGN(4K) (NOLOAD) : AT(ADDR(.bss) - KERNEL_VMA + KERNEL_LMA)
    {
        *(COMMON)
        *(.bss .bss.*)
    } :data

    /DISCARD/ :
    {
        *(.comment)
        *(.eh_frame)
        *(.note .note.*)
    }
}
