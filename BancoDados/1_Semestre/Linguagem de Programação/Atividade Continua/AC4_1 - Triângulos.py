r1 = float(input())
r2 = float(input())
r3 = float(input())

##Condições para existencia de um triângulo
cond1 = abs(r2 - r3) < r1 < r2 + r3
cond2 = abs(r1 - r3) < r2 < r1 + r3
cond3 = abs(r1 - r2) < r3 < r1 + r2


if  not(cond1) or not(cond2) or not(cond3) or r1 == 0 or r2 == 0 or r3 == 0:
    print("impossivel")
    
elif r1 == r2 and r1 == r3 and r2 == r3:
    print("equilatero")
    
elif r1 != r2 and r1 != r3 and r2 != r3:
    print("escaleno")
    
else:
    print("isoceles")

    
