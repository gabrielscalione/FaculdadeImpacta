USE ImpactaEstacionamento;
GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 13 - AC4 - Fun��es e procedimentos - parte 4
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
/*
Aula 08 - Transa��es, Erros: Gera��o, Captura e Tratamento de erros; Debug.
	Logs e rastreamento de erros.
	Debug de processos.
Aula 09 - Fun��es e procedimentos - parte 1
	Utiliza��o de procedures para controle de processos.
	Utiliza��o de fun��es para automatiza��o de processos de valida��o.
	Cria��o de fun��es para manipula��o de processos.
	Cria��o de procedimentos para manipula��o de processos.
Aula 10 - AC3 - Revis�o aulas 08 e 09
Aula 11 - Fun��es e procedimentos - parte 2
	Stored Procedures, m�todos acessores, par�metros de sa�da.
	Fun��es ( escalar, in-line, multi-statement )
Aula 12 - Exerc�cios - Fun��es e procedimentos - Parte 3
Aula 13 - AC4 - Fun��es e procedimentos - parte 4
	Par�metros com valores Default	
	Tratando de par�metros NULOS
	Par�metros nomeados
	Utiliza�ao do m�todo RETURN em Procedimentos
*/
/*
-------------------------------------------------------------------------- 
-- Conte�do novo: Par�metros com valores Default
--------------------------------------------------------------------------- 
Tanto fun��es quanto procedimentos podem ter seus par�metros de entrada
definidos com valores padr�o ( ou default ), ou seja, quando executados
usando a palavra reservada default, ou em procedures sem passar valores, 
o conte�do ser� substitu�do pelo valor padr�o.
Exemplos:
*/
CREATE OR ALTER FUNCTION fn_escalar_horaAtual ( @param datetime = '19000101' )
RETURNS VARCHAR(50)
AS BEGIN
	RETURN 'hora atual: ' + convert(VARCHAR(50),@param)
END
GO
SELECT dbo.fn_escalar_horaAtual(DEFAULT)
GO
SELECT dbo.fn_escalar_horaAtual(GETDATE())
GO
CREATE OR ALTER PROCEDURE sp_horaAtual ( @param datetime = '19000101' )
AS BEGIN
	SELECT 'hora atual: ' + convert(VARCHAR(50),@param)
END
GO
EXEC sp_horaAtual
GO
EXEC sp_horaAtual DEFAULT
GO
Declare @datahora datetime = GETDATE()
EXEC sp_horaAtual @datahora
GO
/*
-------------------------------------------------------------------------- 
-- Conte�do novo: Tratando de par�metros NULOS
--------------------------------------------------------------------------- 
� comum e at� recomendado tratar par�metros NULOS, substituindo-os
por valores padr�o ( DEFAULT ) ou retornando ERRO por mal uso.
Muitas vezes for�amos o valor DEFAULT da fun��o ou procedimento para NULL
e inclu�mos condicionais para trat�-los.
*/
CREATE OR ALTER FUNCTION fn_escalar_horaAtual ( @param datetime = NULL )
RETURNS VARCHAR(50)
AS BEGIN
	IF (@param IS NULL) 
		SET @param = GETDATE()
	RETURN 'hora atual: ' + convert(VARCHAR(50),@param)
END
GO
SELECT dbo.fn_escalar_horaAtual(DEFAULT)
GO
SELECT dbo.fn_escalar_horaAtual(GETDATE())
GO
SELECT dbo.fn_escalar_horaAtual(NULL)
GO

CREATE OR ALTER PROCEDURE sp_horaAtual ( @param datetime = NULL )
AS BEGIN
	IF (@param IS NULL) 
		SET @param = GETDATE()
	SELECT 'hora atual: ' + convert(VARCHAR(50),@param)
END
GO
EXEC sp_horaAtual
GO
EXEC sp_horaAtual DEFAULT
GO
Declare @datahora datetime = GETDATE()
EXEC sp_horaAtual @datahora
GO
EXEC sp_horaAtual NULL
GO
/*
-------------------------------------------------------------------------- 
-- Conte�do novo: Par�metros nomeados
--------------------------------------------------------------------------- 
Ao chamar uma procedure � poss�vel nomear os par�metros de entrada
isso nos permite n�o s� escolher quais ser�o passados ( e quais n�o )
assim como fornec�-los fora da ordem da declara��o.
*/
CREATE OR ALTER PROCEDURE sp_horaAtual 
	( @paramHora CHAR(2) = NULL
	, @paramMinuto CHAR(2) = NULL
	, @paramSegundo CHAR(2) = NULL
	)
AS BEGIN
	IF ( @paramHora IS NULL ) 
		SET @paramHora = SUBSTRING(convert(varchar,GETDATE(),114),1,2)
	IF ( @paramMinuto IS NULL ) 
		SET @paramMinuto = SUBSTRING(convert(varchar,GETDATE(),114),4,2)
	IF ( @paramSegundo IS NULL ) 
		SET @paramSegundo = SUBSTRING(convert(varchar,GETDATE(),114),7,2)
	SELECT 'hora atual: ' + @paramHora + ':' + @paramMinuto + ':' + @paramSegundo
END
GO
--Sem nomear os par�metros (usando-os na ordem de declara��o na procedure)
-- Usando os valores padr�o
	EXEC sp_horaAtual 
	EXEC sp_horaAtual NULL, NULL, NULL
	EXEC sp_horaAtual DEFAULT, DEFAULT, DEFAULT
	EXEC sp_horaAtual '20', '10', '05'
--Nomeando os par�metros 
	EXEC sp_horaAtual @paramHora = '20', @paramMinuto = '10', @paramSegundo = '05'
	EXEC sp_horaAtual @paramSegundo = '05', @paramMinuto = '10', @paramHora = '20'
--Usando s� alguns par�metros ( hora e minuto s�o passados como NULL / DEFAULT)
	EXEC sp_horaAtual @paramSegundo = '05'
	/*
-------------------------------------------------------------------------- 
-- Conte�do novo: Utiliza�ao do m�todo RETURN em Procedimentos
--------------------------------------------------------------------------- 
Tanto em fun��es quanto em procedimentos a fun��o RETURN encerra a 
execu��o do m�todo e devolve o controle de fluxo para quem a executou.
No caso de fun��es, como j� estudado antes, ele devolve, na vers�o escalar 
um valor �nico, e nas fun��es tabulares uma lista ou tabela.
Nos procedimentos, ele devolve um valor �nico ( similar ao escalar ),
por�m, pela limita��o de s� devolver inteiros ( INT ), ele � 
comumente utilizado para devolver o status da execu��o:
Ex:	1 - Sucesso
	0/-1 - Falha
	*/
CREATE OR ALTER PROCEDURE sp_horaAtual 
	( @paramHora CHAR(2) = NULL
	, @paramMinuto CHAR(2) = NULL
	, @paramSegundo CHAR(2) = NULL
	)
AS BEGIN
	IF ( @paramHora IS NULL ) SET @paramHora = SUBSTRING(convert(varchar,GETDATE(),114),1,2)
	IF ( @paramMinuto IS NULL ) SET @paramMinuto = SUBSTRING(convert(varchar,GETDATE(),114),4,2)
	IF ( @paramSegundo IS NULL ) SET @paramSegundo = SUBSTRING(convert(varchar,GETDATE(),114),7,2)

	IF		( ISNUMERIC(@paramHora) = 0 OR @paramHora NOT BETWEEN 00 and 24 ) 
		OR	( ISNUMERIC(@paramMinuto) = 0 OR @paramMinuto NOT BETWEEN 00 and 60 ) 
		OR	( ISNUMERIC(@paramSegundo) = 0 OR @paramSegundo NOT BETWEEN 00 and 60 ) 
		RETURN -1

	SELECT 'hora atual: ' + @paramHora + ':' + @paramMinuto + ':' + @paramSegundo
	RETURN 1
END
GO
DECLARE @retorno VARCHAR(50)
EXEC @retorno = sp_horaAtual 
SELECT @retorno
GO
DECLARE @retorno VARCHAR(50)
EXEC @retorno = sp_horaAtual 'oops'
SELECT @retorno
GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- AC4 
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
/*
1 - Postem o c�digo solicitado como atividade para casa na aula 12 na quest�o 10.
Criem uma procedure que receba como par�metros:
 uma localidade('Faculdade Impacta - Paulista')
 um cliente('Almir dos Santos') --Podem cadastrar outros clientes para testes
 uma categoria ( 'Mensalista Professor' )
 um dia �til ( ex: 5� )
 uma dura��o do contrato em meses ( de 1 a 12 )
Cadastre um contrato com vencimento para o plano vigente atual daquela categoria.
Com dura��o em meses equivalente ao par�metro de dura��o do contrato.
Cadastre os vencimentos das mensalidades no dia �til escolhido.
� e devolva uma lista com as datas e valores devidos a cada m�s.
Ex:		15/06/2021		R$100,00 --10� dia �til ( hipot�tico )
		14/07/2021		R$100,00 --10� dia �til ( hipot�tico )
		...
*/
	select * from plano
	select * from categoriaPlano
	select * from localidade
	select * from cliente
	select * from contrato
	select * from mensalidade
	
	USE master;  
	GO  
	EXEC sp_addmessage @msgnum = 60004, @severity = 16,   
	   @msgtext = N'Error: Contract duration cannot exceed 12 months'
	   ,@lang = 'us_english'
	EXEC sp_addmessage @msgnum = 60004, @severity = 16,   
	   @msgtext = N'Erro: Dura��o do contrato n�o pode ser superior � 12 meses'   
	   ,@lang = 'Portugu�s (Brasil)'
	   ,@replace = 'replace';

	USE ImpactaEstacionamento
	GO 

	CREATE OR ALTER PROCEDURE sp_cadastraContrato 
	( @localidade VARCHAR(50)	= NULL
	, @cliente VARCHAR(50)		= NULL
	, @categoria VARCHAR(50)	= NULL
	, @diaUtil int				= NULL
	, @duracaoContrato int		= NULL
	)AS BEGIN
		declare @idCategoria int
		, @idPlano int
		, @idLocalidade int
		, @idCliente int
		, @dataContratacao datetime = getdate()
		, @dataEncerramento datetime = dateadd(month, @duracaoContrato, getdate())
		, @dataVencimento datetime
		, @diaVencimento tinyint
		, @valor decimal(10,2)
		, @idContrato int
		, @mes tinyint
		, @recebido bit
		, @dataPagamento datetime
		, @multa decimal(10,2)

		IF @duracaoContrato > 12
		BEGIN
			RAISERROR(60004,16,1)
		END
		ELSE
		BEGIN
			-- Localiza o Plano e valor
			select 
				@idPlano = p.id,
				@valor = p.valor
			from 
				categoriaPlano c
				inner join  plano p
					on p.idCategoria = c.id
			where 
				c.nome = @categoria
		

			-- Pega o id do cliente
			select @idCliente = id from cliente where nome = @cliente

			-- Define o dia de vencimento
			EXEC sp_vencimentoemDiasUteis_v2 @dataContratacao, @diaUtil, @dataVencimento OUTPUT
			SELECT @diaVencimento = DATEPART(day, @dataVencimento)  
		
			INSERT INTO contrato (idPlano, idCliente, diaVencimento, dataContratacao, dateEncerramento)
				VALUES (@idPlano, @idCliente, @diaVencimento, @dataContratacao, @dataEncerramento)
		
			--- pegar o id do contrato
			select @idContrato = max(id) from contrato group by id
		
			CREATE TABLE #DatasVencimento ( dia DATE)
			INSERT INTO #DatasVencimento
			EXEC sp_calculaDatasVencimento @diaUtil, @duracaoContrato
		
			insert into mensalidade
			SELECT @idContrato as idContrato, 
				   month(@dataVencimento) as mes , 
				   1 as recebido, 
				   @dataVencimento as dataVencimento, 
				   dia as dataPagamento, 
				   @valor as valorRecebido, 
				   0.00 as multa 
			from #DatasVencimento

			select dia, @valor as valor from #DatasVencimento

			DROP TABLE #DatasVencimento 
		END	
	END
	

	Exec sp_cadastraContrato 'Faculdade Impacta - Paulista','Almir dos Santos','Mensalista Professor',5,6

/*
2- Postem uma evid�ncia dos testes realizados na execu��o da procedure 
realizada no item 1 
Print da tela contendo execu��o da procedure e select das tabelas 
contrato e mensalidade ( com �nfase nos dados rec�m inseridos).
*/

----------------------------------------------------------------------
/*
3 - Postem o c�digo solicitado para o seguinte enunciado:
Criem uma procedure que receba como par�metros de entrada:
 	o nome do cliente ( �Amauri Silva e Silva� )
	um CPF ( �123.456.789.-09� )
 	um telefone ( �912345678�)
	um bit para 0 = n�o � professor ou 1 = � professor
e devolva como par�metros de sa�da o ID daquele Cliente
	, caso o CPF j� esteja cadastrado
ou primeiro cadastre o cliente para depois devolver seu ID
	, caso aquele cpf n�o esteja cadastrado.
*/
	CREATE TABLE cliente3 (
			id	int not null identity(1,1) 
			, nome	varchar (60) not null
			, cpf	char (11) not null
			, telefone	varchar(20) not null
			, professor	bit null CONSTRAINT DF_professorCliente3 DEFAULT(0)
			, CONSTRAINT CK_CPFCLIENTE3
				CHECK (cpf like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
			, CONSTRAINT PK_cliente3 PRIMARY KEY ( id )
			, CONSTRAINT UQ_Cliente3CPF UNIQUE(cpf)
	)
	
GO 

	CREATE OR ALTER PROCEDURE sp_cadastraCliente 
	( @nomeCliente VARCHAR(50)		= NULL
	, @cpf VARCHAR(50)				= NULL
	, @telefone  VARCHAR(20)		= NULL
	, @ehProfessor bit				= 0
	)AS BEGIN
		
		SET @cpf = REPLACE(REPLACE(REPLACE(@cpf,' ', '' ),'.',''),'-','')
		
		IF EXISTS( SELECT 1 FROM cliente3 WHERE cpf = @cpf)
		BEGIN
			select 'CPF j� esteja cadastrado, id: ' + cast(id as char) from cliente3 WHERE cpf = @cpf
		END
		ELSE
		BEGIN
			insert into cliente3 (nome, cpf, telefone, professor)
			VALUES (@nomeCliente, @cpf, @telefone, @ehProfessor)

			select 'Cadastrado do cliente realizado, id: ' + cast(id as char) from cliente3 WHERE cpf = @cpf

		END

	END


	EXEc sp_cadastraCliente 'Luzia Emily da Silva','891.197.860-42','(86) 3953-8373',1
	EXEc sp_cadastraCliente 'Levi Jorge Ian dos Santos','335.763.580-13','(83) 99193-5152',1
	EXEc sp_cadastraCliente 'Marlene Sueli Rocha','167.075.828-10','(27) 99909-0357',0

------------------------------------------------------------------------
/*
4 - Postem uma evid�ncia dos testes realizados na execu��o da procedure 
realizada no item 3 
Print da tela contendo execu��o da procedure, com testes para clientes 
com CPF novos e velhos, al�m do select da tabela cliente 
( com �nfase em demonstrar os dados rec�m inseridos ).
*/


------------------------------------------------------------------------
/*
5 - Postem o c�digo solicitado para o seguinte enunciado:

Alterem a procedure criada no item 4 para incluir uma valida��o no CPF 
recebido como par�metro.
De forma que, a procedure seja encerrada devolvendo -1 ( return -1 ) 
	caso o CPF n�o seja v�lido,
e continue com o prop�sito normal caso o CPF seja v�lido, devolvendo 1 ( return 1 )
	, ao final da execu��o se tudo foi ocorreu corretamente.
(utilize os c�digos da AC3 como refer�ncia para valida��o de CPFs )
*/

DECLARE @CPF VARCHAR(255) = '167.075.828-99', @retorno VARCHAR(255)
EXEC pr_validaCPF @CPF, @retorno OUTPUT
SELECT 'O CPF : '+ @CPF + ' � ' + @retorno

	CREATE OR ALTER PROCEDURE sp_cadastraCliente_v2
	( @nomeCliente VARCHAR(50)		= NULL
	, @cpf VARCHAR(50)				= NULL
	, @telefone  VARCHAR(20)		= NULL
	, @ehProfessor bit				= 0
	)AS BEGIN
		
		declare @validaCPF char(10)

		SET @cpf = dbo.fn_limpaCPF(@cpf)

		EXEC pr_validaCPF @CPF, @validaCPF OUTPUT

		IF(@validaCPF like 'INV%LIDO')
		BEGIN
			select -1 as mensagem
		END
		ELSE
		BEGIN
		
			IF EXISTS( SELECT 1 FROM cliente3 WHERE cpf = @cpf)
			BEGIN
				select 'CPF j� esteja cadastrado, id: ' + cast(id as char) as mensagem from cliente3 WHERE cpf = @cpf
			END
			ELSE
			BEGIN
				insert into cliente3 (nome, cpf, telefone, professor)
				VALUES (@nomeCliente, @cpf, @telefone, @ehProfessor)

				select 'Cadastrado do cliente realizado, id: ' + cast(id as char) as mensagem from cliente3 WHERE cpf = @cpf

			END
		END
	END

	EXEc sp_cadastraCliente_v2 'Luzia Emily da Silva','197.860-42','(86) 3953-8373',1
	EXEc sp_cadastraCliente_v2 'Levi Jorge Ian dos Santos','asd.763.580-13','(83) 99193-5152',1
	EXEc sp_cadastraCliente_v2 'Marlene Sueli Rocha','167.075.828-99','(27) 99909-0357',0

------------------------------------------------------------------------
/*
6 - Postem uma evid�ncia dos testes realizados na execu��o da procedure 
realizada no item 5 
Print da tela contendo execu��o da procedure, com testes para clientes 
com CPF v�lidos e inv�lidos, al�m do  select da tabela cliente 
( com �nfase em demonstrar os dados rec�m inseridos ).
*/
------------------------------------------------------------------------









