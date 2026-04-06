.data
	vetorX: .space 64 # Vetor
	numerosDe1: .word 0 # numerosDe1

.text
main:
	la t0, vetorX # ponteiro para vetorX
	li t1, 0 # contador de 1s
	li t2, 0 # i = 0
	li t3, 64 # limite de i, 64
	li t4, 1 # 1 de comparação
	
loop:
	beq t2, t3, salvar # Se i == 64, vai pra salvar
	
	lbu t5, 0(t0) # carrega o byte atual de vetorX
	bne t5, t4, proximo # se não for igual a 1 vai pro próximo
	
	addi t1, t1, 1 # numerosDe1++
	
proximo:
	addi t0, t0, 1 # move o ponteiro pro próximo byte
	addi t2, t2, 1 # i++
	j loop # volta pro loop
	
salvar:
	la t6, numerosDe1 # endereço de destino
	sw t1, 0(t6) # salva o valor da contagem t1 em numerosDe1
	
exit:
	li a7, 10
	ecall # chamada do sistema pra finalizar o programa