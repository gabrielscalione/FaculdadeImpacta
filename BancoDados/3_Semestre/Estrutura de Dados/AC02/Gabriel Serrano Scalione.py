# NÃO REMOVA OS IMPORTS NEM EDITE OS COMANDOS ABAIXO:
import hashlib
from io import StringIO
import sys
import re
import unicodedata
import inspect
if __name__ != '__main__': # NÃO EDITE ESSA LINHA
	input = lambda x: 10 # NÃO EDITE ESSA LINHA
"""
O código acima serve para testar o seu programa. Alterá-lo prejudicará
a correção da sua atividade e consequentemente a sua nota! 
"""
## ===================================================================
## ===================================================================

# INFORME SEUS DADOS (como string nas variáveis a seguir):
NUMERO_RA = "1903812"
NOME_COMPLETO = "Gabriel Serrano Scalione"
# OBS: Não informar seus dados corretamente implicará em nota 0.0 (zero)!

# CONSTRUA O SEU PROGRAMA A PARTIR DAQUI:

def busca_binaria(lista, alvo):
    pass # Implemente a função
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










## ===================================================================
## ===================================================================
# NÃO EDITE O CÓDIGO A PARTIR DESTE PONTO:
"""
O código abaixo serve para testar o seu programa. Alterá-lo prejudicará
a correção da sua atividade e consequentemente a sua nota! 
"""
def formata_saida(s):
	s = ''.join(c for c in unicodedata.normalize('NFD', s)
    		if unicodedata.category(c) != 'Mn') # remove acentos
	s = re.sub('\s+', '', s)
	return s.upper()
				  
def getHash(s):
	s = formata_saida(s)
	return hashlib.sha1(s.encode('utf-8')).hexdigest()

if __name__ == '__main__':
	print('\n')
	print("="*50)
	print("Executando os testes automatizados: ")
	print("="*50)
	ok, fail = 0, 0
	lista1 = ["Bach", "Beethoven", "Chopin", "Liszt", "Mozart", "Ravel", "Schubert", "Villa-Lobos"]
	lista2 = [1, 2, 3, 4, 5]
	lista3 = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100, 101]
	TESTS = {"caso1":(lista1, "Chopin"), "caso2":(lista1, 'Ravel'), "caso3":(lista1, 'Stravinsky'),
	"caso4":(lista2, 3), "caso5":(lista2, 6), "caso6":(lista3, 99), "caso7":(lista3, 50), "caso8":(lista3, 51) }
	for testname in TESTS:
		OLD_STDOUT = sys.stdout
		sys.stdout = NEW_STDOUT = StringIO()
		try:
			lista_teste, alvo_teste = TESTS[testname]
			resultado_teste = busca_binaria(lista_teste, alvo_teste)
		except:
			pass
		sys.stdout = OLD_STDOUT
		saida = NEW_STDOUT.getvalue().strip()
		try:
			assert type(NUMERO_RA) is str and NUMERO_RA != ''
			assert type(NOME_COMPLETO) is str and NOME_COMPLETO != ''
		except AssertionError:
			print('O número de matrícula ou o nome não foram preenchidos ou não são do tipo string!')
			break
		try:
			print('Executando o teste: {0} ... '.format(testname), end='')
			if testname == 'caso1':
				assert getHash(saida) == '50cb72a0d676061cb277f25dd9094bcde4b5ab4c'
			elif testname == 'caso2':
				assert getHash(saida) == 'a25b1658314722e543683d6a44d2bcf0e1b3c073'
			elif testname == 'caso3':
				assert getHash(saida) == '40db7f29751142517125fa11f1f45a52d81f429d'
			elif testname == 'caso4':
				assert getHash(saida) == '632667547e7cd3e0466547863e1207a8c0c0c549'
			elif testname == 'caso5':
				assert getHash(saida) == '5f17af19d69540aa3c0c8040f27db45f23eeb970'
			elif testname == 'caso6':
				assert getHash(saida) == 'edcb7396ba55840a34076eb5422331ef7c8093fa'
			elif testname == 'caso7':
				if type(resultado_teste) is not bool:
					assert False
			elif testname == 'caso8':
				if type(resultado_teste) is not bool:
					assert False
			else:
				assert False
		except AssertionError:
			fail += 1
			print('FALHOU!')
		else:
			ok += 1
			print('Ok!')
	print(' > Resultado:   Passou em: {0} teste(s)   /  Falhou em: {1} teste(s)'.format(ok, fail))

