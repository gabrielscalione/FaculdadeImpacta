


/* 1 � Crie as seguintes consultas utilizando a tabela pedidos
	Soma do valor total, da quantidade total, onde a data do pedido � maior que 2012-04-01.
	Menor data do pedido e maior data do pedido onde o valor total � maior que 300?
	Contagem dos pedidos e m�dia de valor total onde a quantidade total � maior que 1?
*/
SELECT SUM(VALOR_TOTAL) TOTAL,
	   SUM(QUANTIDADE_TOTAL) QTDE_TOTAL
FROM PEDIDO
WHERE DATA_PEDIDO > '2012-04-01'

SELECT MIN(DATA_PEDIDO) MENOR_DATA,
	   MAX(DATA_PEDIDO) MAIOR_DATA
FROM PEDIDO
WHERE VALOR_TOTAL > 300

SELECT COUNT(ID_PEDIDO) QTDE_PEDIDOS, 
	   AVG(VALOR_TOTAL) MEDIA_VALOR_TOTAL 
FROM PEDIDO WHERE QUANTIDADE_TOTAL > 1 

/* 2- Crie as seguintes consultas utilizando a tabela item pedidos e maquinas
	Soma do valor e quantidade agrupado por nome da m�quina, se caso as m�quinas n�o foram vendidas ainda, as somat�rias devem vir zeradas e n�o com �null�.
	Soma do valor, soma da quantidade, e contagem agrupado por nome da m�quina e cor.
	Soma da quantidade das maquinas de nome FORCEX, soma da quantidade das maquinas n�o FORCEX.
*/
SELECT M.NOME AS NOME_MAQUINA,
	ISNULL(SUM(I.VALOR_TOTAL),0) AS TOTAL,
	ISNULL(SUM(I.QUANTIDADE),0) AS QTDE
FROM MAQUINA M
	LEFT JOIN ITEM_PEDIDO I
		ON M.ID_MAQUINA = I.ID_MAQUINA
GROUP BY M.NOME

SELECT M.NOME AS NOME_MAQUINA,
	M.COR,
	ISNULL(SUM(I.VALOR_TOTAL),0) AS TOTAL,
	ISNULL(SUM(I.QUANTIDADE),0) AS QTDE 
FROM MAQUINA M
	LEFT JOIN ITEM_PEDIDO I
		ON M.ID_MAQUINA = I.ID_MAQUINA
GROUP BY M.NOME,
	M.COR

/*3- Crie as seguintes consultas utilizando a tabela estado, cidade, endere�o, cliente, pedido
	Soma do valor total, da quantidade total, onde a data do pedido � maior que 2012-03-11, agrupado por estado.
	Menor data do pedido e maior data do pedido agrupado por cidade e estado.
	Contagem dos pedidos e m�dia de valor total agrupado pela data de nascimento dos clientes. 
	Soma do valor total, da quantidade total agrupado por estado onde a somat�ria do valor total seja maior que 1500.
	Soma do valor total dos pedidos agrupados pelo Ano da data do pedido.
*/


