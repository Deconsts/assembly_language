#include <stdio.h>
#include <sys/time.h>

void main(){
	struct timeval tv1,tv2;
	double cpufreq;
	gettimeofday(&tv1,NULL);
	asm volatile(
		"push %rax\n\t"
		"mov $10000000000,%rax\n\t"
		"1:\n\t"
		"dec %rax\n\t"
		"test %rax,%rax\n\t"
		"jnz 1b\n\t"
		"pop %rax"
	   );
	gettimeofday(&tv2,NULL);
	double t = 1000000*(tv2.tv_sec-tv1.tv_sec)+tv2.tv_usec-tv1.tv_usec;
	cpufreq = 10000000000.0/t;
	printf("The cpu frequency is %f MHz\n",cpufreq);
}
