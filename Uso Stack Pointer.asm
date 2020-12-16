.data
newline: .asciiz "\n" 
.text

.globl main

main:

addi $s0,$zero 50 #s0 = 0 + 50

jal exemplo #cahamda da função exemplo 

li $v0,4 #chamada para imprimir strings
la $a0,newline #string a ser printada
syscall

li $v0,1 #chamada para printar inteiros
move $a0,$s0 #move o valor de s0 para a0, a0 = s0
syscall

li $v0,10 #retun 0, impede acumulo de lixo na memoria 
syscall

exemplo: #função 

#função por convenção não devem alterar valor de registradores S portanto vamos usar o satack(pilha) para salvar seu valor

addi $sp,$sp,-4 #-4 aloca o espaço de 1 inteiro na pilha ou seja 4 bits
sw $s0,0($sp) #salva o valor de S0 em Sp - 0(sp) significa primeira posição da pilha que deve pular de 4 em 4 ou seja 4(sp) é a segunda posição

addi $s0,$s0,60 # s0 = s0 + 60

li $v0,1 #chamada para printar inteiros 
move $a0,$s0 # passa parametro a ser impresso para a0
syscall

lw $s0,0($sp) #devolve o valor inicial de s0 para s0
addi $sp, $sp , 4 #desaloca espaço da pilha 
jr $ra