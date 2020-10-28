class Pessoa(object):
    nome = None
    
    def salvar(self, x):
        self.nome = x
        print("Salvando ", self.nome)
