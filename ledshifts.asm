;
; ledshifts.asm
;
; Created: 10/12/2018 15:19:49
; Author : gmass
;

	ldi r17, 0xFF						; setting port b as output
	OUT DDRB, r17

	ldi r18, 0xFF


	ldi r19, 0xF0						; initializing delays
	ldi r20, 0xF0
	ldi r21, 0xFF
start:
	rol r18							; r18 is 0xFF, our carry is 0.We rotate left through carry so our leds
	out portb, r18						; there is only one led on shifting through.
	rcall delay0
delay0:									; delay loop 1 (x0)
	inc r19
	breq re
	rcall delay1
	rjmp delay0
delay1:									; delay loop 2 (x1)
	inc r20
	breq delay0
	rcall delay2
	rjmp delay1
delay2:									; delay loop 3 (x2)
	inc r21
	breq delay1
	rjmp delay2
re:
	ldi r19, 0xF0
	ldi r20, 0xF0
	ldi r21, 0xFF
	rjmp start
	
