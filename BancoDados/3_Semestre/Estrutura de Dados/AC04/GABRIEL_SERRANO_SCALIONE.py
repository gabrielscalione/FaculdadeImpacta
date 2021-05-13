import sys
from io import StringIO
import re
import unicodedata
import traceback
if __name__ != '__main__': # NÃO EDITE ESSA LINHA
	input = lambda x: 10  # NÃO EDITE ESSA LINHA
"""
O código acima serve para testar o seu programa. Alterá-lo prejudicará
a correção da sua atividade e consequentemente a sua nota! 
"""
## ===================================================================
## ===================================================================

# INFORME SEUS DADOS (como string nas variáveis a seguir):
NUMERO_RA = "1903812"
NOME_COMPLETO = "GABRIEL SERRANO SCAIONE"
# OBS: Não informar seus dados corretamente implicará em nota 0.0 (zero)!

# CONSTRUA O SEU PROGRAMA A PARTIR DAQUI:

class ListaSimplificada:

	# Início da classe interna: No
	class No:
		def __init__(self, dado, prox):
			# Método já implementado. Você não precisa fazer nada aqui.
			self.dado = dado
			self.prox = prox
	# Fim da classe interna: No

	def __init__(self):
		# Método já implementado. Você não precisa fazer nada aqui.
		self.cabeca = None
		self.ultimo = None
		self.tamanho = 0
	
	def imprime_lista(self):
		# Método já implementado. Você não precisa fazer nada aqui.
		s = '['
		no_atual = self.cabeca
		while no_atual != None:
			if no_atual.prox == None:
				s += str(no_atual.dado)
			else:
				s += str(no_atual.dado) + ', '
			no_atual = no_atual.prox
		s += ']'
		print(s)
	
	def append(self, item):
		# Método já implementado. Você não precisa fazer nada aqui.
		novo_no = self.No(item, None)
		if self.cabeca == None: # se a lista estiver vazia, adiciona no início
			self.cabeca = novo_no
		else: # se a lista não for vazia, adiciona no fim
			self.ultimo.prox = novo_no
		self.ultimo = novo_no  # atualiza a referência para o último nó
		self.tamanho += 1

	def adicionar_na_frente(self, item):
		novo_no = self.No(item, None)
		novo_no.prox = self.cabeca
		self.cabeca = novo_no
		self.tamanho += 1

	def count(self, alvo):
		no_atual = self.cabeca
		conta_alvo = 0
		while no_atual != None:
			if no_atual.dado == alvo:
				conta_alvo += 1
			no_atual = no_atual.prox
		
		return conta_alvo



# Programa principal sugerido para chamar a sua função e testar o seu código.
# Você pode alterá-lo se desejar, mas isso não é obrigatório.
def programa_principal():
	lista = ListaSimplificada()
	lista.append(2)
	lista.append(3)
	lista.append(7)
	lista.imprime_lista()  # imprime [2, 3, 7]
	lista.adicionar_na_frente(7)
	lista.imprime_lista()  # deve imprimir [7, 2, 3, 7]
	print(lista.count(5))  # deve imprimir 0, pois não existe ocorrência de 5 na lista
	print(lista.count(7))  # deve imprimir 2, pois existem duas ocorrências de 7 na lista
	lista.imprime_lista()  # deve continuar imprimindo [7, 2, 3, 7]
programa_principal()









## ===================================================================
## ===================================================================
# NÃO EDITE O CÓDIGO A PARTIR DESTE PONTO:
"""
O código abaixo serve para testar o seu programa. Alterá-lo prejudicará
a correção da sua atividade e consequentemente a sua nota! 
"""

if __name__ == '__main__': # NÃO EDITE ESSA LINHA

	class ListaSimilar:

		class No:
			def __init__(self, dado, prox):
				self.dado = dado
				self.prox = prox

		def __init__(self):
			self.cabeca = None
			self.ultimo = None
			self.tamanho = 0

		def imprime_lista(self):
			pass

		def append(self, item):
			pass

		def adicionar_na_frente(self, item):
			pass

		def count(self, alvo):
			pass


	def check_atributos_metodos(classe):
		instancia = classe()
		instancia_referencia = ListaSimilar()
		atributos = list(instancia.__dict__.keys())
		metodos = [m for m in dir(instancia) if m not in atributos]
		atributos_referencia = list(instancia_referencia.__dict__)
		metodos_referencia = [m for m in dir(instancia_referencia) if m not in atributos]
		if sorted(metodos) != sorted(metodos_referencia):
			print('Erro: não altere os métodos da classe e não crie novos métodos além dos já disponibilizados!')
			return False
		if sorted(atributos) != sorted(atributos_referencia):
			print('Erro: não modifique os atributos da classe e não crie novos atributos além dos já disponibilizados!')
			return False
		return True

	def checks_iniciais(nome, ra):
		if (type(nome) is str) and (type(ra) is str) and nome.strip() != '' and ra.strip() != '':
			if ra.isnumeric():
				return True
			else:
				print('Erro: RA inválido ou o NOME_COMPLETO e NUMERO_RA estão invertidos!')
		else:
			print('Erro: O número de matrícula ou o nome não foram preenchidos ou não são do tipo string!')
		return False

	def lista_enc_para_string(instancia_lista_enc):
		s = '['
		no_atual = instancia_lista_enc.cabeca
		while no_atual != None:
			if no_atual.prox == None:
				s += str(no_atual.dado)
			else:
				s += str(no_atual.dado) + ', '
			no_atual = no_atual.prox
		s += ']'
		return s

	def executa_teste(cod_teste, classe):
		if cod_teste == 't1':
			try:
				instancia = classe()
				instancia.adicionar_na_frente(10)
				if instancia.cabeca.dado == 10 and instancia.cabeca.prox == None and instancia.tamanho == 1:
					return True
				else:
					return False
			except:
				return False
		elif cod_teste == 't2':
			try:
				instancia = classe()
				# No 1
				instancia.cabeca = ListaSimilar.No(3, None)
				instancia.ultimo = instancia.cabeca
				instancia.tamanho += 1
				futuro_segundo_no = instancia.cabeca
				# No 2
				novo_no = ListaSimilar.No(10, None)
				instancia.ultimo.prox = novo_no
				instancia.ultimo = novo_no
				instancia.tamanho += 1
				# No 3
				novo_no = ListaSimilar.No(27, None)
				instancia.ultimo.prox = novo_no
				instancia.ultimo = novo_no
				instancia.tamanho += 1
				# Adiciona na frente
				instancia.adicionar_na_frente(15)
				if instancia.cabeca.dado == 15 and instancia.cabeca.prox == futuro_segundo_no and instancia.tamanho == 4:
					return True
				else:
					return False
			except:
				return False
		elif cod_teste == 't3' or cod_teste == 't4':
			try:
				instancia = classe()
				# No 1
				instancia.cabeca = ListaSimilar.No(3, None)
				instancia.ultimo = instancia.cabeca
				futuro_segundo_no = instancia.cabeca
				# No 2
				novo_no = ListaSimilar.No(10, None)
				instancia.ultimo.prox = novo_no
				instancia.ultimo = novo_no
				# No 3
				novo_no = ListaSimilar.No(27, None)
				instancia.ultimo.prox = novo_no
				instancia.ultimo = novo_no
				# Testa count
				if cod_teste == 't3':
					resultado = instancia.count(12)
					if resultado == 0 and lista_enc_para_string(instancia) == '[3, 10, 27]':
						return True
					else:
						return False
				elif cod_teste == 't4':
					resultado = instancia.count(27)
					if resultado == 1 and lista_enc_para_string(instancia) == '[3, 10, 27]':
						return True
					else:
						return False
			except:
				return False
		elif cod_teste == 't5':
			try:
				instancia = classe()
				# No 1
				instancia.cabeca = ListaSimilar.No(74, None)
				instancia.ultimo = instancia.cabeca
				futuro_segundo_no = instancia.cabeca
				# No 2
				novo_no = ListaSimilar.No(74, None)
				instancia.ultimo.prox = novo_no
				instancia.ultimo = novo_no
				# No 3
				novo_no = ListaSimilar.No(74, None)
				instancia.ultimo.prox = novo_no
				instancia.ultimo = novo_no
				# Testa count
				resultado = instancia.count(74)
				if resultado == 3 and lista_enc_para_string(instancia) == '[74, 74, 74]':
					return True
				else:
					return False
			except:
				return False

	def run(**kwargs):
		nome = kwargs.get('nome')
		ra = kwargs.get('ra')
		classe = kwargs.get('classe')
		print('\n')
		print("="*50)
		print("Executando os testes automatizados: ")
		print("="*50)
		if not (checks_iniciais(nome, ra) and (check_atributos_metodos(classe))):
			return
		try:
			acertos, erros = 0, 0
			dict_testes = {
				't1':'Método adicionar_na_frente(item) quando a lista está vazia',
				't2':'Método adicionar_na_frente(item) quando a lista não está vazia',
				't3':'Método count(alvo) - primeiro teste',
				't4':'Método count(alvo) - segundo teste',
				't5':'Método count(alvo) - terceiro teste',
			}
			for cod_teste in dict_testes:
				print('Executando o teste: "{0}" ... '.format(dict_testes[cod_teste]), end='')
				if executa_teste(cod_teste, classe):
					acertos += 1
					print('OK!')
				else:
					erros += 1
					print('FALHOU!')
			print(' > Resultado:   Passou em: {0} teste(s)   /  Falhou em: {1} teste(s)'.format(acertos, erros))
		except:
			traceback.print_exc()
	run(nome=NOME_COMPLETO, ra=NUMERO_RA, classe=ListaSimplificada)

