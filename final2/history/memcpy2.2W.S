#memcpy.S
.text
.type memcpy,@function
.globl memcpy

memcpy:                       # rdi = dest, rsi = src, rdx = n
	push %rbx
	push %rdi
	mov %rdx,%rax
	and $0x1f,%rax
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
	sub $32,%rdx
	vmovupd 0(%rsi),%ymm0
	vmovupd %ymm0,0(%rdi)
	add $32,%rsi
	add $32,%rdi
	jmp L2
L6:
	pop %rax
	pop %rbx
	ret
