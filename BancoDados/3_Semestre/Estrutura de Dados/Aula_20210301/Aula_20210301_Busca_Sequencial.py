# Busca exaustiva em uma lista  => O(n)
# Percorre toda a lista até achar o alvo
def busca(lista, alvo):
    i=0
    while i < len(lista):
        if lista[i] == alvo:
            return True
        i = i + 1
    return False


# Busca sequencial em uma lista com sentinela => O(n) melhorado
# O primeiro que ele encontra retorna
def busca_com_sentinela(lista,alvo):
    lista.append(alvo)  # acrescenta alvo ao final da lista
                        # o que desejamos saber é: encontraremos alvo na última posição ou antes dela
    i = 0
    while lista[i] != alvo:
        i += 1
    lista.pop()         #remove alvo do final da lista
    if i == len(lista):
        return False
    else:
        return True




#Programa Principal
numeros = [5, 11, 13, 33, 61]
resultado = busca(numeros, 33)
print('Resultado: ', resultado)

resultado = busca_com_sentinela(numeros, 33)
print('Resultado: ', resultado)
