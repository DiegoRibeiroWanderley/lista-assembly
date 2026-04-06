.data
	string_entrada: .asciz "HArdwArE" # String de entrada
	string_saida: .space 100 # Espaço para a string de saída

.text
main:
	la t0, string_entrada # Ponteiro para o começo da string de entrada
	la t1, string_saida # Ponteiro para o começo da string de saída
	li a1, 0 # Inicializa a1 com 0, ou seja, sucesso
	
	mv t2, t0 # t2 vai percorrer a string

achar_fim:
	lbu t3, 0(t2) # t3 carrega o caractere atual
	beq t3, zero, voltar # Se ele for igual a 0, volta pro anteriro
	addi t2, t2, 1 # Acrescenta t2 em 1 para ir para o próximo caractere
	j achar_fim # fica no loop

voltar:
	addi t2, t2, -1 # Se for 0, volta pro caracetere anterior em t2
	
loop_reverso:
	blt t2, t0, finalizar # Se o ponteiro atual menor que o ponteiro inicial, finaliza
	
	lbu t3, 0(t2) # Carrega o caractere de netrada
	
	# Validação da letra
	
	# Valiação de A-Z
	li t4, 65 # A
	li t5, 90 # Z
	blt t3, t4, checar_erro # Se menor que A, erro
	ble t3, t5, e_letra # Se menor que Z, logo maior que A, então letra
	
	# validaçã a-z
	li t4, 97 # a
	li t5, 122 # z
	blt t3, t4, checar_erro # Entre Z e a, erro
	ble t3, t5, e_letra # Entre a e z, letra
	
checar_erro:
	li a1, 1 # Coloca 1 em a1, erro
	j sair # Encerra o programa
	
e_letra:
	# Diferença de maisculas para minusculas é o bit 5, ou seja 32
	xori t3, t3, 32 # Troca de maiuscula para minuscula
	
	sb t3, 0(t1) # Salva na string de saída
	addi t1, t1, 1 # A string de saída vai para frente
	addi t2, t2, -1 # A string de entrada vai pra trás
	j loop_reverso # Volta pro loop
	
finalizar:
	sb zero, 0(t1) # Coloca o caractere nulo no fim da string
	
sair:
	la a0, string_saida # Coloca em a0 a string de saida
	li a7, 4 # Define a7 como 4, print string
	ecall # Chama o sistema