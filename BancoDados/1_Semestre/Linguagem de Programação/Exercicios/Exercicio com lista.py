lista = [1,2,3]
lista2 = [4,5,6]
lista3 = []
print(len(lista))
print(len(lista2))

for i in range(len(lista2)):
  lista3.append(lista[i]+lista2[i])

for i in range(len(lista3)):  
  print(lista3[i])
