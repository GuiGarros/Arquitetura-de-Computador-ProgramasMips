.data 
msg1: .asciiz "os numeros são iguais"
.text 

addi $t1,$zero,10 #t1 = 0 + 10
addi $t2,$zero,10 #t2 = 0 + 10

beq $t1,$t2,equal #se for igual pule para equal

li $v0,10 #return 0
syscall

equal:
li $v0,4 #chamada para imprimir strings 
la $a0,msg1 #string a ser escrita
syscall

li $v0,10 #return 0
syscall