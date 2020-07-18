#memcpy.S
.text
.type memcpy,@function
.globl memcpy

memcpy:                       # rdi = dest, rsi = src, rdx = n
	push %rdi
	mov %rdx,%rax
	and $0x7f,%rax
	sub %rax,%rdx
L1:
	test %rax,%rax
	jz L8
	cmp $32,%rax
	jnb L2
	cmp $16,%rax
	jnb L3
	cmp $8,%rax
	jnb L4
	cmp $4,%rax
	jnb L5
	cmp $2,%rax
	jnb L6
	jmp L7
L2:
	vmovupd 0(%rsi),%ymm0
	add $32,%rsi
	vmovupd %ymm0,0(%rdi)
	add $32,%rdi
	sub $32,%rax
	cmp $32,%rax
	jnb L2
	cmp $16,%rax
	jnb L3
	cmp $8,%rax
	jnb L4
	cmp $4,%rax
	jnb L5
	cmp $2,%rax
	jnb L6
	jmp L7
L3:
	vmovups 0(%rsi),%ymm0
	add $16,%rsi
	vmovups %ymm0,0(%rdi)
	add $16,%rdi
	sub $16,%rax
	cmp $8,%rax
	jnb L4
	cmp $4,%rax
	jnb L5
	cmp $2,%rax
	jnb L6
	jmp L7
L4:
	mov 0(%rsi),%rcx
	add $8,%rsi
	mov %rcx,0(%rdi)
	add $8,%rdi
	sub $8,%rax
	cmp $4,%rax
	jnb L5
	cmp $2,%rax
	jnb L6
	jmp L7
L5:
	mov 0(%rsi),%ecx
	add $4,%rsi
	mov %ecx,0(%rdi)
	add $4,%rdi
	sub $4,%rax
	cmp $2,%rax
	jnb L6
	jmp L7
L6:
	mov (%rsi),%cx
	add $2,%rsi
	mov %cx,(%rdi)
	add $2,%rdi
	sub $2,%rax
	test %rax,%rax
	jz L8
L7:
	mov (%rsi),%cl
	inc %rsi
	mov %cl,(%rdi)
	inc %rdi
L8:
	test %rdx,%rdx
	jz L10
L9:
	vmovupd 0(%rsi),%ymm0
	vmovupd 32(%rsi),%ymm1
	vmovupd 64(%rsi),%ymm2
	vmovupd 96(%rsi),%ymm3
	add $128,%rsi
	vmovupd %ymm0,0(%rdi)
	vmovupd %ymm1,32(%rdi)
	vmovupd %ymm2,64(%rdi)
	vmovupd %ymm3,96(%rdi)
	add $128,%rdi
	sub $128,%rdx
	test %rdx,%rdx
	jnz L9
L10:
	pop %rax
	ret
