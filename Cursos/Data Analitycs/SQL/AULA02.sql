-- Criar um banco de dados (AULA02)
create database DASQLAula02

USE DASQLAula02
-- Criar 3 tabelas dentro do banco de dados
	-- CARRO     (NOME,TIPO,VALOR)
	-- LOJA      (NOME,LOCAL,FATURAMENTO)
	-- VENDEDOR  (NOME,IDADE,SALARIO)

Create table CARRO
(
NOME	VARCHAR(50),
TIPO	VARCHAR(30),
VALOR	INT
)
Create table LOJA
(
NOME	VARCHAR(50),
LOCAL	VARCHAR(30),
FATURAMENTO	VARCHAR(10)
)
CREATE TABLE VENDEDOR
(
NOME	VARCHAR(50),
IDADE	INT,
SALARIO	INT
)

--
ALTER TABLE LOJA
ALTER COLUMN FATURAMENTO INT

-------------------------------------------------
-- Inserir 5 linhas dentro das tabelas criadas
INSERT INTO CARRO VALUES ('Fiat Palio','Hatch',30000)
INSERT INTO CARRO VALUES ('Fiat Idea','Minivan',30000)
INSERT INTO CARRO VALUES ('Volkswagen Golf','Hatch',40000)
INSERT INTO CARRO VALUES ('Honda City','Sedan',35000)


INSERT INTO LOJA VALUES ('Loja 01','Barueri',200000)

INSERT INTO VENDEDOR VALUES ('Luis Gustavo Batista de Oliveira Silva',54,8000)

-- Mostrando os dados dentro das tabelas
SELECT * FROM CARRO
SELECT * FROM LOJA
SELECT * FROM VENDEDOR

--Apagar tudo que tem dentro da tabela
TRUNCATE TABLE CARRO

--Alterando a tabela e adicionando as colunas de ID
ALTER TABLE CARRO
ADD ID_CARRO INT IDENTITY

ALTER TABLE LOJA
ADD ID_LOJA INT IDENTITY

ALTER TABLE VENDEDOR
ADD ID_VENDEDOR INT IDENTITY

-- DROPANDO COLUNA
ALTER TABLE CARRO
DROP COLUMN ID_CARRO




SELECT * FROM CARRO
SELECT * FROM LOJA
SELECT * FROM VENDEDOR


-- Criar 3 selects que retornem todas as colunas das tabelas criadas mudando o nome delas usando os ALIAS
SELECT
NOME  AS 'Nome do carro',
TIPO  'Categoria do carro',
VALOR [Preço do Carro],
ID_CARRO 'ID'
FROM CARRO

SELECT
--NOME,
LOCAL,
FATURAMENTO
FROM LOJA 

SELECT
Nome,
IDADE
FROM VENDEDOR

-- ALIAS de Tabela

select 

V.NOME,
V.IDADE,
V.SALARIO

from VENDEDOR V

--------------------------------------------------------

-- CALCULOS COM AS COLUNAS

select 30000+30000+40000+35000


SELECT

SUM(VALOR) 'Soma total dos valores',
AVG(VALOR)'Média de valor de carro',
COUNT(ID_CARRO) 'Contagem de carros'

FROM CARRO

-- Soma total dos valores de carros que existem na tabela

SELECT 
SUM(VALOR)  'Soma total dos valores de carros'
FROM CARRO

-- Quantos carros existem na tabela carro?

SELECT
COUNT(ID_CARRO) 'Quantos carros existem'
FROM CARRO

-- Quanto é investido em salários?

SELECT
SUM(SALARIO) 'Quanto é investido em salários'
FROM VENDEDOR

-- Quanto eu faturo nas lojas?

SELECT
SUM(FATURAMENTO) 'Faturamento'
FROM LOJA

----------------------
--Agrupar dados

SELECT * FROM CARRO


SELECT

TIPO,
SUM(VALOR) 'SOMA TOTAL',
AVG(VALOR) 'MÉDIA'

FROM CARRO
GROUP BY TIPO

-- Faturamento da loja por LOCAL

SELECT * FROM LOJA


SELECT

FATURAMENTO,
LOCAL

FROM LOJA



SELECT
SUM(FATURAMENTO) 'Faturamento total',
LOCAL
FROM LOJA
GROUP BY LOCAL


-- RETORNAR DADOS DISTINTOS NA BUSCA
SELECT 

DISTINCT TIPO

FROM CARRO

select
*
from CARRO
where TIPO = 'Hatch'

select * from carro where TIPO = 'Sedan'


/*
EXERCICIO PARA CASA


-- CRIAR BANCO DE DADOS COM O NOME CONTROLE_GERAL
-- CRIAR 3 TABELAS

ESTOQUE			- ID,QUANTIDADE, NOME_PRD, DISPONIVEL ('Sim' ou 'Não'), NUMERO DA NOTA
VENDA			- ID,VALOR, PROD, QUANTIDADE, VENDEDOR,FILIAL
CLIENTES		- ID,NOME, CPF, END, SEXO, CIDADE

-- INSERIR 10 REGISTROS PARA CADA TABELA (TODAS AS TABELAS COM ID IDENTITY)

-- Criar um select que retorne todos os dados de cada tabela

-- Quanto de cada produto eu tenho disponivel em estoque (where DISPONIVEL = 'Sim')

-- Quantidade total vendida de produto

-- Quantos clientes eu tive?


*/