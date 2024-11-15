		.syntax     unified
		.cpu        cortex-m4

		.text
		.global		delay
		.thumb_func
		.align
delay:
		ldr		r1, =#10000
		mul		r0, r1

loop:
        .rept 15
        nop
        .endr

		subs	r0, #1
		bgt		loop

		bx		lr

		.end
