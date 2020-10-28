'''
(3) Elabore um programa que leia um número inteiro de três dígitos e imprima se o dígito da
centena é par ou ímpar.
'''

n = int(input())

centena = n//100

print(centena)

aux = centena % 2

if aux == 0:
    print("É par")
else:
    print("É impar")
