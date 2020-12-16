.data #declaração de variaveis e string
		msg1: .asciiz "\nEntre com o numero: " #string 
.text                     # indica que as linhas seguintes contém instruções
.globl main               # define o símbolo main como sendo global


	
	
main:                # indica o início do programa

	addi $sp,$sp, -4 #ajusta a pilha 
	sw $ra,0($sp)    #salva o endereço de retorno
	
	li $v0, 4        # Codigo SysCall p/ escrever strings
	la $a0, msg1     # Parametro (string a ser escrita)
	syscall			 # chama o console
	
    li $v0, 5           #Codigo SysCall p/ ler inteiros
	syscall             # Inteiro lido vai ficar em $v0
	add $a1, $v0, $zero # Armazena em $a1 o número
	

	jal fact #pula para função fact (Fatorial)
	

	
	
	li $v0, 1           #Codigo SysCall p/ escrever inteiros
	add $a0, $zero, $v1 # Parametro (inteiro a ser escrito)
	syscall             #chama o console

	li $v0, 5           # Apenas para esperar um [ENTER]
	syscall 			#chama o console
	
	lw $ra,0($sp)		#devolve o endereço de retorno para ra
	addi $sp,$sp,4		#desaloca da memoria 
	
	jr $ra #finaliza o programa

	
	L1: addi $a1, $a1, -1 # else decrement n  
	jal  fact             # recursive call	
	lw   $a1, 0($sp)      # restore original n
	lw   $ra, 4($sp)      # and return address
	addi $sp, $sp, 8      # pop 2 items from stack
	mul  $v1, $a1, $v1    # multiply to get result		
	jr   $ra              # and return
	
	
	
	fact:
	addi $sp, $sp, -8     # adjust stack for 2 items
	sw   $ra, 4($sp)      # save return address
	sw   $a1, 0($sp)      # save argument	
	slti $t0, $a1, 1      # test for n < 1
	beq  $t0, $zero, L1	
	addi $v1, $zero, 1    # if so, result is 1
	addi $sp, $sp, 8      # pop 2 items from stack
	jr   $ra			  # and return
	
