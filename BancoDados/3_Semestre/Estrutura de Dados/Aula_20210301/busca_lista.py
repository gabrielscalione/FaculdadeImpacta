def busca(lista, alvo):
    i=0
    while i < len(lista):  #sempre o tamanho da lista é ela menos 1
        if lista[i] == alvo:
            return True
        i = i + 1
    return False




#Programa Principal
numeros = [5, 11, 13, 33, 61, 73, 79, 80, 85]
resultado = busca(numeros, 33)
print('Resultado da busca: ', resultado)