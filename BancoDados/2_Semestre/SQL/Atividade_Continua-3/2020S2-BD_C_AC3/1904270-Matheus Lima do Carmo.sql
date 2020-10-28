USE MASTER 
DROP DATABASE IF EXISTS PORTAO
GO
CREATE DATABASE PORTAO
GO
 USE PORTAO
CREATE TABLE FORNECEDOR_PORTAO
(
ID_FORNECEDOR_PORTAO  INT IDENTITY(1,1) PRIMARY KEY,
NOME_FORNECEDOR VARCHAR(MAX)
)
CREATE TABLE PORTAO
(
ID_PORTAO INT IDENTITY(1,1) PRIMARY KEY,
NOME_PORTAO VARCHAR(200) UNIQUE,
CODIGO_PORTAO VARCHAR(200)  ,
ID_FORNECEDOR_PORTAO INT FOREIGN KEY REFERENCES FORNECEDOR_PORTAO(ID_FORNECEDOR_PORTAO)
)
CREATE TABLE CLIENTE_PORTAO
(
ID_CLIENTE_PORTAO INT IDENTITY(1,1) PRIMARY KEY,
NOME_CLIENTE_PORTAO VARCHAR(200)
)
CREATE TABLE PEDIDO_PORTAO
(
ID_PEDIDO_PORTAO INT IDENTITY(1,1) PRIMARY KEY,
NUMERO_PEDIDO_PORTAO INT  ,
QUANTIDADE_TOTAL INT,
VALOR_TOTAL DECIMAL(10,2),
DATA DATE,
ID_CLIENTE_PORTAO INT FOREIGN KEY REFERENCES CLIENTE_PORTAO(ID_CLIENTE_PORTAO)
)
CREATE TABLE DETALHE_PEDIDO_PORTAO
(
ID_DETALHE_PEDIDO_PORTAO INT IDENTITY(1,1) PRIMARY KEY,
ID_PORTAO  INT FOREIGN KEY REFERENCES PORTAO(ID_PORTAO),
QUANTIDADE INT,
VALOR DECIMAL(10,2),
ID_PEDIDO_PORTAO INT FOREIGN KEY REFERENCES PEDIDO_PORTAO(ID_PEDIDO_PORTAO)
)
INSERT INTO FORNECEDOR_PORTAO  VALUES 
('FORNECEDOR PORTAO T'),('FORNECEDOR PORTAO E')
INSERT INTO PORTAO (NOME_PORTAO,ID_FORNECEDOR_PORTAO,CODIGO_PORTAO) VALUES
('PORTAO T',1,'T_PORTAO'),('PORTAO T2',1,'T2_PORTAO'),('PORTAO E',2,'E_PORTAO'),('PORTAO E2',2,'E2_PORTAO')
,('PORTAO ZY',2,'ZY_PORTAO')
INSERT INTO CLIENTE_PORTAO VALUES
('PORTAO TE INC.') , ('EET PORTAO VENDAS SA')
INSERT INTO PEDIDO_PORTAO 
(NUMERO_PEDIDO_PORTAO,QUANTIDADE_TOTAL,VALOR_TOTAL,DATA,ID_CLIENTE_PORTAO) VALUES
(100,2,1000,'2000-01-01',1),
(150,1,500,'2000-02-01',2),
(180,1,500,'2000-03-01',2),
(190,3,1500,'2000-04-01',2)
INSERT INTO DETALHE_PEDIDO_PORTAO (ID_PORTAO,QUANTIDADE,VALOR,ID_PEDIDO_PORTAO) VALUES
(1,1,500,1),
(2,1,500,1),
(1,1,500,2),
(2,1,500,3), 
(3,1,500,4),
(4,2,1000,4)
 /*
 Ola Matheus Lima do Carmo tudo bem com voc�? Preciso de uma ajuda aqui para entregar um relat�rio. Da uma for�a!
1 - Poderia selecionar o nome dos PORTAOS e o nome do fornecedor dos PORTAOS 
    onde o codigo do PORTAO n�o  come�e com E, ordenados pelo nome do PORTAO?
*/
/*
2 - Poderia selecionar o nome dos clientes a data do pedido do PORTAO, quantidade e  valor
    onde a data do pedido � maior que 2000-03-01?
*/
/*
3 - Poderia criar uma tabela chamada [COMPRAS_PORTAO] com os valores
o nome do PORTAO, o nome do cliente, data da compra ?
*/

/*
4 - Poderia criar uma consulta, para buscar o NOME dos PORTAOS que n�o tiveram nenhuma compra?
(PS: OBRIGAT�RIO TER UM JOIN ENTRE A TABELA PORTAO E PEDIDO_PORTAO, 
NADA DE SELECT * FROM PORTAOS where NOME = XXX n�o!
*/
 /*
5 - Poderia criar uma tabela chamada [COMPRAS_PORTAO_FORNECEDOR] com os valores
o nome do PORTAO, quantidade do PORTAO vendida, o valor e o nome do fornecedor onde o 
nome do fornecedor n�o   termine com a letra T? */