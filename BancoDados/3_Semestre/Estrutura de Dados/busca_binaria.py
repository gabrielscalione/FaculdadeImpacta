
def busca_binaria(lista, alvo):
    
    inicio = 0            
    fim = len(lista) - 1
    qtdeComparado = 0
    while inicio <= fim:
        meio = (inicio + fim) // 2
        if alvo == lista[meio]:
            qtdeComparado +=1
            print(lista[meio])
            print(qtdeComparado)
            return True
        elif alvo > lista[meio]:
            qtdeComparado +=1
            print(lista[meio])
            inicio = meio + 1
        else:
            qtdeComparado +=1
            print(lista[meio])
            fim = meio - 1
    print(qtdeComparado)
    return False       


# Programa principal sugerido para chamar a sua função e testar o seu código
# Você pode alterá-lo se desejar, mas isso não é obrigatório.
# Lembrando que a lógica da sua atividade deve estar inteiramente na função pedida!
def programa_principal():
	try:
		lista = [10,20,25,30,40,50,60,70,75,80,90]
		alvo = input('Informe o alvo: ')
		resultado = busca_binaria(lista, alvo)
		if type(resultado) is bool:
			print(alvo, 'existe na lista?', resultado)
		else:
			print('A funcao precisa devolver um valor booleano!')
	except:
		pass
programa_principal()