
.data
        Table: .space 20
        msg1: .asciiz "Digite os numeros do vetor: "   
        msg3: .asciiz "\nVetor Ordenado: "
        .text					                    # indica que as linhas seguintes contém instruções	
	    .globl main				                    # define o símbolo main como sendo global
main:
        addi $s0, $zero, 4                          # insere 1 item na pilha
        addi $t0, $zero, 0                          # seta $t0 = 0
inicio:
        li $v0, 4                                   # Codigo SysCall p/ escrever strings   
        la $a0, msg1                                # Parametro (string a ser escrita)                  
        syscall

        li $v0, 5				                    # Codigo SysCall p/ ler inteiros
        syscall			                            # Inteiro lido vai ficar em $v0
        add $t1, $t0, $zero
        sll $t1, $t0, 2                             # da um shift para esquerda
        add $t3, $v0, $zero
        sw $t3, Table ( $t1 )
        addi $t0, $t0, 1
        slt $t1, $s0, $t0                           # seta $t1 se $s0 for menor que $t0
        beq $t1, $zero, inicio                      # se $t1 for zero volta para o inicio

        la $a0, Table
        addi $a1, $s0, 1 

        jal bubblesortsort  						#jump para bubblesortsort

        li $v0, 4
        la $a0, msg3								#chamada de console e print msg3
        syscall
        
        la $t0, Table
        add $t1, $zero, $zero

imprimi:
        lw $a0, 0($t0)                              # Parametro (inteiro a ser escrito)
        li $v0, 1                                   # Codigo SysCall p/ escrever inteiros
        syscall										#chama o console


        addi $t0, $t0, 4
        addi $t1, $t1, 1
        slt $t2, $s0, $t1
        beq $t2, $zero, imprimi
        li $v0, 10
        syscall

bubblesortsort:
        add $t0, $zero, $zero                       # seta $t0 = 0

while:
        addi $t0, $t0, 1                            # acresenta 1 em $t0
        bgt $t0, $a1, Fimwhile                       # se  t0 for menor que a1 vai para Fimwhile para dar break;
        add $t1, $a1, $zero 
        
whileAux:
        bge $t0, $t1, while                         # se $t1 for menor ou igual a $t0 volta para while
        addi $t1, $t1, -1                           # decrescenta 1 em $t1
        mul $t4, $t1, 4                             # table $t1
        addi $t3, $t4, -4                           #table $t1 - 1
        add $t7, $t4, $a0                           #table $t1
        add $t8, $t3, $a0                           #table $t1 - 1
        lw $t5, 0($t7)
        lw $t6, 0($t8)
        bgt $t5, $t6, whileAux						
        sw $t5, 0($t8)
        sw $t6, 0($t7)
        j whileAux                                   # retorna para whileAux ate ter 5 posicoes no vetor

Fimloop:
        jr $ra