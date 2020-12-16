.data 
.text 
.globl main
main: 

addi $a1,$a1,50
addi $a2,$a2,670

jal function

li $v0,1
move $a0,$v1
syscall

li $v0,10
syscall

function:

add $v1,$a1,$a2

jr $ra