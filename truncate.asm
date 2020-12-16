.data

x: .float 1.5
y: .float 0 

.text
.globl main
main:

lwc1 $f1,x
lwc1 $f3,y

trunc.w.s  $f4,$f1
cvt.s.w   $f4,$f4

add.s $f4,$f4,$f1

li $v0,2
add.s $f12,$f3,$f4
syscall


li $v0,10
syscall
