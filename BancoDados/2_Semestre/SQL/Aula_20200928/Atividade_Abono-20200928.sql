/*
2- Preciso que crie uma consulta trazendo as seguintes colunas:
Nome da categoria do produto.
Nome, n�mero, cor, custo padr�o, pre�o lista, tamanho e peso do produto
Nome do modelo do produto.
AS tabelas s�o VENDA.CATEGORIA_PRODUTO, VENDA.PRODUTO, VENDA.MODELO_PRODUTO)

Obs:
O nome do produto n�o pode ter espa�os e tem que ter todas as letras mai�sculas.
Consegue concatenar um h�fen e o nome da cor no final do nome do produto?
Poderia arredondar para baixo o custo padr�o e arredondar para cima o pre�o lista?
Se o tamanho estiver vazio, poderia trazer o valor 0 no lugar?
Se o tamanho vier como �M� dever� ser 49, se vier �P� dever� ser 32, se vier �L� dever� ser 52 e se vier XL dever� ser 70. Nos outros casos, mantenha o valor do tamanho.
Poderia criar uma coluna chamada C�digo Produto. Essa coluna deve conter os dois primeiros d�gitos do n�mero do produto.
Poderia criar uma coluna chamada C�digo Final. Essa coluna deve conter os dois ultimos d�gitos do n�mero do produto.
Poderia substituir o h�fen no nome do modelo do produto por um espa�o?
Poderia criar uma coluna com um ranking dos produtos mais caros? 

*/


SELECT
	CONCAT(REPLACE(UPPER(P.NOME), ' ',''),'-',COR) AS PRODUTO,
	C.NOME AS NOME_CATEGORIA,
	P.NUMERO_PRODUTO,
	P.COR,
	FLOOR(P.CUSTO_PADRAO)  AS CUSTO_PADRAO,
	CEILING(P.PRECO_LISTA) AS PRECO_LISTA,
	CASE WHEN P.TAMANHO IS NULL THEN '0'
		 WHEN P.TAMANHO = 'M' THEN '49'
		 WHEN P.TAMANHO = 'P' THEN '32'
		 WHEN P.TAMANHO = 'L' THEN '52'
		 WHEN P.TAMANHO = 'XL' THEN '70'
	  ELSE
		 P.TAMANHO	
	END AS TAMANHO,
	LEFT(P.NUMERO_PRODUTO,2) AS CODIGO_PRODUTO,
	RIGHT(P.NUMERO_PRODUTO,2) AS CODIGO_FINAL,
	P.PESO,
	REPLACE(M.NOME,'-',' ') AS MODELO,
	DENSE_RANK() OVER (ORDER BY P.PRECO_LISTA DESC) RANKING_PRODUTO_MAIS_CARO 
FROM 
	VENDA.PRODUTO P
	LEFT JOIN VENDA.CATEGORIA_PRODUTO C
		ON C.ID_CATEGORIA_PRODUTO = P.ID_CATEGORIA_PRODUTO
	LEFT JOIN VENDA.MODELO_PRODUTO M
		ON M.ID_MODELO_PRODUTO = P.ID_MODELO_PRODUTO