
def busca_binaria(lista, alvo):
	inicio = 0
	fim = len(lista)-1
	contador = 0
	while inicio <= fim:
		meio = (inicio + fim) // 2
		print(lista[meio])
		contador += 1
		if alvo == lista[meio]:
			print(contador)
			return True
		elif alvo > lista[meio]:
			inicio = meio + 1
		else:
			fim = meio - 1
	print(contador)
	return False


def programa_principal():
	try:
		lista = ["Bach", "Beethoven", "Chopin", "Liszt", "Mozart", "Ravel", "Schubert", "Villa-Lobos"]
		alvo = input('Informe o alvo: ')
		resultado = busca_binaria(lista, alvo)
		if type(resultado) is bool:
			print(alvo, 'existe na lista?', resultado)
		else:
			print('A funcao precisa devolver um valor booleano!')
	except:
		pass
programa_principal()
