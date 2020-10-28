'''
9) Faça um programa que leia do teclado o sexo de uma pessoa. Se o sexo digitado for 'M', 'm',
'F' ou 'f', escrever na tela 'sexo válido!'. Caso contrário, exibir 'sexo inválido!'.
'''

sexo = input()

if sexo == 'M' or sexo == 'm' or sexo == 'F' or sexo == 'f':
    print('Sexo válido!')
else:
    print('sexo inválido!')

