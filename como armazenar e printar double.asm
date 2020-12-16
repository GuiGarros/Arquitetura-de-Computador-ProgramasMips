.data 
msg1: .asciiz "entre com o numero e:"
.text 
.globl main
main:

li $v0,4 #chamada para printar strings 
la $a0,msg1 #passagem do parametro a ser escrito
syscall

li $v0,7 #codigo para armazenar double fica salvo em $f0
syscall

add.d $f4,$f4,$f0 #salvando o numero armazenado em outro registrador, f4 = f4 + f0

li $v0,3 #chamada para printar double
add.d $f12, $f4,$f6 #passagem do parametro a ser escrito
syscall

li $v0,10 #return 0, impede acumulo de lixo na memória 
syscall