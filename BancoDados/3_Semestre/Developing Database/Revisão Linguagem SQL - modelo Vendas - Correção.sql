--1
SELECT * FROM Venda 
WHERE atendente = 'Marco' 
	AND atendente = 'Pedro'
SELECT * FROM Venda 
WHERE atendente = 'Marco' 
	OR atendente = 'Pedro'

--2
select top 3 * from produto where nome like '%a%'
select distinct preco FROM produto where preco <= 10.00

--3
select * from Itemvenda WHERE QTDE IN ( 1,2,3,4,5,6,7,8,9,10)
select * from Itemvenda where (preco*qtde)<((10/2)+2)

--4
select * from venda INNER JOIN itemvenda on nota_fiscal = NF
select * from venda LEFT JOIN itemvenda on nota_fiscal = NF

--5
select nota_fiscal from venda 
where atendente like 'M%' 
	AND data between '20110401' and '20110601'

--6
select id from itemvenda RIGHT JOIN produto on id = idProduto 
where idProduto is null

--7 
select id from produto where not ( preco = 0.50 or id < 10 )

select id from produto where ( preco <> 0.50 AND id >= 10 )


--8
select atendente, count(*) from venda group by atendente having count(*) > 1
select atendente, count(*) from venda where count(*) > 1 group by atendente 
select atendente, count(*) from venda 


--9 
select	month(data) as mes
		, sum( case when atendente = 'marco' then 1 else 0 end ) as marco
		, sum( case when atendente = 'teresa' then 1 else 0 end ) as teresa
from venda
group by month(data)

mes	 vendas_do_marco	Vendas_da_teresa
03		2					0
04		1					0
05		0					0

--versão simples, não separa os dados entre os atendentes.
select	month(data) as mes, count(*) as total
from venda
group by month(data)

--10 (enunciado traduzido:total de produtos vendidos com desconto )
select sum( qtde ) as total
from itemvenda INNER JOIN Produto ON itemvenda.idproduto = produto.id
where produto.preco > itemvenda.preco

--total de desconto em R$... ( perda / investimento )
select sum( (produto.preco - itemvenda.preco) * qtde ) as total
from itemvenda INNER JOIN Produto ON itemvenda.idproduto = produto.id
where produto.preco > itemvenda.preco

--11 (problema conceitual - questão pegadinha )
select atendente from venda INNER JOIN itemvenda on nota_fiscal = NF where NF is null
select atendente from venda LEFT JOIN itemvenda on nota_fiscal = NF where NF is null
select atendente from venda RIGHT JOIN itemvenda on nota_fiscal = NF where NF is null
select atendente from venda CROSS JOIN itemvenda on nota_fiscal = NF where NF is null

--12 (traduzindo: qual a segunda nota fiscal em ordem)
select top 1 nota_fiscal
from ( 
	select top 2 nota_fiscal from venda order by nota_fiscal asc 
	) subselect
order by nota_fiscal desc


