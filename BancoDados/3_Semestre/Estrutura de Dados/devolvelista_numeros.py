# Escreva a funcao devolve_lista_numeros(x, y) abaixo:
def devolve_lista_numeros(x, y):
    lista = []
    z = x
    while z <= y:                
            lista.append(z)
            z = z + 1
    return lista



# PROGRAMA PRINCIPAL: nao altere o codigo a partir deste ponto
def programa_principal():
	a = int(input())
	b = int(input())
	resultado = devolve_lista_numeros(a, b)
	print(resultado)

programa_principal()