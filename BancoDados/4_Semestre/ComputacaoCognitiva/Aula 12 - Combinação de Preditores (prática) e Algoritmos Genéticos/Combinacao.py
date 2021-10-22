##------------------------------------------------------------------------
## Autor: Prof. Roberto Angelo
##------------------------------------------------------------------------

# Bibliotecas padrão utilizadas
import numpy as np
import pandas as pd

## Carregando os dados
dataset = pd.read_csv('Case_cobranca.csv') 

#------------------------------------------------------------------------------
# Pré-processamento das variáveis
#------------------------------------------------------------------------------
## Tratamento de nulos no alvo --- Tempo de Atraso - transformação para alvo binário (>90 dias) 
dataset['ALVO']   = [0 if np.isnan(x) or x > 90 else 1 for x in dataset['TEMP_RECUPERACAO']]

## Tratamento de nulos e normalização --- Variáveis de entrada numéricas
dataset['PRE_IDADE']        = [18 if np.isnan(x) or x < 18 else x for x in dataset['IDADE']] # Trata mínimo
dataset['PRE_IDADE']        = [1. if x > 76 else (x-18)/(76-18) for x in dataset['PRE_IDADE']] # Trata máximo por percentil 99 e coloca na fórmula
dataset['PRE_QTDE_DIVIDAS'] = [0.  if np.isnan(x) else x/16. for x in dataset['QTD_DIVIDAS']] # retirada de outlier com percentil 99 e normalização     
##--- Dummies - transformação de atributos categóricos em numéricos e tratamanto de nulos ---------------
dataset['PRE_TOMADOR']         = [1 if x=='TOMADOR'          else 0 for x in dataset['TIPO_CLIENTE']]    
dataset['PRE_INVESTIDOR']         = [1 if x=='INVESTIDOR'    else 0 for x in dataset['TIPO_CLIENTE']]    
dataset['PRE_NOVO_VAZIO']= [1 if x=='NOVO' or str(x)=='nan'  else 0 for x in dataset['TIPO_CLIENTE']]                        
dataset['PRE_CDC']          = [1 if x=='CDC'                 else 0 for x in dataset['TIPO_EMPRESTIMO']]
dataset['PRE_PESSOAL']      = [1 if x=='PESSOAL'             else 0 for x in dataset['TIPO_EMPRESTIMO']]
dataset['PRE_SEXO_M']       = [1 if x=='M'                   else 0 for x in dataset['CD_SEXO']]
dataset['PRE_SEXO_F']       = [1 if x=='F'                   else 0 for x in dataset['CD_SEXO']]

#------------------------------------------------------------------------------
# Selecionando as colunasjá pré-processadas
#------------------------------------------------------------------------------
cols_in =  [   'PRE_IDADE'
              ,'PRE_QTDE_DIVIDAS'
              ,'PRE_TOMADOR'
              ,'PRE_INVESTIDOR'
              ,'PRE_NOVO_VAZIO'
              ,'PRE_CDC'
              ,'PRE_PESSOAL'
              ,'PRE_SEXO_M'
              ,'PRE_SEXO_F'] 

#------------------------------------------------------------------------------
## Separando em dados de treinamento e teste
#------------------------------------------------------------------------------
y = dataset['ALVO']         # Carrega alvo ou dataset.iloc[:,7].values
X = dataset.loc[:,cols_in]  # Carrega pré-processadas
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.25, random_state = 25)

#---------------------------------------------------------------------------
## Ajustando modelos - Aprendizado supervisionado  
#---------------------------------------------------------------------------
# Modelos Simples
from sklearn.tree import DecisionTreeClassifier
# from sklearn.linear_model import LinearRegression
# from sklearn.linear_model import LogisticRegression
# from sklearn.neural_network import MLPClassifier 
# from sklearn.neighbors import KNeighborsClassifier
# Outros...

# Árvore de decisão com dados de treinamento (Simples)
dtree = DecisionTreeClassifier(criterion = 'entropy', max_depth=5, min_samples_split=30, random_state = 10,)
dtree.fit(X_train, y_train)

# RandomForest com dados de treinamento
from sklearn.ensemble import RandomForestClassifier
RandomForest = RandomForestClassifier(n_estimators=10, max_depth=5, min_samples_split=30, random_state=10)
RandomForest.fit(X_train, y_train)

# ExtraTreesClassifier com dados de treinamento
from sklearn.ensemble import ExtraTreesClassifier
ExtraTreesClassifier = ExtraTreesClassifier(n_estimators=10, max_depth=5, min_samples_split=30, random_state=10)
ExtraTreesClassifier.fit(X_train, y_train)

# Bagging com dados de treinamento
from sklearn.ensemble import BaggingClassifier
Bagging = BaggingClassifier(base_estimator=DecisionTreeClassifier(),n_estimators=10, random_state=10)
Bagging.fit(X_train, y_train)


#------------------------------------------------------------------------------
## Previsão (Classificação e Regressão) usando todos os conjuntos (TRN e TST)
#------------------------------------------------------------------------------
# Árvore de Decisão
y_pred_train_DT = dtree.predict(X_train)
y_pred_test_DT  = dtree.predict(X_test)
y_pred_train_DT_P  = dtree.predict_proba(X_train)
y_pred_test_DT_P  = dtree.predict_proba(X_test)
# RandomForest
y_pred_train_RF = RandomForest.predict(X_train)
y_pred_test_RF  = RandomForest.predict(X_test)
y_pred_train_RF_P = RandomForest.predict_proba(X_train)
y_pred_test_RF_P  = RandomForest.predict_proba(X_test)
# ExtraTreesClassifier
y_pred_train_ETC = ExtraTreesClassifier.predict(X_train)
y_pred_test_ETC  = ExtraTreesClassifier.predict(X_test)
y_pred_train_ETC_P = ExtraTreesClassifier.predict_proba(X_train)
y_pred_test_ETC_P  = ExtraTreesClassifier.predict_proba(X_test)
# Bagging
y_pred_train_BAG = Bagging.predict(X_train)
y_pred_test_BAG  = Bagging.predict(X_test)
y_pred_train_BAG_P = Bagging.predict_proba(X_train)
y_pred_test_BAG_P  = Bagging.predict_proba(X_test)

##-----------------------------------------------------------------
## Avaliação de Desempenho
##-----------------------------------------------------------------
## Cálculo dos erros da classificação e MSE (Mean Squared Error) Desicion Tree
Erro_DT_Classificacao = np.mean(np.absolute(y_pred_test_DT - y_test))
Erro_DT_MSE = np.mean((y_pred_test_DT_P[:,1] - y_test) ** 2) 
## Cálculo dos erros da classificação e MSE (Mean Squared Error) RandomForest
Erro_RF_Classificacao = np.mean(np.absolute(y_pred_test_RF -y_test))
Erro_RF_MSE = np.mean((y_pred_test_RF_P[:,1] - y_test) ** 2) 
## Cálculo dos erros da classificação e MSE (Mean Squared Error) ExtraTreesClassifier
Erro_ETC_Classificacao = np.mean(np.absolute(y_pred_test_ETC - y_test))
Erro_ETC_MSE = np.mean((y_pred_test_ETC_P[:,1] - y_test) ** 2) 

## Cálculo dos erros da classificação e MSE (Mean Squared Error) Bagging
Erro_BAG_Classificacao = np.mean(np.absolute(y_pred_test_BAG - y_test))
Erro_BAG_MSE = np.mean((y_pred_test_BAG_P[:,1] - y_test) ** 2) 

print()
print('--------- Erro de Classificação ---------')
print('Árvore de Decisão   :',Erro_DT_Classificacao)
print('RandomForest        :',Erro_RF_Classificacao)
print('ExtraTreesClassifier:',Erro_ETC_Classificacao)
print('Bagging             :',Erro_BAG_Classificacao)
print()
print('------------------ MSE ------------------')
print('Árvore de Decisão   :',Erro_DT_MSE)
print('RandomForest        :',Erro_RF_MSE)
print('ExtraTreesClassifier:',Erro_ETC_MSE)
print('Bagging             :',Erro_BAG_MSE)

#------------------------------------------------------------------------------
## Montando um Data Frame (Matriz) com os resultados
#------------------------------------------------------------------------------
# Conjunto de treinamento
df_train = pd.DataFrame(y_pred_train_DT, columns=['CLASSIF_DT'])
df_train['CLASSIF_RF'] = y_pred_train_RF
df_train['CLASSIF_ETC'] = y_pred_train_ETC
df_train['CLASSIF_BAG'] = y_pred_train_BAG
df_train['REGRESSION_DT'] = y_pred_train_DT_P[:,1]
df_train['REGRESSION_RF'] = y_pred_train_RF_P[:,1]
df_train['REGRESSION_ETC'] = y_pred_train_ETC_P[:,1]
df_train['REGRESSION_BAG'] = y_pred_train_BAG_P[:,1]
df_train['TARGET'] = y_train
df_train['CONJUNTO'] = 'TRAIN'
# Conjunto de test
df_test = pd.DataFrame(y_pred_test_DT, columns=['CLASSIF_DT'])
df_test['CLASSIF_RF'] = y_pred_test_RF
df_test['CLASSIF_ETC'] = y_pred_test_ETC
df_test['CLASSIF_BAG'] = y_pred_test_BAG
df_test['REGRESSION_DT'] = y_pred_test_DT_P[:,1]
df_test['REGRESSION_RF'] = y_pred_test_RF_P[:,1]
df_test['REGRESSION_ETC'] = y_pred_test_ETC_P[:,1]
df_test['REGRESSION_BAG'] = y_pred_test_BAG_P[:,1]
df_test['TARGET'] = y_test
df_test['CONJUNTO'] = 'TEST'


# Juntando Conjunto de Teste e Treinamento
df_total = pd.concat([df_test, df_train])

## Exportando os dados para avaliação dos resultados
df_total.to_csv('resultado_comparacao.csv')

