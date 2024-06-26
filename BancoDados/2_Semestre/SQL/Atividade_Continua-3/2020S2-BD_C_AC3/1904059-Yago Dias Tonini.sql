USE MASTER 
DROP DATABASE IF EXISTS PIANO
GO
CREATE DATABASE PIANO
GO
 USE PIANO
CREATE TABLE FORNECEDOR_PIANO
(
ID_FORNECEDOR_PIANO  INT IDENTITY(1,1) PRIMARY KEY,
NOME_FORNECEDOR VARCHAR(MAX)
)
CREATE TABLE PIANO
(
ID_PIANO INT IDENTITY(1,1) PRIMARY KEY,
NOME_PIANO VARCHAR(200) UNIQUE,
CODIGO_PIANO VARCHAR(200)  ,
ID_FORNECEDOR_PIANO INT FOREIGN KEY REFERENCES FORNECEDOR_PIANO(ID_FORNECEDOR_PIANO)
)
CREATE TABLE CLIENTE_PIANO
(
ID_CLIENTE_PIANO INT IDENTITY(1,1) PRIMARY KEY,
NOME_CLIENTE_PIANO VARCHAR(200)
)
CREATE TABLE PEDIDO_PIANO
(
ID_PEDIDO_PIANO INT IDENTITY(1,1) PRIMARY KEY,
NUMERO_PEDIDO_PIANO INT  ,
QUANTIDADE_TOTAL INT,
VALOR_TOTAL DECIMAL(10,2),
DATA DATE,
ID_CLIENTE_PIANO INT FOREIGN KEY REFERENCES CLIENTE_PIANO(ID_CLIENTE_PIANO)
)
CREATE TABLE DETALHE_PEDIDO_PIANO
(
ID_DETALHE_PEDIDO_PIANO INT IDENTITY(1,1) PRIMARY KEY,
ID_PIANO  INT FOREIGN KEY REFERENCES PIANO(ID_PIANO),
QUANTIDADE INT,
VALOR DECIMAL(10,2),
ID_PEDIDO_PIANO INT FOREIGN KEY REFERENCES PEDIDO_PIANO(ID_PEDIDO_PIANO)
)
INSERT INTO FORNECEDOR_PIANO  VALUES 
('FORNECEDOR PIANO F'),('FORNECEDOR PIANO S')
INSERT INTO PIANO (NOME_PIANO,ID_FORNECEDOR_PIANO,CODIGO_PIANO) VALUES
('PIANO F',1,'F_PIANO'),('PIANO F2',1,'F2_PIANO'),('PIANO S',2,'S_PIANO'),('PIANO S2',2,'S2_PIANO')
,('PIANO ZY',2,'ZY_PIANO')
INSERT INTO CLIENTE_PIANO VALUES
('PIANO FS INC.') , ('SSF PIANO VENDAS SA')
INSERT INTO PEDIDO_PIANO 
(NUMERO_PEDIDO_PIANO,QUANTIDADE_TOTAL,VALOR_TOTAL,DATA,ID_CLIENTE_PIANO) VALUES
(100,2,1000,'2000-01-01',1),
(150,1,500,'2000-02-01',2),
(180,1,500,'2000-03-01',2),
(190,3,1500,'2000-04-01',2)
INSERT INTO DETALHE_PEDIDO_PIANO (ID_PIANO,QUANTIDADE,VALOR,ID_PEDIDO_PIANO) VALUES
(1,1,500,1),
(2,1,500,1),
(1,1,500,2),
(2,1,500,3), 
(3,1,500,4),
(4,2,1000,4)
 /*
 Ola Yago Dias Tonini tudo bem com voc�? Preciso de uma ajuda aqui para entregar um relat�rio. Da uma for�a!
1 - Poderia selecionar o nome dos PIANOS e o nome do fornecedor dos PIANOS 
    onde o codigo do PIANO    come�e com S, ordenados pelo nome do PIANO?
*/
/*
2 - Poderia selecionar o nome dos clientes a data do pedido do PIANO, quantidade e  valor
    onde a data do pedido � maior que 2000-03-01?
*/
/*
3 - Poderia criar uma tabela chamada [COMPRAS_PIANO] com os valores
o nome do PIANO, o nome do cliente, data da compra ?
*/

/*
4 - Poderia criar uma consulta, para buscar o NOME dos PIANOS que   tiveram nenhuma compra?
(PS: OBRIGAT�RIO TER UM JOIN ENTRE A TABELA PIANO E PEDIDO_PIANO, 
NADA DE SELECT * FROM PIANOS where NOME = XXX n�o!
*/
 /*
5 - Poderia criar uma tabela chamada [COMPRAS_PIANO_FORNECEDOR] com os valores
o nome do PIANO, quantidade do PIANO vendida, o valor e o nome do fornecedor onde o 
nome do fornecedor     termine com a letra F? */