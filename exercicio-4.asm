.data
	numero_1: .word 9 # numero_1
	numero_2: .word -4 # numero_2
	RESULT: .word 0 # resultado RESULT

.text
main:
	lw a0, numero_1 # carrega em a0 o numero_1
	lw a1, numero_2 # carrega em a1 numero_2
	
	li t1, 0 # t1 começa em 0, servirá pra acumular o número
	li t2, 0 # t2 = 0, sinal positivo, t2 = 1, sinal negativo
	
	bge a0, zero, checar_a1 # se a0 >= 0 vai para checar_a1
	sub a0, zero, a0 # obtem seu modulo
	addi t2, t2, 1 # coloca 1 em t2, ou seja, negativo

checar_a1:
	bge a1, zero, multiplicar # se a1 >= 0 vai para multiplicar
	sub a1, zero, a1 # obtem seu modulo
	addi t2, t2, 1 # coloca 1 em t2, ou seja, negativo
	
multiplicar:
	beq a1, zero, sinal # se a1 == 0 vai para sinal
	add t1, t1, a0 # adiciona a t1 ele mesmo mais o valor de a0
	addi a1, a1, -1 # subtrai de a1 1 até que ele chegue me zero
	j multiplicar # repete o loop
	
sinal:
	li t3, 1 # carrega em t3, o numero 1 para comparação
	bne t2, t3, guardar # se t2 == 1, o número é negativo
	sub t1, zero, t1 # transforma-o em negativo subtraindo ele de zero
	
guardar:
	la t0, RESULT # t0 ponteiro para RESULT
	sw t1, 0(t0) # coloca o valor de t1 em RESULT pelo ponteiro
	
sair:
	li a7, 10 # system call para finalizar o programa
	ecall # chama o sistema
