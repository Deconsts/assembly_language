#include <stdio.h>
#include <sys/time.h>

static inline unsigned long long get_cycles(){
	unsigned long long t;
	asm volatile("rdtsc":"=A"(t));
	return t;
}

void main(){
	struct timeval tv1,tv2;
	unsigned long long c;
	double cpufreq;
	gettimeofday(&tv1,NULL);
	c = get_cycles();
	asm volatile(
		"push %rax\n\t"
		"push %rbx\n\t"
		"mov $100000,%rax\n\t"
		"1:\n\t"
		".rept 100000\n\t"
		"add $1,%rbx\n\t"
		".endr\n\t"
		"dec %rax\n\t"
		"test %rax,%rax\n\t"
		"jnz 1b\n\t"
		"pop %rbx\n\t"
		"pop %rax"
	   );
	gettimeofday(&tv2,NULL);
	c -= get_cycles();
	printf("%llu\n",c);
	double t = 1000000*(tv2.tv_sec-tv1.tv_sec)+tv2.tv_usec-tv1.tv_usec;
	cpufreq = 10000000000.0/t;
	printf("The cpu frequency is %f MHz\n",cpufreq);
}
