.data
.text
.globl main
 main:
addi $t0,$zero,50 # t0 = 0 + 50
addi $t1,$zero,28 # t1 = 0 + 28

div $t0,$t1 # t0/t1

mfhi $s1 #passa o valor do resto da divisão para s1

li $v0,1 #chamada para printar inteiros 
move $a0,$s1 # move para a0 o valor de s1
syscall

li $v0,10 #return 0, impede acumulo de lixo na memoria 
syscall