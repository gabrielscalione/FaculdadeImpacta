rendimento  = float(input())
valorRetido = float(input())

#CONDIÇÕES
cond1 = rendimento <= 22847.76
cond2 = 22847.77 <= rendimento <= 33919.80
cond3 = 33919.81 <= rendimento <= 45012.60
cond4 = 45012.61 <= rendimento <= 55976.16
cond5 = rendimento > 55976.16


if cond1 == True:
    aliquota = 0
    parcela  = 0

elif cond2 == True:
    aliquota = 0.075
    parcela = 1713.58
    
elif cond3 == True:
    aliquota = 0.15
    parcela = 4257.57

elif cond4 == True:
    aliquota = 0.225
    parcela = 7633.51

else:
    aliquota = 0.275
    parcela = 10432.32


valorImposto = round(rendimento * aliquota - parcela - valorRetido,2)

print(valorImposto)
