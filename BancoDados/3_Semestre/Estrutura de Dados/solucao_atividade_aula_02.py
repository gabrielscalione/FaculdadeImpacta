"""
Solução da atividade de presença da aula 02.

ATIVIDADE:
Calcule o número de passos do algoritmo abaixo.
	- Quantas operações aritméticas? (oa)
    - Quantas comparações lógicas? (cl)
    - Quantas atribuições? (at)
    
    - Quantas operações ao todo?

"""

# Vamos considerar n = len(lista); ou seja, n é o comprimento (tamanho) da lista.
def soma_lista(lista):
	soma = 0       # 1 (at)
	i = 0          # 1 (at)
	while i < len(lista):   # n+1 (cl)
		soma += lista[i]    # n (at);    n (oa)
		i += 1              # n (at);    n (oa)
	return soma     # 1 (at)

# Qtd operações aritméticas: n + n = 2n
# Qtd comparações lógicas: n+1
# Qtd atribuções: n + n + 3 = 2n + 3
# Total de operações: 2n + n + 1 + 2n + 3 = 5n + 4
# Então, o algoritmo acima é O(n).

# Exemplo: se a lista tem comprimento 10, então teremos: 5*(10) + 4 = 54 operações ao todo.
# Exemplo 2: se a lista tem comprimento 5, então teremos: 5*(5) + 4 = 29 operações ao todo.

# Programa principal (utilize para comprovar os cálculos acima variando o tamanho da lista!)
numeros = [2, 5, 9, 1, 3]
resultado = soma_lista(numeros)
print('Soma total:', resultado)
