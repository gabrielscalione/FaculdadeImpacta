'''
 Elabore um programa que leia as notas de três avaliações de um aluno.
 A primeira avaliação tem peso 2, a segunda tem peso 3 e a terceira, peso 5.
 Calcule a média do aluno e exiba-a na tela.
 Se a média do aluno for maior ou igual a 6.0, também exiba 'aprovado';
 caso contrário, exiba 'reprovado'.
'''

def media(a,b,c):
    m = (a + b + c) / (2+3+5)
    return m

#----------

n1 = float(input("n1: "))
n2 = float(input("n2: "))
n3 = float(input("n3: "))

p1 = n1*2
p2 = n2*3
p3 = n3*5

media = media(p1,p2,p3)

if media >= 6.0:
    print ("A média é %.1f" % media + ", aluno aprovado.")
else:
    print ("A média é %.1f" % media + ", aluno reprovado.")
