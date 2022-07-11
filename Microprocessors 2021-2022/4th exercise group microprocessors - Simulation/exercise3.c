

#include <avr/io.h>
char x=1; //variable for storing output
int main(void)
{
	DDRB=0xFF; // Initializing PORTB as output
	DDRA=0x00; //Initializing PORTA as INPUT
	
	PORTB=x; //first output(led0=on)
	
	while(1){ //non-terminating program

		//if SW0 was pushed--left shift by 1
		if ((PINA & 0x01)==1){   //check if  push-button was pushed
			while((PINA & 0x01)==1);  //check if push-button was unpushed
			if (x!=128)
			x=x<<1;       //left shift
		else x=1;} //if x is 128(10000000),to prevent overflow we return to 1(00000001)
		

		//if SW1 was pushed--right shift by 1
		else if((PINA & 0x02)==2){     //check if  push-button was pushed
			while ((PINA & 0x02)==2); //check if  push-button was unpushed
			if (x!=1)
			x=x>>1; //right shift
		else x=128;}  //if x is 1(00000001),we return to 128(10000000)


		//if SW2 was pushed--left shift by 2
		else if ((PINA & 0x04)==4){ //check if  push-button was pushed
			while((PINA & 0x04)==4); //check if  push-button was unpushed
			if (x==64)  //to prevent overflow if x=64(01000000) then x is set equal to 1(00000001)
			x=1;
			else if (x==128) //otherwise if x=128(10000000) then x is set equal to 2(00000010)
			x=2;
		else x=x<<2;} //Finally,if none of the above conditions is true,theres no overflow hazard,we shift normally
		
		//if SW3 was pushed--set msb led on
		else if ((PINA & 0x08)==8){  //check if  push-button was pushed
			while( (PINA & 0x08)==8); //check if  push-button was unpushed
		x=128;}  //x=(10000000)
		
		PORTB=x; //set the output at leds
		
	}
}
