#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#define SIZE 150          // mallocation size
#define OFFSET_1 1                 // offset of src unaligned
#define OFFSET_2 2                 // offset of dest unaligned
extern void* memcpy(void *dest,void *src,unsigned int n);

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

unsigned long long test(int num){
	void *p,*q;
	void *m,*n;
	long res;
	struct timeval tv0,tv1,tv2;

	// set memory
	p = malloc(SIZE);
	q = malloc(SIZE);
	m = p + OFFSET_1;
	while(m < p + OFFSET_1 + num){
		*(char*)m=0x78;
		m++;
	}

	// begin memcpy
	unsigned long long t1 = rdtsc();
	memcpy(q + OFFSET_2,p + OFFSET_1,num);
	t1 = rdtsc() - t1;
	tv2.tv_sec = tv1.tv_sec - tv0.tv_sec;
	tv2.tv_usec = tv1.tv_usec - tv0.tv_usec;


	// check memory
	m = p + OFFSET_1;n = q + OFFSET_2;
	int count=0;
	while(m < p + OFFSET_1 + num){
		if(*(char*)m != *(char*)n){
			printf("wrong at %p! (%d/%d)\n",m,count,num);
			return 0;
		}
		m++;
		n++;
		count++;
	}
	free(p);
	free(q);
	return t1;
}

int main(){
	for(int i = 1; i < 121; i++){
		unsigned long long t = 0, temp;
		for(int j = 1; j < 10000; j++){
			temp = test(i);
			if (!temp) return 0;
			t += temp;
		}
		printf("size: %d\ntime elapsed: %lld\n", i, t);
	}
	return 0;
}

