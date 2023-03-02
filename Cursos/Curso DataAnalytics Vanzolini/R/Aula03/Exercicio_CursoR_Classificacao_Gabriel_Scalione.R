#indicando semente para replicabilidade

set.seed(30) # assegura que todos tenham o mesmo randomização


head(BancoAlemao)

summary(BancoAlemao)

# Converter todas as colunas do dataset BancoAlemao em factor
index <- 1:ncol(BancoAlemao)
BancoAlemao[ , index] <- lapply(BancoAlemao[ , index], as.factor)
str(BancoAlemao)


#criar conjuntos de treino e teste

sample <- sample(c(TRUE, FALSE), nrow(BancoAlemao), 
                 replace=TRUE, prob=c(0.8,0.2))
train  <- BancoAlemao[sample, ]
test   <- BancoAlemao[!sample, ]

#verificar a proporção da variável resposta

prop.table(table(BancoAlemao$X1))
prop.table(table(train$X1))


#instalar pacote para construção do modelo

install.packages("rpart.plot")
library(rpart.plot)

#construção do modelo

modelo <- rpart(X1~., data = train, method = 'class')

#visualização da árvore
rpart.plot(modelo, extra = 106)

#predição

predicao <- predict(modelo, test, type = 'class')

#MÉTRICAS DE PERFORMANCE

#Matriz de confusão
tabela <- table(test$X1, predicao)
tabela


# Acurácia = acertos / acertos + erros
acuracia <- (23+17+63)/(23+6+27+9+17+36+3+7+9+4+63)
acuracia

# Precisão = verdadeiros positivos / verdadeiros positivos + falsos positivos   
precisao = (23+17+63) / (23+17+63) + (9+3+9+4)
precisao

# Recall = verdadeiros positivos / verdadeiros positivos + falsos negativos

recall = (23+17+63)/(23+17+63) + (6+27+36+7)
recall
