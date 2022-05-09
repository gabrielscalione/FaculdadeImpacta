
SELECT * FROM DIM_CARRO
SELECT * FROM DIM_VENDEDOR
SELECT * FROM DIM_LOJA
SELECT * FROM FATO_VENDA

SELECT
ID_VENDA
,VALOR_VENDA
,ID_CARRO
,ID_LOJA
,ID_VENDEDOR
FROM FATO_VENDA

SELECT
ID_CARRO
,MODELO
FROM DIM_CARRO

SELECT
ID_VENDEDOR
,NOMEVENDEDOR
FROM DIM_VENDEDOR

SELECT
ID_LOJA
,RAZAOSOCIAL
FROM DIM_LOJA


CREATE VIEW vwBUSCAGERAL
AS
SELECT

f.ID_VENDA
,c.MODELO
,l.RAZAOSOCIAL
,v.NOMEVENDEDOR
,f.VALOR_VENDA

FROM FATO_VENDA f
INNER JOIN DIM_CARRO c
	ON f.ID_CARRO = c.ID_CARRO
INNER JOIN DIM_LOJA l
	ON f.ID_LOJA = l.ID_LOJA
INNER JOIN DIM_VENDEDOR v
	ON f.ID_VENDEDOR = v.ID_VENDEDOR


SELECT * FROM vwBUSCAGERAL

----------------------------------------------------------------

/*
EXERCICIO

Criar uma query que busque os dados da Dimensão Vendedor e da Fato Venda,
com essa junção retornar a soma de venda de cada um dos vendedores 
(use SUM no campo de Valor_venda e use um Group By pelo Nome do Vendedor)

Nome do Vendedor  |  Valor total vendido  |

-- A query deve se tornar uma vwVendasPorVendedor.
*/

CREATE VIEW vwVendasPorVendedor
AS
SELECT

v.NOMEVENDEDOR as 'Nome do Vendedor'
,SUM(f.VALOR_VENDA) AS 'Valor Total Vendido'

FROM FATO_VENDA AS f
JOIN DIM_VENDEDOR AS v
	ON f.ID_VENDEDOR = v.ID_VENDEDOR
GROUP BY v.NOMEVENDEDOR


-- Buscando a View
SELECT * FROM vwVendasPorVendedor


select * from tabelageral




















