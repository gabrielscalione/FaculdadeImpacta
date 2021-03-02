# Busca Binaria em uma lista  => log2n
# Essa solução aplica-se somenta a listas previamente ordenada
def busca_binaria(lista, alvo):
    inicio = 0                      # primeiro  ́ındice da lista
    fim = len(lista)-1              #  ́ultimo  ́ındice da lista
    while inicio <= fim:
        meio = (inicio + fim) // 2  # divis~ao inteira, pois os  ́ındices da lista s~ao n ́umeros inteiros
        if alvo == lista[meio]:
            return True
        elif alvo > lista[meio]:
            inicio = meio + 1       # o novo in ́ıcio da busca passa a ser o pr ́oximo elemento ap ́os o meio
        else:                       # se alvo < lista[meio]
            fim = meio - 1          # o novo fim da busca passa a ser o elemento anterior ao meio
    return False                    # devolve False caso n~ao encontre o alvo na lista






#Programa Principal
numeros = [5, 11, 13, 33, 61]
resultado = busca_binaria(numeros, 33)
print('Resultado: ', resultado)
