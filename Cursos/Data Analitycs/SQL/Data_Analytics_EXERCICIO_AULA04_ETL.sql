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
