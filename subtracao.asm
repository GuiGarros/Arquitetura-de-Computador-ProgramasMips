.data 
x: .word 20
y: .word 8

.text 

.globl main

main:

lw $t0,x #t0 = x
lw $t1,y #t1 = y

sub $t0,$t0,$t1 # t0 = t0 - t1

li $v0,1 #codigo para imprimir inteiros 
move $a0,$t0 #passagem do parametro a ser escrito
syscall

li $v0,10 #retur 0, impede o acumulo de dados na memoria 
syscall