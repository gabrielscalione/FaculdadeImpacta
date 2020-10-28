'''
7) Faça um programa que exiba uma mensagem indicando se o número que o usuário digitou é
divisível por 3 e por 5 ao mesmo tempo.
'''

num = int(input())

if num % 3 == 0 and num % 5 == 0:
    print("div 3 e por 5")
else:
    print("nao é")
