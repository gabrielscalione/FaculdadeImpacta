# Leitura de arquivo que já existe
arq = open("compras.txt","r")

# Escrever arquivo, w - sobrescreve o arquivo, a - append insere novos registros no final
arq = open("compras.txt","w")
arq.write('Item Quantidade\n')
item = input('Nome do item: ')
while item != '':
    qtd = int(input('Quantidade: '))
    arq.write('%s %d\n' % (item, qtd))
    item = input('Nome do item: ')
arq.close()
