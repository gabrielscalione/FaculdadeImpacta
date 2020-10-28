# for i in range(10,0,-1):
#     a = 10
#     b = 100
#     print(f'Valor de i: {i} e o valor de a: {a} e {b}')

# i = 0
# while i < 10:
#     print(f'Valor de i: {i}')
#     i += 1 # i = i + 1  

# i = 10
# while i > 0:
#     print(f'Valor de i: {i}')
#     i -= 1 # i = i - 1  

# def funcao_soma(a,b):
#     return a + b
# res = funcao_soma(1,2)
# print(f'Resultado = {res}')

# a = 10
# if a == 10:
#     b = 40
# print(b)

# lista = ["olá","oi",1,4,"teste","olá mundo"]
# print(lista)
# print(len(lista))
# print(lista[0])

# for i in lista:
#     print(i)

a = {'nome':'kevin',
    'idade':100,
    'cidade':'SP'}
# print(a)
# print(a['nome'])
# print(a['idade'])
# print(a['cidade'])

for chave in a.keys():
    print(f'Chave: {chave} e valor: ${a[chave]}')
