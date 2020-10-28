USE MASTER 
DROP DATABASE IF EXISTS AVIAO
GO
CREATE DATABASE AVIAO
GO
 USE AVIAO
CREATE TABLE FORNECEDOR_AVIAO
(
ID_FORNECEDOR_AVIAO  INT IDENTITY(1,1) PRIMARY KEY,
NOME_FORNECEDOR VARCHAR(MAX)
)
CREATE TABLE AVIAO
(
ID_AVIAO INT IDENTITY(1,1) PRIMARY KEY,
NOME_AVIAO VARCHAR(200) UNIQUE,
CODIGO_AVIAO VARCHAR(200)  ,
ID_FORNECEDOR_AVIAO INT FOREIGN KEY REFERENCES FORNECEDOR_AVIAO(ID_FORNECEDOR_AVIAO)
)
CREATE TABLE CLIENTE_AVIAO
(
ID_CLIENTE_AVIAO INT IDENTITY(1,1) PRIMARY KEY,
NOME_CLIENTE_AVIAO VARCHAR(200)
)
CREATE TABLE PEDIDO_AVIAO
(
ID_PEDIDO_AVIAO INT IDENTITY(1,1) PRIMARY KEY,
NUMERO_PEDIDO_AVIAO INT  ,
QUANTIDADE_TOTAL INT,
VALOR_TOTAL DECIMAL(10,2),
DATA DATE,
ID_CLIENTE_AVIAO INT FOREIGN KEY REFERENCES CLIENTE_AVIAO(ID_CLIENTE_AVIAO)
)
CREATE TABLE DETALHE_PEDIDO_AVIAO
(
ID_DETALHE_PEDIDO_AVIAO INT IDENTITY(1,1) PRIMARY KEY,
ID_AVIAO  INT FOREIGN KEY REFERENCES AVIAO(ID_AVIAO),
QUANTIDADE INT,
VALOR DECIMAL(10,2),
ID_PEDIDO_AVIAO INT FOREIGN KEY REFERENCES PEDIDO_AVIAO(ID_PEDIDO_AVIAO)
)
INSERT INTO FORNECEDOR_AVIAO  VALUES 
('FORNECEDOR AVIAO A'),('FORNECEDOR AVIAO D')
INSERT INTO AVIAO (NOME_AVIAO,ID_FORNECEDOR_AVIAO,CODIGO_AVIAO) VALUES
('AVIAO A',1,'A_AVIAO'),('AVIAO A2',1,'A2_AVIAO'),('AVIAO D',2,'D_AVIAO'),('AVIAO D2',2,'D2_AVIAO')
,('AVIAO ZY',2,'ZY_AVIAO')
INSERT INTO CLIENTE_AVIAO VALUES
('AVIAO AD INC.') , ('DDA AVIAO VENDAS SA')
INSERT INTO PEDIDO_AVIAO 
(NUMERO_PEDIDO_AVIAO,QUANTIDADE_TOTAL,VALOR_TOTAL,DATA,ID_CLIENTE_AVIAO) VALUES
(100,2,1000,'2000-01-01',1),
(150,1,500,'2000-02-01',2),
(180,1,500,'2000-03-01',2),
(190,3,1500,'2000-04-01',2)
INSERT INTO DETALHE_PEDIDO_AVIAO (ID_AVIAO,QUANTIDADE,VALOR,ID_PEDIDO_AVIAO) VALUES
(1,1,500,1),
(2,1,500,1),
(1,1,500,2),
(2,1,500,3), 
(3,1,500,4),
(4,2,1000,4)
 /*
 Ola Alan Rodrigues de Siqueira tudo bem com voc�? Preciso de uma ajuda aqui para entregar um relat�rio. Da uma for�a!
1 - Poderia selecionar o nome dos AVIAOS e o nome do fornecedor dos AVIAOS 
    onde o codigo do AVIAO    come�e com D, ordenados pelo nome do AVIAO?
*/
/*
2 - Poderia selecionar o nome dos clientes a data do pedido do AVIAO, quantidade e  valor
    onde a data do pedido � maior que 2000-03-01?
*/
/*
3 - Poderia criar uma tabela chamada [COMPRAS_AVIAO] com os valores
o nome do AVIAO, o nome do cliente, data da compra ?
*/

/*
4 - Poderia criar uma consulta, para buscar o NOME dos AVIAOS que   tiveram nenhuma compra?
(PS: OBRIGAT�RIO TER UM JOIN ENTRE A TABELA AVIAO E PEDIDO_AVIAO, 
NADA DE SELECT * FROM AVIAOS where NOME = XXX n�o!
*/
 /*
5 - Poderia criar uma tabela chamada [COMPRAS_AVIAO_FORNECEDOR] com os valores
o nome do AVIAO, quantidade do AVIAO vendida, o valor e o nome do fornecedor onde o 
nome do fornecedor     termine com a letra A? */