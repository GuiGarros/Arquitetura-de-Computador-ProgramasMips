
.data
msg1: .asciiz "exemplo, apos entrar na fun��o temos que retornar"
.text
.globl main
main:

jal message #chama da fun��o message

li $v0,10 #end program
syscall

message: #inicio da fun��o 

li $v0,4 #chama para printar menssagens 
la $a0,msg1 #carrega mensagem em A0
syscall

jr $ra #retorno da fun��o
