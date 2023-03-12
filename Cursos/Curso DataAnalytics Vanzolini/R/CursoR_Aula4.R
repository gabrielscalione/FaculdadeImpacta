#pacotes importantes
install.packages("forecast")
install.packages("fpp")

#importar champagne.sales

#criando a série
serie <- ts(champanhe$Sales, start=c(1964, 1), frequency=12)
plot.ts(serie, ylab="Vendas", xlab="Ano")


# Decomposição
componentes <- decompose(serie)

#Visualizar a decomposição
plot(componentes)

#Verificar os coeficientes de sazonalidade
componentes$seasonal

# Visualização mensal
monthplot(serie)

# Visualização sazonal
seasonplot(serie)

# Ajuste Sazonal
serie_ajustada = serie-componentes$seasonal
plot(serie_ajustada)

# Visualização mensal
monthplot(serie_ajustada)

# Visualização sazonal
seasonplot(serie_ajustada)

# Suavização Exponencial Simples - Séries sem tendência e sem sazonalidade
SuaveSimples <- HoltWinters(serie_ajustada, beta=FALSE, gamma=FALSE)
SuaveSimples

#quanto mais próximo o parâmetro alpha for de 1, mais peso tem as observações mais recentes

#predições para a série atual
SuaveSimples$fitted

#para visualizar predição com a série real
plot(SuaveSimples)

#Acurácia: Soma dos Erros Quadrados (SSE)
SuaveSimples$SSE

#Predições para o futuro
SuaveSimplesFuturo <- forecast(SuaveSimples, h=12)
SuaveSimplesFuturo

#Para visualizar as predições futuras
plot(SuaveSimplesFuturo)


# Suavização Exponencial de Holt - Séries com tendência e sem sazonalidade

serie_saias <- ts(saias,start=c(1866))
plot.ts(serie_saias)

SuaveHolt <- HoltWinters(serie_saias, gamma=FALSE)
SuaveHolt

#Valores altos para os parametros alfa e beta apontam que tanto o ponto presente
# quanto a tendência são baseados em observações muito recentes da série.

#Acurácia do modelo
SuaveHolt$SSE

#Para visualizar a série com o modelo
plot(SuaveHolt)

#Predições para o futuro
SuaveHoltFuturo <- forecast(SuaveHolt, h=19)
SuaveHoltFuturo

#Para visualizar as predições futuras
plot(SuaveHoltFuturo)

# Suavização Exponencial de Holt-Winters - Séries com tendência e sazonalidde

log_souvenirs <- log(souvenirs)

serie_souvenirs <- ts(log_souvenirs, frequency=12, start=c(1987,1))
plot.ts(log_souvenirs)

SuaveHoltWinters <- HoltWinters(serie_souvenirs)
SuaveHoltWinters

#alfa = influencia no ponto presente, beta = tendencia, gama = sazonalidade

#Acurácia do modelo
SuaveHoltWinters$SSE

#Para visualizar a série com o modelo
plot(SuaveHoltWinters)

#Predições para o futuro
SuaveHoltWintersFuturo <- forecast(SuaveHoltWinters, h=48)
SuaveHoltWintersFuturo

#Para visualizar as predições futuras
plot(SuaveHoltWintersFuturo)




