# Define a função sem parametros
def soma():
    n1 = int(input("n1: "))
    n2 = int(input("n2: "))
    s = n1 + n2
    print(s)
    
#--------------------------------
    
# Define a função com parametros
def somap(n1,n2):
    s = n1 + n2
    return s
#--------------------------------

opcao = int(input("Digite 1 ou 2:"))


if opcao == 1:
    print("\n Função sem parametros \n ")
    soma()
else:
    print("\n Função com parametros \n ")
    n1 = int(input())
    n2 = int(input())
    result = somap(n1,n2)
    print(result)
    
    
    
