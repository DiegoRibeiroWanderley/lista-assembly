.data
    # -5 em 32 bits
    string_bin: .asciz "11111111111111111111111111111011"

.text
main:
    la t0, string_bin    # t0 ponteiro para a string
    li a0, 0             # a0 acumulador do resultado
    li a1, 0             # a1 status de erro
    li t1, 0             # t1 contador de bits processados

loop:
    lbu t2, 0(t0)        # Carrega o caractere atual
    beq t2, zero, encerra_programa    # Se for \0 encerra o loop
    
    # Verifica se é 1 ou 0
    li t3, 48            # ASCII '0'
    li t4, 49            # ASCII '1'
    
    beq t2, t3, eh_zero
    beq t2, t4, eh_um
    
    # Se chegou aqui não é nem 1 nem 0
    li a1, 1             # a1 = 1, erro
    j encerra_programa

eh_zero:
    li t5, 0
    j processa_bit

eh_um:
    li t5, 1

processa_bit:
    # Lógica: v0 = (v0 << 1) | bit
    slli a0, a0, 1       # Desloca o acumulador 1 bit para a esquerda
    or a0, a0, t5        # Adiciona o bit atual na posição menos significativa
    
    addi t0, t0, 1       # Move ponteiro da string
    addi t1, t1, 1       # Incrementa contador de bits
    j loop

encerra_programa:
    li a7, 10
    ecall # Chamada do sistema pra finalizar o programa
