# Exercício 1
lista1 = []

for i in range(10):
    n = int(input("Idade: "))
    lista1.append(n)

for i in range(10):
    print(lista1[i])

menor = min(lista1)
maior = max(lista1)

print(menor, maior)

####### Exercício 2 #########
print('-------')
lista2 = []
for i in range(5):
    n = int(input("Números: "))
    lista2.append(n)

par = [ i for i in lista2 if i%2 == 0]
impar = [ i for i in lista2 if i%2 != 0]

print("Pares: ", par)
print("Impares: ", impar)

####### Exercício 3 #########
print('---------------------')
lista3 = []
soma = 0
for i in range(5):
    n = float(input("Nota: "))
    lista3.append(n)

mnota = [i for i in lista3]
mnota.sort(reverse = True)

for i in range(4):
    soma += mnota[i]

media = soma/4

print(media)



####### Exercício 4 #########
print('---------------------')
temp_media = []

for i in range(5):
    temp = float(input("Digite a temp: "))
    temp_media.append(temp)

media_anual = sum(temp_media) / len(temp_media)

print("Media anual: ", media_anual)
for mes in range(12):
    if temp_media[mes] > media_anual:
        print(mes, temp_media[mes])


####### Exercício 6 #########
print('---------------------')
lista = []

for i in range(5):
    n = float(input())
    lista.append(n)

media = sum(lista) / len(lista)

diff = []
for num in lista:
    d = media - num
    if d < 0:
        d *= -1
    diff.append(d)

m = min(diff)
ind = diff.index(m)
print(lista[ind])


