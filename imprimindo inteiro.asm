.data 
x: .word 20

.text
.globl main
main:

lw  $t0,x

li $v0,1
add $a0,$t0,$zero
syscall

li $v0,10
syscall