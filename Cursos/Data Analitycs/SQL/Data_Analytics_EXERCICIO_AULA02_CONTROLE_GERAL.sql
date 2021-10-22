/*
	EXERCICIO PARA CASA - Data Analytics
*/
-- CRIAR BANCO DE DADOS COM O NOME CONTROLE_GERAL
CREATE DATABASE CONTROLE_GERAL
GO

-- CRIAR 3 TABELAS
USE CONTROLE_GERAL
GO

CREATE TABLE ESTOQUE			
	( ID INT IDENTITY NOT NULL
	, QUANTIDADE INT
	, NOME_PRD VARCHAR(200)
	, DISPONIVEL VARCHAR(3)	--('Sim' ou 'Não')
	, NUMERO_DA_NOTA varchar(10)
	)

CREATE TABLE VENDA
	( ID INT IDENTITY NOT NULL
	, VALOR DECIMAL(10,2)
	, PROD VARCHAR(200)
	, QUANTIDADE INT
	, VENDEDOR VARCHAR(200)
	, FILIAL VARCHAR(200)
	)

CREATE TABLE CLIENTES		
	( ID INT IDENTITY NOT NULL
	, NOME VARCHAR(200)
	, CPF varchar(11)
	, ENDERECO VARCHAR(300)
	, SEXO CHAR(1)
	, CIDADE VARCHAR(100)
	)


-- INSERIR 10 REGISTROS PARA CADA TABELA (TODAS AS TABELAS COM ID IDENTITY)
INSERT INTO ESTOQUE VALUES (1,'Arroz','Sim','3887')
INSERT INTO ESTOQUE VALUES (9,'Feijão','Sim','1871')
INSERT INTO ESTOQUE VALUES (9,'Farinha','Não','21')
INSERT INTO ESTOQUE VALUES (28,'Fubá','Não','5032')
INSERT INTO ESTOQUE VALUES (30,'Azeite','Não','9894')
INSERT INTO ESTOQUE VALUES (24,'Bandeja de Ovo - Dúzia','Sim','243')
INSERT INTO ESTOQUE VALUES (5,'Leite 1L','Sim','2320')
INSERT INTO ESTOQUE VALUES (2,'Café 500g','Sim','7479')
INSERT INTO ESTOQUE VALUES (10,'Maionese','Não','2773')
INSERT INTO ESTOQUE VALUES (30,'Nescau','Sim','6630')
--
INSERT INTO VENDA VALUES (10,'Arroz',2,'Goku','Casa do mestre Kame')
INSERT INTO VENDA VALUES (3,'Feijão',5,'Naruto','Konoha')
INSERT INTO VENDA VALUES (13,'Farinha',3,'Luffy','Going Merry')
INSERT INTO VENDA VALUES (6,'Fubá',10,'Tanjiro','Casa do mestre Kame')
INSERT INTO VENDA VALUES (13,'Azeite',4,'Asta','Konoha')
INSERT INTO VENDA VALUES (16,'Bandeja de Ovo - Dúzia',7,'Goku','Going Merry')
INSERT INTO VENDA VALUES (28,'Leite 1L',4,'Naruto','Casa do mestre Kame')
INSERT INTO VENDA VALUES (26,'Café 500g',7,'Luffy','Konoha')
INSERT INTO VENDA VALUES (28,'Maionese',10,'Tanjiro','Going Merry')
INSERT INTO VENDA VALUES (2869,'Nescau',5,'Asta','Konoha')
--
INSERT INTO CLIENTES VALUES ('Goku',76561674707,'Rua do Farol, sem numero','M','São Paulo')
INSERT INTO CLIENTES VALUES ('Naruto',83794792631,'Avenida da Esquina, 400','M','São Paulo')
INSERT INTO CLIENTES VALUES ('Nami',73847783170,'Estrada do Sabão, 345','F','São Paulo')
INSERT INTO CLIENTES VALUES ('Nezuko',81086014943,'Rua 15, numero: 16','F','Brasilia')
INSERT INTO CLIENTES VALUES ('Robin',83022389722,'Praia da Barra, perto da Orla','F','Rio de Janeiro')
INSERT INTO CLIENTES VALUES ('Goku',72458906819,'Rua da casa verde','M','Curitiba')
INSERT INTO CLIENTES VALUES ('Naruto',72528780667,'Estrada do Sabão, 345','M','São Paulo')
INSERT INTO CLIENTES VALUES ('Luffy',93575968567,'Rua 15, numero: 16','M','Brasilia')
INSERT INTO CLIENTES VALUES ('Tanjiro',66488201181,'Praia da Barra, perto da Orla','M','Rio de Janeiro')
INSERT INTO CLIENTES VALUES ('Asta',65302480231,'Rua da casa verde','M','Curitiba')

-- Criar um select que retorne todos os dados de cada tabela

select * from ESTOQUE
select * from VENDA
select * from CLIENTES


-- Quanto de cada produto eu tenho disponivel em estoque (where DISPONIVEL = 'Sim')

select NOME_PRD, QUANTIDADE from ESTOQUE where DISPONIVEL = 'Sim'
 

-- Quantidade total vendida de produto
select sum(QUANTIDADE) as TOTAL_VENDIDO from VENDA


-- Quantos clientes eu tive?
select count(*) from CLIENTES
