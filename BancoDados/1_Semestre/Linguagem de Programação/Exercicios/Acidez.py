'''
Escreva um programa que leia o valor do índice de acidez (pH) de uma
solução e informe se ela é ácida, básica ou neutra.

A solução é ácida quando o pH é menor que 7
A solução é básica quando o pH é maior que 7
Caso contrário a solução é neutra

Formato de entrada

O valor do pH (entre 1.0 e 14.0)

'''
pH = float(input())

if(pH < 7.0 and pH >= 1.0):
    print("Acida")
else:
    if(pH > 7.0 and pH <= 14.0):
        print("Basica")
    else:
        print("Neutra")
