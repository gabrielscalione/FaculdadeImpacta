arq = open('atividade.txt', 'a')
n = input()
while (n!=""):
    n = int(n)
    arq.write('%d\n' %n)
    n = input()
arq.close()


#ler o arquivo atividade.txt e guarda em outro
arq = open('atividade.txt','r')
arq2 = open('atividade_resolvida.txt','w')
for linha in arq:
    linha = linha.rstrip()
    linha = int(linha)
    r = 2 * linha
    arq2.write('%d\n' %r)

arq.close()
arq2.close()
