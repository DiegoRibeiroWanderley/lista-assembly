.data
	string_inicio: .asciz "Sobstitoi" # string inicial
	string_final: .space 100 # espaço pra string final
	letra_procurar: .asciz "o" # letra que será procurada
	letra_substituir: .asciz "u" # letra que a substituirá
	
.text
main:
	la t1, string_inicio # ponteiro para a string inicial
	la t2, string_final # ponteiro para a string final
	
	la t0, letra_procurar # carrega a letra pra procurar
	lbu a2, 0(t0) # e coloca em a2
	la t0, letra_substituir # carrega a letra que substituir
	lbu a3, 0(t0) # e coloca em a3
	
loop:
	lbu t3, 0(t1) # carrega caractere correspondente em t3
	
	beq t3, zero, guardar # se t3 for zero pula pra guardar
	beq t3, a2, substituir # se t3 for igual a letra procurada pula pra substituir
	
	sb t3, 0(t2) # se nada disso acontecer coloca a letra que já tava na string final
	j proximo # pula pro próximo

substituir:
	sb a3, 0(t2) # se cair aqui troca a letra atual pela que irá substituir
	
proximo:
	addi t1, t1, 1 # acresecenta o indice da string inicial em 1
	addi t2, t2, 1 # a da final também
	j loop # volta pro loop
	
guardar:
	sb zero, 0(t2) # se cair aqui acrescenta o zero no fim da string
	
finalizar:
	la a0, string_final # guarda a string final em a0
	li a7, 4 # chamada do sistema pra printar uma string
	ecall # chama o sistema