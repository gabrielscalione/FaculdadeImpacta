
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
	DP.EnglishProductName,
	SUM(FI.SalesAmount) TOTAL_VENDA,
	AVG(FI.SalesAmount) MEDIA_VENDA
FROM 
	FactInternetSales FI
	INNER JOIN DimProduct DP
		ON DP.ProductKey = fi.ProductKey
GROUP BY DP.ProductKey, DP.EnglishProductName


-- A soma total e a média de valor de venda total separada por Customer
-- Buscar na tabela DimCustomer (Campo FirstName)
SELECT 
	DP.FirstName,
	SUM(FI.SalesAmount) TOTAL_VENDA,
	AVG(FI.SalesAmount) MEDIA_VENDA
FROM 
	FactInternetSales FI
	INNER JOIN DimCustomer DP
		ON DP.CustomerKey = fi.CustomerKey
GROUP BY DP.CustomerKey, DP.FirstName
