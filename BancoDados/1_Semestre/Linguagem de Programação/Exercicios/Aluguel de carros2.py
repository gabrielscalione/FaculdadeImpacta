dias=float(input("Digite a quantidade de dias de locacao: "))
Km=float(input("Digite a quantidade de km rodados: "))

diaria = dias*30  
kmrodados =Km*0.01  
total= diaria+kmrodados 
desconto=10/100*total  
total=total-desconto

# ou aluguel = diaria*30 + km*0.01

print("Valor a pagar pelo aluguel: R$ %.6f" % total)
