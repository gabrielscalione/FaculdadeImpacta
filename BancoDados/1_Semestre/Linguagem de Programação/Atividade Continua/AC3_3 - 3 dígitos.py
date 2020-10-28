Elabore um programa que leia um número inteiro de três dígitos e imprima:

sim, se o dígito da centena for par ou se o dígito da dezena for ímpar.

nao, caso contrário.


n = int(input())

cent = n//100
dez = n//10

if cent%2 == 0 or dez%2 != 0:
    print('sim')
else:
    print('nao')
    
