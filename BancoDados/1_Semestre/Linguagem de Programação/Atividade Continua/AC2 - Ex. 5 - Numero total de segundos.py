segundos = int(input())

dias = segundos // 86400

resto = segundos % 86400
horas = resto//3600

resto = resto % 3600
minutos = resto // 60

segundos = resto % 60

print(dias)
print(horas)
print(minutos)
print(segundos)
