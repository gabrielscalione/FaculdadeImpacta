'''
8) Faça um programa que receba um ano (quatro dígitos) e informe se é um ano bissexto ou não.
Pesquise quais as regras para um ano ser bissexto.
'''

ano = int(input())

if (ano % 400 == 0) or (ano % 4 == 0 and ano % 100 != 0):
    print("BISSEXTO")
else:
    print("NAOBISSEXTO")
