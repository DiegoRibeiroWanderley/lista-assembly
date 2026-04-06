.data
    msg_pedir:   .asciz "\nDigite sua matricula (9 digitos): "
    msg_enc:     .asciz "A matricula "
    msg_corresp: .asciz " corresponde ao aluno "
    msg_nao_enc: .asciz " nao foi encontrada"
    msg_sou_eu:  .asciz "Sou eu! Eu sou "
    msg_e_tenho: .asciz ", e tenho matricula "
    
    buffer:      .space 12
    
    # --- COLOQUE AQUI AS 70 MATRICULAS QUE ENVIEI ANTES ---
    lista_matriculas:
        .word 0x24000001, 0x24000002, 0x24000003, 0x24000004, 0x24000005
        .word 0x24000006, 0x24000007, 0x24000008, 0x24000009, 0x24000010
        .word 0x24000011, 0x24000012, 0x24000013, 0x24000014, 0x24000015
        .word 0x24000016, 0x24000017, 0x24000018, 0x24000019, 0x24000020
        .word 0x24000021, 0x24000022, 0x24000023, 0x24000024, 0x24000025
        .word 0x24000026, 0x24000027, 0x24000028, 0x24000029, 0x24000030
        .word 0x24000031, 0x24000032, 0x24000033, 0x24000034, 0x24000035
        .word 0x24000036, 0x24000037, 0x24000038, 0x24000039, 0x24000040
        .word 0x24000041, 0x24000042, 0x24000043, 0x24000044, 0x24000045
        .word 0x24000046, 0x24000047, 0x24000048, 0x24000049, 0x24000050
        .word 0x24000051, 0x24000052, 0x24000053, 0x24000054, 0x24000055
        .word 0x24000056, 0x24000057, 0x24000058, 0x24000059, 0x24000060
        .word 0x24000061, 0x24000062, 0x24000063, 0x24000064, 0x24000065
        .word 0x24000066, 0x24000067, 0x24000068, 0x24000069, 0x24000070
    
    # --- COLOQUE AQUI OS 70 NOMES QUE ENVIEI ANTES ---
    lista_nomes:
        .asciz "Im Nayeon"
        .asciz "Bruno Souza"
        .asciz "Carla Dias"
        .asciz "Diego Lira"
        .asciz "Elena Cruz"
        .asciz "Fabio Melo"
        .asciz "Yoo Jeongyeon"
        .asciz "Hugo Rocha"
        .asciz "Diego Ribeiro"
        .asciz "Joao Lima"
        .asciz "Karen Amorim"
        .asciz "Lucas Neto"
        .asciz "Hirai Momo"
        .asciz "Nuno Pires"
        .asciz "Olga Reais"
        .asciz "Paulo Tito"
        .asciz "Quenia Sol"
        .asciz "Raul Rosa"
        .asciz "Minatozaki Sana"
        .asciz "Talis Jua"
        .asciz "Uriel Bins"
        .asciz "Vera Leal"
        .asciz "Wagner Gil"
        .asciz "Xavier Paz"
        .asciz "Park Jihyo"
        .asciz "Zuleica Oh"
        .asciz "Andre Luis"
        .asciz "Beatriz Sa"
        .asciz "Caio Cesar"
        .asciz "Dora Meira"
        .asciz "Myoi Mina"
        .asciz "Flora Rios"
        .asciz "Guido Mota"
        .asciz "Heitor Vaz"
        .asciz "Iris Neves"
        .asciz "Jair Lopes"
        .asciz "Kim Dahyun"
        .asciz "Luan Matos"
        .asciz "Mara Sales"
        .asciz "Noe Fontes"
        .asciz "Otto Meyer"
        .asciz "Pilar Lima"
        .asciz "Ruan Silva"
        .asciz "Son Chaeyoung"
        .asciz "Theo Nobre"
        .asciz "Vitor Hugo"
        .asciz "Zelia Guedes"
        .asciz "Alan Pontes"
        .asciz "Bia Moraes"
        .asciz "Ciro Gomes"
        .asciz "Chou Tzuyu"
        .asciz "Enzo Ramos"
        .asciz "Fani Viana"
        .asciz "Guto Ferraz"
        .asciz "Hilda Rosa"
        .asciz "Iago Teles"
        .asciz "Julia Paes"
        .asciz "Kelvin Lu"
        .asciz "Twice da Silva"
        .asciz "Miro Alves"
        .asciz "Nara Costa"
        .asciz "Omar Souza"
        .asciz "Pepe Jales"
        .asciz "Rute Bezer"
        .asciz "Saulo Neri"
        .asciz "Tais Faria"
        .asciz "Ugo Duarte"
        .asciz "Park Jin Young"
        .asciz "Yara Porto"
        .asciz "Zilda Meire"

    # Defina qual é a SUA matrícula para o passo d.3
    minha_matr_bcd: .word 0x24000009 

.text
main:
loop_principal:
    la a0, msg_pedir # guarda em a0 a msg_pedir
    li a7, 4 # system call para print string
    ecall # chama o sistema

    la a0, buffer # ponteiro para buffer
    li a1, 12 # quantidade de caracteres que serão recebidos
    li a7, 8 # system call para input string
    ecall

    la t1, buffer # ponteiro para a matricula recebida
    addi t1, t1, 1 # Pula o 1
    li t0, 0 # t0 inicializa com 0
    li t2, 8 # contador de 8 dígitos
conv_loop:
    lb t3, 0(t1) # t3 recebe o numero no digito t1
    addi t3, t3, -48  # tira 48 pois na tabela ascii é a diferença do texto pro numero real
    slli t0, t0, 4 # movimenta o t0 4 bits pra esquera
    or t0, t0, t3 # adiciona em t0 o valor real de t3
    addi t1, t1, 1 # encrementa o t1 em 1
    addi t2, t2, -1 # decrementa o t2, contador, em 1
    bnez t2, conv_loop # se não for /0 continua no loop

    beqz t0, encerrar # se toda a matrícula for 0 finaliza o programa

    la s0, lista_matriculas # ponteiro para matrículas
    la s1, lista_nomes # ponteiro para nomes
    li s2, 0 # contador de índice (0 a 69)
    li s3, 70 # limite

busca_loop:
    lw t4, 0(s0) # carrega matrícula da lista
    beq t0, t4, encontrada  # se for igual vai para o print
    
# se não for igual vem para pula_nome
pula_nome:
    lb t5, 0(s1) # recebe a letra do nome no indice s1
    addi s1, s1, 1 # encrementa s1 em 1
    bnez t5, pula_nome # enquanto não achar o '\0', continua andando
    
    addi s0, s0, 4 # próxima matrícula, 4 bytes depois
    addi s2, s2, 1 # i++
    blt s2, s3, busca_loop # volta pro loop

# caso não encontre
    la a0, msg_enc # guarda em a0 a msg_enc
    li a7, 4 # system call para print string
    ecall # chama o sistema
    mv a0, t0 # a0 recebe t0 (matricula)
    li a7, 34 # system call pra hexadecimal
    ecall # chama o sistema
    la a0, msg_nao_enc # guarda em a0 a msg_nao_enc
    li a7, 4 # system call para print string
    ecall # chama o sistema
    j loop_principal # volta pro loop_principal
    # No fim irá printar: "A matricula {matricula} nao foi encontrada"

encontrada:
    # verifica se é minha matírcula
    lw t6, minha_matr_bcd
    beq t0, t6, sou_eu_print # pula para sou_eu_print

    la a0, msg_enc # carrega em a0 a msg_enc
    li a7, 4 # system call para print string
    ecall # chama o sistema
    mv a0, t0 # a0 recebe t0 (matricula)
    li a7, 34 # system call para print hexadecimal
    ecall # chama o sistema
    la a0, msg_corresp # carrega em a0 msg_corresp
    li a7, 4 # system call para print string
    ecall # chama o sistema
    mv a0, s1 # a0 recebe s1 (nome do aluno)
    li a7, 4 # system call para print string
    ecall # chama o sistema
    j loop_principal # volta pro loop_principal
    # No fim irá printar: "A matricula {matricula} corresponde ao aluno {aluno}"

sou_eu_print:
    la a0, msg_sou_eu # carrega em a0 a msg_sou_eu
    li a7, 4 # system call para print string
    ecall # chama o sistema
    mv a0, s1 # a0 recebe s1 (nome do aluno)
    li a7, 4 # system call para print string
    ecall # chama o sistema
    la a0, msg_e_tenho
    li a7, 4 # system call para print string
    ecall # chama o sistema
    mv a0, t0 # a0 recebe t0 (matricula)
    li a7, 34 # system call para print hexadecimal
    ecall # chama o sistema
    j loop_principal # volta pro loop principal
    # No fim irá printar "Sou eu! Eu sou {aluno}, e tenho matricula {matricula}"

encerrar:
    li a7, 10 # system call para finalizar o programa
    ecall # chama o sistema
