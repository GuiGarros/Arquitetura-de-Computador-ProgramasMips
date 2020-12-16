.data 
msg1: .asciiz "qual sua idade?"
msg2: .asciiz "\n your age is: "
.text
.globl main
main:

li $v0,4 #chamada para printar strings
la $a0,msg1 #passagem de parametro a ser escrito
syscall

li $v0,5 #codigo para armazenar inteiros  (numero fica armazenado em v0)
syscall

move $t0,$v0 #salvando numero de v0 em t0, t0 = v0

li $v0,4 #chamada para imprimir strings 
la $a0,msg2 #passagem do parametro a ser escrito 
syscall

li $v0,1 #chamada para imprimir inteiros 
move $a0,$t0 #passagem do parametro a ser escrito
syscall

li $v0,10 #return 0, impede acumulo de lixo na memória 
syscall