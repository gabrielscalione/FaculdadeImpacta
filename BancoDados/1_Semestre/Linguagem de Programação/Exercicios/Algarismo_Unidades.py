#Algarismo da casa das unidades

#Escreva um programa que recebe um numero inteiro
#como entrada e fornece o algarismo da casa das unidades deste numero.

numero = int(input('Digite um numero inteiro positivo: '))

# Extraindo a unidade


if numero < 0:
    aux = numero * -1
    unidade = (aux % 10)*-1
else:
    unidade = numero % 10


print(unidade)
