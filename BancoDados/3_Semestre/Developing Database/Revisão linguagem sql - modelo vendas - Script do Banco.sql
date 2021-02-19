create database ac9
go
use ac9
go
create table venda (
	nota_fiscal int not null
	, data datetime not null
	, atendente nvarchar(50) null
	, constraint PK_venda PRIMARY KEY ( nota_fiscal)
)
GO
create table Produto (
	ID int not null
	, nome nvarchar(50) not null
	, preco decimal(10,4) not null
	, constraint PK_produto PRIMARY KEY ( ID )
)
GO
create table ItemVenda (
	NF int not null
	, idProduto int not null
	, preco decimal(10,4) not null
	, qtde int not null
	, constraint PK_Itemvenda PRIMARY KEY ( NF, idProduto )
	, constraint FK_itemvenda_notafiscal FOREIGN KEY (NF) REFERENCES venda( nota_fiscal )
	, constraint FK_Itemvenda_produto FOREIGN KEY ( idProduto) REFERENCES produto ( id )
)
GO
INSERT INTO venda(nota_fiscal, data, atendente) 
values (1112, '20110312', 'Marco' ), (3002, '20110314', 'Marco' ), (7134, '20110421', 'Marco' ), (7135, '20110501', 'Pedro' )
GO
INSERT INTO produto(ID, nome, preco) 
VALUES ( 1, 'Lapis', 0.25), ( 2, 'Caneta', 0.50), ( 9, 'Caderno', 5.00), ( 10, 'Borracha', 0.50)
GO
INSERT INTO ItemVenda(NF, idProduto, preco, qtde)
VALUES (1112, 1, 0.22, 230), (1112,2,0.50,10), (1112,9,5.50,1), (3002, 9, 4.50,20)
GO
select * from venda
select * from itemvenda
select * from produto

SELECT * FROM Venda WHERE Atendente = 'Marco' AND Atendente = 'Pedro'
SELECT * FROM Venda WHERE Atendente = 'Marco' OR Atendente = 'Pedro'


