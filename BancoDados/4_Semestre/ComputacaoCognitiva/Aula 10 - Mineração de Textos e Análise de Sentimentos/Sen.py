#-*- coding: utf-8 -*-


# Bibliotecas padrão
import pandas as pd

## Carrega os dados
dataset = pd.read_csv('Input.csv', sep=';') 

print()
print('POLARIDADE REAL_SENTIMENT PREV_SENTIMENT RESULTADO')
# Varre o arquivo de entrada
from textblob import TextBlob
for index, row in dataset.iterrows():
    sentiment = TextBlob(row['Text'])

    dataset.at[index,'POLARITY']  = sentiment.sentiment.polarity;
    
    # Polaridade
    #Classificação do sentimento - Limiar determinado por testes
    if dataset.at[index,'POLARITY']  > 0.05: dataset.at[index,'PREV_SENTIMENT']  =  'positive';
    else:dataset.at[index,'PREV_SENTIMENT']  =  'negative';
    #
    if dataset.at[index,'Sentiment'] == dataset.at[index,'PREV_SENTIMENT']: dataset.at[index,'ERRO'] = 'CERTO';
    else:dataset.at[index,'ERRO'] = 'ERRADO';
 
    print(str(sentiment.sentiment.polarity),dataset.at[index,'Sentiment'],dataset.at[index,'PREV_SENTIMENT'], dataset.at[index,'ERRO'] )

## Exporta os dados para avaliar resultados em outra ferramenta
dataset['Text'] = [x[:10] for x in dataset['Text']] #Reduzindo o texto para análise
dataset.to_csv('resultado_comparacao.csv',  sep='|')



# Cálculo da Acurácia
Resultado = dataset.groupby('ERRO').count()
del Resultado['Sentiment']
del Resultado['POLARITY']
del Resultado['PREV_SENTIMENT']
ACURACIA = Resultado.loc['CERTO'].values/dataset['ERRO'].count()
print()
print('A Acurácia é:', ACURACIA)
print('O Erro de Classificação é:', 1-ACURACIA)
print()
######################################################################
# Variações do limiar da polaridade: 0, 0.08, 0.10, e 0.12
######################################################################



