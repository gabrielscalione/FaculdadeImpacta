use AdventureWorksDW2019
go

--Criar uma query que retorne o valor do custo total campo totalproductcost
--englishproductname



SELECT 
	DP.EnglishProductName,
	SUM(FI.TotalProductCost) CUSTO_TOTAL
FROM 
	FactInternetSales FI
	INNER JOIN DimProduct DP
		ON DP.ProductKey = fi.ProductKey
GROUP BY  DP.EnglishProductName

------------------------------------------------------
-- custo total, media de vendas, soma total de vendas 
SELECT 
	DP.EnglishProductName,
	SUM(FI.TotalProductCost) CUSTO_TOTAL,
	SUM(FI.SalesAmount) TOTAL_VENDA,
	avg(FI.SalesAmount) MEDIA_VENDA
FROM 
	FactInternetSales FI
	INNER JOIN DimProduct DP
		ON DP.ProductKey = fi.ProductKey
GROUP BY DP.EnglishProductName

------------------------------------------------------
-- média que pago para cada genero
baserate
gender

select 
	Gender,
	AVG(BaseRate) MEDIA_PAGA_GENERO
from DimEmployee
GROUP BY Gender


------------------------------------------------------
-- média de ganh por cargo
baserate 
title

select 
	Title,
	AVG(BaseRate) MEDIA_GANHO_CARGO
from DimEmployee
GROUP BY Title


------------------------------------------------------
-- Criar uma query retorne os dados FirstName, LastName e Title da tabela DimEmployee.
-- fazer um join com a tabela DimSalesTerritory e retornar os dados SalesTerritoryCountry

select 
	e.FirstName,
	e.LastName,
	e.Title,
	t.SalesTerritoryCountry,
	AVG(BaseRate) MEDIA_GANHO_CARGO
from DimEmployee e
	inner join DimSalesTerritory t
		on e.SalesTerritoryKey = t.SalesTerritoryKey
where
	SalesTerritoryCountry != 'NA'
GROUP BY e.FirstName,
	e.LastName,
	e.Title,
	t.SalesTerritoryCountry

-------------------------------------------------------
