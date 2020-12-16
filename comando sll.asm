.data 
.text 
.globl main
main:

addi $t0,$zero,5 # t0 = 0 + 5

sll $t0,$t0,2 # t0 tem valor 5 e pula 2 bits para a esquerda ou seja t0 x 4 

li $v0,1 #chamada para imprimir inteiros
move $a0,$t0 #passagem de parametro a ser escrito
syscall

li $v0,10 #retun 0, impede acumulo de lixo na memória
syscall