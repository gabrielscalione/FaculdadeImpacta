
-- >>> Abra o SSMS ( SQL Server Management Studio ) e estabeleça 1 conexão com o servidor. <<<
-- 1. Detalhe os comandos executados para: 
create database ISOLAMENTO
GO

USE ISOLAMENTO
GO  

-- a) Ajustar o nível de isolamento para SERIALIZABLE 
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE


-- b) Abrir uma transação 
BEGIN TRANSACTION

-- c) Executar um CREATE TABLE  
CREATE TABLE Paciente (
	ID INT NOT NULL IDENTITY(1,1)
	, Nome VARCHAR(50) NOT NULL
	, Telefone INT NULL
	, CONSTRAINT PK_Paciente PRIMARY KEY nonclustered ( ID )
)


GO  

-- d) Executar alguns INSERTs 
;with base(ra, nome) as (
	select '1601152', 'Wellington Serafim'
	union all select '1600892', 'Daywison Ferreira Leal'
	union all select '1601291', 'Alan Lazari'
	union all select '1601119', 'Eduardo Felipe Freitas Satyra'
	union all select '1601148', 'Lucas do Nascimento Galdino da Silva'
	union all select '1701091', 'Victor Correia de Campos'
	union all select '1701340', 'Mateus Yoshihito Teruya Sugimura'
	union all select '1701214', 'Vitor Hugo Lage Cabral'
	union all select '1701697', 'Diogo Barbosa Lima'
	union all select '1701362', 'Luis Henrique Miranda de Souza'

)
INSERT INTO Paciente ( telefone, nome )
select left('9'+convert(varchar,convert(int,ra*rand())),9), nome
from base
GO

-- e) Conferir se os dados foram inseridos ( SELECT ) 
SELECT *   
FROM   Paciente  

GO  

-- f) Dar ROLLBACK de toda a operação 
ROLLBACK TRANSACTION

GO

-- g) Conferir se os dados ainda estão lá ( SELECT ) 
SELECT *   
FROM   Paciente  
