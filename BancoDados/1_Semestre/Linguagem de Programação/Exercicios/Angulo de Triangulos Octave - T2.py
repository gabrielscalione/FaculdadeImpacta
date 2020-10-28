a1 = int(input("Digite o valor do primeiro ângulo:"))
a2 = int(input("\nDigite o valor do segundo ângulo:"))
a3 = int(input("\nDigite o valor do terceiro ângulo:"))

if(a1==90 or a2==90 or a3==90):
    print("\nEste e um triangulo retangulo.")
else:
    if(a1>90 or a2>90 or a3>90):
        print("\nEste e um triangulo obtusangulo.")
    else:
        if(a1<90 or a2<90 or a3<90):
            print("\nEste e um triangulo acutangulo.")
