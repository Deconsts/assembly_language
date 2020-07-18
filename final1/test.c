#include <stdio.h>


int main(){
	char s[100];
	char c;
	int n;
	int i=0;
	
	while((c=getchar())!=EOF){
		s[i++]=c;
	}
	s[i]=0;
	n=atoi(s);
	printf("%d\n",n);
	return 0;
}
