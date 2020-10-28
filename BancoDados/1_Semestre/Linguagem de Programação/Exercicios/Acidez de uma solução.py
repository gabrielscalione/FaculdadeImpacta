pH = float(input("Digite o pH da solucao:"))

if(pH < 0 or pH > 14):
    print("Valor do pH deve estar entre 0 e 14")
else:
    if(pH < 7.0 and pH >= 0):
        print("Solucao acida")
    else:
        if(pH > 7.0 and pH <= 14.0):
            print("Solucao basica")
        else:
            print("Solucao neutra")

    
