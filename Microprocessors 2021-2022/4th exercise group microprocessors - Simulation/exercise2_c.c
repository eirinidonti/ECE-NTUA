#include <avr/io.h>

int main(void)
{
	char x, f0, f1, a, b, c, d;
	DDRA=0xFF; //initialize PORTA as output
	DDRB=0x00; //initialize PORTB as input
	while(1)
	{
		x = PINB; //contains all bits of port B in the input (0000 xxxx)
		a = x & 1; // isolate LSB
		b = (x >> 1) & 1; // shift the value right by one bit and isolate the new LSB
		c = (x >> 2) & 1; // shift the value right and isolate
		d = (x >> 3) & 1; // shift the valye right and isolate
		f1 = ((a || b || c) && d) << 1;// take F1 to 2nd most LSB
		f0 = ((a && b && c) || ((!b) && (!c) && (!d))); // F0
		
		f0 = f0 && 1; //ignore all bits except bit 1
		f1 = f1 & 2; //ignore all bits except bit 2
		PORTA = f0 | f1; // put the result of f0 and f1 in the output
	}
}
