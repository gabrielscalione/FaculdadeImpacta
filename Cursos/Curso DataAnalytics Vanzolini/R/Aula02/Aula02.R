library(readxl)

#medidas-resumo
summary(Dados)


#box-plot
boxplot(Dados$TaxaDesemprego) # há algum erro de digitacao deixando um outlayer muito fora 

boxplot(Dados$PreçoAcoes) 

#remover uma tabela/dataframe
rm(Dados)


install.packages("ggplot2")
library(ggplot2)


ggplot(Dados2, aes(x=TaxaJuros, y=PreçoAcoes)) + 
  geom_point() +
  stat_smooth()

ggplot(Dados2, aes(x=TaxaDesemprego, y=PreçoAcoes)) + 
  geom_point() +
  stat_smooth()

ggplot(Dados2, aes(x=DividaPublica, y=PreçoAcoes)) + 
  geom_point() +
  stat_smooth()


# Modelo de regressao linear simples

modelo1 = lm(PreçoAcoes~TaxaJuros, data = Dados2)

summary(modelo1)

# Y = b0 + b1x
# PreçoAcoes = -99.46 + 564.20*TaxaJuros

#intervalos de confiança para os coeficientes
confint(modelo1)

#validações para saber se o modelo é bom

#Métricas de qualidade de ajustes 

#RSE (Erro padrão dos resíduos)
RSE = 75.96/mean(Dados2$PreçoAcoes)*100

#coeficiente de determinicao - R² (R-squared)
R2 = 0.8701

#predição Juros
variavel_juros = data.frame(TaxaJuros=c(3,4,5)) #cria uma tabela
predict(modelo1, newdata = variavel_juros)
predict(modelo1, newdata = variavel_juros, interval = "confidence")

####################################
#Para Taxa de Desemprego


# Modelo de regressao linear simples

modelo1 = lm(PreçoAcoes~TaxaDesemprego, data = Dados2)

summary(modelo1)

# Y = b0 + b1x
# PreçoAcoes = 4471.3 + -589.0*TaxaDesemprego

#intervalos de confiança para os coeficientes
confint(modelo1)

#validações para saber se o modelo é bom

#Métricas de qualidade de ajustes 

#RSE (Erro padrão dos resíduos)
RSE = 83.25/mean(Dados2$PreçoAcoes)*100

#coeficiente de determinicao - R² (R-squared)
R2 = 0.8507

#predição Desemprego
variavel_desemprego = data.frame(TaxaDesemprego=c(3,4,5,6)) #cria uma tabela
predict(modelo1, newdata = variavel_desemprego)
predict(modelo1, newdata = variavel_desemprego, interval = "confidence")



##################Regressao Linear multipla##################
# Modelo de regressao linear Multipla

modelo2 = lm(PreçoAcoes~TaxaJuros + TaxaDesemprego, data = Dados2)

summary(modelo2)

#intervalos de confiança para os coeficientes
confint(modelo2)

#RSE (Erro padrão dos resíduos)
RSE_mult = 70.56/mean(Dados2$PreçoAcoes)*100
R2_mult = 0.8879

#predição Juros
variavel_multi = data.frame(TaxaJuros=c(3,4,5), TaxaDesemprego=c(6,7,8)) #cria uma tabela
predict(modelo2, newdata = variavel_multi)
predict(modelo2, newdata = variavel_multi, interval = "confidence")

#Calculo do predict em caso de multipla

# PreçoAcoes = 1798.4 + 345.5*TaxaJuros - 250.1*TaxaDesemprego