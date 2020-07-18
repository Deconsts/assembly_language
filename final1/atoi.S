#atoi.S
.text
.type atoi,@function
.globl atoi

atoi:                       # rdi = nptr
	mov $0,%rcx         # sign
	mov $0,%rax         # n
	mov $0,%rdx         # char
L1:
	movb (%rdi),%dl
	inc %rdi
	test %dl,%dl
	jz L6
	cmp $' ',%dl
	jna L1              # blank character
	cmp $'-',%dl
	je L2               # negative number
	cmp $'9',%dl
	ja L5               # non-number char
	cmp $'0',%dl
	jae L3              # start to calculate num
	cmp $'+',%dl
	jne L6              # non-number char
	jmp L1
L2:
	not %rcx            # sign = ~ sign
	jmp L1
L3:
	sub $'0',%dl
	cmp $0x0ccccccc,%rax
	ja L4
	lea (%rax,%rax,4),%rax
	add %rax,%rax       # n *= 10
	add %rdx,%rax       # n += c - '0'
	cmp $0,%rax
	jl L4               # overflow
	movb (%rdi),%dl
	inc %rdi
	cmp $'0',%dl
	jb L5
	cmp $'9',%dl
	ja L5
	jmp L3
L4:
	mov $0x80000000,%rax
	test %rcx,%rcx
	jnz L5
	sub $1,%rax
L5:
	test %rcx,%rcx
	je L6
	not %rax
	add $1,%rax
L6:
	ret
