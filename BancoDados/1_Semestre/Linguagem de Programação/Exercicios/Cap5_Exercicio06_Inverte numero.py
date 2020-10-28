valido = False

while not valido:
    num = int(input("Digite um numero: "))
    if not (num % 10 == 0 or (num // 10)%10 == 0 or num//100 == 0) :
        valido = True
    
invertido = 0
while num != 0:
    invertido *= 10
    digito = num % 10
    invertido += digito
    num = num // 10

print(invertido)
