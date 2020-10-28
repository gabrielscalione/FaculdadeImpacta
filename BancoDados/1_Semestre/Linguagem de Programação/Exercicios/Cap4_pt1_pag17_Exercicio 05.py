'''
 (5)Elabore um programa que leia o peso de peixes, e verifique se há excesso. Se houver excesso, exiba o
peso excedente e o valor da multa, caso contrário, exiba 'dentro do regulamento'.

'''

peso = float(input("Informe o peso total dos peixes (kg): "))

limite = 50.0

peso_excedente = peso - 50

if peso > limite:
    multa = peso_excedente * 4
    print("Limite excedido em: %.2f Kg" % peso_excedente + " e o valor da multa é de R$ %.2f ." % multa)
else:
    print("Dentro do regulamento.")
