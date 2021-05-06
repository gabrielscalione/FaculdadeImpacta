# Calculadora em Python

# Desenvolva uma calculadora em Python com tudo que você aprendeu nos capítulos 2 e 3. 
# A solução será apresentada no próximo capítulo!
# Assista o vídeo com a execução do programa!

print("\n******************* Python Calculator *******************")

soma = lambda x,y: x + y
sub  = lambda x,y: x - y
mult = lambda x,y: x * y
div  = lambda x,y: x / y


print("\nSelecione o número da operação desejada: ")

print("\n1 - Soma")
print("2 - Subtração")
print("3 - Multiplicação")
print("4 - Divisão")

operador = int(input("\nDigite a opção desajada: "))

if operador > 4 or operador < 1:

    print("\nOpção Inválida")

else:
    
    num1 = float(input("\nDigite o primeiro número: "))
    num2 = float(input("Digite o segundo número: "))

    if operador == 1:
        
        print(num1, " + ", num2, " = ", soma(num1, num2) )

    elif operador == 2:

        print(num1, " + ", num2, " = ", sub(num1, num2) )

    elif operador == 3:

        print(num1, " + ", num2, " = ", mult(num1, num2) )

    elif operador == 4:

        print(num1, " + ", num2, " = ", div(num1, num2) )
