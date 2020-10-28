arq = open("fibonacci.txt","a")
n = int(input('A sequência de Fibonacci de: '))
a, b = 0, 1
while a < n:
    a, b = b, a+b
    arq.write('%d\n' % (a))
arq.write('\n')
arq.close()

