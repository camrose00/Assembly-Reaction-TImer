		.syntax     unified
		.cpu        cortex-m4

		.data
state:	.word	0x01	// static variable to hold state of pseudorandom generator

		.text
		.global		seed_random
		.thumb_func
		.align
seed_random:
		ldr		r1, =state	// point to random state
		str		r0, [r1]	// set random state
		bx		lr

		.global		random
		.thumb_func
		.align
random:
LDR R1, =state
LDR R0, [R1]
LSLS R0, 1
LDR R2, =0x1D872B41

IT CS
EORCS R0,R2

STR R0,[R1]

		bx		lr
		.end
