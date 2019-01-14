;
; readFromMemoryCounter.asm
;
; Created: 19/12/2018 12:29:32
; Author : gmass
;


; Replace with your application code
;
; ledshifts.asm
;
; Created: 10/12/2018 15:19:49
; Author : gmass
;


; Replace with your application code
.org 0
MyTable:
	.DW 0x0100, 0x0302, 0x0504, 0x0706, 0x0908, 0x0B0A, 0x0D0C, 0x0F0E
	
	ldi r19, 0xD5					;Delays
	ldi r20, 0x00
	ldi r21, 0x00
	
	ldi r18, 0xff					;port b as output
	out DDRB, r18	
start:
	ldi r17, 0x11					;control in oreder to reset after iterating through the table
	ldi ZH, HIGH(MyTable*2)			;Z pointer
	ldi ZL, LOW(MyTable*2)
loop:
	dec r17
	breq start						;if r17 is 0x00 load the table from the begining
	lpm 
	mov r25, r0
	com r25							;complementary logic out
	out portb, r25
	adiw ZL, 01
	rcall delay0
	rjmp loop
delay0:								;delay loop No 1 (x0)
	inc r19 
	breq re
	rcall delay1
	rjmp delay0
delay1:								;delay loop No 2 (x1)
	inc r20
	breq delay0
	rcall delay2
	rjmp delay1
delay2:								;delay No 3 (x2)
	inc r21
	breq delay1
	rjmp delay2
re:									;reinnitializing the register values for the next delay
	ldi r19, 0xD5
	ldi r20, 0x00
	ldi r21, 0x00
	rjmp loop