'''
Faça um programa que indique se um número que o usuário digitou
é divisível por 4 e por 7 ao mesmo tempo mas não divisível por 5.

A saída deve ser um mensagem 'sim' ou 'nao' (minúsculos e sem o til).

'''

n = int(input())

if n%4 == 0 and n%7 == 0 and n%5 != 0:
    print('sim')
else:
    print('nao')
