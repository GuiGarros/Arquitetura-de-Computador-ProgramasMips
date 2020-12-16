.data 
msg1: .asciiz "Hello world"

.text

.globl main
main:

li $v0,4        #codigo para printar strings
la $a0,msg1     # passagem da string que vai ser printada
syscall		# código para dizer "faça agora"

li $v0,10	# semelhante ao return 0 impede a carga de memoria no seu sistema
syscall