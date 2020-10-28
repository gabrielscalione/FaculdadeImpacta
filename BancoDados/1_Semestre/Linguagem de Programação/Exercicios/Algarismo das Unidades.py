n = int(input("Digite um numero:"))

if n < 0:
    aux = n * -1
    unidade = (aux % 10)* -1
else:
    unidade = n % 10

print("Algarismo das unidades:",unidade)
