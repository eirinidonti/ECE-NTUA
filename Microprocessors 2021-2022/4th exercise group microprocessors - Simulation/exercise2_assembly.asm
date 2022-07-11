.include "m16def.inc"
.DEF temp = r16
.DEF A = r17
.DEF B = r18
.DEF C = r19
.DEF D = r20
.DEF F0= r21
.DEF F1= r22
.DEF E = r15

reset:
ldi r24,low(RAMEND) ;initialize stack pointer
out SPL,r24 
ldi r24,high(RAMEND) ;load 8-bit value in r24
out SPH,r24

start:
clr temp
out DDRB,temp ;set port B as input 
ser temp ;put ones in every bit of the register
out DDRA,temp ;set port A as output 


main:
clr F0 ;clear F0 - initialize with zeros 
in temp,PINB ;put data from the input post B in temp
mov A,temp 
andi A,0x01 ;isolate LSB using mask
lsr temp ;shift the value right
mov B,temp 
andi B,0x01 ;isolate LSB using mask
lsr temp ;shift the value right
mov C,temp 
andi C,0x01 ;isolate LSB using mask
lsr temp ;shift the value right
mov D,temp 
andi D,0x01 ;isolate LSB

mov F0,A ;store register A in F0
and F0,B ;F0 = AB
and F0,C ;F0 = ABC
mov E,B
or E,C ;B or C
or E,D ;B or C or D
com E ;(B or C or D)' - De Morgan
or F0,E ;F0 = (ABC) + (B+C+D)'

mov F1,A ;store register A in F1
or F1,B ;A or B
or F1,C ;A or B or C
and F1,D ;F1 = (A+B+C)D
lsl F1 ;shift the value left in order to take the 2nd LSB for F1

andi F0, 0x01 ;isolate LSB
andi F1, 0x02 ;isolate 2nd LSB
or F0,F1 
out PORTA,F0 ;show the exit F0 | F1
rjmp main

