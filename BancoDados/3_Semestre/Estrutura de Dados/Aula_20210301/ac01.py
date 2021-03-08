

# Escreva a funcao lista_esta_ordenada(lista) abaixo:
def lista_esta_ordenada(lista):
    i=0
    tamanho = len(lista)
    ordenada = True
    while i < tamanho:
        for j in range(i):
            if lista[j] <= lista[i]:
                ordenada = True
            elif lista[j] > lista[i]:
                return False
        i = i + 1
    return ordenada
            

# Programa principal: NAO altere o codigo abaixo. Ele serve apenas para testar a sua funcao.

def main():
	sequencia = [1, 3, 9, 5, 7]
	resultado = lista_esta_ordenada(sequencia)
	print(str(resultado))
main()