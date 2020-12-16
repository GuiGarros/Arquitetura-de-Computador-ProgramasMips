.data 
vetor: .word 12:4 # todos elementos vão ser 12 e teremos 4 elementos no vetor 
.text 
.globl main
main:


addi $t0,$zero,0 #resta o index

while:
beq $t0,16,exit # se t0 for igual a 12 pula pra exit
 
lw $s3,vetor($t0) #carrega na variavel s3 o valor da posição zero do vetor
addi $t0,$t0,4 # soma 4 no index

li $v0,1 #chama para printar inteiros
move $a0,$s3 #passagem de parametro a ser imprimido
syscall

j while #pula para while
exit:

li $v0,10 #end program
syscall