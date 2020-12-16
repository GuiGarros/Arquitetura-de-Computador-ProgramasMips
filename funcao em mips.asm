
.data
msg1: .asciiz "exemplo, apos entrar na função temos que retornar"
.text
.globl main
main:

jal message #chama da função message

li $v0,10 #end program
syscall

message: #inicio da função 

li $v0,4 #chama para printar menssagens 
la $a0,msg1 #carrega mensagem em A0
syscall

jr $ra #retorno da função
