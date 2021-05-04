class PilhaEnc:

	# Início da definição da classe NoPilha
	class NoPilha:

		def __init__(self, dado, prox):
			self.dado = dado
			self.prox = prox
	# Fim da definição da classe NoPilha

	def __init__(self):
		self.cabeca = None
		self.tamanho = 0

	def is_empty(self):
		return self.tamanho == 0

	def push(self, item):
		novo_no = self.NoPilha(item, self.cabeca) # acrescentamos o novo item sempre no início da lista encadeada
		self.cabeca = novo_no    # muda a referência da cabeça para o novo nó
		self.tamanho += 1

	def top(self):
		if self.is_empty():
			raise Exception('Pilha vazia')
		return self.cabeca.dado

	def pop(self):
		if self.is_empty():
			raise Exception('Pilha vazia')
		dado = self.cabeca.dado
		self.cabeca = self.cabeca.prox  # removemos o item sempre do início da lista encadeada
		self.tamanho -= 1
		return dado

	def __len__(self):
		return self.tamanho


# Programa principal:
p = PilhaEnc()
print('Tamanho da pilha:', len(p))
p.push('Maria')
p.push('Fernando')
p.push('Fabio')
print('Tamanho da pilha:', len(p))
print('Valor no topo:', p.top())
while not p.is_empty():
	print('Desempilhando:', p.pop())
print('Tamanho da pilha:', len(p))
