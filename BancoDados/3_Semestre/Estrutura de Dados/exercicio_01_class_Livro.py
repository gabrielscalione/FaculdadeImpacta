class Livro:

	def __init__(self, titulo, autor, num_paginas):
		self.titulo = titulo
		self.autor = autor
		self.num_paginas = num_paginas

	def dados_livro(self):
		print('Dados do livro:')
		print('  Titulo:', self.titulo)
		print('  Autor:', self.autor)
		print('  Número de páginas:', self.num_paginas)

# Programa principal:
livro1 = Livro("O Senhor dos Anéis - Volume Único", "J.R.R. Tolkien", 1202)
livro2 = Livro("O Código Da Vinci", "Dan Brown", 540)
livro1.dados_livro()
livro2.dados_livro()
