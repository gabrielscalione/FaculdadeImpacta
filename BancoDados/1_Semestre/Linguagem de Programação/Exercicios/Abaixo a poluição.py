qv = int(input())
cont = 0
total = 0
while qv != 999:
    if qv > 2:
        multa = (qv-2) * 12.89
        cont = cont + 1
        total = total + multa
    qv = int(input())

print("%.2f" %total)
print(cont)
