###################    AULA DE REGRESSÃO  ##############################################

#Medidas-resumo

summary(Dados)

#Fazer um boxplot geral para visualizar as medidas-resumo

boxplot(Dados)

#Fazer um boxplot específico das ações

boxplot(Dados$PreçoAcoes)

#Introduzir ggplot2
install.packages(ggplot2)

#Para identificar quais variáveis compor o modelo, faremos graficos de dispersão

ggplot(Dados, aes(x = TaxaJuros, y = PreçoAcoes)) +
  geom_point() +
  stat_smooth()

ggplot(Dados, aes(x = TaxaDesemprego, y = PreçoAcoes)) +
  geom_point() +
  stat_smooth()

############################# REGRESSÃO SIMPLES ###############################################

#Realizar o modelo de regressão linear simples

modelo1 = lm(PreçoAcoes~TaxaJuros, data=Dados)
modelo1
#Ou seja, PreçoAções = -99,46 + 564.20*TaxaJuros

#Ou seja, com 0 taxas de juros, o preço das ações é de -99 milhares de reais e espera-se um aumento
#de 564.20 milhares de reais para cada unidade de taxa de juros.

#Mas como validar se essa fórmula está coerente?

#Faremos analisando o modelo com o summary
summary(modelo1)

#Na seção resíduos, o ideal é que a mediana seja próxima de zero e que os valores mínimoe
#e máximo sejam iguais em valor absoluto

#Na seção coeficientes, são apresentados os coeficientes (betas) do modelo, o erro padrão
# (que define a acurácia dos coeficientes), e o p-valor. Quanto menor o P-valor, mais
# significante é o preditor para o modelo.

#Para calcular os intervalos de confiança dos coeficientes
confint(modelo1)

#Para verificar a qualidade deste ajuste, verificamos as 3 métricas que o summary do modelo
#trouxe: RSE (Erro padrão dos resíduos), R-quadrado (R2) e Estatística F.

# Queremos que o RSE seja o menor possível, pois ele representa os padrões que não foram 
# explicados pelo modelo. Para achar a porcentagem do RSE, 
# dividimos o seu valor pela média da variável de interesse e
# multiplicamos por 100.

RSE = 75.96/mean(Dados$PreçoAcoes)*100

#O R-Quadrado (R2) varia entre 0 e 1 e representa a proporção de informação explicada pelo
#modelo. Ou seja, queremos um R2 alto. No summary, ele consta como 0.87

R2 = 0.87

#A estatística F verifica a significância do modelo, analisando se ao menos um coeficiente
# possui valor diferente de zero. É mais utilizada em regressões múltiplas. Alta Estatística F
# implica em baixo p-valor.

EstatísticaF = 155

#Predição

variavel_juros <- data.frame(TaxaJuros = c(3,4,5))
predict(modelo1, newdata = variavel_juros)
predict(modelo1, newdata = variavel_juros, interval = "confidence")

########################   REGRESSÃO MÚLTIPLA   #################################################

#Podemos pensar em um modelo com ambas as taxas de desemprego e juros

modelo2=lm(PreçoAcoes ~ TaxaJuros + TaxaDesemprego, data=Dados)

#Façamos uma análise do novo modelo com o summary
summary(modelo2)

#Para analisar quais variáveis são significativas para o modelo,
# prestamos atenção aos p-valores associados a cada variável

summary(modelo2)$coefficients

#Apesar de taxa de desemprego apresentar um p-valor ligeraimente maior
# podemos mantê-la no modelo.

#Assim, a equação do modelo seria composta por:
# PreçoAcoes = 1798.4040 + 345.5401*TaxaJuros - 250.1466*TaxaDesemprego

#Para determinar os intervalos de confiança dos coeficientes:
confint(modelo2)

#As métricas de avaliação são análogas aos da regressão simples, com a verificação
# do RSE e do R2.

RSE = 70.56/mean(Dados$PreçoAcoes)*100
R2 = 0.8879

#Predição

variaveis <- data.frame(TaxaJuros = c(3,4,5), TaxaDesemprego = c(6.5, 7, 7.5))
predict(modelo2, newdata = variaveis)
predict(modelo2, newdata = variaveis, interval = "confidence")
