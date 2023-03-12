install.packages("dplyr")

# Pacotes a serem utilizados neste post
library(dplyr)
library(readr)
library(rpart)
library(rpart.plot)
library(xtable)

# Lendo os dados do titanic a partir de repositório, selecionando e tratando variáveis
dados_df <- TABELAO_POP_TEMPO_MODAL 


# Mostrando o head dos dados
print(dados_df)


# Separar os dados em treino e teste
set.seed(123)
.data <- c("training", "test") %>%
  sample(nrow(dados_df), replace = T) %>%
  split(dados_df, .)


# Criar a árvore de decisão por Divisão Modal
rtree_fit <- rpart(DIVISAO_MODAL ~ ., 
                   .data$training
)
rpart.plot(rtree_fit)

################################

# Criar a árvore de decisão por percentual de utilização
rtree_fit <- rpart(PERC_UTILIZACAO ~ ., 
                   .data$training
)
rpart.plot(rtree_fit)

################################

# Criar a árvore de decisão por tempo médio de deslocamento
rtree_fit <- rpart(TEMPO_MEDIO ~ ., 
                   .data$training
)
rpart.plot(rtree_fit)