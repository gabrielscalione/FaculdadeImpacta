library(readxl)


#Comando que traz as medidas resumo de uma tabela

summary(Exemplo1)


#medidas de disparsão: variancia
var(Exemplo1)

#medidas de dispersão: desvio-padrão
sd(Exemplo1$Ano)

#grafico de dispersao
plot(Exemplo1$Publicidade, Exemplo1$Vendas, main = "Publicidades por vendas",
     xlab = "Publicidades", ylab = "Vendas")


#########
##Exemplo 2
#Comando que traz as medidas resumo de uma tabela

summary(Exemplo2)


#medidas de disparsão: variancia
var(Exemplo2)

#medidas de dispersão: desvio-padrão
sd(Exemplo2$Ano)

#grafico de dispersao
plot(Exemplo2$Publicidade, Exemplo2$Vendas, main = "Publicidades por vendas",
     xlab = "Publicidades", ylab = "Vendas")
