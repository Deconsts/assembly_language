.text
.type print_dec,@function
.globl print_dec

print_dec:
addiu $sp,$sp,-32
addiu $t0,$0,1
addiu $t1,$0,10
addiu $t2,$sp,24
addiu $t3,$0,0x30
beq $a0,$0,L2

L1:
divu $a0,$t1
mflo $a0
mfhi $t4
addiu $t4,$t4,0x30
sb $t4,0($t2)
beq $a0,$0,L3
addiu $t0,$t0,1
addiu $t2,$t2,-1
j L1

L2:
sb $t3,0($t2)

L3:
addiu $v0,$0,4004
addiu $a0,$0,1
addiu $a1,$t2,0
addiu $a2,$t0,0
syscall
addiu $sp,$sp,32
jr $ra
