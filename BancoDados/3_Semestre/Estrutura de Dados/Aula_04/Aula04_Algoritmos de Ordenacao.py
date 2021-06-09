## Lista Ordenada Seleção 

def ordenacao_selecao(lista):
    for i in range(len(lista)):
        indice_menor = i
        for j in range(i+1, len(lista)):
            if lista[j] < lista[indice_menor]:
                indice_menor = j
        temp = lista[indice_menor]
        lista[indice_menor] = lista[i]
        lista[i] = temp

##Lista Ordenada Bubble Sort
def ordenacao_bolha(lista):
    for i in range(0, len(lista)): # repetimos o processo len(lista) vezes
        for j in range(1, len(lista)-i):
            # a cada repeticao do processo, comparamos lista[j-1] com lista[j] at ́e o final da sublista nao-ordenada
            if lista[j-1] > lista[j]:
                temp = lista[j-1]
                lista[j-1] = lista[j]
                lista[j] = temp

##Bubble Sort Melhorado
def ordenacao_bolha(lista):
    houveTroca = True # inicializa a flag para for ̧car a primeira execu ̧c~ao do while
    i = 0
    while i < len(lista) and houveTroca:
        houveTroca = False # marca a flag como falsa, pois se n~ao houve troca a lista estar ́a ordenada
        for j in range(1, len(lista)-i):
            if lista[j-1] > lista[j]:
                temp = lista[j-1]
                lista[j-1] = lista[j]
                lista[j] = temp
                houveTroca = True # se houve troca, a flag  ́e marcada como verdadeira e o while ser ́a executado mais uma vez
    i += 1


#Programa Principal
lista = [61, 45, 12, 5, 7, 6, 87, 9, 33, 11]
print('Lista Original: ',lista)
""" 
ordenacao_selecao(lista)
print('Lista Ordenada por Seleção: ', lista) 
"""
ordenacao_bolha(lista)
print('Lista Ordenada por Bubble sort: ', lista) 
