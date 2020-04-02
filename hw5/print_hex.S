#print_hex.S
.section .data
testdata:
	var: .int 0xffffabcd
.section .text
.global _start
_start:
	pushl var
	call print_hex
	call as_exit

print_hex:
	push %ebp
	mov %esp,%ebp
	sub $32,%esp
	mov 8(%ebp),%eax        #eax = var
	movl $0,4(%esp)         #flag for negative int
	cmp $0x80000000,%eax
	jb L1
	notl %eax               #var = ~var
	inc %eax
	movl $1,4(%esp)         #flag = 1
L1:
	lea 20(%esp),%ecx       #ecx = add of hex
	movl $2,%edx            #edx = length
L2:
	mov %eax,%ebx
	andb $0xf,%bl           #bl = c
	cmpb $10,%bl
	jb L4
	addb $0x57,%bl
	jmp L5
L4:
	orb $0x30,%bl
L5:
	movb %bl,(%ecx)
	dec %ecx
	inc %edx
	shrl $4,%eax
	test %eax,%eax
	jnz L2
	movb $'x',(%ecx)
	dec %ecx
	movb $'0',(%ecx)
	mov 4(%esp),%esi
	test %esi,%esi
	jz L3
	dec %ecx
	movb $'-',(%ecx)
	inc %edx
L3:	
	movl $4,%eax
	movl $1,%ebx
	int $0x80
	leave
	ret

as_exit:
	movl $1,%eax
	movl $0,%ebx
	int $0x80

