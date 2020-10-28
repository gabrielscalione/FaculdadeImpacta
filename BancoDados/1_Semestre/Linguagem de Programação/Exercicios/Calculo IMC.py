#Inicio

P = float(input("Digite o peso (Kg): "))
A = float(input("Digite a altura (m): "))

IMC = P / A ** 2

print("O IMC é %.2f" % IMC)

if IMC > 25:
    print("IMC ALTO")
else:
    print("IMC BAIXO")

#Fim    
