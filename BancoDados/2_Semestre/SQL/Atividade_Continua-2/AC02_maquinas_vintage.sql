/*
AC02- MAQUINAS VINTAGE 
=======
Turma: BD 2C
Grupo:
	Gabriel Scalione	RA: 1903812
	Isaque Ribeiro		RA: 1903978 
	Lucimara Mendes		RA: 1903617
	Mayra Fernanda		RA: 1903486
	Yuri Placido		RA: 1904177
*/
/*************************************************
-- 1 - Na atividade da AC1, foram criadas tabelas para criar um banco de dados de um comercio
de maquinas vintage. Porém, para prosseguirmos no exercício de insert, recomendo recriar
as tabelas utilizando o script disponibilizado no material: “maquinas_vintage.sql”
**************************************************/

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
	DATA_NASCIMENTO DATE
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


/*************************************************
-- 2 – Através do comando INSERT insira os valores 
abaixo nas respectivas tabelas:
**************************************************/
--INSERT NA TABELA ESTADO
INSERT INTO ESTADO (ESTADO,SIGLA)
VALUES(	'SÃO PAULO', 'SP')
	, ( 'RIO DE JANEIRO', 'RJ')
	, (	'MINAS GERAIS', NULL)

--INSERT NA TABELA CIDADE
INSERT INTO CIDADE (CIDADE, ID_ESTADO)
VALUES(	'SÃO PAULO', 1)
	, (	'RIO DE JANEIRO', 2)
	, (	'BELO HORIZONTE', 3)
	, (	'RIO CLAROOOOOOO', 1)
	, (	'CAMPINAS', 1)


--INSERT NA TABELA ENDERECO
INSERT INTO ENDERECO (LOGRADOURO, NUMERO, CEP, ID_CIDADE)
VALUES(	'RUA LIMA E SILVA',30,'04215-020',1)
	, (	'AVENIDA BRAGA',1,'04326-140',1)
	, (	'RUA MARIA LOPES',90,'21310-050',2)
	, (	'RUA CLODOALDO DE FREITAS',100,'21660-300',2)
	, (	'RUA ORLANDIA',1,'13090-750',5)
	, (	'AVENIDA AMAZONAS',1200,'30180-001',3)
	, (	'AVENIDA TRINTA E SETE',NULL,'13501-170',4)



--INSERT NA TABELA CLIENTE
INSERT INTO CLIENTE (CNPJ_CPF,NOME,DATA_CADASTRO,ID_ENDERECO,DATA_NASCIMENTO,TELEFONE)
VALUES(	'11283194303','CLEBER XAVIER','2012-01-01',1,'1988-01-30',NULL)
	, (	'99634595602','LORENA AMARAL',NULL,3,'2000-05-13',NULL)
	, (	'88877194306','CAIO JUNQUEIRA',NULL,2,'1988-06-13',NULL)
	, (	'33134567800','ALEXANDRE SILVA',NULL,4,'1995-09-28',NULL)
	, (	'55512199377','LEIA PEREIRA','2012-01-01',7,'1989-11-17',NULL)
	, (	'77787890612','JULIO LARANJEIRA',NULL,5,'1990-12-17',NULL)
	, (	'18773294202','WESLEY WINSTON','2012-01-01',6,NULL,NULL)


--INSERT NA TABELA MAQUINA
INSERT INTO MAQUINA(CODIGO,NOME,DESCRICAO,COR)
VALUES(10, 'FORCEX','Máquina de fliperama de última geração para pessoas nostálgicas',NULL)
	, (20, 'IMAGINE 980','Máquina de pebolim com design criativo',NULL)
	, (30, 'SKY130',NULL,NULL)


--INSERT NA TABELA PEDIDO
INSERT INTO PEDIDO (CONTRATO,VALOR,QUANTIDADE,DATA_PEDIDO,ID_CLIENTE,VALOR_TOTAL,QUANTIDADE_TOTAL)
VALUES( 20000, 600, 2, '2012-01-01', 1, 600, 2)
	, ( 20001, 600, 2, '2012-04-01', 2, 600, 2)
	, ( 20002, 1200, 4, '2012-05-01', 3, 1200, 4)
	, ( 20003, 900, 3, '2012-05-16',4,900,3)
	, ( 20004, 300, 1, '2012-06-19', 5, 300, 1)
	, ( 20005, 300, 1, '2012-10-28', 7, 300, 1)
	, ( 20006, 1200, 4, '2012-11-29', 6, 1200, 4)


-- INSERT NA TABELA ITEM PEDIDO
INSERT INTO ITEM_PEDIDO (ID_MAQUINA,ID_PEDIDO,QUANTIDADE,VALOR_TOTAL)
VALUES(1, 1, 2, 600)
	, (3, 2, 2, 600)
	, (3, 3, 2, 600)
	, (2, 3, 2, 600)
	, (1, 4, 2, 600)
	, (2, 4, 1, 300)
	, (3, 5, 1, 300)
	, (2, 6, 1, 300)
	, (1, 7, 2, 600)
	, (2, 7, 2, 600)
	
/*************************************************
3- Foram verificadas algumas inconsistências nos dados inseridos. Utilize o comando UPDATE para atualizar os dados.
- A tabela estado, possui uma sigla vazia, deverá ser atualizado para a sigla do respectivo estado.
- A cidade “Rio Claro” está com o nome errado na tabela cidade.   
- O endereço “Avenida Trinta e Sete” está com o número vazio, deveria ser 560.
- A endereço “Avenida Braga” deveria ser “Rua Braga”.
- Os clientes que não possuem DATA_CADASTRO devem ser atualizados para a data “01/01/2012”.
- Os clientes que não possuem DATA_NASCIMENTO devem ser atualizados para a data “01/01/1950”.
- A descrição da máquina SKY130, está vazia. Deveria ser “Jukebox dos anos 50 em acabamento refinado”.
- Estão faltando as informações de desconto na tabela PEDIDO.  Altere a tabela, criando uma coluna chamada DESCONTO, com o valor de 10% do valor total.
- Atualize a tabela VALOR_TOTAL = VALOR – DESCONTO.
*************************************************/

--select * from estado where sigla is null;
update ESTADO set sigla = 'MG' where estado = 'Minas gerais';

--select * from cidade;
update CIDADE set CIDADE = 'RIO CLARO' where ID_CIDADE = 4;

--SELECT * FROM ENDERECO;
update ENDERECO set NUMERO = 560 where ID_ENDERECO = 7;
update ENDERECO set logradouro = 'Rua Braga' where ID_ENDERECO = 2;

--select * from cliente;
update CLIENTE set DATA_CADASTRO = '20120101' where DATA_CADASTRO is null;
update CLIENTE set DATA_NASCIMENTO = '19500101' where DATA_NASCIMENTO is null;
--select * from MAQUINA;
update MAQUINA set DESCRICAO = 'Jukebox dos anos 50 em acabamento refinado' where DESCRICAO is null;
--SELECT * FROM PEDIDO;
alter table PEDIDO add  DESCONTO int;
update pedido set desconto = (VALOR_TOTAL * 0.1)
update pedido set VALOR_TOTAL = (VALOR_TOTAL - DESCONTO)
--SELECT * FROM PEDIDO;


/*************************************************
*4 – Foi descoberto que uma compra de um cliente foi uma fraude. Precisamos deletar os
dados dessa transação e os dados do cliente.
 - Delete dados da tabela ITEM_PEDIDO em que o ID_PEDIDO = 7
 - Delete dados do PEDIDO em que o ID_PEDIDO = 7
 - Delete dados do CLIENTE em que o ID_CLIENTE = 6
 - Delete dados do ENDEREÇO em que o ID_ENDEREÇO= 5 */

DELETE FROM ITEM_PEDIDO 
WHERE ID_PEDIDO = 7

DELETE FROM PEDIDO 
WHERE ID_PEDIDO = 7

DELETE FROM CLIENTE 
WHERE ID_CLIENTE = 6

DELETE FROM ENDERECO 
WHERE ID_ENDERECO = 5


/*************************************************
5 – A área comercial deseja entrar em contato com os clientes que nasceram antes de 1980
para atualizar os dados cadastrais. Crie uma tabela chamada
“CLIENTES_CADASTRO_ATUALIZADO” c ontento os campos (CNPJ_CPF, NOME,
DATA_NASCIMENTO) e insira os dados dos clientes que nasceram antes de 1980 nessa tabela.
*************************************************/

--Criação da tabela CLIENTES_CADASTRO_ATUALIZADO
CREATE TABLE CLIENTES_CADASTRO_ATUALIZADO (
	ID_CLIENTES_CAD_ATUAL INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	CNPJ_CPF VARCHAR(500),
	NOME VARCHAR (900),
	DATA_NASCIMENTO DATE
)
---- Insert na tabela CLIENTES_CADASTRO_ATUALIZADO
INSERT INTO CLIENTES_CADASTRO_ATUALIZADO (
	CNPJ_CPF, 
	NOME, 
	DATA_NASCIMENTO
)
SELECT CNPJ_CPF, NOME, DATA_NASCIMENTO 
FROM  CLIENTE
WHERE YEAR(DATA_NASCIMENTO) < 1980