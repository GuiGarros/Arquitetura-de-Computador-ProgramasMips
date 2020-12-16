.data 
vetorteste: .align 1
.space 500
.text
.globl main
main:
addi $t0,$zero,0
while: 

beq $t0,10,exit



li $v0,5
syscall

sw $v0,vetorteste($t0)

addi $t0,$t0,2

j while

exit:
addi $t0,$zero,0
while3 : 

beq $t0,10,exit3

lw $a1,vetorteste($t0)

li $v0,1
move $a0,$a1
syscall



addi $t0,$t0,2

j while3

exit3: