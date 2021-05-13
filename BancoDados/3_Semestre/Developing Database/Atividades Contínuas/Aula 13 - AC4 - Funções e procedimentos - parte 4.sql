USE ImpactaEstacionamento;
GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 13 - AC4 - Funções e procedimentos - parte 4
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
/*
Aula 08 - Transações, Erros: Geração, Captura e Tratamento de erros; Debug.
	Logs e rastreamento de erros.
	Debug de processos.
Aula 09 - Funções e procedimentos - parte 1
	Utilização de procedures para controle de processos.
	Utilização de funções para automatização de processos de validação.
	Criação de funções para manipulação de processos.
	Criação de procedimentos para manipulação de processos.
Aula 10 - AC3 - Revisão aulas 08 e 09
Aula 11 - Funções e procedimentos - parte 2
	Stored Procedures, métodos acessores, parâmetros de saída.
	Funções ( escalar, in-line, multi-statement )
Aula 12 - Exercícios - Funções e procedimentos - Parte 3
Aula 13 - AC4 - Funções e procedimentos - parte 4
	Parâmetros com valores Default	
	Tratando de parâmetros NULOS
	Parâmetros nomeados
	Utilizaçao do método RETURN em Procedimentos
*/
/*
-------------------------------------------------------------------------- 
-- Conteúdo novo: Parâmetros com valores Default
--------------------------------------------------------------------------- 
Tanto funções quanto procedimentos podem ter seus parâmetros de entrada
definidos com valores padrão ( ou default ), ou seja, quando executados
usando a palavra reservada default, ou em procedures sem passar valores, 
o conteúdo será substituído pelo valor padrão.
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
-- Conteúdo novo: Tratando de parâmetros NULOS
--------------------------------------------------------------------------- 
É comum e até recomendado tratar parâmetros NULOS, substituindo-os
por valores padrão ( DEFAULT ) ou retornando ERRO por mal uso.
Muitas vezes forçamos o valor DEFAULT da função ou procedimento para NULL
e incluímos condicionais para tratá-los.
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
-- Conteúdo novo: Parâmetros nomeados
--------------------------------------------------------------------------- 
Ao chamar uma procedure é possível nomear os parâmetros de entrada
isso nos permite não só escolher quais serão passados ( e quais não )
assim como fornecê-los fora da ordem da declaração.
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
--Sem nomear os parâmetros (usando-os na ordem de declaração na procedure)
-- Usando os valores padrão
	EXEC sp_horaAtual 
	EXEC sp_horaAtual NULL, NULL, NULL
	EXEC sp_horaAtual DEFAULT, DEFAULT, DEFAULT
	EXEC sp_horaAtual '20', '10', '05'
--Nomeando os parâmetros 
	EXEC sp_horaAtual @paramHora = '20', @paramMinuto = '10', @paramSegundo = '05'
	EXEC sp_horaAtual @paramSegundo = '05', @paramMinuto = '10', @paramHora = '20'
--Usando só alguns parâmetros ( hora e minuto são passados como NULL / DEFAULT)
	EXEC sp_horaAtual @paramSegundo = '05'
	/*
-------------------------------------------------------------------------- 
-- Conteúdo novo: Utilizaçao do método RETURN em Procedimentos
--------------------------------------------------------------------------- 
Tanto em funções quanto em procedimentos a função RETURN encerra a 
execução do método e devolve o controle de fluxo para quem a executou.
No caso de funções, como já estudado antes, ele devolve, na versão escalar 
um valor único, e nas funções tabulares uma lista ou tabela.
Nos procedimentos, ele devolve um valor único ( similar ao escalar ),
porém, pela limitação de só devolver inteiros ( INT ), ele é 
comumente utilizado para devolver o status da execução:
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
1 - Postem o código solicitado como atividade para casa na aula 12 na questão 10.
Criem uma procedure que receba como parâmetros:
 uma localidade('Faculdade Impacta - Paulista')
 um cliente('Almir dos Santos') --Podem cadastrar outros clientes para testes
 uma categoria ( 'Mensalista Professor' )
 um dia útil ( ex: 5º )
 uma duração do contrato em meses ( de 1 a 12 )
Cadastre um contrato com vencimento para o plano vigente atual daquela categoria.
Com duração em meses equivalente ao parâmetro de duração do contrato.
Cadastre os vencimentos das mensalidades no dia útil escolhido.
… e devolva uma lista com as datas e valores devidos a cada mês.
Ex:		15/06/2021		R$100,00 --10º dia útil ( hipotético )
		14/07/2021		R$100,00 --10º dia útil ( hipotético )
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
	   @msgtext = N'Erro: Duração do contrato não pode ser superior à 12 meses'   
	   ,@lang = 'Português (Brasil)'
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
2- Postem uma evidência dos testes realizados na execução da procedure 
realizada no item 1 
Print da tela contendo execução da procedure e select das tabelas 
contrato e mensalidade ( com ênfase nos dados recém inseridos).
*/

----------------------------------------------------------------------
/*
3 - Postem o código solicitado para o seguinte enunciado:
Criem uma procedure que receba como parâmetros de entrada:
 	o nome do cliente ( ‘Amauri Silva e Silva’ )
	um CPF ( ‘123.456.789.-09’ )
 	um telefone ( ‘912345678’)
	um bit para 0 = não é professor ou 1 = é professor
e devolva como parâmetros de saída o ID daquele Cliente
	, caso o CPF já esteja cadastrado
ou primeiro cadastre o cliente para depois devolver seu ID
	, caso aquele cpf não esteja cadastrado.
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
			select 'CPF já esteja cadastrado, id: ' + cast(id as char) from cliente3 WHERE cpf = @cpf
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
4 - Postem uma evidência dos testes realizados na execução da procedure 
realizada no item 3 
Print da tela contendo execução da procedure, com testes para clientes 
com CPF novos e velhos, além do select da tabela cliente 
( com ênfase em demonstrar os dados recém inseridos ).
*/


------------------------------------------------------------------------
/*
5 - Postem o código solicitado para o seguinte enunciado:

Alterem a procedure criada no item 4 para incluir uma validação no CPF 
recebido como parâmetro.
De forma que, a procedure seja encerrada devolvendo -1 ( return -1 ) 
	caso o CPF não seja válido,
e continue com o propósito normal caso o CPF seja válido, devolvendo 1 ( return 1 )
	, ao final da execução se tudo foi ocorreu corretamente.
(utilize os códigos da AC3 como referência para validação de CPFs )
*/

DECLARE @CPF VARCHAR(255) = '167.075.828-99', @retorno VARCHAR(255)
EXEC pr_validaCPF @CPF, @retorno OUTPUT
SELECT 'O CPF : '+ @CPF + ' é ' + @retorno

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
				select 'CPF já esteja cadastrado, id: ' + cast(id as char) as mensagem from cliente3 WHERE cpf = @cpf
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
6 - Postem uma evidência dos testes realizados na execução da procedure 
realizada no item 5 
Print da tela contendo execução da procedure, com testes para clientes 
com CPF válidos e inválidos, além do  select da tabela cliente 
( com ênfase em demonstrar os dados recém inseridos ).
*/
------------------------------------------------------------------------









