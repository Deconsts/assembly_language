#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <string.h>
#define SIZE 1024 * 1024 * 64          // mallocation size
#define OFFSET_1 1                 // offset of src unaligned
#define OFFSET_2 2                 // offset of dest unaligned
#define N 1024 * 1024 * 64 - 10        // size of memcpy

void test(){
	void *p,*q;
	void *m,*n;
	int num = N;
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
	printf("copy from %p to %p. N = %d\n",p,q,num);
	gettimeofday(&tv0,NULL);
	memcpy(q + OFFSET_2,p + OFFSET_1,num);
	gettimeofday(&tv1,NULL);
	tv2.tv_sec = tv1.tv_sec - tv0.tv_sec;
	tv2.tv_usec = tv1.tv_usec - tv0.tv_usec;
	printf("time elapsed: %ld usec\n", tv2.tv_sec * 1000000 + tv2.tv_usec);

	// check memory
	m = p + OFFSET_1;n = q + OFFSET_2;
	int count=0;
	while(m < p + OFFSET_1 + num){
		if(*(char*)m != *(char*)n){
			printf("wrong at %p! (%d/%d)\n",m,count,num);
			return;
		}
		m++;
		n++;
		count++;
	}
	free(p);
	free(q);
}

int main(){
	for(int i = 1; i < 11; i++){
		printf("test %d:\n",i);
		test();
	}
}

