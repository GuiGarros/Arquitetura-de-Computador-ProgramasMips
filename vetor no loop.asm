.data 
vetor: .space 12
.text 
.globl main
main:
addi $s0,$zero,10 #s0 = 0 + 10
addi $s1,$zero,20 #s1 = 0 + 20
addi $s2,$zero,30 #s3 = 0 + 30

# index 

addi $t0, $zero,0 #t0 = 0 + 0

sw $s0,vetor($t0) #carrega na posição 0 do vetor o valor de s0
addi $t0,$t0,4 #soma no index
sw $s1,vetor($t0) #carrega na posição 1 do vetor o valor de s1
addi $t0,$t0,4 #soma no indez
sw $s2,vetor($t0) #carrega na posição 2 do veto o valor de s2

#printar a primeira posição 

addi $t0,$zero,0

while:
beq $t0,12,exit
 
lw $s3,vetor($t0) #carrega na variavel s3 o valor da posição zero do vetor
addi $t0,$t0,4

li $v0,1 #chama para printar inteiros
move $a0,$s3 #passagem de parametro a ser imprimido
syscall

j while
exit:

li $v0,10 #end program
syscall