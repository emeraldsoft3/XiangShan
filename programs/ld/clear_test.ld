SECTIONS
{
    . = 0x80000000;          /* XiangShan bare-metal start address */
    .text : { *(.text) }
    .data : { *(.data) }
    .bss : { *(.bss) }
}