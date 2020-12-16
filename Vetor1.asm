.data 
vetor: .space 12
.text 

addi $s0,$zero,10
addi $s1,$zero,20
addi $s2,$zero,30

# index 

addi $t0, $zero,0

sw $s0,vetor($t0)
addi $t0,$t0,4
sw $s1,vetor($t0)
addi $t0,$t0,4
sw $s2,vetor($t0)

#printar a primeira posição 

lw $s3,vetor($zero)

li $v0,1
move $a0,$s3
syscall

li $v0,10
syscall