'''
A locadora de carros SAI DA FRENTE está fazendo uma promoção e
está alugando carros no período junino por R$ 30,00 a diária.
Além disso, a locadora cobra R$ 0,01 por quilômetro rodado.
Como é período de São João, a locadora quer fidelizar os clientes e
está dando 10% de desconto no valor total do aluguel de qualquer carro.

O valor total que a pessoa deve pagar pelo aluguel do carro
arredondado para duas casas decimais.

'''

dias=float(input("Dias de aluguel: "))
Km=float(input("Quilometros rodados: "))

diaria = dias*30  
kmrodados =Km*0.01  
total= diaria+kmrodados 
desconto=10/100*total  
total=total-desconto

# ou aluguel = diaria*30 + km*0.01

print("Total a pagar: %.2f" % total)



