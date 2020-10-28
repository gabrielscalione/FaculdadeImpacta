USE MASTER 
DROP DATABASE IF EXISTS CARRO
GO
CREATE DATABASE CARRO
GO
 USE CARRO
CREATE TABLE FORNECEDOR_CARRO
(
ID_FORNECEDOR_CARRO  INT IDENTITY(1,1) PRIMARY KEY,
NOME_FORNECEDOR VARCHAR(MAX)
)
CREATE TABLE CARRO
(
ID_CARRO INT IDENTITY(1,1) PRIMARY KEY,
NOME_CARRO VARCHAR(200) UNIQUE,
CODIGO_CARRO VARCHAR(200)  ,
ID_FORNECEDOR_CARRO INT FOREIGN KEY REFERENCES FORNECEDOR_CARRO(ID_FORNECEDOR_CARRO)
)
CREATE TABLE CLIENTE_CARRO
(
ID_CLIENTE_CARRO INT IDENTITY(1,1) PRIMARY KEY,
NOME_CLIENTE_CARRO VARCHAR(200)
)
CREATE TABLE PEDIDO_CARRO
(
ID_PEDIDO_CARRO INT IDENTITY(1,1) PRIMARY KEY,
NUMERO_PEDIDO_CARRO INT  ,
QUANTIDADE_TOTAL INT,
VALOR_TOTAL DECIMAL(10,2),
DATA DATE,
ID_CLIENTE_CARRO INT FOREIGN KEY REFERENCES CLIENTE_CARRO(ID_CLIENTE_CARRO)
)
CREATE TABLE DETALHE_PEDIDO_CARRO
(
ID_DETALHE_PEDIDO_CARRO INT IDENTITY(1,1) PRIMARY KEY,
ID_CARRO  INT FOREIGN KEY REFERENCES CARRO(ID_CARRO),
QUANTIDADE INT,
VALOR DECIMAL(10,2),
ID_PEDIDO_CARRO INT FOREIGN KEY REFERENCES PEDIDO_CARRO(ID_PEDIDO_CARRO)
)
INSERT INTO FORNECEDOR_CARRO  VALUES 
('FORNECEDOR CARRO B'),('FORNECEDOR CARRO C')
INSERT INTO CARRO (NOME_CARRO,ID_FORNECEDOR_CARRO,CODIGO_CARRO) VALUES
('CARRO B',1,'B_CARRO'),('CARRO B2',1,'B2_CARRO'),('CARRO C',2,'C_CARRO'),('CARRO C2',2,'C2_CARRO')
,('CARRO ZY',2,'ZY_CARRO')
INSERT INTO CLIENTE_CARRO VALUES
('CARRO BC INC.') , ('CCB CARRO VENDAS SA')
INSERT INTO PEDIDO_CARRO 
(NUMERO_PEDIDO_CARRO,QUANTIDADE_TOTAL,VALOR_TOTAL,DATA,ID_CLIENTE_CARRO) VALUES
(100,2,1000,'2000-01-01',1),
(150,1,500,'2000-02-01',2),
(180,1,500,'2000-03-01',2),
(190,3,1500,'2000-04-01',2)
INSERT INTO DETALHE_PEDIDO_CARRO (ID_CARRO,QUANTIDADE,VALOR,ID_PEDIDO_CARRO) VALUES
(1,1,500,1),
(2,1,500,1),
(1,1,500,2),
(2,1,500,3), 
(3,1,500,4),
(4,2,1000,4)
 /*
 Ola Cassio de Lima Alves Silva tudo bem com voc�? Preciso de uma ajuda aqui para entregar um relat�rio. Da uma for�a!
1 - Poderia selecionar o nome dos CARROS e o nome do fornecedor dos CARROS 
    onde o codigo do CARRO n�o  come�e com C, ordenados pelo nome do CARRO?
*/
/*
2 - Poderia selecionar o nome dos clientes a data do pedido do CARRO, quantidade e  valor
    onde a data do pedido � maior que 2000-03-01?
*/
/*
3 - Poderia criar uma tabela chamada [COMPRAS_CARRO] com os valores
o nome do CARRO, o nome do cliente, data da compra ?
*/

/*
4 - Poderia criar uma consulta, para buscar o NOME dos CARROS que n�o tiveram nenhuma compra?
(PS: OBRIGAT�RIO TER UM JOIN ENTRE A TABELA CARRO E PEDIDO_CARRO, 
NADA DE SELECT * FROM CARROS where NOME = XXX n�o!
*/
 /*
5 - Poderia criar uma tabela chamada [COMPRAS_CARRO_FORNECEDOR] com os valores
o nome do CARRO, quantidade do CARRO vendida, o valor e o nome do fornecedor onde o 
nome do fornecedor n�o   termine com a letra B? */