		.syntax     unified
		.cpu        cortex-m4

		.text
// The argument to this function is the address just above the top of the memory
// area allocated for a temporary stack. It is loaded into the SP register so
// that the results of some push and pop operations can be traced by the calling C program.
		.global		pushpop
		.thumb_func
		.align
pushpop:
// Stash current real stack pointer into R12 to be restored at the
// end of this function
		mov		r12, sp
// Make the current stack pointer the address argument that was
// passed in by the calling main C program
		mov		sp, r0
// Push three example words
		ldr		r1, =#0x7E7E7E7E
		ldr		r2, =#0x5A5A5A5A
		ldr		r3, =#0x44332211
		push	{r1-r3}
// Allocate a local variable word on the stack and store R12 in it
		sub		sp, #4
		str		r12, [sp]
// De-allocate local variable word on the stack
		add		sp, #4
// Pop back registers, but in reverse order
		pop		{r3}
		pop		{r2}
		pop		{r1}
// Restore SP register to the real stack pointer
		mov		sp, r12
		svc		#0
		bx		lr

		.end
