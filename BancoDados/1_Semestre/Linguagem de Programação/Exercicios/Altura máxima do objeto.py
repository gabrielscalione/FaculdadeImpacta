'''
Leia 3 números decimais (floats) representando:

- O ângulo theta em graus.

- A velocidade v.

- A gravidade g.
'''

import math as m

a = float(input())
v = float(input())
g = float(input())

rad = m.radians(a)

h= (pow(v,2)*pow(m.sin(rad),2))/(2*g)

print(h)
