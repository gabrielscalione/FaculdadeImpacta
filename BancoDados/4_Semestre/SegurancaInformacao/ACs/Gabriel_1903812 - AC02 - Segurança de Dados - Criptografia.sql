/* 
			AC2 - Segurança de Dados - Criptografia

	NOME: Gabriel Serrano Scalione
	RA: 1903812
	BD 4A
*/
USE Cripto
GO

/************************************************************************************************
------- PARTE 1 -------
--Função de criptografia

Recebe uma string e devolve o respectivo valor criptografado em VARBINARY utilizando
um algoritmo de 2 vias assimétrico de criptografia.
*************************************************************************************************/

	--=X=-- CRIA CHAVE ASSIMÉTRICA
	CREATE ASYMMETRIC KEY ChaveAssimetrica001
	WITH ALGORITHM = RSA_2048
	ENCRYPTION BY PASSWORD = N'mGd]Ap#]ei4{bff';
	GO
	
	--=X=-- CRIA A FUNÇÃO DE CRIPTOGRAFIA
	CREATE OR ALTER FUNCTION dbo.Fn_encrypt(@ST VARCHAR(max))
	RETURNS VARBINARY(max)
	AS
	BEGIN

		Declare @key_ID INT = (select AsymKey_ID('ChaveAssimetrica001'))

		Declare @result VARBINARY(MAX)
		SELECT @result = EncryptByAsymKey(@key_ID, @ST)
	
		return @result
	END
	GO

	--=X=-- TESTE
	SELECT dbo.Fn_encrypt('senhaforte')
	GO

/************************************************************************************************
--Função de decriptografia

Recebe um valor já criptografado e devolve o respectivo valor decriptografado já
convertido em VARCHAR
*************************************************************************************************/
	
	--=X=-- CRIA A FUNÇÃO DE DECRIPTOGRAFIA
	CREATE OR ALTER FUNCTION dbo.Fn_decrypt (@result VARBINARY(MAX))
	RETURNS varchar(max)
	AS
	begin
		Declare @key_ID INT = (select AsymKey_ID('ChaveAssimetrica001'))
	
		return CONVERT(VARCHAR,DecryptByAsymKey(@key_ID, @result, N'mGd]Ap#]ei4{bff'))

		return @result
	end
	GO

	--=X=-- TESTE
	SELECT dbo.Fn_decrypt(dbo.Fn_encrypt('senhaforte')) AS SENHA_DECRIPT
	GO

/************************************************************************************************
--Função de criptografia de HASH

Recebe uma string e devolve o respectivo valor criptografado em VARBINARY utilizando
um algoritmo de HASH com a utilização de um SALT ( por segurança ).
*************************************************************************************************/

	--=X=-- CRIA A FUNÇÃO DE HASH
	CREATE OR ALTER FUNCTION dbo.Fn_hash (@pass VARCHAR(255))
	RETURNS VARBINARY(max)
	AS
	begin

		Declare @Salt Varchar(50) = 'kamehamehaaaa'
		Declare @value Varchar(255) =  @pass + @salt

		Declare @result VARBINARY(MAX)
	
		SELECT @result = HASHBYTES('sha1',@value)
	
		return @result
	end
	GO

	--=X=-- TESTE
	SELECT dbo.Fn_hash('testepass') AS SENHA_HASH
	GO

/********************************************************************************/
------- PARTE 2 -------

--Criando a tabela
CREATE TABLE TBL_CTRL_ACESSO (
	LOGIN VARCHAR(60) NOT NULL
	, SENHA VARBINARY(MAX) NOT NULL
	, DICA_SENHA VARBINARY(MAX) NULL
	, CONSTRAINT PK_CTRL_ACESSO PRIMARY KEY ( LOGIN )
)
GO

	--Inserindo valores nas tabelas para testes:
	INSERT INTO TBL_CTRL_ACESSO ( LOGIN, SENHA, DICA_SENHA )
	VALUES	
			( 'igor.schmidt', dbo.FN_HASH('17544'), dbo.FN_ENCRYPT('Pediatra'))
	, 		( 'camila.pereira', dbo.FN_HASH('88666'), dbo.FN_ENCRYPT('Obstetra'))
	, 		( 'adamastor.pedreira', dbo.FN_HASH('64564'), dbo.FN_ENCRYPT('Cardiologista'))
	, 		( 'mauricio.santos', dbo.FN_HASH('23577'), dbo.FN_ENCRYPT('Obstetra'))
	, 		( 'dorival.silva', dbo.FN_HASH('98567'),  dbo.FN_ENCRYPT('Obstetra'))
	, 		( 'patricia.santos', dbo.FN_HASH('65867'), dbo.FN_ENCRYPT('Pediatra'))
	GO

	--Testando valores brutos inseridos na tabela
	select * from TBL_CTRL_ACESSO
	GO

	--Testando valores decriptografados lidos da tabela
	SELECT login, senha,
	CONVERT(VARCHAR, dbo.Fn_decrypt(dica_senha)) AS dica_senha
	FROM TBL_CTRL_ACESSO
	GO



/********************************************************************************
------- PARTE 3 -------

Seja a seguinte procedure ( que também será criada na AC2 )

EXEC Pr_login @login, @senha, @result output

Que, recebe um login e senha ( ambos varchar ) e devolve 1 se ele foi autenticado, ou seja,
se aquele usuário foi cadastrado com aquela senha, e 0 caso contrário.
********************************************************************************/

	--- CRIAÇÃO DA PROC LOGIN
	create or alter procedure Pr_login 
	(	@login VARCHAR(100)		= NULL
		, @senha VARCHAR(255)	= NULL
		, @result BIT output
	)
	as begin
		
		SET @result = IIF(EXISTS(SELECT * FROM tbl_ctrl_acesso WHERE login = @login and senha = dbo.Fn_hash(@senha)), 1, 0)

	end
	go

	--testando procedure de login
	DECLARE @result BIT
	, @login VARCHAR(100) = NULL
	, @senha VARCHAR(255) = NULL

	
	-- TESTE COM AUTENTICADOS
	-- 1 --
	SET @login = 'igor.schmidt'
	SET @senha = '17544'
	EXEC Pr_login @login, @senha, @result output
	SELECT CASE WHEN @result = 1 THEN 'Autenticado' ELSE 'Não autenticado' END
	
	-- 2 --
	SET @login = 'camila.pereira'
	SET @senha = '88666'
	EXEC Pr_login @login, @senha, @result output
	SELECT CASE WHEN @result = 1 THEN 'Autenticado' ELSE 'Não autenticado' END

	------------------------------------------------------------------------------------------------------------------------------
	--TESTES COM NÃO AUTENTICADOS
	-- 1 --  LOGIN ERRADO COM A SENHA CERTA
	SET @login = 'adamastor'
	SET @senha = '64564'
	EXEC Pr_login @login, @senha, @result output
	SELECT CASE WHEN @result = 1 THEN 'Autenticado' ELSE 'Não autenticado' END

	-- 2 -- LOGIN CERTO COM A SENHA ERRADA
	SET @login = 'patricia.santos'
	SET @senha = '88666'
	EXEC Pr_login @login, @senha, @result output
	SELECT CASE WHEN @result = 1 THEN 'Autenticado' ELSE 'Não autenticado' END
go


/************************************************************************
------- PARTE 4 -------

Seja a seguinte procedure ( que também será criada na AC2 )
EXEC Pr_esqueci_senha @login, @result output
Que, recebe um login ( varchar ) e devolve a dica da senha decriptografada, cadastrada
para aquele login.
*************************************************************************/

	--- CRIAÇÃO DA PROC	ESQUECI SENHA
	create or alter procedure Pr_esqueci_senha 
	(	@login VARCHAR(100) = NULL
		, @retornadica varchar(500) output
	)
	AS BEGIN
		
		declare @dica_senha VARBINARY(max)

		SELECT @dica_senha = dica_senha from TBL_CTRL_ACESSO where login = @login

		SET @retornadica = CONVERT(VARCHAR, dbo.Fn_decrypt(@dica_senha))

	END
	go


--Exemplo de utilização:
--Testando a procedure esqueci senha
	DECLARE @dicadesenha VARCHAR(500)


	EXEC Pr_esqueci_senha 'patricia.santos', @dicadesenha output
	SELECT 'Sua dica da senha é: "' + @dicadesenha + '"'

	EXEC Pr_esqueci_senha 'adamastor.pedreira', @dicadesenha output
	SELECT 'Sua dica da senha é: "' + @dicadesenha + '"'
	
	EXEC Pr_esqueci_senha 'dorival.silva', @dicadesenha output
	SELECT 'Sua dica da senha é: "' + @dicadesenha + '"'

go