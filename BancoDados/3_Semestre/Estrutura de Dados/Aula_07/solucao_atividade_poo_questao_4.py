
class Aluno:

	def __init__(self, nome):
		self.nome = nome
		self.tempo_sem_dormir = 0
	
	def estudar(self, horas):
		self.tempo_sem_dormir += horas
	
	def dormir(self, horas):
		self.tempo_sem_dormir -= horas

# Programa principal:
aluno1 = Aluno('Renato')
aluno2 = Aluno('Pedro')
aluno1.estudar(3)
aluno1.dormir(2)
aluno1.estudar(4)
aluno1.dormir(2)
aluno2.estudar(7)
aluno2.dormir(5)
aluno2.estudar(4)

# A instrução abaixo deve imprimir: "O aluno Renato está 3 horas sem dormir"
print('O aluno', aluno1.nome, 'está', aluno1.tempo_sem_dormir,'horas sem dormir')

# A instrução abaixo deve imprimir: "O aluno Pedro está 6 horas sem dormir"
print('O aluno', aluno2.nome, 'está', aluno2.tempo_sem_dormir,'horas sem dormir')
