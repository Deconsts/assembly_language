#memcpy.S
.text
.type memcpy,@function
.globl memcpy

memcpy:                       # rdi = dest, rsi = src, rdx = n
	push %rbx
	mov %rdi,%rax         # last 5 digit of dest
	not %rax
	add $1,%rax
	and $0xf,%rax        # unaligned part of beginning of dest
L1:
	test %rax,%rax
	jz L2
	test %rdx,%rdx
	jz L6
	dec %rax
	dec %rdx
	mov (%rsi),%cl
	mov %cl,(%rdi)
	inc %rdi
	inc %rsi
	jmp L1
L2:
	mov %rsi,%rax
	and $0x3,%rax        # last 5 digit of src
	sub %rax,%rsi
	mov %al,%ah         # << al >> ah
	not %ah
	inc %ah
	mov (%rsi),%r15
	mov %al,%cl
	shl %cl,%r15
L3:
	cmp $16,%rdx
	jl L5
	mov 4(%rsi),%rbx
	mov %rbx,%r12
	mov %al,%cl
	shl %cl,%r12
	mov %ah,%cl
	shr %cl,%rbx
	or %r15,%rbx
	mov 8(%rsi),%r10
	mov %r10,%r13
	mov %al,%cl
	shl %cl,%r13
	mov %ah,%cl
	shr %cl,%r10
	or %r12,%r10
	mov 12(%rsi),%r8
	mov %r8,%r14
	mov %al,%cl
	shl %cl,%r14
	mov %ah,%cl
	shr %cl,%r8
	or %r13,%r8
	mov 16(%rsi),%r9
	mov %r9,%r15
	mov %al,%cl
	shl %cl,%r15
	mov %ah,%cl
	shr %cl,%r9
	or %r14,%r9
	mov %rbx,(%rdi)
	mov %r10,4(%rdi)
	mov %r8,8(%rdi)
	mov %r9,12(%rdi)
	add $16,%rdi
	add $16,%rsi
	sub $16,%rdx
	jmp L3
L5:
	and $0x3,%rax
	add %rax,%rsi
L4:
	test %rdx,%rdx
	jz L6
	dec %rdx
	mov (%rsi),%cl
	mov %cl,(%rdi)
	inc %rdi
	inc %rsi
	jmp L4

L6:
	pop %rbx
	ret
