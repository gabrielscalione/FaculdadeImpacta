#Inicio
n1 = int(input("Digite um numero: "))

n2 = int(input("Digite outro numero: "))

operacao = input("Informe um dos operadores, + - * ou /: ")

if operacao == '+':
    resultado = n1 + n2
else:
    if operacao == '-':
        resultado = n1 - n2
    else:
        if operacao == '*':
            resultado = n1 * n2
        else:
            if operacao == '/':
                resultado = n1 / n2
            else:
                print("Nenhum operador informado!")
                resultado = 0


print("O resultado é ", resultado)

#Fim
