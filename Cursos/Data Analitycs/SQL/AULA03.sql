--JOINS!

CREATE TABLE TabelaA(
  Nome varchar(50) NULL
)

GO

CREATE TABLE TabelaB(
  Nome varchar(50) NULL
)

INSERT INTO TabelaA VALUES('Fernanda')
INSERT INTO TabelaA VALUES('Josefa')
INSERT INTO TabelaA VALUES('Luiz')
INSERT INTO TabelaA VALUES('Fernando')

INSERT INTO TabelaB VALUES('Carlos')
INSERT INTO TabelaB VALUES('Manoel')
INSERT INTO TabelaB VALUES('Luiz')
INSERT INTO TabelaB VALUES('Fernando')

SELECT NOME FROM TABELAA
SELECT NOME FROM TABELAB


--INNER JOIN
hahaha
SELECT
a.Nome
,b.Nome
FROM TabelaA as A
JOIN TabelaB as B
	on a.Nome = b.Nome

--LEFT JOIN
SELECT a.Nome, b.Nome
FROM TabelaA as A
LEFT JOIN TabelaB as B
                on a.Nome = b.Nome
WHERE B.NOME IS NULL


--RIGHT JOIN
SELECT a.Nome, b.Nome
FROM TabelaA as A
RIGHT JOIN TabelaB as B
  on a.Nome = b.Nome
WHERE A.NOME IS NULL

-- (FULL) OUTER JOIN
SELECT a.Nome, b.Nome
FROM TabelaA as A
FULL OUTER JOIN TabelaB as B
    on a.Nome = b.Nome 
WHERE A.NOME IS NULL OR B.NOME IS NULL






---------------------------------------------------
USE DASQLAula02
GO

--BUSCANDO AS TABELAS QUE IREMOS JUNTAR	
SELECT * FROM CARRO
SELECT * FROM VENDEDOR
SELECT * FROM LOJA

INSERT INTO LOJA VALUES ('Loja02','São Paulo',32154)
INSERT INTO LOJA VALUES ('Loja03','Rio de Janeiro',3215)
INSERT INTO LOJA VALUES ('Loja04','Minas Gerais',654321)


INSERT INTO VENDEDOR VALUES ('João de Deus',35,5000)
INSERT INTO VENDEDOR VALUES ('Maria',27,10000)

-- Alterando a tabela para adicionar o campo que vamos usar como junção (chave)
ALTER TABLE CARRO
ADD ID_VENDEDOR INT
ALTER TABLE CARRO
ADD ID_LOJA INT

-- Populando o campo com o update, campo novo sendo populado
update CARRO
set id_vendedor = 2
	, ID_LOJA = 3
where
	ID_CARRO = 4
---------------------------------------------------

SELECT 
	*
FROM CARRO C
	JOIN LOJA L
		ON C.ID_LOJA = L.ID_LOJA

SELECT 
	*
FROM CARRO C
	JOIN VENDEDOR V
		ON C.ID_VENDEDOR = V.ID_VENDEDOR


SELECT 
	C.NOME,
	C.TIPO,
	C.VALOR,
	V.NOME AS NOME_VENDEDOR,
	V.IDADE,
	L.NOME AS NOME_LOJA,
	L.LOCAL
FROM CARRO C
	JOIN VENDEDOR V
		ON C.ID_VENDEDOR = V.ID_VENDEDOR
	JOIN LOJA L
		ON C.ID_LOJA = L.ID_LOJA	

---------------------------------------------------

Use AdventureWorksDW2019
go



SELECT 
	FI.SalesOrderNumber,
	FI.SalesAmount,
	FI.CustomerKey,
	DC.FirstName,
	DC.LastName,
	DC.BirthDate,
	DC.CustomerKey

FROM 
	FactInternetSales FI
	INNER JOIN DimCustomer DC
		ON dc.CustomerKey = fi.CustomerKey

-- Soma do valor total que foi vendido (SalesAmount)
select sum(SalesAmount) as ValorTotal
from FactInternetSales

-- Média de custo do produto (TotalProductCost)
select avg(SalesAmount) as MediaDeCusto
from FactInternetSales

-- A soma total e a média de valor de venda total separada por produto 
-- (buscar a coluna English Product Name dentro da tabela DimProduct)

SELECT 
	DP.ProductKey,
	DP.EnglishProductName,
	SUM(FI.SalesAmount) TOTAL_VENDA,
	avg(FI.SalesAmount) MEDIA_VENDA
FROM 
	FactInternetSales FI
	INNER JOIN DimProduct DP
		ON DP.ProductKey = fi.ProductKey
GROUP BY DP.ProductKey, DP.EnglishProductName


-- A soma total e a média de valor de venda total separada por Customer
-- Buscar na tabela DimCustomer (Campo FirstName)
SELECT 
	DP.CustomerKey,
	DP.FirstName,
	SUM(FI.SalesAmount) TOTAL_VENDA
FROM 
	FactInternetSales FI
	INNER JOIN DimCustomer DP
		ON DP.CustomerKey = fi.CustomerKey
GROUP BY DP.CustomerKey, DP.FirstName

SELECT 
	DP.CustomerKey,
	DP.FirstName,
	AVG(FI.SalesAmount) MEDIA_VENDA
FROM 
	FactInternetSales FI
	INNER JOIN DimCustomer DP
		ON DP.CustomerKey = fi.CustomerKey
GROUP BY DP.CustomerKey, DP.FirstName
