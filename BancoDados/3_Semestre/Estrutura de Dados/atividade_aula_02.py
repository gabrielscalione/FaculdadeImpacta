"""
Nome completo:
Número do RA:



ATIVIDADE:
Calcule o número de passos do algoritmo abaixo.
	- Quantas operações aritméticas?
    - Quantas comparações lógicas?
    - Quantas atribuições?
    
    - Quantas operações ao todo?

"""


def soma_lista(lista):
	soma = 0
	i = 0
	while i < len(lista):
		soma += lista[i]
		i += 1
	return soma

