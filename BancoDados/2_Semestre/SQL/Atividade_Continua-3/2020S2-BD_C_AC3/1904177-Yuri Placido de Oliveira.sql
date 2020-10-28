USE MASTER 
DROP DATABASE IF EXISTS VIOLAO
GO
CREATE DATABASE VIOLAO
GO
 USE VIOLAO
CREATE TABLE FORNECEDOR_VIOLAO
(
ID_FORNECEDOR_VIOLAO  INT IDENTITY(1,1) PRIMARY KEY,
NOME_FORNECEDOR VARCHAR(MAX)
)
CREATE TABLE VIOLAO
(
ID_VIOLAO INT IDENTITY(1,1) PRIMARY KEY,
NOME_VIOLAO VARCHAR(200) UNIQUE,
CODIGO_VIOLAO VARCHAR(200)  ,
ID_FORNECEDOR_VIOLAO INT FOREIGN KEY REFERENCES FORNECEDOR_VIOLAO(ID_FORNECEDOR_VIOLAO)
)
CREATE TABLE CLIENTE_VIOLAO
(
ID_CLIENTE_VIOLAO INT IDENTITY(1,1) PRIMARY KEY,
NOME_CLIENTE_VIOLAO VARCHAR(200)
)
CREATE TABLE PEDIDO_VIOLAO
(
ID_PEDIDO_VIOLAO INT IDENTITY(1,1) PRIMARY KEY,
NUMERO_PEDIDO_VIOLAO INT  ,
QUANTIDADE_TOTAL INT,
VALOR_TOTAL DECIMAL(10,2),
DATA DATE,
ID_CLIENTE_VIOLAO INT FOREIGN KEY REFERENCES CLIENTE_VIOLAO(ID_CLIENTE_VIOLAO)
)
CREATE TABLE DETALHE_PEDIDO_VIOLAO
(
ID_DETALHE_PEDIDO_VIOLAO INT IDENTITY(1,1) PRIMARY KEY,
ID_VIOLAO  INT FOREIGN KEY REFERENCES VIOLAO(ID_VIOLAO),
QUANTIDADE INT,
VALOR DECIMAL(10,2),
ID_PEDIDO_VIOLAO INT FOREIGN KEY REFERENCES PEDIDO_VIOLAO(ID_PEDIDO_VIOLAO)
)
INSERT INTO FORNECEDOR_VIOLAO  VALUES 
('FORNECEDOR VIOLAO G'),('FORNECEDOR VIOLAO R')
INSERT INTO VIOLAO (NOME_VIOLAO,ID_FORNECEDOR_VIOLAO,CODIGO_VIOLAO) VALUES
('VIOLAO G',1,'G_VIOLAO'),('VIOLAO G2',1,'G2_VIOLAO'),('VIOLAO R',2,'R_VIOLAO'),('VIOLAO R2',2,'R2_VIOLAO')
,('VIOLAO ZY',2,'ZY_VIOLAO')
INSERT INTO CLIENTE_VIOLAO VALUES
('VIOLAO GR INC.') , ('RRG VIOLAO VENDAS SA')
INSERT INTO PEDIDO_VIOLAO 
(NUMERO_PEDIDO_VIOLAO,QUANTIDADE_TOTAL,VALOR_TOTAL,DATA,ID_CLIENTE_VIOLAO) VALUES
(100,2,1000,'2000-01-01',1),
(150,1,500,'2000-02-01',2),
(180,1,500,'2000-03-01',2),
(190,3,1500,'2000-04-01',2)
INSERT INTO DETALHE_PEDIDO_VIOLAO (ID_VIOLAO,QUANTIDADE,VALOR,ID_PEDIDO_VIOLAO) VALUES
(1,1,500,1),
(2,1,500,1),
(1,1,500,2),
(2,1,500,3), 
(3,1,500,4),
(4,2,1000,4)
 /*
 Ola Yuri Placido de Oliveira tudo bem com voc�? Preciso de uma ajuda aqui para entregar um relat�rio. Da uma for�a!
1 - Poderia selecionar o nome dos VIOLAOS e o nome do fornecedor dos VIOLAOS 
    onde o codigo do VIOLAO n�o  come�e com R, ordenados pelo nome do VIOLAO?
*/
/*
2 - Poderia selecionar o nome dos clientes a data do pedido do VIOLAO, quantidade e  valor
    onde a data do pedido � maior que 2000-03-01?
*/
/*
3 - Poderia criar uma tabela chamada [COMPRAS_VIOLAO] com os valores
o nome do VIOLAO, o nome do cliente, data da compra ?
*/

/*
4 - Poderia criar uma consulta, para buscar o NOME dos VIOLAOS que n�o tiveram nenhuma compra?
(PS: OBRIGAT�RIO TER UM JOIN ENTRE A TABELA VIOLAO E PEDIDO_VIOLAO, 
NADA DE SELECT * FROM VIOLAOS where NOME = XXX n�o!
*/
 /*
5 - Poderia criar uma tabela chamada [COMPRAS_VIOLAO_FORNECEDOR] com os valores
o nome do VIOLAO, quantidade do VIOLAO vendida, o valor e o nome do fornecedor onde o 
nome do fornecedor n�o   termine com a letra G? */