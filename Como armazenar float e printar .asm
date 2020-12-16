.data 
msg1: .asciiz "digite o valor de pi:"
Kzero: .float 0.0
.text
.globl main
main:

lwc1 $f4, Kzero #passa constante 0.0 para o registrador f4

li $v0,4 #chama para printar strings
la $a0,msg1 #passa string a ser printada 
syscall

li $v0,6 #codigo para armazenar ponto flutuante fica salvo em f0 
syscall

add.s $f1,$f0,$f4 # $f1 = f0 + f4

li $v0,2 #chama para printar ponto flutuante 
add.s $f12,$f1,$f4 #f12 = f1 + f4
syscall

li $v0,10 # return 0 , impede acumulo de lixo na memória
syscall