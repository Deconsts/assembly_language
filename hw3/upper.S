#upper.S
.section .data
iostring:
        .asciz "ab1g2hA0H56po9wK78nB"
.section .text
.global _start
_start:
        mov $iostring,%edx 
L1:
        mov (%edx),%al
        test %al,%al
        je L3
        cmp $'a',%al
        jb L2
        cmp $'z',%al
        ja L2
	sub $32,(%edx)
L2:
        inc %edx
        jmp L1
L3:
#output
        movl $4,%eax
        movl $1,%ebx
        movl $iostring,%ecx
        sub $iostring,%edx
        int $0x80
#exit
        movl $1,%eax
        movl $0,%ebx
        int $0x80

