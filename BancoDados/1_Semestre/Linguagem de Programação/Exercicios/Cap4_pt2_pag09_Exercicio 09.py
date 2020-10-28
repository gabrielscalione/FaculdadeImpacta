#frete
#comissao
#lucro
#ct - custo total
#vt - valor total
#regiao

codigo   = int(input("Informe o código da região: "))
cliente  = input("Informe o nome do cliente: ")
pecas    = int(input("Informe o numero de peças: "))
vendedor = input("Informe o nome do vendedor: ")

ct = pecas * 7.00
vt = ct * 1.5

if codigo == 1:
    if pecas <= 1000 :
        frete = pecas * 1.00
    else:
        frete = ct * 1.1

    regiao   = 'Sul'    
    comissao = vt * 0.065
    lucro    = vt - ct - comissao
    
elif codigo == 2:
    if pecas <= 1000 :
        frete = pecas * 1.10
    else:
        frete = ct * 1.08

    regiao   = 'Norte'
    comissao = vt * 0.065
    lucro    = vt - ct - comissao

elif codigo == 3:
    if pecas <= 1000 :
        frete = pecas * 1.15
    else:
        frete = ct * 1.07
        
    regiao   = 'Leste'
    comissao = vt * 0.065
    lucro    = vt - ct - comissao

elif codigo == 4:
    if pecas <= 1000 :
        frete = pecas * 1.20
    else:
        frete = ct * 1.11
        
    regiao   = 'Oeste'
    comissao = vt * 0.065
    lucro    = vt - ct - comissao

elif codigo == 5:
    if pecas <= 1000 :
        frete = pecas * 1.25
    else:
        frete = ct * 1.15
        
    regiao   = 'Noroeste'
    comissao = vt * 0.065
    lucro    = vt - ct - comissao

elif codigo == 6:
    if pecas <= 1000 :
        frete = pecas * 1.30
    else:
        frete = ct * 1.12
        
    regiao   = 'Sudeste'
    comissao = vt * 0.065
    lucro    = vt - ct - comissao

elif codigo == 7:
    if pecas <= 1000 :
        frete = pecas * 1.40
    else:
        frete = ct * 1.18
        
    regiao   = 'Centro-Oeste'
    comissao = vt * 0.065
    lucro    = vt - ct - comissao

elif codigo == 8:
    if pecas <= 1000 :
        frete = pecas * 1.35
    else:
        frete = ct * 1.15
        
    regiao   = 'Nordeste'
    comissao = vt * 0.065
    lucro    = vt - ct - comissao

else:
    print("Região informada não existe, tem q ser entre 1 e 8.")

# Imprimir resultados #
print("\nInformações da compra do cliente", cliente)
print("Valor total da Venda: R$ %.2f" % vt)
print("Região:", regiao)
print("Valor do frete: R$ %.2f" % frete)
print("A comissão do vendedor",vendedor,"é R$ %.2f" % comissao)
print("O lucro obtido R$ %.2f" % lucro)
