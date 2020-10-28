'''
Desenvolva um programa que receba um número n de notas e
a seguir as leia e depois calcule a média entre elas.
(usem round(media, 1) para exibir a media)
'''

nNotas = int(input())

soma = 0

for i in range(nNotas):
    nota = float(input())
    soma += nota

media = round(soma/nNotas,1)

print(media)
