#exchange.S
.section .data
stringvar:
	.ascii "0123456789abcdef"
.section .text
.global _start
_start:
	mov $8,%ecx
	mov $stringvar,%eax
	mov $stringvar,%ebp
	inc %ebp
L1:
	mov (%eax),%edx
	mov (%ebp),%ebx
	mov %dl,(%ebp)
	mov %bl,(%eax)
	inc %eax
	inc %eax
	inc %ebp
	inc %ebp
	loop L1
#output
	movl $4,%eax
	movl $1,%ebx
	movl $stringvar,%ecx
	movl $16,%edx
	int $0x80
#exit
	movl $1,%eax
	movl $0,%ebx
	int $0x80
