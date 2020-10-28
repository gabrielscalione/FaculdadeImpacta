'''
Escreva um programa que leia um número inteiro
e calcule a soma de seus algarismos.
'''

num = int(input())

somadig = 0
while num != 0:

    digito   = num % 10
    print (digito)
    somadig += digito
    print (somadig)
    num = num // 10
    print (num)
    print ('----------')

print(somadig)
