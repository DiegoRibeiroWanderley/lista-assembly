addi t0, x0, 3 # Guarda 3 em t0
addi t1, x0, 4 # Guarda 4 em t1
addi t2, x0, 10 # Guarda 10 em t2
addi t3, x0, 0 # Guarda 0 em t3

bge t1, t2, else_block # Verifica se t1 é maior ou igual a t2, se sim vai no else
bge t3, t0, else_block # Verifica se t3 é maior ou igual a t0, se sim vai no else

add t3, t1, x0 # Se true t3 recebe o valor de t1
j end_if # finaliza o programa

else_block: # Se false t3 recebe o valor de t2
	add t3, t2, x0

end_if:
