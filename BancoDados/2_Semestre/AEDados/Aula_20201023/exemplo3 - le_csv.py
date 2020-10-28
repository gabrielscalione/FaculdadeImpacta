def le_csv():
    alunos = []
    with open('disciplina.csv','r') as arq:
        for linha in arq:
            linha = linha.rstrip()
            aluno = linha.split(',')
            aluno[1]= float(aluno[1])
            aluno[2]= float(aluno[2])
            if aluno[3]=="False":
                aluno[3] = False
            else:
                aluno[3] = True

            alunos.append(aluno)
    return alunos

lista = le_csv()

print(lista)
