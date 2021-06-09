
class Fila:

	def __init__(self):
		self.items = []

	def is_empty(self):
		return len(self.items) == 0

	def enqueue(self, item):
		self.items.append(item)

	def dequeue(self):
		if self.is_empty():
			raise Exception('Erro: fila vazia')
		return self.items.pop(0)

	def first(self):
		if self.is_empty():
			raise Exception('Erro: fila vazia')
		return self.items[0]
	
	def __len__(self):
		return len(self.items)

# Programa principal:
fila = Fila()

fila.enqueue(1)      # enfileira o item 1
fila.enqueue(2)      # enfileira o item 2
fila.enqueue(3)      # enfileira o item 3
fila.enqueue(4)      # enfileira o item 4
print('Fila vazia?', fila.is_empty())       # Testa se a fila está vazia (False)
print('Tamanho da fila:', len(fila))
print('Primeiro elemento:', fila.first())   # Mostra o primeiro elemento da fila sem removê-lo
print('Desenfileirando:', fila.dequeue())      # Desenfileira e imprime o item 1
print('Desenfileirando:', fila.dequeue())      # Desenfileira e imprime o item 2
print('Desenfileirando:', fila.dequeue())      # Desenfileira e imprime o item 3
print('Desenfileirando:', fila.dequeue())      # Desenfileira e imprime o item 4
print('Fila vazia?', fila.is_empty())      # Testa se a fila está vazia (True)
print('Tamanho da fila:', len(fila))
