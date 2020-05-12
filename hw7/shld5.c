#include<stdio.h>

unsigned int shld5(unsigned int a, unsigned int b){
	unsigned int result;
	result = (a << 5) | (b >> (32 - 5));
	asm("shl $5,%1\n\t"
	    "shr $27,%2\n\t"
	    "or %1,%2\n\t"
	    "mov %2,%0"
	    :"=r"(result)
	    :"r"(a),"r"(b));
	return result;
}

int main(){
	unsigned int a;
	unsigned int b;
	unsigned int result;
	scanf("%d %d", &a, &b);
	result = shld5(a,b);
	printf("%d\n",result);
}
