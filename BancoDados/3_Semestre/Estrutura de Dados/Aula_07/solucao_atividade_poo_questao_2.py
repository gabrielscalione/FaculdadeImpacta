
class Retangulo:

	def __init__(self, lado_a, lado_b):
		self.lado_a = lado_a
		self.lado_b = lado_b
	
	def calcular_area(self):
		area = self.lado_a * self.lado_b
		return area
	
	def calcular_perimetro(self):
		perimetro = (2 * self.lado_a) + (2 * self.lado_b)
		return perimetro

# Programa principal:
comprimento = float(input('Informe o comprimento do retângulo: '))
largura = float(input('Informe a largura do retângulo: '))
ret = Retangulo(comprimento, largura)
print('Área do retângulo:', ret.calcular_area())
print('Perímetro do retângulo:', ret.calcular_perimetro())
