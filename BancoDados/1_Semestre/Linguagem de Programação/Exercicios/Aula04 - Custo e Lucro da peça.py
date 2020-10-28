custo = float(input("Custo da peça: "))
convite = float(input("Preço do convite: "))

minconvites = ceil(custo / convite)
print(minconvites)

custoLucro = custo * 1.23
minconvitesLucro = ceil(custoLucro / convite)

print(minconvitesLucro)
