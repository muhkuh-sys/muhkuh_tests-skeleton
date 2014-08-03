
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

	@ Save the stack pointer.
	mov     r1, sp
	ldr     r2, =stack_save
	str     r1, [r2]

	@ Set own stack position
	@ The ROM code does not have very much stack space on older netX
	@ platforms.
	ldr     r1, =stack_top
	mov     sp, r1

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

	@ Restore the stack pointer.
	ldr     r2, =stack_save
	ldr     r1, [r2]
	mov     sp, r1

	@ Save the result in the parameter block.
	ldr     r1, [sp]
	str     r0, [r1]

	@ Restore all working registers and jump back to the ROM code.
	ldmfd   sp!, {r0, r1, r2, r3, lr}
	bx      lr

  .endfunc

@--------------------------------------

	.align 4

stack_save:
	.word 0

@--------------------------------------

  .end

