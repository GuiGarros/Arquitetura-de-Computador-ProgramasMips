.data 
msg1: .asciiz "hello, "
nome: .space 20 #variavel para armazenar string, reservado espaço para 20 caracteres
.text 

li $v0,8 #código para armazenar strings 
la $a0,nome #variavel que vai salvar nome
li $a1,20 #limite ou tamanho da variavel
syscall

li $v0,4 #chamada para printar strings
la $a0,msg1 #passagem do parametro a ser printado
syscall

li $v0,4 #chamada para printar strings
la $a0,nome #passagem do parametro a ser escrito
syscall

li $v0,10 #return 0, evita acumulo de lixo na memoria
syscall

