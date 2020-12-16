.data 
msg1: .asciiz "é menor"
.text 

.globl main
main:

addi $t0,$zero,10
addi $t1,$zero,20

slt $s0,$t0,$t1
bnez $s0,print

li $v0,10
syscall

print:

li $v0,4
la $a0,msg1
syscall

li $v0,10
syscall