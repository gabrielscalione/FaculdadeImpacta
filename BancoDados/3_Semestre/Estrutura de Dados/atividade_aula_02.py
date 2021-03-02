"""


ATIVIDADE:
Calcule o número de passos do algoritmo abaixo.
	- Quantas operações aritméticas? (oa)
    - Quantas comparações lógicas?   (cl)
    - Quantas atribuições?           (at)
    
    - Quantas operações ao todo?

"""

#Vamos considerar n = len(lista); ou seja, n é o comprimento (tamanho)
def soma_lista(lista):
	soma = 0				# 1 at
	i = 0					# 1 at
	while i < len(lista):   # n + 1 (cl)
		soma += lista[i]	# n (at);    n(oa)
		i += 1				# n (at);    n(oa)
	return soma

# Qtd Operações: n + n = 2n
# Qtd Comparações:  n + 1
# Qtd Atribuições: n + n + = 2n + 3
# Total de operacoes: 2n + n + 1 + 2n + 3 = 5n + 4
#Exemplo 2: se a lista tem comprimento 5, então teremos 5*(5) + 4 = 29 operações ao todo.
# Então, o algorimo acima é O(n)




# Programa principal
numeros = [2, 5, 9, 1, 3]
resultado = soma_lista(numeros)
print('Soma Total:', resultado)