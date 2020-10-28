# Escrever um algoritmo que lê 5 valores para "a", um de cada vez, e conta quantos destes são negativos, escrevendo esta informação.

negativo = 0
n = 1
a = float(input("Digite um valor:"))
if a < 0:
    negativo += 1

while n <= 4:
    a = float(input("\nDigite um valor:"))

    if a < 0:
        negativo += 1

    n += 1

print("\nForam digitados", negativo, "numeros negativos")