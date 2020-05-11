.section .data
	var:
	.int 0x9812abcd
.section .text
	.globl __start
__start:
	addiu $sp,$sp,-16
	lw $a0,var
	jal print_dec
	addiu $v0,$0,4001
	addiu $a0,$0,0
	syscall
