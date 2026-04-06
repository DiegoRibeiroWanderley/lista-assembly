addi t0, x0, 3 # Guarda 3 em t0
addi t1, x0, 51 # Guarda 49 em t1
addi t2, x0, 0 # Guarda 0 em t2

addi t3, x0, 50 # Guarda 50 em t3 para comparação

blt t0, x0, else_block # Verifica se t0 menor que 0, se sim vai pro else
bgt t1, t3, else_block # Verifica se t1 menor que 50(t3), se sim vai pro else

addi t2, x0, 1 # Se true t2 recebe 1

else_block: # Se false acaba o programa