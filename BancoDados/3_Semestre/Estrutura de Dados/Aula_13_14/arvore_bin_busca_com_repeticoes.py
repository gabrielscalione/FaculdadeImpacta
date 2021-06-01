class ArvoreBinBusca:

	# Início da classe que implementa um nó da árvore binária
	class NoArv:
		def __init__(self, dado, esquerdo=None, direito=None):
			self.dado = dado
			self.qtd = 1
			self.esq = esquerdo
			self.dir = direito
	# Fim da classe que implementa um nó da árvore binária

	def __init__(self):
		self.raiz = None
		self.qtd_nos = 0
		self.niveis = 0

	def inserir(self, item):
		nivel_atual = 1
		if self.raiz == None:    # se a árvore está vazia, crie a raiz
			self.raiz = self.NoArv(item, None, None)
			self.qtd_nos += 1
			self.niveis = nivel_atual
		else:
			subarv = self.raiz
			inseriu = False
			while not inseriu:
				nivel_atual += 1
				if item == subarv.dado:   # encontrou o item, então sai do método sem inserir
					subarv.qtd += 1
					inseriu = True
				elif item < subarv.dado:  # se item < subarv.dado, investigue a subárvore esquerda
					if subarv.esq == None:    # se a subárvore esquerda está vazia, insira
						subarv.esq = self.NoArv(item, None, None)
						self.qtd_nos += 1
						self.niveis = nivel_atual
						inseriu = True
					else:
						subarv = subarv.esq   # investigue a subárvore esquerda na próxima iteração
				elif item > subarv.dado:  # se item > subarv.dado, investigue a subárvore direita
					if subarv.dir == None:   # se a subárvore direita está vazia, insira
						subarv.dir = self.NoArv(item, None, None)
						self.qtd_nos += 1
						self.niveis = nivel_atual
						inseriu = True
					else:
						subarv = subarv.dir # investigue a subárvore direita na próxima iteração

	def buscar(self, item):
		subarv = self.raiz
		while subarv != None:     # enquanto a subárvore não for uma lista vazia, faça
			if item == subarv.dado:  # se o item é igual ao nó raiz da subárvore, encontramos! 
				return subarv.qtd
			elif item < subarv.dado:  # se o item é menor que a raiz da subárvore, vá para a subárvore da esquerda
				subarv = subarv.esq
			elif item > subarv.dado:  # se o item é maior que a raiz da subárvore, vá para a subárvore da direita
				subarv = subarv.dir
		return 0

# Programa principal:
ab = ArvoreBinBusca()
dados = [52, 45, 78, 33, 48, 63, 94, 10, 37, 46, 50, 60, 72, 85, 99, 10, 63, 63]
for d in dados:     # insere todos os itens na árvore automaticamente
	ab.inserir(d)
dados = None

# Busca por um alvo qualquer
while True:
	alvo = int(input('Digite um valor para buscar na árvore binária de busca: '))
	print('Ocorrências de', alvo, ':', ab.buscar(alvo))

