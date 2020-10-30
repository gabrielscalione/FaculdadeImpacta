# Faça um código que abre um arquivo csv contendo quatro valores float por linha
# e crie um arquivo csv com apenas um valor por linha se tratando da média dos
# valores de cada linha correspondente ao arquivo aberto já existente.

#gera arquivo com 4 valores
def grava_csv(nome,modo,dados,esq,sep):
    arq=open(nome,modo)
    esq=sep.join(esq)+"\n"
    for linha in dados:
        arq.write(esq % tuple(linha))
    arq.close()


dados=[[4,2,8,8],
       [10,4,2,8],
       [9,9,8,7],
       [1,2,4,8],
       [10,5,7,8]]
nome="notas.csv"
modo="w"
esq=["%.1f","%.1f","%.1f","%.1f"]
sep=","

grava_csv(nome,modo,dados,esq,sep)


###ler o arquivo notas.csv , calcula media e guarda em media.csv
arq = open('notas.csv','r')
arq2 = open('media.csv','w')
for linha in arq:
    linha = linha.rstrip()
    linha = linha.split(',')
    for i in range(0,4):
        linha[i] = float(linha[i])
    
    media = (linha[0]+linha[1]+linha[2]+linha[3])/4
    arq2.write('%.1f\n' %media)

arq.close()
arq2.close()
