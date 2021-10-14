-- EXERCICIO
-- Criar 3 Bancos de dados, sendo eles com os nomes:
-- 1 banco com o nome do aluno
create database RUI
-- 1 banco com o nome AULA01
create database AULA01
-- 1 Banco com o nome YTONIHON
CREATE DATABASE YTONIHON

-- APAGANDO UM BANCO DE DADOS
drop database YTONIHON


------------------------------------------------------------------------
use AULA01

create table TABELATESTE 
(
COLUNA1		VARCHAR,
COLUNA2		VARCHAR,
COLUNA3		VARCHAR,
)

/* EXERCICIO

Criar 3 tabelas, com os nomes:
1-TbCliente (ID,NomeCliente,EstadoCliente)
2-TbProduto	(ID,NomeProduto,ValorProduto)
3-TbLoja	(ID,NomeLoja,Local)

*/
-- 1
--DROP TABLE TbCliente
create table TbCliente
(ID				INT,
NomeCliente		VARCHAR(80),
EstadoCliente	VARCHAR(40)
)					  
					  
-- 2
--DROP TABLE TbProduto
CREATE TABLE TbProduto
(
ID			INT,
NomeProduto	VARCHAR(50),
ValorProduto VARCHAR(5)
)
					  
-- 3 	
--Drop Table TbLoja
CREATE TABLE TbLoja	  
(
ID			INT,
NomeLoja	varchar(50),
Local		varchar(40)
)

--EXERCICIO:
-- Dropar todas as tabelas e recriar com os tamanhos corretos

--ACESSO CRUD

CREATE
READ
UPDATE
DELETE/DROP


SELECT * FROM TbCliente

INSERT INTO TbCliente VALUES (1,'Luis Gustavo','São Paulo')
INSERT INTO TbCliente VALUES (2,'Carlos','São Paulo')
INSERT INTO TbCliente VALUES (3,'Paloma','Lisboa')
INSERT INTO TbCliente VALUES (4,'Patricia','São Paulo')
insert into TbCliente values (5,'','')
insert into TbCliente values (6,null,null)

truncate table TbCliente


----------------------



INSERT INTO TbLoja VALUES (1,'Loja do SQL','Barueri')
INSERT INTO TbLoja VALUES (2,'LojaYTO','Barueri')


select * from TbLoja


INSERT INTO TbProduto VALUES (1,'COCADA','23.00')
INSERT INTO TbProduto VALUES (2,'FILÉ MIGNON','100')
INSERT INTO TbProduto VALUES (3,'CELULAR','5000')

SELECT * FROM TbProduto

-- EXERCICIO
-- Inserir dados dentro das tabelas criadas
-- Cada tabela deve ter pelo menos 5 linhas dentro


SELECT 2 * 24 /2 + 60

SELECT 'O SQL É A MELHOR FERRAMENTA DO MUNDO!'

SELECT * FROM TbCliente
SELECT * FROM TbLoja
SELECT * FROM TbProduto


-- TRAZENDO AS COLUNAS QUE O USUARIO PRECISA VISUALIZAR

SELECT
NOMECLIENTE,
ESTADOCLIENTE
FROM TbCliente

SELECT
NomeLoja,
Local
FROM TbLoja

SELECT
NomeProduto,
ValorProduto
from TbProduto



-- COMENTÁRIO
/*
QUALQUER 
TRECHO
DE
TEXTO
*/