.data 
msg1: .asciiz "funcionou"
.text
.globl main
main:

addi $s0,$zero,20
addi $s1,$zero,12

bgt $s0,$s1,funcionou

li $v0,10
syscall

funcionou:

li $v0,4
la $a0,msg1
syscall

li $v0,10
syscall