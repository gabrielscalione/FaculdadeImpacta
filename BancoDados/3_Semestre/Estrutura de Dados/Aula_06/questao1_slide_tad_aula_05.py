import math

class Ponto:

	def __init__(self, x=0, y=0):
		self.x = x   # criação do atributo x
		self.y = y   # criação do atributo y

	def obter_coordenadas(self):
		return '(' + str(self.x) + ', ' + str(self.y) + ')'
	
	def igual(self, p):
		return (self.x == p.x) and (self.y == p.y)
	
	def distancia(self, p):
		"""
		self.x e self.y representam o ponto (x1, y1)
		p.x e p.y representam o ponto (x2, y2)
		"""
		somatorio = (p.x - self.x)**2 + (p.y - self.y)**2
		d = math.sqrt(somatorio)
		return d

	def transladar(self, dx, dy):
		self.x = self.x + dx
		self.y = self.y + dy

# Programa principal:
p1 = Ponto(3, 4)
p2 = Ponto(5, 6)
print(p1.obter_coordenadas())
print(p2.obter_coordenadas())
print('Distância entre p1 e p2:', p1.distancia(p2))
p1.transladar(2, -1)
print('p1 após ser transladado:', p1.obter_coordenadas())