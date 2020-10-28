def gera_csv():
    file=open("disciplina.csv","a") # cria o arquivo se ele nao existe
    nome = input()
    while (nome!=""):
        trab = float(input())
        prova = float(input())
        rf = input()
        file.write("%s,%.1f,%.1f,%s\n" %(nome, trab, prova, rf))
        print("-"*30)
        nome = input()
    file.close()


gera_csv()
