class Aluno:

	def __init__(self, ra, nome, data_nasc):
		self.ra = ra
		self.nome = nome
		self.data_nasc = data_nasc

	def dados_aluno(self):
		print('Dados do aluno:')
		print('  RA:', self.ra)
		print('  Nome:', self.nome)
		print('  Data de nascimento:', self.data_nasc)

# Programa principal:
aluno1 = Aluno(12345, "João", "12/03/1999")
aluno2 = Aluno(202133, "José", "11/11/2002")
aluno3 = Aluno(22334, "Maria", "09/01/1991")
aluno1.dados_aluno()
aluno2.dados_aluno()
aluno3.dados_aluno()