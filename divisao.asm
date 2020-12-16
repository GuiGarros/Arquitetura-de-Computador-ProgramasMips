.data 
.text 
.globl main
main:

addi $t0,$zero,50 # t0 = 0 + 50
addi $t1,$zero,10 # t1 = 0 + 10

div $t0, $t0, $t1 # t0 = t0/t1

li $v0,1 #chamada para imprimir inteiros 
move $a0,$t0 # passagem do inteiro a ser imprimido
syscall

li $v0,10 #return 0, impede acumulo de lixo
syscall