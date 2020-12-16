.data
msg1: .asciiz "Digite os numeros da matriz:"
.text
.globl main
main:


	li $v0, 4        # Codigo SysCall p/ escrever strings
	la $a0, msg1     # Parametro (string a ser escrita)
	syscall			 # chama o console
	
	 li $v0, 6	     # Codigo SysCall p/ ler inteiros
     syscall		 # Inteiro lido vai ficar em $v0
	 
	 add 4($s0), 4($s0), $f0
	 
	li $v0, 2           #Codigo SysCall p/ escrever inteiros
	add $f12, $zero, 4($s0) # Parametro (inteiro a ser escrito)
	syscall             #chama o console
	
	