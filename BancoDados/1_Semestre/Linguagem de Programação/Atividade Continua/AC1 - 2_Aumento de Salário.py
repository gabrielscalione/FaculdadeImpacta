#Faça um programa que receba o salário de um funcionário e o percentual de aumento.

#Calcule e mostre o valor do aumento e o novo salário com as seguintes mensagens

#Entrada: (um por linha, sem mensagem)
#Salario
#Percentual de aumento


#Saída

#Seu salario teve aumento de <x> %, passando de R$ <x> para R$ <x>

ssalario = float(input())
percAumento = float(input())

aumentoSalario = round(salario*(percAumento/100),2)

novoSalario = salario + aumentoSalario

print("Seu salario teve aumento de", percAumento,"%, passando de R$",
      salario, "para R$", novoSalario)
