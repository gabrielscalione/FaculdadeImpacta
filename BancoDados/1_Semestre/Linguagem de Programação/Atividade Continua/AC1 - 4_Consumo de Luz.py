minimo = float(input())
valorm3 = minimo*.05
energiaGasta = float(input())

contaLuz = energiaGasta * (valorm3/10000)

print(contaLuz)

desconto = contaLuz - contaLuz*0.15

print(desconto)
