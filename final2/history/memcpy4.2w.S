#memcpy.S
.text
.type memcpy,@function
.globl memcpy

memcpy:                       # rdi = dest, rsi = src, rdx = n
	push %rbx
	push %rdi
	mov %rdx,%rax
	and $0x3f,%rax
L1:
	test %rdx,%rdx
	jz L6
	test %rax,%rax
	jz L2
	dec %rax
	dec %rdx
	mov (%rsi),%cl
	mov %cl,(%rdi)
	inc %rdi
	inc %rsi
	jmp L1
L2:
	test %rdx,%rdx
	jz L6
	sub $64,%rdx
	movq 0(%rsi),%xmm0
	movq 8(%rsi),%xmm1
	movq 16(%rsi),%xmm2
	movq 24(%rsi),%xmm3
	movq 32(%rsi),%xmm4
	movq 40(%rsi),%xmm5
	movq 48(%rsi),%xmm6
	movq 56(%rsi),%xmm7
	movq %xmm0,0(%rdi)
	movq %xmm1,8(%rdi)
	movq %xmm2,16(%rdi)
	movq %xmm3,24(%rdi)
	movq %xmm4,32(%rdi)
	movq %xmm5,40(%rdi)
	movq %xmm6,48(%rdi)
	movq %xmm7,56(%rdi)
	add $64,%rsi
	add $64,%rdi
	jmp L2
L6:
	pop %rax
	pop %rbx
	ret
