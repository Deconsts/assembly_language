#insert_sort.S
.section .data
testdata:
        .byte 'A', '0', 'z', 'P', '8', 'r', 'Z', '2', 'f'
.section .text
.global _start
_start:
	subl $8,%esp
	movl $10,4(%esp)
	movl $testdata,(%esp)
	call insert_sort
#output
	call as_puts
#exit
	call as_exit

insert_sort:
	movl 8(%esp),%edi    #edi = n
	movl 4(%esp),%esi    #esi = testdata
	movl %esi,%eax
	addl %edi,%eax       #eax = testdata + n
	movl %esi,%ebx       #ebx = testdata + i
L1:
	addl $1,%ebx
	cmpl %ebx,%eax       #i>=n?
	jle L2
	movb (%ebx),%dl
	movb %dl,12(%esp)    #esp + 12 = tmp = a[i]
	movl %ebx,%ecx
	movl %ecx,16(%esp)   #esp + 16 = testdata + j
	movl %ecx,20(%esp)   #esp + 20 = testdata + j + 1
	addl $1,20(%esp)
L3:
	subl $1,16(%esp)
	subl $1,20(%esp)
	cmpl %esi,16(%esp)   #j<0?
	jl L4
	movb 12(%esp),%dl
	movl 16(%esp),%ecx
	cmpb %dl,(%ecx)      #a[j]>tmp?
	jle L4
	movb (%ecx),%dl
	movl 20(%esp),%ecx
	movb %dl,(%ecx)      #a[j+1]=a[j]
	jmp L3
L4:
	movb 12(%esp),%dl
	movl 20(%esp),%ecx
	movb %dl,(%ecx)      #a[j+1]=tmp
	jmp L1
L2:
	ret

as_puts:
	movl $4,%eax
	movl $1,%ebx
	movl $testdata,%ecx
	movl $9,%edx
	int $0x80
	ret

as_exit:
	movl $1,%eax
	movl $0,%ebx
	int $0x80

