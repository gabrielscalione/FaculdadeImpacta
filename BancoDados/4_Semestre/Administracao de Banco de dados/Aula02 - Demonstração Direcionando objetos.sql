use master
go


-- Direcionando objetos 
-- Drop Database DBAula 

CREATE DATABASE DBAula 
ON PRIMARY (
	NAME = 'DBAula_Data1', 
	FILENAME = 'C:\BD\MDF\DBAula_Data1.mdf', 
	SIZE = 5 MB, FILEGROWTH = 10  MB), 

FILEGROUP CORPORATIVO DEFAULT (NAME = 'DBAula_Data2', FILENAME = 'C:\BD\MDF\DBAula_Data2.ndf', SIZE = 20  MB, FILEGROWTH = 10 %), 
FILEGROUP HISTORICO  
(NAME = 'DBAula_Data3', FILENAME = 'C:\BD\MDF\DBAula_Data3.ndf', SIZE = 10 MB, FILEGROWTH = 5 MB), (NAME = 'DBAula_Data4', FILENAME = 'C:\BD\MDF\DBAula_Data4.ndf', SIZE = 10 MB, FILEGROWTH = 5 MB) 
LOG ON 
(NAME = 'DBAula_log', FILENAME ='C:\BD\LDF\DBAula_Data4.mdf', SIZE = 10 MB, FILEGROWTH = 10 %) 

USE DBAula
go

-- Criando Objetos no filegroup DEFAULT 
create table Cliente (
	idCliente int identity primary key
	, nome varchar(20)
	, sobrenome varchar(20)) 

-- Criando Objetos no filegroup desejado 
create table Produto (
	idProduto smallint identity primary key
	, nome varchar(50)
	, descricao varchar(200)) on corporativo 
create table Venda (
	idVenda int identity primary key
	, data datetime default getdate()
	, idCliente int foreign key references Cliente(idCliente)
	, idProduto smallint foreign key references Produto(idProduto)) on Historico
