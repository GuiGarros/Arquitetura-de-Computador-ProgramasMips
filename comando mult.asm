.data 
.text
.globl main
main:

addi $t0,$zero,20000 # to = 0 + 20000
addi $t1,$zero,100  # t1 = 0 + 100

mult $t0,$t1 # multiplica t1 e t0 e guarda em lo e hi serve para multiplicar numeros grandes
	     # nesse caso o numero fica apenas em lo pois não estoura os 32 bits

mflo $s0    # s0 = lo

li $v0,1 #chama para imprimir inteiros
move $a0,$s0 #passagem de parametro a ser printado
syscall

li $v0,10 #return 0, impede acumulo de lixo na memória 
syscall