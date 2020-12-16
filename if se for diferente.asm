.data 
msg1: .asciiz "os numeros não são iguais"
.text 

addi $t1,$zero,10 #t1 = 0 + 10
addi $t2,$zero,15 #t2 = 0 + 15

bne  $t1,$t2,nequal #se não for igual pule para nequal

li $v0,10 #return 0
syscall

nequal:
li $v0,4 #chamada para imprimir strings 
la $a0,msg1 #string a ser escrita
syscall

li $v0,10 #return 0
syscall