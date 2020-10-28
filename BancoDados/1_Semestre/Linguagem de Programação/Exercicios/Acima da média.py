
acima = 0
soma  = 0 
n1 = float(input())
n2 = float(input())
n3 = float(input())

media = round((n1+n2+n3)/3,2)

if round(n1,2) >= media:
    acima += 1
if round(n2,2) >= media:
    acima += 1
if round(n3,2) >= media:
    acima += 1


print(acima)
