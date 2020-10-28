#recursividade

def fatorial(n):
    if(n==1):
        return 1
    else:
      return n*fatorial(n-1)


#somalista
def somalista(li):
    soma=0
    tam = len(li)
    for i in range(0,tam,1):
        soma = soma + li[i]
    return soma


#outra forma de somar lista por recursividade
def somalistarecur(li):
    if(len(li)==1):
        return li[0]
    else:
        return li[0]+somalistarecur(li[1:])

print(somalista([1,4,8,2]))

print(somalistarecur([1,4,8,2]))

print(fatorial(1))
print(fatorial(5))
print(fatorial(3))
