	.section .isr_vector, "a"
	.align 2
	.globl __isr_vector
__isr_vector:
	ldr     pc, =Reset_Handler           /* Reset                  */
    ldr     pc, =Undef_Handler      	 /* Undefined instructions */
    ldr     pc, =Sup_Call_Handler    	 /* Supervisor Call        */
    ldr     pc, =Pref_Abort_Handler      /* Prefetch abort         */
    ldr     pc, =Data_Abort_Handler      /* Data abort             */
    .word   0                            /* RESERVED               */
    ldr     pc, =IRQ_Handler     		 /* IRQ interrupt          */
    ldr     pc, =FIQ_Handler      		 /* FIQ interrupt          */


/* Reset Handler */
	.globl reset_handler
	.type reset_handler, %function
reset_handler:
	/* Clear BSS */
	ldr r1, =__bss_start__
	ldr r2, =__bss_end__

	movs r0, #0

	.LoopClearBss:
		cmp r1, r2
		itt lt
		strlt r0, [r1], #4
		blt .LoopClearBss
	/* End clear BSS */

	cpsid i

	/* Reset SCTlr Settings */
    mrc     p15, 0, r0, c1, c0, 0     /* Read CP15 System Control register                  */
    bic     r0,  r0, #(0x1 << 12)     /* Clear I bit 12 to disable I Cache                  */
    bic     r0,  r0, #(0x1 <<  2)     /* Clear C bit  2 to disable D Cache                  */
    bic     r0,  r0, #0x2             /* Clear A bit  1 to disable strict alignment         */
    bic     r0,  r0, #(0x1 << 11)     /* Clear Z bit 11 to disable branch prediction        */
    bic     r0,  r0, #0x1             /* Clear M bit  0 to disable MMU                      */
    mcr     p15, 0, r0, c1, c0, 0     /* Write value back to CP15 System Control register   */

	ldr r0,=__VECTOR_TABLE
	mcr p15, 0, r0, c12, c0, 0  /*Write value of the vector interrupt table  in VBAR*/

	/* Set up stack */
	cps     #0x12                /* Enter IRQ mode                */
    ldr     sp, =__IRQ_Stack_Top     /* Set up IRQ handler stack      */

    cps     #0x1F                /* Enter System mode             */
    ldr     sp, =__USR_Stack_Top     /* Set up System/User Mode stack */

    cps     #0x13                /* Enter Supervisor mode         */
    ldr     sp, =__SUP_Stack_Top     /* Set up Supervisor Mode stack  */

	cpsie i

	ldr   r0,=__libc_init_array
    blx   r0
    ldr   r0,=main
    bx    r0
	
	.type Reset_Handler, %function
Reset_Handler:
	ldr r1, =reset_handler
	bx r1

	.type Undef_Handler, %function
Undef_Handler:
	ldr r1, =OS_CPU_ARM_ExceptUndefInstrHndlr
	bx r1

	.type Sup_Call_Handler, %function
Sup_Call_Handler:
	ldr r1, =OS_CPU_ARM_ExceptSwiHndlr
	bx r1

	.type Pref_Abort_Handler, %function
Pref_Abort_Handler:
	ldr r1, =OS_CPU_ARM_ExceptPrefetchAbortHndlr
	bx r1

	.type Data_Abort_Handler, %function
Data_Abort_Handler:
	ldr r1, =OS_CPU_ARM_ExceptDataAbortHndlr
	bx r1

	.type IRQ_Handler, %function
IRQ_Handler:
	ldr r1, =OS_CPU_ARM_ExceptIrqHndlr
	bx r1

	.type FIQ_Handler, %function
FIQ_Handler:
	ldr r1, =OS_CPU_ARM_ExceptFiqHndlr
	bx r1

