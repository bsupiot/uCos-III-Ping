/* ENTRY POINT */
ENTRY(reset_handler)

MEMORY
{
	ddr					(RWX) : ORIGIN = 0x80000000, LENGTH = 0x80000000
}

SECTIONS
{

	.interrupts :{
		__VECTOR_TABLE = .;
		. = ALIGN(4);
		KEEP(*(.isr_vector))
		. = ALIGN(4);
	} > ddr

	.text :
	{
		. = ALIGN(4);
    *(.text)                 /* .text sections (code) */
    *(.text*)                /* .text* sections (code) */
    *(.rodata)               /* .rodata sections (constants, strings, etc.) */
    *(.rodata*)              /* .rodata* sections (constants, strings, etc.) */
		. = ALIGN(4);
	} > ddr
	
	.data :
	{
		. = ALIGN(4);
		*(.data)                 /* .data sections */
    	*(.data*)                /* .data* sections */
		. = ALIGN(4);
	} > ddr

	.bss :
	{
		. = ALIGN(4);
		__bss_start__ = .;
		*(.bss)
    	*(.bss*)
		__bss_end__ = .;
		end = __bss_end__;

		_end = end;
		. = ALIGN(4);
	} > ddr

	IRQ_Stack_Size = 0x400;
	SUP_Stack_Size = 0x400;
	USR_Stack_Size = 0x400;

	.stack :
	{
		. = ALIGN(8);
		. += IRQ_Stack_Size;
		. += SUP_Stack_Size;
		. += USR_Stack_Size;
		__stack_end = .;

		end = __stack_end;
		_end = end;
	} > ddr

	__USR_Stack_Top = __stack_end;
	__USR_Stack_Limit = __USR_Stack_Top - USR_Stack_Size;
	__SUP_Stack_Top = __USR_Stack_Limit;
	__SUP_Stack_Limit = __SUP_Stack_Top - SUP_Stack_Size;
	__IRQ_Stack_Top = __SUP_Stack_Limit;
	__IRQ_Stack_Limit = __IRQ_Stack_Top - IRQ_Stack_Size;
}
