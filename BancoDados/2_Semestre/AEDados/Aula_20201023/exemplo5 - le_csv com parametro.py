def le_csv(nome,esq,sep):
    dados=[]
    arq=open(nome,"r")
    for linha in arq:
        linha=linha.rstrip()
        linha=linha.split(sep)
        for i in range(0,len(linha),1):
            esp=esq[i][-1]
            if (esp=="d"):
                linha[i]=int(linha[i])
            elif (esp=="f"):
                linha[i]=float(linha[i])
            elif (linha[i]=="True"):
                linha[i]=True
            elif (linha[i]=="False"):
                linha[i]=False
        dados.append(linha)
    arq.close()
    return dados

ld=le_csv("notas.csv",["%d","%d","%d"],",")
print(ld)
