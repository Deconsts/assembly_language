#include <stdio.h>
#include <sys/time.h>

// get cycles of cpu
unsigned long long rdtsc(){
	unsigned long long count;
	unsigned long long counta;
	asm volatile(
		"rdtsc"
		:"=d"(count),"=a"(counta)
	);
	count <<= 32;
	count += counta;
	return count;
}

void main(){
	struct timeval tv1,tv2;
	double cpufreq;
	unsigned long long count;
	gettimeofday(&tv1,NULL);
	count = rdtsc();
	asm volatile(
		"push %rax\n\t"
		"push %rbx\n\t"
		"mov $100000,%rax\n\t"
		"1:\n\t"
		".rept 100000\n\t"
		"sar $9,%rbx\n\t"
		".endr\n\t"
		"dec %rax\n\t"
		"test %rax,%rax\n\t"
		"jnz 1b\n\t"
		"pop %rbx\n\t"
		"pop %rax"
	   );
	count = rdtsc() - count;
	gettimeofday(&tv2,NULL);
	printf("%llu\n", count);
	double t = 1000000*(tv2.tv_sec-tv1.tv_sec)+tv2.tv_usec-tv1.tv_usec;
	cpufreq = 10000000000.0/t;
	printf("The cpu frequency is %f MHz\n",cpufreq);
	printf("The cpu frequency is %f MHz\n",cpufreq*count/10000000000);
}
