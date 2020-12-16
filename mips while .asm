.data 
.text 

addi $t0,$zero,0 # t0 = 0 + 0

while:

bgt $t0,10,exit # se t0 > 10 pula para exit

li $v0,1 #chamada para printar inteiros 
move $a0,$t0 #passa para a0 o valor a ser printado
syscall

addi $t0,$t0,1 # to = to + 1

j  while #pula para while
exit:

li $v0,10 #end program
syscall