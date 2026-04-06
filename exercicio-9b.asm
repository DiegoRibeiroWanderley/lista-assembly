.data
    i: .word 10 # i
    A: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 # vetor A
    
.text
main:
    li t0, 0            # i = 0
    lw t1, i            # t1 = 9
    la s0, A            # ponteiro pra A
    li s1, 2            # s1 = 2

loop:
    bge t0, t1, fim # se t0 >= t1, vai pra fim
    
    slli t3, t0, 2 # guarda em t3 o deslocamento no vetor     
    add  t4, s0, t3 # guarda em t4 o endereço de s0 mais o deslocamento
    lw   t5, 0(t4) # carrega em t5 o valor do vetor no indice i em A

    rem  t2, t0, s1 # guarda o resto da divisão de t0 e s1 em t2
    beq  t2, zero, if # se t2 == 0, ele entra no if

else:
    mul  t5, t5, s1 # multiplica t5 por 2 
    sw   t5, 0(t4) # salva o valor em A     
    j    proximo # pula pra proximo

if:
    lw   t6, 4(t4) # valor depois do elemento do vetor atual
    add  t5, t5, t6 # soma A[i] com A[i + 1]   
    sw   t5, 0(t4) # guarda no indice repectivo no vetor A     

proximo:
    addi t0, t0, 1 # i++     
    j    loop # volta pro loop
    
fim:
    li a7, 10 # system call pra finalizar o programa
    ecall # chama o sistema
