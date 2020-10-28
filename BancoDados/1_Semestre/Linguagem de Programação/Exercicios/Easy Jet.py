'''
Escreva um programa que receba como entrada as dimensões de uma mala
e exiba uma mensagem informando se a mala será aceita ou não.
 para ser aceita, a mala deve ter no máximo
 45 cm de largura,
 56 cm de comprimento e
 25 cm de altura.
'''

l = float(input())
c = float(input())
a = float(input())

if(l <= 45.0 and c <= 56.0 and a <= 25.0):
    print("PERMITIDA")
else:
    print("PROIBIDA")
