
class Livro:

	def __init__(self, titulo, autor, num_paginas):
		self.titulo = titulo
		self.autor = autor
		self.num_paginas = num_paginas

# Programa principal:
livro1 = Livro("Como programar em Python", "Fulano de Tal", 235)
livro2 = Livro("Banco de Dados", "Esmeri Navathe", 1100)

print('Informações do livro 1:')
print('  Título:', livro1.titulo)
print('  Autor:', livro1.autor)
print('  Núm de págs:', livro1.num_paginas)

print('Informações do livro 2:')
print('  Título:', livro2.titulo)
print('  Autor:', livro2.autor)
print('  Núm de págs:', livro2.num_paginas)
