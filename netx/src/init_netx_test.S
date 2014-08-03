
	.section .init_code, "ax"
	.arm

	.extern test_main

	.global start
	.global stack_top


@--------------------------------------

  .func start_init_s

@ This code is started from the ROM code with the "call" command.
@ The "call" command has one 32bit parameter. It is passed to this code in the
@ register R0. For muhkuh tests this parameter must be the address of the test
@ parameter structure.

start:
	@ Save all working registers on the stack.
	stmfd   sp!, {r0, r1, r2, r3, lr}

	@ Save the ROM code stack pointer in R1.
	mov     r1, sp

	@ Set own stack position
	@ The ROM code does not have very much stack space on older netX
	@ platforms.
	ldr     r2, =stack_top
	mov     sp, r2

	@ Store the ROM code stack pointer on the new stack.
	stmfd   sp!, {r1}

	@ Clear .bss section (zero init).
	mov     r1, #0
	ldr     r2, =__bss_start__
	ldr     r3, =__bss_end__
clear_bss:
	cmp     r2, r3
	strlo   r1, [r2], #4
	blo     clear_bss

	@ Jump to the test_main routine.
	bl      test_main

	@ Restore the ROM code stack pointer.
	ldmfd   sp!, {r1}
	mov     sp, r1

	@ Save the result in the parameter block.
	ldr     r1, [sp]
	str     r0, [r1]

	@ Restore all working registers and jump back to the ROM code.
	ldmfd   sp!, {r0, r1, r2, r3, lr}
	bx      lr

  .endfunc

@--------------------------------------

  .end

