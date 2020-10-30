def grava_csv(nome,modo,dados,esq,sep):
    arq=open(nome,modo)
    esq=sep.join(esq)+"\n"
    for linha in dados:
        arq.write(esq % tuple(linha))
    arq.close()


dados=[[4,2,8],[10,4,2],[9,9,8],[1,2,4]]
nome="notas.csv"
modo="w"
esq=["%d","%d","%d"]
sep=","

grava_csv(nome,modo,dados,esq,sep)