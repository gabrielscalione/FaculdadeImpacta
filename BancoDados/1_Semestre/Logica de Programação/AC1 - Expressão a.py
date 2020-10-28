import math as m

a = int(input())
b = int(input())
x = int(input())
y = int(input())


raizC = ((m.pow(a,3) - m.pow(b,3))/(x + y)) ** (1/3)

resultado = raizC * 2*x*(m.pow(y,3)) - 5*a*(a + m.pow(b,6) + x)

print(resultado)

