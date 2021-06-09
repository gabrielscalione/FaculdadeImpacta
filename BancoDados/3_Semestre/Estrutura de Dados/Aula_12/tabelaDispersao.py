class TabelaDispersao:
    def __init__(self, tamanho_tabela):
        self.tamanho_tabela = tamanho_tabela
        self.tabela = [None] * tamanho_tabela
    
    def hash_int(self, item):
        return item % self.tamanho_tabela
    
    def hash_string(self, item):
        soma = 0
        for pos in range(len(item)):
            soma = soma + (ord(item[pos]) * (pos+1))
        return soma % self.tamanho_tabela
    
    def hash(self, item):
        if type(item) is int:
            posicao = self.hash_int(item)
        else:
            posicao = self.hash_string(str(item))
        return posicao

    def adicionar(self, item):
        posicao = self.hash(item)
        if self.tabela[posicao] is None: # verifica se o slot  ́e None
            self.tabela[posicao] = [item]
        else:
            self.tabela[posicao].append(item)
    
    def remover(self, item):
        posicao = self.hash(item)
        if self.tabela[posicao] is not None: # se o slot n~ao  ́e None, ent~ao ele  ́e uma lista (encadeamento)
            for i in range(len(self.tabela[posicao])): # percorre a lista do slot para remover o item, se ele existir
                if item == self.tabela[posicao][i]:
                    self.tabela[posicao].pop(i) # remove o item da lista daquele slot espec ́ıfico
                    break
            if len(self.tabela[posicao]) == 0: # se a lista ficar vazia, mudamos o valor do slot para None
                self.tabela[posicao] = None
    
    def buscar(self, item):
        posicao = self.hash(item)
        if self.tabela[posicao] is not None: # se o slot n~ao  ́e None, ent~ao ele  ́e uma lista (encadeamento)
            for i in range(len(self.tabela[posicao])): # percorre a lista do slot para procurar o item, se ele existir
                if item == self.tabela[posicao][i]:
                    return True
            return False

# Programa principal
tabela = TabelaDispersao(37)
tabela.adicionar("objeto")

print("Existe 'objeto'?", tabela.buscar("objeto"))
