'''
Determine os resultados obtidos na avaliação das expressões lógicas
seguintes sabendo que a, b, c contém, respectivamente, 2, 7, 3.5,
e que existem duas variáveis m e n cujos conteúdos são,
respectivamente, False e True

1) (b == a * c) and (m or n)
2) (b > a) or (b == pow(a,a))
3) m and (b // a >= c) or not (a <= c)
4) not m or n and (sqrt(a + b) >= c)
5) b/a == c or b/a != c
6) m or pow(b,a) <= c * 10 + a * b
'''

a = 2
b = 7
c = 3.5
m = False
n = True

#1)
ex1 = b == a * c and (m or n)
print("Resposta 1: ",ex1)

#2)
ex2 = b > a or b == pow(a,a)
print("Resposta 2: ",ex2)

#3)
ex3 = m and b // a >= c or not a <= c
print("Resposta 3: ",ex3)

#4)
ex4 = not m or n and sqrt(a + b) >= c
print("Resposta 4: ",ex4)

#5)
ex5 = b/a == c or b/a != c
print("Resposta 5: ",ex5)

#6)
ex6 = m or pow(b,a) <= c * 10 + a * b
print("Resposta 6: ",ex6)
