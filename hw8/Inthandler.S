Inthandle:
	pushw %ax
	pushw %bx
	mov %si,%bx
1:
        movb (%si),%al
	inc %si
        test %al,%al
        je 1f
        cmp $'0',%al
        jb 2f
        cmp $'9',%al
        ja 2f
	jmp 1b
2:
	movb %al,(%bx)
        inc %bx
        jmp 1b
1:
	movb $0,(%bx)
	pop %ax
	pop %bx
	iret
