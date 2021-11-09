
use AdventureWorksDW2019
go


--- tratamento com datas
SELECT 
	OrderDate as data,
	YEAR(OrderDate) as ano,
	MONTH(OrderDate) as Mes,
	DAY(OrderDate) as dia,
	
	-- outra forma
	LEFT(OrderDateKey,4) as ano2,
	RIGHT (OrderDateKey,2) as mes2,
	LEFT(RIGHT(OrderDateKey,4),2) as dia2
FROM FactInternetSales

-- dueDate

SELECT 
	DueDate as data,
	YEAR(DueDate) as ano,
	MONTH(DueDate) as Mes,
	DAY(DueDate) as dia,
	
	-- outra forma
	LEFT(DueDateKey,4) as ano2,
	RIGHT (DueDateKey,2) as mes2,
	LEFT(RIGHT(DueDateKey,4),2) as dia2
FROM FactInternetSales

--------------------------------------
use DataAnalitycsDW
go

select * from DimColaborador
select * from DimCliente
select * from FatoVenda


	SELECT 
		c.PrimeiroNome,
		c.UltimoNome,
		c.DataNascimento,
		c.GanhoAnual,
		v.ValorVenda,
		v.CustoTotal
	FROM FatoVenda V
	INNER JOIN DimCliente C
		ON C.ChaveCliente = V.ChaveCliente

/* 
	Criar uma query, que retorne o quanto cada cliente 
	gastou com a soma das vendas que foram feitas a ele

*/
	SELECT 
		PrimeiroNome,
		UltimoNome,
		Sum(isnull(v.ValorVenda,0)) as TotalVenda
	FROM FatoVenda V
	left JOIN DimCliente C
		ON C.ChaveCliente = V.ChaveCliente
	group by PrimeiroNome,
		UltimoNome


-------------------------------------------------------
-- Exercícios


select * from FatoVenda
select * from DimColaborador
select * from DimCliente
select * from DimProduto

select * from AdventureWorksDW2019.dbo.DimCustomer

-- Realizar um ETL da tabela abaixo
select GeographyKey, City, EnglishCountryRegionName 
from AdventureWorksDW2019.dbo.DimGeography

create table DimRegional (
	Id_Regional int identity not null,
	ChaveRegiao int,
	Cidade varchar(255),
	Pais varchar(255)
)
-- 
Insert into DimRegional
select GeographyKey, City, EnglishCountryRegionName 
from AdventureWorksDW2019.dbo.DimGeography

select * from DimRegional


---------------------------------------------------------
use AulaFinal
go

-- nome de tabelas 
select * from [Base de dados]


---------------------------------------------------------
--PROCEDURES
---------------------------------------------------------

use DataAnalitycsDW
go
create procedure teste @campo varchar(50)
as 
select * from DimCliente
where ChaveRegiao =  @campo


exec dbo.teste '32'

-----------------------------

create procedure sp_consulta_tabelas
as 
	select * from FatoVenda
	select * from DimColaborador
	select * from DimCliente
	select * from DimProduto

exec dbo.sp_consulta_tabelas

---------------------------

select 
	*,
	case 
		when ValorVenda > 4000 then 'Muito Caro'
		when ValorVenda < 2000 then 'Caro'
		else 'Barato'
	end Sit
from FatoVenda


--- Exercicio Criar uma query que retorne a chave de região e se ela tiver dentro
--	dentro dos critérios retornar os dados correspondentes


select 
	ChaveRegiao,
	case 
		when ChaveRegiao = 26 then 'Barueri'
		when ChaveRegiao = 37 then 'São Paulo'
		when ChaveRegiao = 31 then 'Osasco'
		when ChaveRegiao = 11 then 'Curitiba'
		when ChaveRegiao = 19 then 'Rio de Janeiro'
		else 'Lisboa'
	end Regiao
from DimCliente