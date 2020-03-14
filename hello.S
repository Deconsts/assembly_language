#hello.S
.section .data
	output: .ascii "University of CAS\n"
.section .text
.global _start
_start:
	movq $1,%rax
	movq $1,%rdi
	movq $output,%rsi
	movq $18,%rdx
	syscall
	
	movq $60,%rax
	movq $0,%rdi
	syscall
