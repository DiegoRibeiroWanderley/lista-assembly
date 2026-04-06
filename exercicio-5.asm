.data
    n: .word 5 # n
    s: .word 4 # s
    COMB: .word 0 # resultado COMB da combinação
    
.text
main:
    lw s1, n # carrega em s1 o valor de n
    lw s2, s # carrega em s2 o valor de s
    
    blt s1, zero, n_ou_s_menor_0  # se s1 ou
    blt s2, zero, n_ou_s_menor_0  # s2 menor que zero, pula pra n_ou_s_menor_0
    beq s1, zero, n_ou_s_0 # se s1 ou        
    beq s2, zero, n_ou_s_0 # ou s2 igual a zero, pula pra n_ou_s_0       
    beq s1, s2, n_igual_s # se s1 igual a s2, pula pra n_igual_s        
    bgt s2, s1, s_maior_n  # se s2 maior que s1, pula pra s_maior_n  
    
    li a1, 0 # a1 = 0                     
    j n_fatorial # pula pra n_fatorial

s_maior_n:
    li a1, 1 # a1 = 1
    j saida # pula pra saida

n_ou_s_menor_0:
    li a1, 2 # a1 = 2
    j saida # pula pra saida
        
n_igual_s:
    li a1, 3 # a1 = 3
    j saida # pula pra saida
    
n_ou_s_0:
    li a1, 4 # a1 = 4
    j saida # pula pra saida

n_fatorial:
    mv a0, s1 # a0 = s1
    jal fatorial # pula pra fatorial e volta
    mv s3, a0  # s3 = a0

s_fatorial:
    mv a0, s2 # a0 = s2
    jal fatorial # pula pra fatorial e volta
    mv s4, a0 # s4 = s0
    
n_menos_s_fatorial:
    sub a0, s1, s2 # a0 = s1 - s2
    jal fatorial # pula pra fatorial e volta
    mv s5, a0  # s5 = a0       
    
combinacao:
    mul t1, s4, s5  # multiplica s4 e s5 e guarda em t1 # (s! * (n - s)!)  
    div t1, s3, t1  # divide s3 por t1 e guarda em t1 (n! / (s! * (n - s)!))   
    
guardar:
    la t0, COMB # ponteiro pra COMB
    sw t1, 0(t0) # carrega em COMB o valor de t1
    j saida # pula pra saida          

fatorial:
    li t0, 1 # guarda em t0 o valor 1         
    mv t1, a0 # guarda em t1 o valor de a0
            
loop_fatorial:
    ble t1, zero, fim_fatorial # se t1 <= zero finaliza o fatorial
    mul t0, t0, t1 # multiplica t0 por t1
    addi t1, t1, -1 # decresce t1 em 1
    j loop_fatorial # repete o loop 
          
fim_fatorial:
    mv a0, t0 # guarda em a0 o valor de t0
    jr ra # volta pro jal            

saida:
    li a7, 10 # system call pra finalizar o programa
    ecall # chama o sistema
