#indicando semente para replicabilidade

set.seed(30)

#importar os dados

library(readr)
titanic <- read_csv("titanic.csv")

head(titanic)

#limpeza dos dados em 3 passos

install.packages("dplyr")
library(dplyr)

#passo 1: excluir as colunas cabin, PassengerID, name, ticket

clean_titanic <- subset(titanic, select= -c(Cabin, PassengerId, Name, Ticket))
  
#passo 2: criar fatores para pclass e survived

clean_titanic$Pclass = factor(clean_titanic$Pclass, labels = c(""))
clean_titanic$Survived = as.factor(clean_titanic$Survived) 

#passo 3: excluir os NA

clean_titanic <- na.omit(clean_titanic)
glimpse(clean_titanic)

#criar conjuntos de treino e teste

sample <- sample(c(TRUE, FALSE), nrow(clean_titanic), 
                 replace=TRUE, prob=c(0.8,0.2))
train  <- clean_titanic[sample, ]
test   <- clean_titanic[!sample, ]

#verificar a proporção da variável resposta

prop.table(table(clean_titanic$Survived))
prop.table(table(train$Survived))

#instalar pacote para construção do modelo

install.packages("rpart.plot")
library(rpart.plot)

#construção do modelo

modelo <- rpart(Survived~., data = train, method = 'class')

#visualização da árvore
rpart.plot(modelo, extra = 106)
           
#predição

predicao <- predict(modelo, test, type = 'class')

#MÉTRICAS DE PERFORMANCE

#Matriz de confusão
tabela <- table(test$Survived, predicao)
tabela

#neste caso, o modelo classificou corretamente 78 passageiros que falecidos e
#33 passageiros que sobreviveram. Porém, o modelo classificou 11 falecidos como
#sobreviventes e 22 sobreviventes como falecidos.

# Acurácia = acertos / acertos + erros
acuracia <- (67+35)/(67+35+11+21)

# Precisão = verdadeiros positivos / verdadeiros positivos + falsos positivos   

precisao = 35/(35+11)

# Recall = verdadeiros positivos / verdadeiros positivos + falsos negativos

recall = 35/(35+21)

# Converter todas as colunas do dataset BancoAlemao em factor
index <- 1:ncol(BancoAlemao)
BancoAlemao[ , index] <- lapply(BancoAlemao[ , index], as.factor)
str(BancoAlemao)