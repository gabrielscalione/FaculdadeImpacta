'''(2) Elabore um programa que leia dois númerosreais
e mostre o resultado da diferença do maior
valor pelo menor
'''

a = float(input())
b = float(input())

if(a>=b):
    dif = a - b
else:
    dif = b - a

print(dif)
