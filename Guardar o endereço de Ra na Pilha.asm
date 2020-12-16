.data
msg1: .asciiz "\n"
.text

.globl main
main:

addi $s0,$zero,50 # s0 = 0 + 50

jal function #chama a função function

jal print #chama função print

li $v0,10 #return 0, impede acumulo de lixo na memória
syscall 

function:

addi $sp,$sp,-8 #aloca 2 espaços na pilha
sw $s0,0($sp) #armazena o valor s0 na pilha 
sw $ra,4($sp) #armazena o endereço de ra na pilha 

addi $s0,$s0,100 # s0 = s0 + 100

jal print #chama a função print

lw $s0,0($sp) #devolve o valor de s0
lw $ra,4($sp) #devolve o endereço de ra
addi $sp,$sp,8 #desaloca espaço da pilha 

jr $ra #retorna para main

print:

li $v0,1 #chamada para printar inteiros na tela
move $a0,$s0 #passagem de parametro a ser impresso
syscall

li $v0,4 #chamada para imprimir strings 
la $a0,msg1 #passagem de string a ser escrita 
syscall

jr $ra #retorna para função qua a chamou seja main ou function