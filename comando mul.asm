.data
.text

.globl main
main:

addi $s0,$zero,10 # s0 = 0 + 10
addi $s1,$zero,20 # s1 = 0 + 20

mul $s0,$s0,$s1  # s0 = s0 * S1

 
li $v0,1 #chamada para imprimir inteiros
move $a0,$s0 #passagem de parametro a ser imprimido
syscall

li $v0,10 #end program 
syscall