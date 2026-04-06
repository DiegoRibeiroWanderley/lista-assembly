.data
	i: .word 10 # i
	A: .word 1, 2, 3, 0, 5, 6, 7, 8, 9, 10 # vetor A
	B: .word 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 # vetor B
	C: .word 5 # constante C
	
.text
main:
	li t0, 0 # carrega em t0 o valor 0
	lw t1, i # carrega em t1 o valor de i
	la s0, A # ponteiro para o vetor A
	la s1, B # ponteiro para o vetor B
	lw s2, C # carrega em s2 o valor de C
	
loop:
	beq t0, t1, fim # se t0 igual a t1 acaba o programa
	
	slli t2, t0, 2 # coloca em t2 o valor de deslocamento
	
	add t3, s0, t2 # adiciona em t3 o endereço de s0 mais o deslocamento t2
	lw t5, 0(t3) # carrega em t5 o valor no endereço de t3
	
	add t4, s1, t2 # adiciona em t4 o endereço de s1 mais o deslocamento t2
	lw t6, 0(t4) # carrega em t6 o valor no endereço de t4
	
	bge t5, t6, entrou_else # se t5 >= t6 entra no else
	bne t5, zero, entrou_if # se não verfica se o valor em A é zero, se não entra no if

entrou_else:
	sub t5, t6, s2 # guarda em t5 t6 - s2
	sw t5, 0(t3) # coloca esse valor no vetor
	j proximo # pula pro proximo

entrou_if:
	add t5, t6, s2 # guarda em t5 t6 + s2
	sw t5, 0(t3) # coloca esse valor no vetor
	
proximo:
	addi t0, t0, 1 # i++
	j loop # volta pro loop
	
fim:
	li a7, 10 # system call pra finalizar
	ecall # chama o sistema
