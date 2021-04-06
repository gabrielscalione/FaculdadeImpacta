# TAD - código utilizandos classe

class Ponto:

    def __init__(self, a, b):
         self .x = a      # criação  do atribuição x
         self .y = b      # criação  do atribuição y

    def obter_coordenadas(self):
        return '(' + str(self.x) + ', ' + str(self.y) + ')'


# Programa principal:
p1 = Ponto(1, 2)
p2 = Ponto(5, 8)
p3 = Ponto(15, 18)

print(p1.obter_coordenadas())
print(p2.obter_coordenadas())
print(p3.obter_coordenadas())

