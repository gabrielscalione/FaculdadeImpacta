use master
go
 drop database maquina
 go
 create database maquina
 go
  use maquina
  go
 
CREATE TABLE ESTADO
	(
	ID_ESTADO INT IDENTITY(1,1),
	ESTADO VARCHAR(200),
	SIGLA VARCHAR(10)	
	CONSTRAINT PK_ESTADO PRIMARY KEY (ID_ESTADO)
	)

	-- TABELA CIDADE
CREATE TABLE CIDADE
	(
	ID_CIDADE INT IDENTITY(1,1),
	CIDADE VARCHAR(200),
	ID_ESTADO INT
	CONSTRAINT PK_CIDADE PRIMARY KEY (ID_CIDADE),
	CONSTRAINT FK_ESTADO_CIDADE FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
	)
	-- TABELA ENDERECO
CREATE TABLE ENDERECO
	(
	ID_ENDERECO INT IDENTITY(1,1),
	LOGRADOURO VARCHAR(300),
	NUMERO INT,
	CEP VARCHAR(50),
	ID_CIDADE INT
	CONSTRAINT PK_ENDERECO PRIMARY KEY (ID_ENDERECO),
	CONSTRAINT FK_CIDADE_ENDERECO FOREIGN KEY (ID_CIDADE) REFERENCES CIDADE(ID_CIDADE)
	)
	--TABELA CLIENTE  
CREATE TABLE CLIENTE
	(
	ID_CLIENTE INT IDENTITY(1,1),
	CNPJ_CPF VARCHAR(500),
	NOME VARCHAR(200),	
	NOME_FANTASIA VARCHAR(200),
	DATA_CADASTRO DATE,
	ID_ENDERECO INT,
	DATA_NASCIMENTO DATE,	
	CONSTRAINT PK_CLIENTE PRIMARY KEY (ID_CLIENTE),
	CONSTRAINT FK_ENDERECO_CLIENTE FOREIGN KEY (ID_ENDERECO) REFERENCES ENDERECO(ID_ENDERECO)
	)
	 
	   	  --TABELA PEDIDO  
CREATE TABLE PEDIDO
	(
	ID_PEDIDO INT IDENTITY(1,1),
	CONTRATO INT NOT NULL,
	VALOR DECIMAL(18,2) NOT NULL,
	QUANTIDADE INT NOT NULL,
	DATA_PEDIDO DATE NOT NULL,
	ID_CLIENTE INT NOT NULL,
	VALOR_TOTAL DECIMAL(18,2) NOT NULL,
	QUANTIDADE_TOTAL INT NOT NULL
	CONSTRAINT PK_PEDIDO PRIMARY KEY (ID_PEDIDO),
	CONSTRAINT FK_PEDIDO_CLIENTE FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE)
	)
	--TABELA MAQUINA
CREATE TABLE MAQUINA
	(
	ID_MAQUINA INT IDENTITY(1,1),
	CODIGO INT,
	NOME VARCHAR(200),
	DESCRICAO VARCHAR(200)
	CONSTRAINT PK_MAQUINA PRIMARY KEY (ID_MAQUINA)
	)
	--TABELA ITEM PEDIDO
CREATE TABLE ITEM_PEDIDO
	(
	ID_ITEM_PEDIDO INT IDENTITY(1,1),
	ID_MAQUINA INT NOT NULL,
	ID_PEDIDO INT NOT NULL,
	QUANTIDADE INT NOT NULL,
	VALOR_TOTAL DECIMAL(18,2) NOT NULL
	CONSTRAINT PK_ITEM_PEDIDO PRIMARY KEY (ID_ITEM_PEDIDO),
	CONSTRAINT FK_PEDIDO_ITEMPEDIDO FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDO(ID_PEDIDO),
	CONSTRAINT FK_MAQUINA_ITEMPEDIDO FOREIGN KEY (ID_MAQUINA) REFERENCES MAQUINA(ID_MAQUINA)
	)
 
ALTER TABLE MAQUINA
ADD COR VARCHAR(50)
ALTER TABLE MAQUINA
ADD TIPO VARCHAR(50)
 
 
ALTER TABLE CLIENTE
ADD TELEFONE VARCHAR(100)
ALTER TABLE CLIENTE
ADD EMAIL VARCHAR(100)

INSERT INTO ESTADO (ESTADO,	SIGLA)
VALUES 
('S�O PAULO', 'SP'),
('RIO DE JANEIRO','RJ'),
('BELO HORIZONTE','MG'),
(NULL,'BA')

INSERT INTO CIDADE (CIDADE,	ID_ESTADO)
VALUES
('S�O PAULO',	1),
('RIO DE JANEIRO',	2),
('BELO HORIZONTE',	3),
('RIO CLARO',	1),
('CAMPINAS',	1),
('VARZEA PAULISTA',	1)

INSERT INTO ENDERECO (LOGRADOURO	,NUMERO	,CEP,	ID_CIDADE)
VALUES
('RUA LIMA E SILVA',	30,	'04215020',	1                        )
,('AVENIDA BRAGA'	,1	,'04326140'	,1							 )
,('RUA MARIA LOPES',	90,	'21310-050',	2						 )
,('RUA CLODOALDO DE FREITAS',	100	,'21660-300',	2				 )
,('RUA ORLANDIA',	1,	'13090-750',	5							 )
,('AVENIDA AMAZONAS',1200,	'30180-001'	,3							 )
,('AVENIDA TRINTA E SETE',	1370 ,	'13501-170',	4				)
,('AVENIDA TRINTA E SETE',	1370 ,	'13501-170',	4				)

INSERT INTO CLIENTE (CNPJ_CPF,	NOME,	DATA_CADASTRO	,ID_ENDERECO,	DATA_NASCIMENTO,EMAIL)
VALUES
('112.831.943-03',	'CLEBER XAVIER'		,'01/01/2012',	1	,'30/01/1988'          ,  'clebaogatao@hotmail.com' )
,('996.345.956-02',	'LORENA AMARAL'		,NULL,   	   3,	'13/05/2000'			,'lorena_itaqua@gmail.com'   )
,('888.771.943-06',	'CAIO JUNQUEIRA'	,NULL,		   2	,'13/06/1988'			,'cainho_lorota@yahoo.com'   )
,('331.345.678-00',	'ALEXANDRE SILVA'	,NULL,    	   4	,'28/09/1995'			, 'ale_delas.aol.com.br'   )
,('555.121.993-77',	'LEIA PEREIRA'		,'01/01/2012',	7	,'17/11/1989'			, 'leia_gavioeslhp#hotmail.com.br'  )
,('777.878.906-12',	'JULIO LARANJEIRA'	,NULL,5,	'17/12/1990'					,  'saizica@ig.com.br' )
,('187.732.942-02',	'WESLEY WINSTON'	,	'01/01/2012',		6	 ,'11/04/2004'			, 'wesley157@.com'  )

INSERT INTO MAQUINA(CODIGO,	NOME,	DESCRICAO)
VALUES 
(10,'FORCEX',	'M�quina de fliperama de �ltima gera��o para pessoas nost�lgicas')
,(20,'IMAGINE 980',	'M�quina de pebolim com design criativo')
,(30,'SKY130',	 'Ca�a niquel t�o ilegal que chega a ser divertido')
,(40,'GENYUL',	 'M�quina de ca�a niquel que rouba mais que juiz no jogo do Corinthians')
,(50,'LARS-09',	 'Fliperama de boteco raiz, refor�adas para soco e briga generalizada')
,(60,'SKSX',	 'Pebolim surrado, feito de madeira de caix�o e ferro de constru��o roubada. Um achado')
,(70,'890-PL',	 'Fliperama com arma e mira, pronta para explodir os aliens')


INSERT INTO PEDIDO (CONTRATO,	VALOR,	QUANTIDADE,	DATA_PEDIDO	,ID_CLIENTE,	VALOR_TOTAL,	QUANTIDADE_TOTAL)
VALUES
(20000	,600	,2	,'01/01/2012',	1	,600	,2)
,(20001	,600	,2	,'01/02/2012',	2	,600	,2)
,(20002	,1200	,4	,'01/02/2012',	3	,1200	,4)
,(20003	,900	,3	,'16/04/2012',	7	,900	,3)
,(20004	,300	,1	,'19/04/2012',	5	,300	,1)
,(20005	,300	,1	,'28/04/2012',	7	,300	,1)
,(20006	,1200	,4	,'29/05/2012',	6	,1200	,4)
,(20000	,600	,2	,'01/06/2012',	1	,600	,2)
,(20001	,600	,2	,'01/06/2012',	7	,600	,2)
,(20002	,1200	,4	,'01/07/2012',	2	,1200	,4)
,(20003	,900	,3	,'16/08/2012',	2	,900	,3)
,(20004	,300	,1	,'19/09/2012',	1	,300	,2)
,(20005	,300	,1	,'28/10/2012',	3	,300	,2)
,(20006	,1200	,4	,'29/11/2012',	7	,1200	,2)



INSERT INTO ITEM_PEDIDO (ID_MAQUINA,	ID_PEDIDO,	QUANTIDADE	,VALOR_TOTAL)
VALUES 
 (1,	1,	2,	600)
,(3,	2,	2,	600)
,(3,	3,	2,	600)
,(2,	3,	2,	600)
,(1,	4,	2,	600)
,(2,	4,	1,	300)
,(3,	5,	1,	300)
,(2,	6,	1,	300)
,(1,	7,	2,	600)
,(2,	7,	2,	600)
,(1,	8,	2,	600)
,(3,	9,	2,	600)
,(3,	10,	2,	600)
,(2,	10,	2,	600)
,(1,	11,	2,	600)
,(2,	11,	1,	300)
,(3,	12,	1,	300)
,(2,	13,	1,	300)
,(1,	14,	2,	600)
,(2,	14,	2,	600)


