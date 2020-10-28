'''
Chama-se ano bissexto o ano ao qual é acrescentado um dia extra,
ficando ele com 366 dias, um dia a mais do que os anos normais de 365 dias,
ocorrendo a cada quatro anos
(exceto anos múltiplos de 100 que não são múltiplos de 400).

Faça um programa que indique se o ano digitado é bissexto.

'''

ano = int(input())


if (ano % 400 == 0) or (ano % 4 == 0 and ano % 100 != 0):

    print("BISSEXTO")
else:
    print("NAOBISSEXTO")
