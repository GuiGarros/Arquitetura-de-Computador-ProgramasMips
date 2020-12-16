.data 
msg1: .asciiz "igual a zero"
msg2: .asciiz "diferente de zero"
.text 

addi $t1,$zero,0

#beqz pelu se for igual a zero ou  bnez pule se for diferente de 0
beqz  $t1,equal #se for igual a zero pule para equal

li $v0,4 #chamada para imprimir strings 
la $a0,msg2 #string a ser escrita
syscall

li $v0,10 #return 0
syscall

equal:
li $v0,4 #chamada para imprimir strings 
la $a0,msg1 #string a ser escrita
syscall

li $v0,10 #return 0
syscall