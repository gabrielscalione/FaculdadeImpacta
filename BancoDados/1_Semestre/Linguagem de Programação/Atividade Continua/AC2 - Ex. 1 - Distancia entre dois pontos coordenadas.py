import math as m

xA = float(input())
yA = float(input())
zA = float(input())

xB = float(input())
yB = float(input())
zB = float(input())

dAB = m.sqrt(pow(xB - xA,2) + pow(yB - yA,2)+ pow(zB - zA,2))

print(dAB)
