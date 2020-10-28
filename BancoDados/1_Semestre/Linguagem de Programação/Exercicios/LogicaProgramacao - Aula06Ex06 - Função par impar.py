import math as m

# funcao quadrado do numero par
def par(x):
    quad = x**2

    print("O quadrado do número par é: %d" % quad)
    return

# funcao raiz de numero impar
def impar(num):
    raiz = round(m.sqrt(num),2)

    print("A raiz do número impar é: ", raiz)
    return


#main

num = int(input("Digite um número: "))

if num%2 == 0:
    par(num)
else:
    impar(num)

#fim
