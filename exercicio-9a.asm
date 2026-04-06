.data
	i: .word 10 # i
	A: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 # vetor A
	
.text
main:
	li t1, 0 # carrega em t1 o valor 0
	lw t2, i # carrega em t2 o valor de i
	la s0, A # ponteiro para A
	
loop:
	bge t1, t2, fim # se t1 >= t2 vai pra fim
	
	slli t3, t1, 2 # guarda o deslocamento em t3
	add t4, s0, t3 # adiciona em t4 o endereço do do elemento do vetor correspondente
	
	lw t5, 0(t4) # carrega em t5 o valor desse elemento
	addi t5, t5, 1 # incrementa t5 em 1
	sw t5, 0(t4) # guarda no vetor novamente
	
	addi t1, t1, 1 # i++
	j loop # volta pro loop
	
fim:
	li a7, 10 # system call pra finalizar o programa
	ecall # chama o sistema
