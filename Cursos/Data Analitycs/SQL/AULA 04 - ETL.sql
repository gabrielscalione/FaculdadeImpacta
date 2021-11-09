/*
	DATA ANALITYCS AULA 04 - ETL
*/
CREATE DATABASE DataAnalitycsDW
GO

USE DataAnalitycsDW
GO

CREATE TABLE DimProduto (
		ID_Produto int Identity,
		ChabeProduto INT,
		NomeProduto VARCHAR(MAX)
	)
GO
CREATE TABLE FatoVenda (
		ID_Venda int identity,
		ChaveProduto int,
		ValorVenda decimal(18,8),
		CustoTotal decimal(18,8)
	)
GO


----------------------------------------
-- Insert na tabela FatoVenda

INSERT INTO FatoVenda
SELECT 
	ProductKey,
	SalesAmount,
	TotalProductCost
FROM AdventureWorksDW2019.DBO.FactInternetSales

select * from FatoVenda

----------------------------------------
-- Insert na Tabela DimProduto

INSERT INTO DimProduto
SELECT 
	ProductKey,
	EnglishProductName
FROM AdventureWorksDW2019.DBO.DimProduct

select * from DimProduto

----------------------------------------
/* Criar uma tabela que guarda os dados de 
	employeekey ChaveColaborador, 
	firstname PrimeiroNome,
	lastname UltimoNome
	midlename SegundoNome
	e o title Cargo. 
  Realizar um ETL para adicionar os dados 
*/

CREATE TABLE DimColaborador (
	  ID_Colaborador int identity,
	  ChaveColaborador int
	, PrimeiroNome	varchar(255)
	, UltimoNome varchar(255)
	, SegundoNome varchar(255)
	, Cargo varchar(255)
) 
go 

INSERT INTO DimColaborador
select 
	EmployeeKey ,
	FirstName ,
	LastName ,
	MiddleName ,
	Title
from AdventureWorksDW2019.dbo.DimEmployee

select  * from DimColaborador

------
/* Realizar um ETL da DimCustomer, deve ter como tabela destino a seguinte tabela
	DimCliente, deve guardar os dados de primeiro nome , ultimo nome, data nascimento, 
	chaveRegiao (geografykey) E Ganho anuais (yearlyhome)
*/

SELECT 
	CustomerKey,
	FirstName,
	LastName,
	BirthDate,
	GeographyKey,
	YearlyIncome
FROM 
	AdventureWorksDW2019.dbo.DimCustomer

create TABLE DimCliente (
	  Id_Cliente int identity
	, ChaveCliente int
	, ChaveRegiao int
	, PrimeiroNome varchar(255)
	, UltimoNome  varchar(255)
	, DataNascimento date
	, GanhoAnual money
)

insert into DimCliente 
SELECT 
	CustomerKey,
	GeographyKey,
	FirstName,
	LastName,
	BirthDate,
	YearlyIncome
FROM 
	AdventureWorksDW2019.dbo.DimCustomer

select * from DimCliente

--------------------------------------------------------
-- Exercícios
--------------------------------------------------------


/*
	Uma query que retorne agrupado pelo nome do produto
	a soma do valor de venda total
*/

select * from DimCliente
select * from DimColaborador
select * from DimProduto
select * from FatoVenda


select 
	p.NomeProduto,
	sum(f.ValorVenda) VendaTotal
from
	FatoVenda f
	inner join DimProduto p
		on p.ChabeProduto = f.ChaveProduto
group by NomeProduto



/*
	Ajustar a Tabela "FatoVenda" adicionando o customerkey como uma coluna adicional
*/
--Adiciona a coluna ChaveCliente
	ALTER TABLE FatoVenda
	ADD ChaveCliente int

--Atualiza a chave cliente de acordo com a chave de produto
	UPDATE FatoVenda
	SET
		ChaveCliente = Customerkey
	from
		AdventureWorksDW2019.DBO.FactInternetSales Af
	where
		af.ProductKey = ChaveProduto

/*
	Criar uma query, retorne todos os dados dos Clientes (primeiro nome, ultimonome, data nascimento)
	, de cada uma das vendas realizadas
*/
	
	SELECT 
		PrimeiroNome,
		UltimoNome,
		DataNascimento,
		v.ValorVenda
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
