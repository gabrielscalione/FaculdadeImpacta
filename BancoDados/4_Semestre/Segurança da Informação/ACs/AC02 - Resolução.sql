/* 
			AC2 - 
*/
USE Cripto
GO
------- PARTE 1 -------

/************************************
Recebe uma string e devolve o respectivo valor criptografado em VARBINARY utilizando
um algoritmo de 2 vias assimétrico de criptografia.
*************************************/

	--=X=-- CRIA CHAVE ASSIMÉTRICA
	CREATE ASYMMETRIC KEY ChaveAssimetrica001
	WITH ALGORITHM = RSA_2048
	ENCRYPTION BY PASSWORD = N'!@@QW#E#$R%dreud76';
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
	SELECT dbo.Fn_encrypt('Bazzinga')
	GO

/************************************
Recebe um valor já criptografado e devolve o respectivo valor decriptografado já
convertido em VARCHAR
*************************************/
	
	--=X=-- CRIA A FUNÇÃO DE DECRIPTOGRAFIA
	CREATE OR ALTER FUNCTION dbo.Fn_decrypt (@result VARBINARY(MAX))
	RETURNS varchar(max)
	AS
	begin
		Declare @key_ID INT = (select AsymKey_ID('ChaveAssimetrica001'))
	
		return CONVERT(VARCHAR,DecryptByAsymKey(@key_ID, @result, N'!@@QW#E#$R%dreud76'))

		return @result
	end
	GO

	--=X=-- TESTE
	SELECT dbo.Fn_decrypt(dbo.Fn_encrypt('Bazzinga'))
	GO

/************************************
Recebe uma string e devolve o respectivo valor criptografado em VARBINARY utilizando
um algoritmo de HASH com a utilização de um SALT ( por segurança ).
*************************************/

	--=X=-- CRIA A FUNÇÃO DE HASH
	create or alter function dbo.Fn_hash (@pass VARCHAR(255))
	RETURNS VARBINARY(max)
	AS
	begin

		Declare @Salt Varchar(50) = 'Saitama'
		Declare @value Varchar(255) =  @pass + @salt

		Declare @result VARBINARY(MAX)
	
		SELECT @result = HASHBYTES('sha1',@value)
	
		return @result
	end
	GO

	--=X=-- TESTE
	SELECT dbo.Fn_hash('oi')
	GO


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
	VALUES ( 'José', dbo.FN_HASH('senha'), dbo.FN_ENCRYPT('aquela lá') )
	GO
	INSERT INTO TBL_CTRL_ACESSO ( LOGIN, SENHA, DICA_SENHA )
	VALUES ( 'Jaiminho', dbo.FN_HASH('tangamandapio'), dbo.FN_ENCRYPT('evitar a fadiga na terrinha') )
	GO
	INSERT INTO TBL_CTRL_ACESSO ( LOGIN, SENHA, DICA_SENHA )
	VALUES ( 'Chapolin', dbo.FN_HASH('marreta'), dbo.FN_ENCRYPT('a bionica') )
	GO

	--Testando valores brutos inseridos na tabela
	select * from TBL_CTRL_ACESSO
	GO

	--Testando valores decriptografados lidos da tabela
	SELECT login, senha,
	CONVERT(VARCHAR, dbo.Fn_decrypt(dica_senha)) AS dica_senha
	FROM tbl_ctrl_acesso
	GO


------- PARTE 3 -------
/************************************
Seja a seguinte procedure ( que também será criada na AC2 )
EXEC Pr_login @login, @senha, @result output
Que, recebe um login e senha ( ambos varchar ) e devolve 1 se ele foi autenticado, ou seja,
se aquele usuário foi cadastrado com aquela senha, e 0 caso contrário.
*************************************/

	--- CRIAÇÃO DA PROC LOGIN
	create or alter procedure Pr_login 
	(	@login VARCHAR(100) = NULL
		, @senha VARCHAR(255) = NULL
		, @result BIT output
	)
	as begin
		
		SET @result = IIF( EXISTS(SELECT * FROM tbl_ctrl_acesso WHERE login = @login and senha = dbo.Fn_hash(@senha)), 1, 0)

	end
	go

	--testando procedure de login
	DECLARE @result BIT
	
	--AUTENTICADO
	EXEC Pr_login 'josé', 'senha', @result output
	SELECT CASE WHEN @result = 1 THEN 'Autenticado' ELSE 'Não autenticado' END
	
	EXEC Pr_login 'Chapolin', 'marreta', @result output
	SELECT CASE WHEN @result = 1 THEN 'Autenticado' ELSE 'Não autenticado' END

	--NÃO AUTENTICADO
	EXEC Pr_login 'Jaiminho', 'carteiro', @result output
	SELECT CASE WHEN @result = 1 THEN 'Autenticado' ELSE 'Não autenticado' END

	EXEC Pr_login 'josé', 'senha errada', @result output
	SELECT CASE WHEN @result = 1 THEN 'Autenticado' ELSE 'Não autenticado' END
go


------- PARTE 4 -------

/************************************
Seja a seguinte procedure ( que também será criada na AC2 )
EXEC Pr_esqueci_senha @login, @result output
Que, recebe um login ( varchar ) e devolve a dica da senha decriptografada, cadastrada
para aquele login.
*************************************/

	--- CRIAÇÃO DA PROC	ESQUECI SENHA
	create or alter procedure Pr_esqueci_senha 
	(	@login VARCHAR(100) = NULL
		, @result varchar(500) output
	)
	AS BEGIN
		
		declare @dica_senha VARBINARY(max)

		SELECT @dica_senha = dica_senha from TBL_CTRL_ACESSO where login = @login

		SET @result = CONVERT(VARCHAR, dbo.Fn_decrypt(@dica_senha))

	END
	go


--Exemplo de utilização:
--Testando a procedure esqueci senha
	DECLARE @result VARCHAR(60)
	
	EXEC Pr_esqueci_senha 'josé', @result output
	SELECT 'Sua dica da senha é: "' + @result + '"'

	EXEC Pr_esqueci_senha 'chapolin', @result output
	SELECT 'Sua dica da senha é: "' + @result + '"'
	
	EXEC Pr_esqueci_senha 'jaiminho', @result output
	SELECT 'Sua dica da senha é: "' + @result + '"'

go