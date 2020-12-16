.data 
x: .word 10
y: .word 20
.text

.globl main

main:

lw $t0,x #carrega o valor de x em t0
lw $t1,y #carrega o valor de y em t1

add $t0,$t0,$t1 # t0 = t0 + t1

li $v0,1 #codigo de chamada para printar inteiros
add $a0,$zero,$t0 #passagem de parametro inteiro para ser printado
syscall #chamada de console

li $v0,10 #return 0, impede acumulo de dados na memoria 
syscall
