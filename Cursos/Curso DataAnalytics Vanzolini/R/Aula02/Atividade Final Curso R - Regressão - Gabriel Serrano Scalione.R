###################    AULA DE REGRESSÃO  ##############################################

#Medidas-resumo

summary(Dados_Carros2)

#Fazer um boxplot geral para visualizar as medidas-resumo

boxplot(Dados_Carros2)

#Fazer um boxplot específico das ações

boxplot(Dados_Carros2$price)

#Introduzir ggplot2
install.packages(ggplot2)

#Para identificar quais variáveis compor o modelo, faremos graficos de dispersão

ggplot(Dados_Carros2, aes(x = price, y = horsepower)) +
  geom_point() +
  stat_smooth()

########################   REGRESSÃO MÚLTIPLA   #################################################

#Modelo1 com preço e horsepower e carwidth

modelo1=lm(price ~ horsepower + carwidth + carheight + enginesize + peakrpm , data=Dados_Carros2)

#Análise do novo modelo com o summary
summary(modelo1)

#Para analisar quais variáveis são significativas para o modelo,
# prestamos atenção aos p-valores associados a cada variável

summary(modelo1)$coefficients



#Para determinar os intervalos de confiança dos coeficientes:
confint(modelo1)

# RSE

RSE = 20230 /mean(Dados_Carros2$price)*100
RSE


R2 = 0.2692

#Predição

variaveis <- data.frame(carwidth= c(700), carheight= c(500), enginesize= c(110), horsepower=c(120), peakrpm = c(4500))
predict(modelo1, newdata = variaveis)
predict(modelo1, newdata = variaveis, interval = "confidence")
