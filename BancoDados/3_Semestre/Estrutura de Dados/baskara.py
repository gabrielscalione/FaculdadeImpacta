def raiz(numero):
    raiz_quadrada = numero ** 0.5 # calcula a raiz quadrada usando pot^encia de 1/2
    return raiz_quadrada
# O c ́odigo abaixo apenas usa a fun ̧c~ao para exemplificar melhor:
a = 1
b = -1
c = -6
delta = (b**2) - 4*a*c
x1 = (-b + raiz(delta)) / (2*a)
x2 = (-b - raiz(delta)) / (2*a)
print('Valores de x1 e x2: %.2f e %.2f' % (x1, x2))