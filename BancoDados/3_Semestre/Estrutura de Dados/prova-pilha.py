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
p.push('João')
p.push('Pedro')
p.push('Victor')
print(p.top())
p.push('Joana')
p.push('Gabriela')
print(p.pop())
print(p.pop())
p.push('William')
p.push('Ana')
print(p.pop())
print(p.pop())
print(p.pop())
print(p.pop())
print(p.pop())
