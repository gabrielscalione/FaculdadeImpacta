#Faca um programa que leia 3 numeros inteiros e os imprima em ordem crescente.

a = int(input())
b = int(input())
c = int(input())

if(a>=b and a>=c):
    maior = a
    if(b>=c):
        meio = b
        menor = c
    else:
        if(c>=b):
            meio = c
            menor = b
else:
    if(b>=a and b>=c):
        maior = b
        if(a>=c):
            meio = a
            menor = c
        else:
            if(c>=a):
                meio = c
                menor = a
    else:
        if(c>=b and c>=a):
            maior = c
            if(b>=a):
                meio = b
                menor = a
            else:
                if(a>=b):
                    meio = a
                    menor = b

print(menor)
print(meio)
print(maior)
