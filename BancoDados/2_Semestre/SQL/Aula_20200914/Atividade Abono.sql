USE ATIVIDADE_ABONO
GO

-- 1 � Crie as tabelas abaixo e insira os dados:

CREATE TABLE BANDA(
	  ID_BANDA INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	, BANDA VARCHAR (100)
	, ANO_FUNDACAO INT,
)

CREATE TABLE MUSICA(
	ID_MUSICA INT PRIMARY KEY IDENTITY(1,1) NOT NULL
	, NOME VARCHAR (100)
	, ID_BANDA INT NOT NULL
	, CONSTRAINT fkBanda FOREIGN KEY (ID_BANDA) REFERENCES  BANDA (ID_BANDA)
)


INSERT INTO BANDA (BANDA,ANO_FUNDACAO)
VALUES
	('TITANS',1981),
	('LEGIAO URBANA', 1982),
	('PARALAMAS DO SUCESSO', 1977),
	('ROUPA NOVA', 1980)

INSERT INTO MUSICA(NOME,ID_BANDA)
VALUES
	('Enquanto Houver Sol',1),
	('Fam�lia',1),
	('Flores',1),
	('Mais Uma Vez',2),
	('Que Pa�s � Esse?',2),
	('�culos',3),
	('Uma Brasileira',3)


--2- Utilizando as tabelas MUSICA e BANDA realize os seguintes comandos:
--Liste todas as colunas da tabela MUSICA onde o nome contem a palavra �Uma�, ordene o resultado pelo nome decrescente.
	SELECT * FROM MUSICA WHERE NOME LIKE '%Uma%' ORDER BY NOME DESC

--Liste todas as colunas da tabela MUSICA onde a primeira letra � igual a F. ordene o resultado pelo ID_BANDA ascendente.
	SELECT * FROM MUSICA WHERE NOME LIKE 'F%' ORDER BY ID_BANDA 

--Liste todas as colunas da tabela BANDA onde os nomes da banda contem a palavra �nova� ou contem a palavra �sucesso�, ordene o resultado pelo nome da BANDA decrescente.
	SELECT * FROM BANDA WHERE BANDA LIKE '%nova%' OR BANDA LIKE '%sucesso%' ORDER BY BANDA DESC

--Liste todas as colunas das tabelas BANDA E MUSICA atrav�s da clausula INNER JOIN.
	SELECT * 
	FROM BANDA B
	INNER JOIN MUSICA M 
		ON B.ID_BANDA = M.ID_BANDA

--Liste todas as colunas das tabelas BANDA E MUSICA atrav�s da clausula LEFT JOIN.
	SELECT * 
	FROM BANDA B
	LEFT JOIN MUSICA M 
		ON B.ID_BANDA = M.ID_BANDA

--Liste todas as colunas das tabelas BANDA E MUSICA atrav�s da clausula RIGHT JOIN.
	SELECT * 
	FROM BANDA B
	RIGHT JOIN MUSICA M 
		ON B.ID_BANDA = M.ID_BANDA

--Liste todas as colunas das tabelas BANDA E MUSICA atrav�s da clausula FULL JOIN.
	SELECT * 
	FROM BANDA B
	FULL JOIN MUSICA M 
		ON B.ID_BANDA = M.ID_BANDA
		
--Liste todas as colunas das tabelas BANDA E MUSICA atrav�s da clausula CROSS JOIN.
	SELECT * 
	FROM BANDA
	CROSS JOIN MUSICA
		
--Crie uma nova coluna chamada IDADE, tipo INT e atualize com o valor da IDADE da banda (ANO ATUAL � ANO FUNDA��O)
	ALTER TABLE BANDA ADD IDADE INT

	UPDATE BANDA 
	SET
		IDADE = YEAR(GETDATE()) - ANO_FUNDACAO

--Delete todas as m�sicas que o ID_MUSICA seja maior que 5.
	DELETE MUSICA WHERE ID_MUSICA > 5

--Crie uma nova coluna chamada ANO_TERMINO e atualize os seguintes valores:
	--Legi�o urbana=1996
	--ROUPA NOVA =2030
	ALTER TABLE BANDA ADD ANO_TERMINO INT

	UPDATE BANDA 
	SET
		ANO_TERMINO  = 1996
	WHERE BANDA like 'LEGIAO URBANA' or ID_BANDA = 2

	UPDATE BANDA 
	SET
		ANO_TERMINO  = 2030
	WHERE BANDA = 'ROUPA NOVA' or ID_BANDA = 4





--3- Utilizando a base de dados �Concessionaria� realize os seguintes comandos.
USE Concessionaria
GO

--Liste todas as colunas das tabelas M�S E VENDASANUAIS, UTILIZE O INNER JOIN.
	SELECT * 
	FROM Mes M
	INNER JOIN VendasAnuais V
		ON M.idMes = V.idMesdaVenda

--Liste todas as colunas das tabelas ANO E VENDASANUAIS, UTILIZE O LEFT JOIN.
	SELECT * 
	FROM Ano A
	LEFT JOIN VENDASANUAIS V
		ON A.idAno = V.idAnodaVenda
--Liste todas as colunas das tabelas ANO E VEICULO, UTILIZE O FULL JOIN.
	SELECT * 
	FROM Ano A
	FULL JOIN VENDASANUAIS V
		ON A.idAno = V.idAnodaVenda

--Liste as colunas qtd e descri��o do ve�culo das tabelas VENDASANUAIS E VEICULO. UTILIZE O INNER JOIN. Ordene pela coluna qtd.
	SELECT qtd, descricao 
	FROM VendasAnuais V
	INNER JOIN Veiculo E
		ON V.idVeiculo = E.idVeiculo
	ORDER BY qtd

--Liste todas as colunas das tabelas FABRICANTE, VEICULO e ANO UTILIZE O LEFT JOIN para todas. 
	SELECT *
	FROM Fabricante F
	LEFT JOIN Veiculo E
		ON E.idFabricante = F.idFabricante
	LEFT JOIN Ano A
		ON A.idAno = E.idAnoFabricacao
	
--Liste todas as colunas das tabelas FABRICANTE, VEICULO (INNER JOIN) e MODELO (LEFT JOIN). Ordene pela descri��o do veiculo.
	SELECT *
	FROM Fabricante F
	INNER JOIN Veiculo E
		ON E.idFabricante = F.idFabricante
	LEFT JOIN Modelo M
		ON M.idModelo = E.idModelo
	ORDER BY E.descricao

--Liste todas as colunas da tabela VENDASANUAIS onde os meses das vendas foram feitos no segundo semestre, ordene por DataCompra do ve�culo.
	SELECT *
	FROM Fabricante F
	INNER JOIN Veiculo E
		ON E.idFabricante = F.idFabricante
	LEFT JOIN Modelo M
		ON M.idModelo = E.idModelo
	ORDER BY E.descricao

--Liste todas as colunas da tabela VEICULOS e o ano de fabrica��o, onde  o ano de fabrica��o seja maior que 2012 e menor que 2013 e que tamb�m o nome da fabricante seja HONDA. 
-- Ordene por Descri��o e Ano de fabrica��o
	SELECT  V.*
		  , A.ano
	FROM Veiculo V
		INNER JOIN Ano A
			ON A.idAno = V.idAnoFabricacao
		INNER JOIN Fabricante F
			ON F.idFabricante = V.idFabricante
	WHERE A.ano > 2012
	  AND A.ano < 2013
	  AND F.Nome = 'Honda'
	ORDER BY V.descricao, A.ano


--Liste todas as colunas da tabela VEICULOS em que o nome da fabricante seja HONDA OU DAFRA OU SUZUKI OU BMW e que o modelo tenha pelo menos um G na descri��o.



--Liste apenas os n�meros dos meses que houveram vendas de ve�culo, n�o repetir as linhas. Ordene o resultado.

--Liste todas as colunas da tabela VENDASANUAIS em que o Fabricante do ve�culo fica situado na cidade de S�o Paulo ordene por qtd decrescente.
--Crie uma nova tabela e insira os dados abaixo: 
--Descri��o do Ve�culo, o Nome do Fabricante onde a qtd na tabela VENDASANUAIS foi maior que 900 em uma �nica venda. 
--Crie uma nova tabela e insira os dados abaixo: 
--Nome da Fabricante, Descri��o do Modelo, Descri��o Ve�culo e Ano de fabrica��o de todos os ve�culos da base.


