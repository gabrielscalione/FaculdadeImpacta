/*
AC01- CLAUSULAS SELECT E CREATE 

Turma: BD 2C
Grupo:
	Gabriel Scalione	RA: 1903812
	Isaque Ribeiro		RA: 1903978 
	Lucimara Mendes		RA: 1903617
	Mayra Fernanda		RA: 1903486
	Yuri Placido		RA: 1904177

*/

----------------------------------------------------------
-- Exercício 3 - Alteração das Tabelas MAQUINA e CLIENTE
----------------------------------------------------------
-- TABELA MAQUINA - Crie uma nova coluna chamada “COR” VARCHAR (50).
	
	ALTER TABLE MAQUINA ADD COR VARCHAR(20)

--TABELA CLIENTE - Crie uma restrição na coluna CNPJ_CPF para que esse valor seja ÚNICO.
	
	ALTER TABLE CLIENTE ADD CONSTRAINT uqCLIENTE_CNPJ_CPF UNIQUE (CNPJ_CPF)

-- TABELA CLIENTE - Remova a coluna NOME_FANTASIA.
	
	ALTER TABLE CLIENTE DROP COLUMN NOME_FANTASIA

-- TABELA CLIENTE - Crie uma nova coluna chamada “TELEFONE” VARCHAR (100).
	
	ALTER TABLE CLIENTE ADD TELEFONE VARCHAR(100)
