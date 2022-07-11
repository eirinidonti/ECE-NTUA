.include "m16def.inc"

reset:
	ldi r24 , low(RAMEND) ; initialize stack pointer
	out SPL , r24
	ldi r24 , high(RAMEND)
	out SPH , r24
	clr r22          

main:
	clr r21         ;CLC TEMP
	out PORTA , r21 ;PORTA FOR INPUT
	ser r21         ;SET TEMP
	out PORTB,r21   ;PORTB FOR OUTPUT
	ldi r22, 0x01   ;LIGHT BIT
	out PORTB, r22  ;FLASH LSB
	ldi r20,7       ;r20 COUNTER VALUE 7

left:
	in r23, PINA        ;READ INPUT A
	subi r23,1      
	breq left           ;NOT EXIT CONTINUE
	ldi r24 , low(500)  ;load r25:r24 with 500
	ldi r25 , high(500) ; delay 0.5 second
	rcall wait_msec
	clc
	rol r22
	out PORTB, r22   ;FLASH NEXT LED TO THE LEFT
	dec r20          ; counter = counter-1
	cpi r20, 0       ; IF counter == 0 => MSB => RIGHT ROTATION
	breq right
	rjmp left

right:
	in r23,PINA      ;READ INPUT A
	subi r23,1       
	breq right       ;NOT EXIT CONTINUE
	ldi r24,low(500)    ;load r25:r24 with 500
	ldi r25,high(500)   ; delay 0.5 second
	rcall wait_msec     
	clc
	ror r22
	out PORTB,r22  ;FLASH NEXT LED TO THE RIGHT
	inc r20        ; counter = counter + 1
	cpi r20,7      ; if counter = 7  => LSB => LEFT ROTATION
	breq left 
	rjmp right
	
wait_msec: ;1 msec
	push r24          ;2 cycles (0.250usec)
	push r25          ;2 cycles (0.250usec)
	ldi r24,low(998)  ;1 cycle  (0.125 usec) - load r25:r24 with 998
	ldi r25,high(998) ;1 cycle  (0.125 usec)
	rcall wait_usec   ;3 cycles (0.375 usec) - delay 998.375 usec
	pop r25           ;2 cycles (0.250usec)
	pop r24           ;2 cycles (0.250usec)
	sbiw r24,1        ;2 cycles (0.250usec)
	brne wait_msec    ;1 or 2 cycles (0.125 or 0.250 usec)
	ret               ;4 cycles (0.500usec)

wait_usec:
	sbiw r24,1        ;2 cycles (0.250usec)
	nop               ;1 cycle  (0.125 usec)
	nop               ;1 cycle  (0.125 usec)
	nop               ;1 cycle  (0.125 usec)
	nop               ;1 cycle  (0.125 usec)
	brne wait_usec    ;1 or 2 cycles (0.125 or 0.250) usec
	ret               ;4 cycles (0.500 usec)
end: