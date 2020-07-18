#memcpy.S
.text
.type memcpy,@function
.globl memcpy

memcpy:                       # rdi = dest, rsi = src, rdx = n
	push %rbx
	push %rdi
	mov %rdx,%rax
	and $0x7f,%rax
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
	sub $128,%rdx
	vmovupd 0(%rsi),%ymm0
	vmovupd 32(%rsi),%ymm0
	vmovupd 64(%rsi),%ymm0
	vmovupd 96(%rsi),%ymm0
	vmovupd %ymm0,0(%rdi)
	vmovupd %ymm0,32(%rdi)
	vmovupd %ymm0,64(%rdi)
	vmovupd %ymm0,96(%rdi)
	add $128,%rsi
	add $128,%rdi
	jmp L2
L6:
	pop %rax
	pop %rbx
	ret
