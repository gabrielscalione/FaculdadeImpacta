USE MASTER 
DROP DATABASE IF EXISTS GARFO
GO
CREATE DATABASE GARFO
GO
 USE GARFO
CREATE TABLE FORNECEDOR_GARFO
(
ID_FORNECEDOR_GARFO  INT IDENTITY(1,1) PRIMARY KEY,
NOME_FORNECEDOR VARCHAR(MAX)
)
CREATE TABLE GARFO
(
ID_GARFO INT IDENTITY(1,1) PRIMARY KEY,
NOME_GARFO VARCHAR(200) UNIQUE,
CODIGO_GARFO VARCHAR(200)  ,
ID_FORNECEDOR_GARFO INT FOREIGN KEY REFERENCES FORNECEDOR_GARFO(ID_FORNECEDOR_GARFO)
)
CREATE TABLE CLIENTE_GARFO
(
ID_CLIENTE_GARFO INT IDENTITY(1,1) PRIMARY KEY,
NOME_CLIENTE_GARFO VARCHAR(200)
)
CREATE TABLE PEDIDO_GARFO
(
ID_PEDIDO_GARFO INT IDENTITY(1,1) PRIMARY KEY,
NUMERO_PEDIDO_GARFO INT  ,
QUANTIDADE_TOTAL INT,
VALOR_TOTAL DECIMAL(10,2),
DATA DATE,
ID_CLIENTE_GARFO INT FOREIGN KEY REFERENCES CLIENTE_GARFO(ID_CLIENTE_GARFO)
)
CREATE TABLE DETALHE_PEDIDO_GARFO
(
ID_DETALHE_PEDIDO_GARFO INT IDENTITY(1,1) PRIMARY KEY,
ID_GARFO  INT FOREIGN KEY REFERENCES GARFO(ID_GARFO),
QUANTIDADE INT,
VALOR DECIMAL(10,2),
ID_PEDIDO_GARFO INT FOREIGN KEY REFERENCES PEDIDO_GARFO(ID_PEDIDO_GARFO)
)
INSERT INTO FORNECEDOR_GARFO  VALUES 
('FORNECEDOR GARFO D'),('FORNECEDOR GARFO A')
INSERT INTO GARFO (NOME_GARFO,ID_FORNECEDOR_GARFO,CODIGO_GARFO) VALUES
('GARFO D',1,'D_GARFO'),('GARFO D2',1,'D2_GARFO'),('GARFO A',2,'A_GARFO'),('GARFO A2',2,'A2_GARFO')
,('GARFO ZY',2,'ZY_GARFO')
INSERT INTO CLIENTE_GARFO VALUES
('GARFO DA INC.') , ('AAD GARFO VENDAS SA')
INSERT INTO PEDIDO_GARFO 
(NUMERO_PEDIDO_GARFO,QUANTIDADE_TOTAL,VALOR_TOTAL,DATA,ID_CLIENTE_GARFO) VALUES
(100,2,1000,'2000-01-01',1),
(150,1,500,'2000-02-01',2),
(180,1,500,'2000-03-01',2),
(190,3,1500,'2000-04-01',2)
INSERT INTO DETALHE_PEDIDO_GARFO (ID_GARFO,QUANTIDADE,VALOR,ID_PEDIDO_GARFO) VALUES
(1,1,500,1),
(2,1,500,1),
(1,1,500,2),
(2,1,500,3), 
(3,1,500,4),
(4,2,1000,4)
 /*
 Ola Chrystian Wallace Xavier Coelho tudo bem com voc�? Preciso de uma ajuda aqui para entregar um relat�rio. Da uma for�a!
1 - Poderia selecionar o nome dos GARFOS e o nome do fornecedor dos GARFOS 
    onde o codigo do GARFO n�o  come�e com A, ordenados pelo nome do GARFO?
*/
/*
2 - Poderia selecionar o nome dos clientes a data do pedido do GARFO, quantidade e  valor
    onde a data do pedido � maior que 2000-03-01?
*/
/*
3 - Poderia criar uma tabela chamada [COMPRAS_GARFO] com os valores
o nome do GARFO, o nome do cliente, data da compra ?
*/

/*
4 - Poderia criar uma consulta, para buscar o NOME dos GARFOS que n�o tiveram nenhuma compra?
(PS: OBRIGAT�RIO TER UM JOIN ENTRE A TABELA GARFO E PEDIDO_GARFO, 
NADA DE SELECT * FROM GARFOS where NOME = XXX n�o!
*/
 /*
5 - Poderia criar uma tabela chamada [COMPRAS_GARFO_FORNECEDOR] com os valores
o nome do GARFO, quantidade do GARFO vendida, o valor e o nome do fornecedor onde o 
nome do fornecedor n�o   termine com a letra D? */