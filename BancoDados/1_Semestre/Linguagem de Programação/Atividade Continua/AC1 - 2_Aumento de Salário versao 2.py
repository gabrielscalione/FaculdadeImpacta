salario = float(input())

if salario <= 280.00:
    aumentoSalario = round(salario*(20/100),2)
    novoSalario = salario + aumentoSalario
elif salario > 280.00 and salario <= 700.00:
    aumentoSalario = round(salario*(15/100),2)
    novoSalario = salario + aumentoSalario
elif salario > 700.00 and salario <= 1500.00:
    aumentoSalario = round(salario*(10/100),2)
    novoSalario = salario + aumentoSalario
else:
    aumentoSalario = round(salario*(5/100),2)
    novoSalario = salario + aumentoSalario

print(novoSalario)
