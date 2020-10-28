def grava_csv(nome, dados, esquema, separador):
    with open(nome, modo) as arquivo:
        esquema = separador.join(esquema) + '\n'
        for linha in dados:
            arquivo.write(esquema % tuple(linha))
        arq.close()

dados = [[4,2,7],[5,10,3],[6,7,8]]
nome = 'notas.csv'
modo = 'a'
esquema = ['%d','%d','%d']
separador = ','

grava_csv(nome, dados, esquema, separador)
