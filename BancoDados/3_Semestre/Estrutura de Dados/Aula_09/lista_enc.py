class ListaEnc:

	# Início do TAD que implementa um nó
	class No:
		def __init__(self, dado, prox):
			self.dado = dado
			self.prox = prox
	# Fim do TAD que implementa um nó
	
	def __init__(self):
		self.cabeca = None
		self.ultimo = None
		self.tamanho = 0
	
	# Implementa o acesso ao tamanho da lista através da função len()
	def __len__(self):
		return self.tamanho
	
	# Representação como string da lista. Permite utilizar a instrução print com o objeto lista: print(lista)
	def __repr__(self):
		s = '['
		no_atual = self.cabeca
		while no_atual != None:
			if no_atual.prox == None: # testa se já está no último nó
				s += str(no_atual.dado)
			else:
				s += str(no_atual.dado) + ', '
			no_atual = no_atual.prox
		s += ']'
		return s
	
	# Implementa o acesso de um item pelo seu índice: lista[0], lista[1], ..., etc.
	# Também suporta índices negativos: lista[-1], lista[-2], ..., etc.
	def __getitem__(self, posicao):
		if posicao < 0:  # permite índices negativos
			posicao = self.tamanho + posicao 
		if not (posicao >= 0 and posicao < self.tamanho):
			raise IndexError('Índice fora do intervalo!')
		cont = 0
		no_atual = self.cabeca
		while cont < posicao and no_atual != None:
			no_atual = no_atual.prox
			cont += 1
		return no_atual.dado
	
	def append(self, item):
		novo_no = self.No(item, None)
		if self.cabeca == None:
			self.cabeca = novo_no
		else:
			self.ultimo.prox = novo_no
		self.ultimo = novo_no
		self.tamanho += 1
	
	def insert(self, posicao, item):
		cont = 0
		no_ant = self.cabeca
		no_prox = self.cabeca
		while cont < posicao and no_prox != None:
			no_ant = no_prox
			no_prox = no_prox.prox
			cont += 1
		novo_no = self.No(item, None)
		if self.cabeca == None: # caso especial da lista estar vazia
			self.cabeca = novo_no
			self.ultimo = novo_no
		elif no_prox == None: # se no_prox é None, deve adicionar no final da lista
			no_ant.prox = novo_no
			self.ultimo = novo_no
		else: # adiciona entre 2 nós já existentes
			novo_no.prox = no_prox
			if cont == 0: # caso especial para adicionar no início da lista quando ela não está vazia
				self.cabeca = novo_no
			else:
				no_ant.prox = novo_no
		self.tamanho += 1
	
# Programa principal:
lista = ListaEnc()
print('Comprimento da lista:', len(lista))
lista.append(3)
lista.append(10)
lista.append(5)
lista.append(8)
lista.insert(2, 22)
print('Comprimento da lista:', len(lista))
print(lista)
for i in range(len(lista)):
	print('Índice', i, ' => ', lista[i])
print('Testando índice negativo:', lista[-1])
print('Testando índice negativo:', lista[-2])
