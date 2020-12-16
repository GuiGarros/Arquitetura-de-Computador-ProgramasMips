#######################################################################################################################################################
				#Guilherme Marques Brait Garros Ra : 19264266
				#Vitor Ferra Conti              Ra : 1901945
				
######################################################################################################################################################		
		

.data
	BancoRa: .word 0, 0, 0, 0, 0 #Vetor RA´S
	
	BancoNotas: .float			-1, -1, -1, -1, -1, -1, -1, 0,  #matriz precisão simples 5 x 9
						-1, -1, -1, -1, -1, -1, -1, 0,
						-1, -1, -1, -1, -1, -1, -1, 0,
						-1, -1, -1, -1, -1, -1, -1, 0,
						-1, -1, -1, -1, -1, -1, -1, 0
						
	

	Zero: .float 0
	MenosUm: .float -1.0
	dois: .float 2
	cinco: .float 5
	vinte: .float 20
	um: .float 1
	dez: .float 10
	zeroVinteCinco: .float 0.25
	Meio: .float 0.5
	zeroSetentaCinco: .float 0.75
	#strings da main
	menu: .asciiz "\nBem vindo ao controle de notas de Arquitetura de computadores \n[1] Cadastrar aluno \n[2] Adicionar ou alterar nota \n[3] Exibir nota \n[4] Média aritimética das médias da turma \n[5] exibir relação dos aprovados \n[0] encerrar programa \n:"

	#Strings usadas no cadastro [1]
	msg1: .asciiz "\nEntre com o Ra:"
	msg2: .asciiz "\nLimite de alunos Atingidos\n"
	msg15: .asciiz "\n ERRO RA EXISTENTE POR FAVOR INSIRA UM DIFERENTE\n"

	#Strings usadas na Alteração de Notas [2]
	msg3: .asciiz "\nAdicionar ou Alterar Notas \n[1] - Atividade 1 \n[2] - Atividade 2 \n[3] - Atividade 3\n[4] - Atividade 4\n[5] - Atividade 5\n[6] - Projeto 1\n[7] - Projeto 2\n[0] - Voltar ao menu principal\n:"
	msg4: .asciiz "\n Erro: Ra Invalido \n"
	msg5: .asciiz "\n Esse Aluno Ja tem nota Na atividade "
	msg6: .asciiz "\n[1] - Deseja alterar nota\n[2] - cancelar\n:"
	msg7: .asciiz "\nDigite a nota que deseja atribuir a Atividade "
	#msg8 foi criado nessa função 

	#strings usadas na Exibir Notas [3]
	msg9: .asciiz "\n - Notas:"
	msg10: .asciiz "\n Media parcial do aluno:"
	msg11: .asciiz "\nRa:"

	#strings usadas na Exibir Notas [4]
	msg12: "\n Média da Sala:"
	
	#strings usadas na Exibir Relação aprovados
	
	msg13: .asciiz "alunos aprovados:"
	msg14: .asciiz " De Total da Sala:"

	#strings usadas no projeto todo
	PressEnter: .asciiz "\n\nPressione [ENTER] para continuar\n:"
	msg8: .asciiz ":"
	space: .asciiz " "
	nextline: .asciiz "\n"
	
	buffer: .space 20


.text
	.globl main
		main:
			lwc1 $f30,Zero #$f30 vai ser nosso $fzero
			lwc1 $f31,MenosUm #$f31 vai ser nosso -1 em float

			
			la $a1,BancoNotas #carrega endereço da matriz em $a1
			la $a3,BancoRa #carrega o vetor de Ra em $a3
			
			li $v0,4 #chamada para imprimir strings 
			la $a0,menu #impressão do menu
			syscall

			li $v0,5 #chamada para armazenar inteiros 
			syscall

			move $s0,$v0 #passagem do parametro salvo em $v0 para $s0 

			#Switch Case
			
			beq $s0,1,Cadastro  #caso 1 pula para Cadastro
			beq $s0,2,AlterarNota #caso 2 pula para AlterarNota
			beq $s0,3,ExibirNotas #caso 3 pula para Exibir Notas
			beq $s0,4,ExibirMedia #caso 4 pula para Exibir medias 
			beq $s0,5,ExibirAprov #caso 5 pula para Exibir aprovados
			beq $s0,0,Fim #caso 0 pula para fim

			j main #se não entrar em nenhum caso chama de novo o menu
			
		Cadastro: 
			jal CadastroA #pula para a função que cadastra
			j main
			
		AlterarNota:
			jal AlterarNotaA #pula para a função que altera notas
			j main

		ExibirNotas:

			jal ExibirNotaT #pula para função que exibe da turma
			j main 

		ExibirMedia:
			jal ExibirMediaT #exibi media aritimetica da turma
			j main 

		ExibirAprov:
			jal ExibirAprovT #exibi relação de aprovados
			j main
			
		Fim:
			
			li $v0,10  #Return 0, encerra o programa e evita ocupar espaço na memória
			syscall
			
			
			
#cadastra o RA dos alunos-----------------------------------------------------------------------------------------------------------------------------------------
		CadastroA:
		
		#CADASTRA OS RA´S, VERIFICA SEM TEM ESPAÇO E VERIFICA SE O RA É VALIDO.
			
			add $t3,$zero,$zero #t3=0 
			
			While: #forJ
			    move $t1,$a3 #passagem do endereço de memória do vetor 			
				add $t1,$t1,$t3 #t1 = t1 + t3
				lw $t2,($t1) #carrega em t2 o valor salvo na posição t1
				
				bnez $t2,exit #Verifica se a posição está livre para armazenar Ra
				
				li $v0,4    #chamada para imprimir strings
				la $a0,msg1 #passagem do parametro a ser escrito
				syscall
				
				li $v0,5 #chamada para armazenar inteiros
				syscall
				
				#Verificação do RA, verifica se ele ja existe, caso ja exista pede para inserir outro
				move $t4,$zero #t4=0
				
				verifica:
				add $t5,$a3,$t4 #t5 = a3 + t4
				lw $t6,($t5) # t6 recebe o valor armazenado na posição a3 + t4
				

				bne $t6,$v0,proximo #verifica se o Ra digitado é igual ao do vetor
				
				li $v0,4 #chamada para imprimir strings
				la $a0,msg15 #passagem da string a ser escrita
				syscall
				
				li $v0,4 #chamada para printar string
				la $a0,PressEnter #passagem da string a se printada
				syscall
				
				move $s7,$a1 #s7 recebe o endereço de a1 para salvar
				
				li $v0,8 #chamada para ler string
				la $a0,buffer #passagem do local onde vai ser salvo a string
				li $a1,20 #espaço reservado para a variavel
				syscall
				
				move $a1,$s7 #devolve o endereço de a1 para ele 
				
				
				li $v0,4 #chamada para printar strings
				la $a0,nextline #passagem do parametro a ser escrito
				syscall
				
				j return #pula incondicionalmente para return
				
				proximo:
				addi $t4,$t4,4 #t4=t+4
				bne $t4,20,verifica #se t4 != 20, pula para 20
				
				sw $v0,($t1) #Salva o RA na posição t1 do vetor
				
				j return #pula incondicionalmente para return
				
			exit:
				
				addi $t3,$t3,4    #passa para proxima posição do vetor 
				bne  $t3,20,While #enquanto t3!=20 pula para while 
				
				
				li $v0,4 #chamada para imprimir strings
				la $a0,msg2 #passagem do parametro a ser escrito	
				syscall
				
				li $v0,4 #chamada para printar string
				la $a0,PressEnter #passagem da string a se printada
				syscall
				
				move $s7,$a1 #salva o endereço de a1 em Ss7
				
				li $v0,8 #chamada para ler string
				la $a0,buffer #passagem da variavel 
				li $a1,20 #tamanho da variavel
				syscall
				
				move $a1,$s7 #devolve o endereço de a1
				
				li $v0,4 #chamada para printar strings
				la $a0,nextline #passagem do parametro a ser escrito
				syscall
				
			return:
				jr $ra #retorno da função
			
#Adiciona ou Altera Notas-----------------------------------------------------------------------------------------------------------------------------------

		erro: #erro caso Ra Digitado Seja Invalido
			
			li $v0,4 #chamada para printar strings
			la $a0,msg4 #passagem do parametro a ser escrito
			syscall
			
			li $v0,4 #chamada para printar string
			la $a0,PressEnter #passagem da string a se printada
			syscall
			
			move $s7,$a1 #salva o endereço de a1 em s7
			
			li $v0,8 #apenas um Enter para pausar o programa
			la $a0,buffer #passagem da variavel
			li $a1,20 #tamanho da variavel
			syscall
			
			move $a1,$s7 #devolve o endereço salvo em a1
			
			li $v0,4 #chamada para printar strings
			la $a0,nextline #passagem do parametro a ser escrito
			syscall
			
			j exit2 #pula incondicinalmente para exit2
			
			
		AlterarNotaA: #Seleção da posição da matriz pelo RA Digitado
			#armazena ou altera notas de acordo com escolha do usuario
			
			
			
			li $v0,4 #chamada para printar strings
			la $a0,msg1 #passagem do parametro a ser escrito 
			syscall
			
			li $v0,5 #chamada para armazenar inteiro
			syscall
			
			beq $v0,0,erro # se v0 == 0 pula para erro
			
			move  $s3,$v0 #Salva o Ra em $s3
			
			move $t6,$a3 #passa o endereço da matriz para t6
			
				move $s0,$zero # int i = 0
			
			ForJ2:
				lw $t7,($t6) #carrega em t7 valor da memoria salvo na posição de $t6
				
				move $s1,$zero  # j=0;
				
				mul $t0,$s0,8   #i*8
				add $t0,$t0,$s1 #i*8+j
				sll $t0,$t0,2  #(i*8+j)*4
				add $t1,$t0,$a1 #passagem do endereço da matriz + posição 
				
				lwc1 $f2,($t1)#carrega o valor da matriz na posição [i][0] em $f2
				
				
				beq $t7,$s3,valido #se $f2 == f1, pula para Valido
				
				addi $t6,$t6,4 # t6 = t6 + 4
				addi $s0,$s0,1 #s0 = s0 +1
				bne  $s0,5,ForJ2 # se $s0 != 5 pula para ForJ2
			
				bne $t7,$s3,erro #se $t7 != fs3, pula para erro
			
			valido: #Fim da validação dos dados  inicio do processo de armazenar nota
			
				li $v0,4 #chamada para printar strings
				la $a0,msg3 #passagem do parametro a ser escrito 
				syscall
				
				li $v0,5 #chamada para armazenar inteiros 
				syscall
				
				bgt $v0,7,valido #Verifica se valor inserido é valido, caso não for pede para inserir de novo
				beq $v0,0,exit2 # se v0 == 0 pula para exit2
				
			addi $a2,$v0,-1 # $s0 = $v0 + $zero ($zero = constante 0)

			
			
			add $sp,$sp,-12 #abre 1 espaço na Pilha
			sw $ra,0($sp) #salva o endereço de retorno para devolver depois de voltar da função 
			
			jal CalculoDasNotas #pula incondicionalmente para calculo das notas

			
			lw $ra,0($sp)#devolve o endereço de retorono para $ra
			add $sp,$sp,12#fecha espaço aberto na pilha
			
			exit2:
			
			jr $ra #retorno da função 
			
			
#--EXIBIR NOTAS------------------------------------------------------------------------------------------------------
		ExibirNotaT:#exibi nota de todos alunos, média parcial e arredonda 
			
			
			addi $sp,$sp-8 #abre dois espaços na pilha
			sw $ra,0($sp) #salva ra em sp
			
			jal BubbleSortV #chamada de função 
			
			lw $ra,0($sp) #devolve o endereço de ra para ra salvo em sp 
			addi $sp,$sp,8 #fecha dois espaços na pilha 

			
			
			
			move $s0,$zero #s0=0
			move $t6,$zero #t6=0
			ForI3:
				
				move $s1,$zero #s1=0
				ForJ3:
					
					mul $t1,$s0,8 		#i*8
					add $t1,$t1,$s1 	#i*8+j
					sll $t1,$t1,2 		#(i*8+j)*4
					add $t1,$t1,$a1 	#soma endereço da matriz com a posição [i][j]
					
					lwc1 $f1,($t1)		#carrega valor da matriz em $f1
					
					move $t1,$a3 #t1 recebe o endereço de a3
					add  $t1,$t1,$t6 #t1=t1+t6
					lw $t7,($t1) #salva em t7 o valor da memoria em t1
					
					bne $s1,0,next 		# se j!=0 pula para next

					beqz $t7,next4 	#compara se $f1 == $f30(0), se for salva 1 em Coproc1
					
					
					li $v0,4 			#chamada para imprimir strings 
					la $a0,msg11 		#passagem do parametro a ser escrito
					syscall
					
					li $v0,1 #chamada para printar inteiros 
					move $a0,$t7 #passagem do inteiro a ser escrito
					syscall
					

					
					li $v0,4 			#chamada para imprimir strings
					la $a0,msg9 		#passagem do parametro a ser escrito
					syscall
					
					
					li $v0,4 			#chamada para printar strings
					la $a0,space 		#passagem do parametro a ser escrito
					syscall
					

					
					next:
					bne $s1,7,next2 	# se j != 7 pula para next2
					
					li $v0,4 			#chamada para printar strings
					la $a0,msg10 		#passagem do parametro a ser escrito
					syscall
					
					addi $sp,$sp,-4 #abre 1 espaço na pilha 
					sw $ra,($sp) #salva ra na pilha
					
					jal ArredondaNota #chamada da função
					
					lw $ra,($sp) #carrega em ra o valor de ra salvo em sp
					addi $sp,$sp,4 #fecha 1 espaço na pilha
					
					j next3 #pula para next3
					
					next2:
					
					c.eq.s $f1,$f31 	#compara se $f1 e $f31 são iguais e salva em coproc1
					bc1t next3 			#se f1 == -1 pula para next3
					
					
					
					li $v0,2 			#chamada para imprimir ponto flutuante
					add.s $f12,$f30,$f1                    #$f12 = $f30 + $f1
					syscall
					

					
					li $v0,4 			#chamada para printar strings
					la $a0,space 		#passagem do parametro a ser escrito
					syscall
					
					next3:
						addi $s1,$s1,1 #j++
						bne  $s1,8,ForJ3 # se j != 8 pula para ForJ3
				
			next4:
				addi $t6,$t6,4 #t6 = t6 + 4
				addi $s0,$s0,1  #i++
				
				
				bne $t6,20,ForI3 #se i != 20 1pula para ForI3
				
				
				li $v0,4 #chamada para printar string
				la $a0,PressEnter #passagem da string a se printada
				syscall
				
				move $s7,$a1 #passagem do endereço de a1 para s7
				
				li $v0,8 #chamada para ler string
				la $a0,buffer #passa variavel para a0
				li $a1,20 #passa o tamanho da variavel
				syscall
				
				move $a1,$s7 #devolve o endereço de a1
				
				li $v0,4 #chamada para printar strings
				la $a0,nextline #passagem do parametro a ser escrito
				syscall

			jr $ra
			
			
#------------EXIBIR MEDIA-------------------------------------------------------------------------------------------------
		ExibirMediaT:
			#exibi a média das médias da turma
			
			mov.s $f1,$f30 #f1 = 0
			move $s0,$zero#i=0
			add.s $f3,$f30,$f30 #contador de alunos
			add.s $f4,$f30,$f30 #soma das notas
			lwc1 $f5,um #transformando registrador em 1
			mov.s $f6,$f30 #f6 = 0
			
			
			move $t7,$zero #t7 = 0
			
			ForI4:
				add $s1,$zero,0 #j=0
				
				move $t5,$a3 #passagem do endereço da matriz para t5
				
				add $t5,$t5,$t7 #t5 = t5 + t7

				
				ForJ4:
				
				
				lw $t6($t5) #carrega em t6 o valor salvo em t5
				
				mul $t1,$s0,8 #i*8
				add $t1,$t1,$s1 #i*8+j
				sll $t1,$t1,2 #(i*8+j)*4
				add $t1,$t1,$a1 #soma endereço da matriz com a posição [i][j]
				
				lwc1 $f1,($t1)#carrega valor da matriz em $f1
				
				beqz $t6,next7 #compara se $t6 == 0 se for pula pra next7
				beq $s1,7,next5 # se j==7 pula para next5

				
				
				j next6 #pula incondicionalmente para next6
				next5:
				
				bne $s1,7,next6 #se s1 != 7 pula para next6
				add.s $f3,$f3,$f5 #contador++
				add.s $f4,$f4,$f1 # notas = notas + $f1
				
				next6:
				add $s1,$s1,1 #s1 = s1 + 1
				bne $s1,8,ForJ4	 #se s1 != 8 pula para ForJ4
				next7:
				addi $t7,$t7,4	 #t7 = t7 + 4
				add $s0,$s0,1  #s0 = s0 + 1
				bne $s0,5,ForI4 #se s0 != 0 pula para ForI4
 			
			
				c.eq.s $f3,$f30 # compara se f3 == 30
				bc1t semAlunos #caso for verdade, pula para sem alunos 
				
				div.s  $f6,$f4,$f3 #f6 = f4 / f3
			
			semAlunos:
			
			add.s $f1,$f30,$f6 # f1 = f30 + f6
			
			li $v0,4 #chamada para printar strings
			la $a0,msg12 #passagem da string a ser escrita
			syscall
			
			
			addi $sp,$sp,-4 #abre um espaço na pillha 
			sw $ra,($sp) #salva o endereço de retorno na pilha
					
			jal ArredondaNota #chamada da função
					
			lw $ra,($sp)#devolve o endereço de ra salvo na pilha
			addi $sp,$sp,4 #fecha 1 espaço na pilha
			
				

			
			li $v0,4 #chamada para printar string
			la $a0,PressEnter #passagem da string a se printada
			syscall
				
			move $s7,$a1 # salva o endereço de a1 em s7
				
			li $v0,8 #chamada para ler string
			la $a0,buffer #passagem da variavel
			li $a1,20 #passagem do tamanho da variavel
			syscall
			
			move $a1,$s7 #devolve o endereço de a1 salvo em s7
				
			li $v0,4 #chamada para printar strings
			la $a0,nextline #passagem do parametro a ser escrito
			syscall
			
			
			jr $ra #retorno da função 
#--------------EXIBIR APROVADOS-------------------------------------------------------		
		ExibirAprovT:
		
			move $s0,$zero#i=0
			add.s $f3,$f30,$f30 #contador de Aprovados
			lwc1 $f4,cinco #carrega o valor cinco em f4
			lwc1 $f5,um #transformando registrador em 1
			add.s $f6,$f30,$f30 #contador de alunos
			
			move $t7,$zero #t7=0
			
			ForI5:
				move $t5,$a3 #passa o endereço da matriz para t5
				add $t5,$t5,$t7 #t5 = t5 + t7
				add $s1,$zero,0 #j=0

				ForJ5:				
				
				lw $t6,($t5) #carrega em t6 o valor salvo em t5
				
				mul $t1,$s0,8   #i*8
				add $t1,$t1,$s1 #i*8+j
				sll $t1,$t1,2   #(i*8+j)*4
				add $t1,$t1,$a1 #soma endereço da matriz com a posição [i][j]
				
				lwc1 $f1,($t1)#carrega valor da matriz em $f1
				
				
				bne $s1,0,next8 # se j!=0 pula para next

				beqz $t6,next9 #se t6 == 0 pula para next9

				
				add.s $f6,$f6,$f5 #contador de alunos ++
				

				next8:
				
				bne $s1,7,next10 #se s1 != 7 pula para next10
				
				c.lt.s  $f1,$f4 #compara se f1 < f4
				bc1t  next9 # se for menor pula para next9
				
				add.s $f3,$f3,$f5 #contador de aprovados ++
				
				next10:
				add $s1,$s1,1 #s1 = s1 + 1
				bne $s1,8,ForJ5	 #se s1 != 8 pula para ForJ5
				next9:
				addi $t7,$t7,4	#t7 = t7 + 4
				add $s0,$s0,1   #s0 = s0 + 1
				bne $s0,5,ForI5 #se s0 != 5 pula para ForI5
				
				li $v0,4 #chamada para printar strings
				la $a0,msg13 #passagem da string a ser escrita
				syscall
				
				li $v0,2 #chamada para printar ponto flutuante
				add.s $f12,$f3,$f30 #passagem do ponto flutuante a ser escrito
				syscall
				
				li $v0,4 #chamada para printar strings
				la $a0,msg14 #passagem da string a ser escrita
				syscall
				
				li $v0,2 #chamada para printar ponto flutuante
				add.s $f12,$f6,$f30 #passagem do ponto flutuante a ser escrito
				syscall
				
				li $v0,4 #chamada para printar strings
				la $a0,PressEnter #passagem da string a ser escrita
				syscall
				
				move $s7,$a1 #passagem do endereço de a1 para s7
				
				li $v0,8 #chamada para armazenar strings
				la $a0,buffer #passagem da variavel para salvar string
				li $a1,20 #passagem do tamanho da satring
				syscall
				
				move $a1,$s7 #passagem do endereço de s7 para a1
				
				li $v0,4 #chamada para printar strings
				la $a0,nextline #passagem do parametro a ser escrito
				syscall
		
		jr $ra #retorno da função
#--------------FUNÇÕES UTEIS----------------------------------------------------------------------------------------------------------------------------------------------
		CalculoDasNotas: #Passa notas e Calcula Médias -------------------------------------------------------------------------------------------------------------
			
			#a2 passado como parametro posição da nota
			#t1 passado como endereço do aluno
			


			sw  $s0,4($sp) #salva os valores de $s0 para que possa manipular durante a execução da função
			sw  $s1,8($sp) #salva os valores de $s1 para que possa manipular durante a execução da função
			
			move $t7,$zero #t7=0

			sll $a2,$a2,2 #multiplica a2 por 2
			add $t2,$t1,$a2 #soma a posição no endereço do aluno salvo em t1 - Matriz [$t1][$a2]
			
			lwc1 $f2,($t2)#carrega valor em $f2
			
			div $a2,$a2,4 # divide a2 por 4

			
			c.eq.s $f31,$f2 #verifica se são iguais
			bc1t altera#se $f2 == f31, pula para valido2
		
		
			li $v0,4 #chamada para printar strings 
			la $a0,msg5 #passagem do parametro a ser escrito
			syscall
			
			li $v0,1 #chamada para imrprimir inteiros 
			addi $a0,$a2,1 #passagem do inteiro a ser escrito
			syscall
			
			li $v0,4 #chamada para imprimir strings
			la $a0,msg6 #passagem da string a ser escrita
			syscall
			
			li $v0,5 #chamada para armazenar inteiros
			syscall
			
			bne $v0,1,fim #se não for igual 1 pula para valido2
			move $t7,$v0 #t7 = v0

			altera:
				li $v0,4 #chamada para imprimir strings
				la $a0,msg7#passagem do parametro a ser escrito
				syscall
				
				li $v0,1 #chamada pra imprimir inteiros
				add $a0,$a2,1 #passagem do inteiro a ser escrito
				syscall
				
				li $v0,4 #chamada para imprimir strings
				la $a0,msg8 #passagem do parametro a ser escrito
				syscall
				
				li $v0,6 #chamada para armazenar ponto flutuante
				syscall
				
				c.le.s $f0,$f31 #compara se f0 é menor ou igual que f31
				bc1t altera #se for pula para altera
				
				lwc1 $f29,dez #carrega 10 em f29
				c.le.s $f0,$f29 #se f0 for igual f29
				bc1f altera  #se for pula para alteera
			
			swc1 $f0,($t2) #armazenagem do ponto flutuante na matriz
			
			
			bgt $a2,4,projeto #se a2 for maior que 4 pula para projeto

			lwc1 $f5,($t2)  #carrega valor da matriz em $f5
			add  $t2,$t1,28  #passagem do endereço da media de tarefas feitas até o momento
			lwc1  $f6,dois  #carrega 2 em $f6
			lwc1  $f7,vinte #carrega 20 em $f7

			lwc1 $f8,($t2) #carrega valor antigo Matriz (i*4+j)*8
			
			bne  $t7,1,normal #se t7 != 1 pula para normal
			
			mul.s $f2,$f2,$f6 # f2  = f2 * f6
			div.s $f2,$f2,$f7 # f2 = f2 / f7
			sub.s $f8,$f8,$f2# f8 = f8 - f2
			
			normal:
			
			mul.s $f5,$f5,$f6 #multiplica $f5 por $f6 e salva em $f5
			div.s $f5,$f5,$f7 #divide $f5 por $f7 e salva em $f5
			add.s $f8,$f5,$f8 #soma o valor antigo de média com o novo
			
			swc1 $f8,($t2) #carrega o novo valor na Matriz[i][j]
		
		
			j fim #pula para média geral
			
			projeto:
				
				
				lwc1 $f5,($t2) #carrega o valor de $a1 em $f5
				add $t2,$t1,28 #passagem do endereço da media de tarefas feitas até o momento 
				lwc1 $f6,cinco     #carrega 5 em $f6
				lwc1 $f7,vinte    #carrega 20 em $f7
				lwc1 $f8,($t2) #carrega valor antigo Matriz (i*4+j)*8
				
				bne  $t7,1,normal1 #se t7 != 1 pula para normal
				mul.s $f2,$f2,$f6 #f2 = f2 * f6
				div.s $f2,$f2,$f7 # f2 = f2 / f7
				sub.s $f8,$f8,$f2#f8 = f8 - f2
				normal1:
				
				mul.s $f5,$f5,$f6 #multiplica $f5 por $f6 e salva em $f5
				div.s $f5,$f5,$f7 #divide $f5 por $f7 e salva em $f5
				add.s $f8,$f5,$f8 #soma o valor antigo de média com o 
				

				
				swc1 $f8,($t2) #carrega o novo valor na Matriz[i][j]
				

				
			fim:
				lw $s0,4($sp) #devolve o valor de $s0
				lw $s1,8($sp) #devolve o valor de $s1

				
				jr $ra #return
				
				
	BubbleSortV:
			
		sw $ra,4($sp) # salva o endereço de ra em sp na segunda posição
		
		move $s3,$zero #i=0;

		ForI6:
		

		
		move $t7,$zero #j=0

		
		addi $t3,$zero,0 #contador aux 1
		addi $t9,$zero,1 #contador aux 2
		
		
		ForJ6:
		
		add $t5,$a3,$zero #posição 0 d0 vetor
		addi $t4,$a3,4    #posição 1 do vetor
		
		add $t5,$t5,$t7 #posição do vetor + 1 a partir da segunda execução
		add $t4,$t4,$t7 #posição do vetor + 1 a partir da segunda execução
		
		lw $t6($t5) #carrega o valor salvo na posição $t5 em $t6
		lw $t8($t4) #carrega o valor salvo na posição $t4 em $t8
		
		blt $t6,$t8,next11#se t6<=t8 pula para next11
						
		sw $t8,($t5) #se não troca seus valores 
		sw $t6,($t4)						

		jal BubbleSortM
				
		next11:

		addi $t3,$t3,1 #contador aux++
		addi $t9,$t9,1 #contador aux2++

		addi $t7,$t7,4 #posição do vetor ++
		bne  $t7,16,ForJ6 #se t7 n for igual a 16 pula para ForJ6
		
		addi $s3,$s3,1 #i++
		bne $s3,4,ForI6 #se s3!=5 pula para ForI6

		

		lw $ra,4($sp) #devolve o valor de ra salvo na pilha em sp
		jr $ra#retorno da função 
			
		BubbleSortM:

			move $s0,$t3 #s0 = t3
			move $s1,$t9 #s1 = t9
			add $t6,$t6,$s3 # t6 = t6 + s3
			add $t8,$t8,$s3	# t8 = t8 + s3
			

			move $s2,$zero #j=0
			ForJ7:

				mul $t1,$s0,8   #i*8
				add $t1,$t1,$s2 #i*8+j
				sll $t1,$t1,2   #(i*8+j)*4
				add $t1,$t1,$a1 #soma endereço da matriz com a posição [i][j]
				
				mul $t2,$s1,8   #i*8
				add $t2,$t2,$s2 #i*8+j
				sll $t2,$t2,2   #(i*8+j)*4
				add $t2,$t2,$a1 #soma endereço da matriz com a posição [i][j]
					
				lwc1 $f1,($t1)#carrega valor da matriz em $f1
				lwc1 $f2,($t2)#carrega valor da matriz em $f2
				
				
				swc1 $f1,($t2) #inverte os valores
				swc1 $f2,($t1)
				
			addi $s2,$s2,1 # s2 = s2 + 1
			bne $s2,8,ForJ7 #se s2 != 8 pula para ForJ7
			
			jr $ra #retorno da função 

			
ArredondaNota:
								#ARREDONDAMENTO DA NOTA
								
					mov.s $f4,$f30 # f4 = f30
					add.s $f5,$f30,$f1 #f5 = f30 + f1
					
					lwc1 $f6,zeroVinteCinco #carrega 0.25 em $f6
					lwc1 $f7,Meio #carrega 0.5 em $f7
					lwc1 $f8,zeroSetentaCinco #carrega 0.75 em $f8
					lwc1 $f9,um #carrega 1 em $f9
					
					trunc.w.s  $f4,$f1 #pega só a parte inteira de f1 e salva em f4
					cvt.s.w   $f4,$f4
					
					sub.s $f5,$f5,$f4 #f5 = f5 - f4
				
					c.lt.s  $f5,$f6 #compara se f5 é menor que f6
					bc1t nota #se for verdade pula pra nota 
					
					c.lt.s $f5,$f8 #compara se f5 for menor f8 
					bc1t arredonda # se for verdade pula para arredonda
					
					j arredonda2 #pula incondicionalmente para arredonda2
					
					arredonda:
					add.s $f4,$f4,$f7 # f4 = f4 + f7
					j nota #pula incondicionalmente para nota
							
					arredonda2:
					add.s $f4,$f4,$f9 #f4 = f4 + f9
															
					nota:
					li $v0,2 			#chamda para printar float
					add.s $f12,$f30,$f4          #$f12 = $f30 + $f1, passagem do parametro que vai ser escrito
					syscall
					
					jr $ra #retorno da função
			
