/* Isto j� deve estar criado, n�o precisa rodar novamente... */
	USE ImpactaEstacionamento;
	GO
	/*Cliente � o mensalista, pode estacionar se estiver em dia com as mensalidades*/
	CREATE TABLE cliente (
		id INT NOT NULL IDENTITY(1,1)
		, nome VARCHAR(60) NOT NULL
		, cpf CHAR(11) NOT NULL
		, telefone VARCHAR(20) NOT NULL
		, professor BIT NULL CONSTRAINT DF_professorCliente DEFAULT (0)
		, CONSTRAINT CK_CPFCliente CHECK ( cpf LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' )
		, CONSTRAINT PK_cliente PRIMARY KEY ( id )
		, CONSTRAINT UQ_ClienteCPF UNIQUE (cpf)
	)
	GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 08 - Transa��es, Erros: Gera��o, Captura e Tratamento de erros; Debug.
--=X=-- 	Logs e rastreamento de erros.
--=X=-- 	Debug de processos.
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

select * from cliente
/*
	id	nome				cpf			telefone		professor
	---	------------------- -----------	--------------- --------------
	1	Almir dos Santos	78654552421	(11)91234-5678	0
*/
--Teste ROLLBACK
BEGIN TRANSACTION
	INSERT INTO cliente( nome, cpf, telefone, professor ) 
	SELECT 'Klaus Petherson', '12345678901', '11976531251', 1
ROLLBACK TRANSACTION

select * from cliente
/*
	id	nome				cpf			telefone		professor
	---	------------------- -----------	--------------- --------------
	1	Almir dos Santos	78654552421	(11)91234-5678	0
	O que mais ele retornou ?
*/

--Teste COMMIT
BEGIN TRANSACTION
	INSERT INTO cliente( nome, cpf, telefone, professor ) 
	SELECT 'Klaus Petherson', '12345678901', '11976531251', 1
COMMIT TRANSACTION

select * from cliente
	id	nome				cpf			telefone		professor
	---	------------------- -----------	--------------- --------------
	1	Almir dos Santos	78654552421	(11)91234-5678	0
	???

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Testes de isolamento
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--Sess�o 1
select * from cliente
/*
	id	nome				cpf			telefone		professor
	---	------------------- -----------	--------------- --------------
	1	Almir dos Santos	78654552421	(11)91234-5678	0
*/
--Teste ISOLAMENTO
BEGIN TRANSACTION
	UPDATE cliente 
		SET nome = 'Joacir dos Santos'
		WHERE nome = 'Almir dos Santos'

select * from cliente
/*
	id	nome				cpf			telefone		professor
	---	------------------- -----------	--------------- --------------
	1	????? dos Santos	78654552421	(11)91234-5678	0
	Almir ou Joacir dos Santos ?
*/

--n�o rode o COMMIT ainda
COMMIT

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
/*Testes de isolamento*/
--Sess�o 2
select * from cliente WITH(NOLOCK)
/*
	id	nome				cpf			telefone		professor
	---	------------------- -----------	--------------- --------------
	1	????? dos Santos	78654552421	(11)91234-5678	0
	Almir ou Joacir dos Santos ?
*/

select * from cliente 
/*
	O que aconteceu ?
*/


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Testes de transa��es aninhadas
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
SELECT 'Ponto 1', @@TRANCOUNT as TRANCOUNT
BEGIN TRANSACTION A
	INSERT INTO cliente( nome, cpf, telefone, professor ) 
	SELECT 'Juliana Petron', '87555273663', '11984847474', 0

	SELECT 'Ponto 2', @@TRANCOUNT as TRANCOUNT

	BEGIN TRANSACTION B
		INSERT INTO cliente( nome, cpf, telefone, professor ) 
		SELECT 'Samira Pinheiro', '19281765231', '11997675544', 0

		SELECT 'Ponto 3', @@TRANCOUNT as TRANCOUNT

	COMMIT TRANSACTION B
	SELECT 'Ponto 4', @@TRANCOUNT as TRANCOUNT

COMMIT TRANSACTION A
SELECT 'Ponto 5', @@TRANCOUNT as TRANCOUNT

/*
  O que � devolvido em cada ponto ?
*/


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Testes de transa��es impl�citas
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

SET IMPLICIT_TRANSACTIONS ON;

INSERT INTO cliente( nome, cpf, telefone, professor ) 
SELECT 'Edward Strays', '14367866578', '11878764351', 1

/*
	Ele entrou em uma transa��o, como fazer para verificar ?
	Ele j� salvou o cliente Edward em definitivo ?
	O que acontece seu eu esquecer o COMMIT ?
*/

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- ERROS
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

select * from cliente
/*
	id	nome				cpf			telefone		professor
	---	------------------- -----------	--------------- --------------
	1	Almir dos Santos	78654552421	(11)91234-5678	0
*/
INSERT INTO cliente( nome, cpf, telefone, professor ) 
SELECT 'Almir dos Santos', '78654552421', '11912345678', 1



--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- ERROS - Gerando erros - RAISERROR
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

RAISERROR('Por favor Digite um valor entre 1 e 10, valor fornecido: %d',16,1,99)

RAISERROR('N�mero de ve�culos estacionados (%d) � superior � capacidade do estabelecimento (%d)',16,1,13,10)

DECLARE @datahoraTextual VARCHAR(255) = convert(varchar,getdate(),113)
RAISERROR('S� s�o aceitos estacionamentos at� �s 12:00, agora s�o: %s',16,1,@datahoraTextual)

--fonte: https://docs.microsoft.com/pt-br/sql/t-sql/language-elements/raiserror-transact-sql?view=sql-server-ver15

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- ERROS - Gerando erros - THROW
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--fonte: https://docs.microsoft.com/pt-br/sql/t-sql/language-elements/throw-transact-sql?view=sql-server-ver15
	--O par�metro error_number n�o precisa ser definido em sys.messages.
	--O par�metro message n�o aceita a formata��o de estilo printf.
	--N�o h� nenhum par�metro severity. Quando THROW � usado para iniciar a exce��o, a severidade � sempre definida como 16

THROW 51000, 'Id do cliente n�o encontrado.', 1;

THROW 51000, 'Id do cliente n�o encontrado.', 1;



--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- ERROS - Criando mensagens e gerando erros  
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

USE master;  
GO  
EXEC sp_addmessage @msgnum = 60000, @severity = 16,   
   @msgtext = N'Age should be between 0 and 120 years'
   ,@lang = 'us_english'
   --,@replace = 'replace'
EXEC sp_addmessage @msgnum = 60000, @severity = 16,   
   @msgtext = N'Idade deve ser entre 0 e 120 anos'   
   ,@lang = 'Portugu�s (Brasil)'
   --,@replace = 'replace';
GO  

DECLARE @idade TINYINT = 180
IF @idade NOT BETWEEN 0 AND 120 
	RAISERROR(60000,16,1)
GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- ERROS - identificando errros com o @@rowcount
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

BEGIN TRAN
	Declare @linhasAfetadas int = 0
	select @linhasAfetadas = count(*) from estacionamento where idVeiculo = 1

	UPDATE estacionamento set valorCobrado += 0.10

	IF @@ROWCOUNT = @linhasAfetadas
		COMMIT
	ELSE
		ROLLBACK
IF @@TRANCOUNT > 0
	RAISERROR('OOps, voc� n�o deveria ainda estar dentro de uma transa��o',16,1)

select * from estacionamento

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- ERROS - identificando errros com o @@error
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

BEGIN TRAN
	Declare @erroCapturado int = 0
	select * from estacionamento where valorCobrado / valorCobrado > 0

	set @erroCapturado = @@error
	IF @erroCapturado = 0
		COMMIT
	ELSE IF @erroCapturado = 8134
	BEGIN
		PRINT 'Sim, voc� realmente dividiu por zero'
		ROLLBACK
	END

IF @@TRANCOUNT > 0
	RAISERROR('OOps, voc� n�o deveria ainda estar dentro de uma transa��o',16,1)

select * from estacionamento

----------------------------------------------------------------------------

BEGIN TRAN
	select * from estacionamento where valorCobrado / valorCobrado > 0

	IF @@error = 0
		COMMIT
	ELSE IF @@error = 8134
	BEGIN
		PRINT 'Sim, voc� realmente dividiu por zero'
		ROLLBACK
	END

IF @@TRANCOUNT > 0
	RAISERROR('OOps, voc� n�o deveria ainda estar dentro de uma transa��o',16,1)

select * from estacionamento

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- ERROS - Tente entender o que acontece aqui.
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
SELECT 'Ponto 1', @@TRANCOUNT as TRANCOUNT
BEGIN TRANSACTION A
	INSERT INTO cliente( nome, cpf, telefone, professor ) 
	SELECT 'Klaus Petherson', '12345678901', '11976531251', 1

	SELECT 'Ponto 2', @@TRANCOUNT as TRANCOUNT

	BEGIN TRANSACTION B
		INSERT INTO cliente( nome, cpf, telefone, professor ) 
		SELECT 'Klaus Petherson', '12345678901', '11976531251', 1

		SELECT 'Ponto 3', @@TRANCOUNT as TRANCOUNT

	ROLLBACK TRANSACTION B
	SELECT 'Ponto 4', @@TRANCOUNT as TRANCOUNT

COMMIT TRANSACTION A
SELECT 'Ponto 5', @@TRANCOUNT as TRANCOUNT


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- ERROS - Blocos Try Catch
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

BEGIN TRY  
    -- Generate a divide-by-zero error.  
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
    SELECT  
        ERROR_NUMBER() AS ErrorNumber,  
        ERROR_SEVERITY() AS ErrorSeverity,  
        ERROR_STATE() AS ErrorState,  
        ERROR_PROCEDURE() AS ErrorProcedure,  
        ERROR_LINE() AS ErrorLine,  
        ERROR_MESSAGE() AS ErrorMessage;  
END CATCH;  
GO 

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- ERROS - Blocos Try Catch - rethrow
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

USE tempdb;  
GO  
CREATE TABLE dbo.TestRethrow  
(    ID INT PRIMARY KEY  
);  
BEGIN TRY  
    INSERT dbo.TestRethrow(ID) VALUES(1);  
--  Force error 2627, Violation of PRIMARY KEY constraint to be raised.  
    INSERT dbo.TestRethrow(ID) VALUES(1);  
END TRY  
BEGIN CATCH  
  
    PRINT 'In catch block.';  
    THROW;  
END CATCH;  


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- ERROS - Exerc�cios
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 





