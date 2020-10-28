/*
AC01- CLAUSULAS SELECT E CREATE 

Turma: BD 2C
Grupo:
	Gabriel Scalione	RA: 1903812
	Isaque Ribeiro		RA: 1903978 
	Lucimara Mendes		RA: 1903617
	Mayra Fernanda		RA: 1903486
	Yuri Placido		RA: 1904177

*/

/******************************************************************/
-- Exercício 01 – Execute o script aposta.sql disponibilizado na pasta da atividade no seu banco de dados para criar a tabela “APOSTA” e crie as consultas abaixo:
/******************************************************************/

	-- > Retorne todas as colunas da tabela aposta e uma nova coluna calculada chamada LUCRO_PREJUIZO com o valor do resultado - valor_apostado. 
	-- Onde o resultado é maior que o valor apostado.
	SELECT 
		*,
		RESULTADO - VALOR_APOSTADO AS LUCRO_PREJUIZO
	FROM 	
		APOSTA
	WHERE
		RESULTADO > VALOR_APOSTADO
	--------------------------------------------------------------------
	-- > Retorne os tipos aposta, distintos, em que a data é maior que 1980 e menor que 1990. 
	SELECT DISTINCT
		TIPO_APOSTA
	FROM 
		APOSTA
	WHERE
		DATA BETWEEN '1980-01-01' AND '1990-12-31'

	--------------------------------------------------------------------
	-- > Retorne a data e o tipo, onde o tipo aposta é diferente de “MMA” e a data é maior que ‘2020-01-05’
	SELECT 
		DATA,	
		TIPO_APOSTA
	FROM 
		APOSTA
	WHERE
		TIPO_APOSTA != 'MMA'
		AND DATA > '2020-01-05'   --- A tabela vai até 2000

	--------------------------------------------------------------------
	-- > Retorne apenas o valor apostado e o resultado, onde o valor apostado for maior que 1.000 ou o resultado for maior que 2.000.
	SELECT 
		VALOR_APOSTADO,
		RESULTADO
	FROM 
		APOSTA
	WHERE
		VALOR_APOSTADO > 1000
		OR RESULTADO > 2000


	--------------------------------------------------------------------
	-- > Retorne todas as colunas da tabela aposta, onde o tipo aposta é igual “FUTEBOL” e o resultado é maior que 0.
	SELECT 
		*
	FROM 
		APOSTA
	WHERE
		TIPO_APOSTA = 'Futebol'
		AND RESULTADO > 0

	--------------------------------------------------------------------
	-- > Retorne todas as colunas da tabela aposta, onde o tipo aposta é igual “MMA” e o resultado é maior que 0, OU, onde o tipo aposta é igual “CORRIDA DE CAVALOS” e o valor apostado é menor que 1.000.
	SELECT 
		*
	FROM 
		APOSTA
	WHERE
		(TIPO_APOSTA = 'MMA' AND RESULTADO > 0)
		OR (TIPO_APOSTA = 'CORRIDA DE CAVALOS' AND VALOR_APOSTADO < 1000)

	--------------------------------------------------------------------
	-- > Retorne todas as colunas da tabela aposta, com uma nova coluna calculada chamada TAXA_APOSTA com o valor do valor_apostado x 5%.
	SELECT 
		*,
		TAXA_APOSTA = VALOR_APOSTADO * (5.0/100)
	FROM 
		APOSTA

GO

/******************************************************************/
-- Exercício 2 - Criação das Tabelas com base no Diagrama
/******************************************************************/

	CREATE TABLE ESTADO (
		  ID_ESTADO INT NOT NULL IDENTITY(1,1)
		, ESTADO VARCHAR (100) NOT NULL
		, SIGLA CHAR(2) NOT NULL
		, CONSTRAINT pkESTADO PRIMARY KEY (ID_ESTADO)
	)

	CREATE TABLE CIDADE (
		  ID_CIDADE INT NOT NULL IDENTITY(1,1)
		, CIDADE VARCHAR(100) NOT NULL
		, ID_ESTADO INT NOT NULL
		, CONSTRAINT pkCIDADE PRIMARY KEY (ID_CIDADE)
		, CONSTRAINT fkESTADO FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO (ID_ESTADO)
	)

	CREATE TABLE ENDERECO (
		  ID_ENDERECO INT NOT NULL IDENTITY(1,1)
		, LOGRADOURO VARCHAR(200)
		, NUMERO INT
		, CEP VARCHAR(9)
		, ID_CIDADE INT NOT NULL
		, CONSTRAINT pkENDERECO PRIMARY KEY (ID_ENDERECO)
		, CONSTRAINT fkCIDADE FOREIGN KEY (ID_CIDADE) REFERENCES CIDADE (ID_CIDADE)
	)

	CREATE TABLE CLIENTE (
		  ID_CLIENTE INT NOT NULL IDENTITY(1,1)
		, CNPJ_CPF INT NOT NULL
		, NOME VARCHAR(200)
		, NOME_FANTASIA VARCHAR(200)
		, DATA_CADASTRO DATETIME
		, ID_ENDERECO INT NOT NULL
		, DATA_NASCIMENTO DATETIME
		, CONSTRAINT pkCLIENTE PRIMARY KEY (ID_CLIENTE)
		, CONSTRAINT fkENDERECO FOREIGN KEY (ID_ENDERECO) REFERENCES ENDERECO (ID_ENDERECO)
	)

	CREATE TABLE PEDIDO (
		  ID_PEDIDO INT NOT NULL IDENTITY(1,1)
		, CONTRATO VARCHAR(100)
		, VALOR DECIMAL(10,2)
		, QUANTIDADE NUMERIC
		, DATA_PEDIDO DATETIME
		, ID_CLIENTE INT NOT NULL
		, VALOR_TOTAL DECIMAL(10,2)
		, QUANTIDADE_TOTAL NUMERIC
		, CONSTRAINT pkPEDIDO PRIMARY KEY (ID_PEDIDO)
		, CONSTRAINT fkCLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID_CLIENTE)
	)

	CREATE TABLE MAQUINA (
		  ID_MAQUINA INT NOT NULL IDENTITY(1,1)
		, CODIGO INT NOT NULL
		, NOME VARCHAR(100)
		, DESCRICAO VARCHAR(200)
		, CONSTRAINT pkMAQUINA PRIMARY KEY (ID_MAQUINA)
	)

	CREATE TABLE ITEM_PEDIDO (
		  ID_ITEM_PEDIDO INT NOT NULL IDENTITY(1,1)
		, ID_MAQUINA INT NOT NULL
		, ID_PEDIDO INT NOT NULL
		, QUANTIDADE NUMERIC NOT NULL
		, VALOR_TOTAL DECIMAL(10,2) NOT NULL
		, CONSTRAINT pkITEM_PEDIDO PRIMARY KEY (ID_ITEM_PEDIDO) 
		, CONSTRAINT fkMAQUINA FOREIGN KEY (ID_MAQUINA) REFERENCES MAQUINA (ID_MAQUINA)
		, CONSTRAINT fkPEDIDO FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDO (ID_PEDIDO)
	)

GO

/******************************************************************/
-- Exercício 3 - Alteração das Tabelas MAQUINA e CLIENTE
/******************************************************************/

	-- TABELA MAQUINA - Crie uma nova coluna chamada “COR” VARCHAR (50).
		
		ALTER TABLE MAQUINA ADD COR VARCHAR(20)

	--TABELA CLIENTE - Crie uma restrição na coluna CNPJ_CPF para que esse valor seja ÚNICO.
		
		ALTER TABLE CLIENTE ADD CONSTRAINT uqCLIENTE_CNPJ_CPF UNIQUE (CNPJ_CPF)

	-- TABELA CLIENTE - Remova a coluna NOME_FANTASIA.
		
		ALTER TABLE CLIENTE DROP COLUMN NOME_FANTASIA

	-- TABELA CLIENTE - Crie uma nova coluna chamada “TELEFONE” VARCHAR (100).
		
		ALTER TABLE CLIENTE ADD TELEFONE VARCHAR(100)

GO