//
// The user push button is connected to the I/O PA0 of the STM32F429ZIT6.
//

	.syntax     unified
	.cpu        cortex-m4
	.equ RCC_AHB1ENR,	0x40023830
    .equ GPIOA_MODER,	0x40020000
    .equ GPIOA_PUPDR,	0x4002000C
    .equ GPIOA_IDR,		0x40020010

	.text

//
// Function to set up bit 0 of the GPIO port A to read the
// blue user push button state. The bit is set to input mode
// with a pull-down enabled. There are no arguments or a
// return value.
//
	.global		setup_button
	.thumb_func
	.align
setup_button:
LDR R0, =RCC_AHB1ENR
LDR R1, [R0]
ORR R1,0x1
STR R1, [R0]
    bx	lr

//
// Function to read the current state of the blue user push button
// connected to bit 0 of GPIO port A. The bit will read 0 for a
// released button and 1 for a pressed button. There are no function
// arguments. The uint32_t return value is 0 for released, 1 for
// pressed.
//
	.global		button
	.thumb_func
	.align
button:
LDR R0, =GPIOA_IDR
LDR R1,[R0]
TST R1,0x0
beq pressed

MOV R0, 1

pressed:
MOV R0, 0

    bx	lr

//
// Function to wait indefinitely for the blue user push button
// to be pressed.  There are no arguments or a return value.
//
	.global		wait_for_press
	.thumb_func
	.align
wait_for_press:

    wait:

    LDR R1, =GPIOA_IDR
    LDR R0,[R1]
    TST R0, 0x1

    beq wait

	bx	lr

//
// Function to wait indefinitely for the blue user push button
// to be released.  There are no arguments or a return value.
//
	.global		wait_for_release
	.thumb_func
	.align
wait_for_release:

    hold:
    LDR R1, =GPIOA_IDR
    LDR R0, [R1]
    TST R0, 0x1

    beq hold

	bx	lr
	.end
