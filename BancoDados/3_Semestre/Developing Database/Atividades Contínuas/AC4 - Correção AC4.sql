USE ImpactaEstacionamento;
GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- AC4 
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

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
----------------------------------------------------------------------------------------------------------------------------
Passo 0. Esclarecimento:
	- Esta quest�o n�o � para se inspirar na resposta da 
	quest�o da 10 ( da aula 12 ), ela � EXATAMENTE a quest�o 10, 
	ou seja, quem a fez para casa na semana anterior, 
	poderia simples copiar e colar o resultado.

	- Portanto, eu n�o corrigi [ainda] a quest�o 10 da aula 12 
	pois ela � a quest�o 1 da AC4.
----------------------------------------------------------------------------------------------------------------------------
Passo 1. Planejamento: 

	par�metros de entrada: 
		<- uma localidade('Faculdade Impacta - Paulista')
		<- um cliente('Almir dos Santos') --Podem cadastrar outros clientes para testes
		<- uma categoria ( 'Mensalista Professor' )
		<- um dia �til ( ex: 5� )
		<- uma dura��o do contrato em meses ( de 1 a 12 )
	Par�metros de sa�da 
		-> NENHUM ( sem par�metros do tipo OUTPUT )
	Valores Retornados ( SELECTs internos na procedure )
		-> lista com as datas e valores devidos a cada m�s.
		Ex:		15/06/2021		R$100,00 --10� dia �til ( hipot�tico )
				14/07/2021		R$100,00 --10� dia �til ( hipot�tico )
	Tipo de fun��o / procedimento
		Pelo Enunciado, deve ser uma procedure e n�o uma fun��o.
	Pesquisa - o que ser� �til para resolver esta quest�o ?
		Rever: INSERT INTO TABELA ( ..., ... ) VALUES (..., ... )
			Aula 01 - Revisao SQL e entendimento de um banco de dados - Revis�o Linguagem SQL - GUIA DE ESTUDO.sql
			WHILE...Aula 06 - Controle de fluxo.sql
		Rever: Quest�es 1 a 8 ( em especial a 7 )
			Aula 12 - Fun��es e procedimentos - parte 3.sql
			Aula 12 - Fun��es e procedimentos - parte 3 - CORRE��O.sql
----------------------------------------------------------------------------------------------------------------------------
Passo 2. Entendimento dos dados
Como registrar contratos e mensalidades (vencimentos) ?
--Identifica��o das categorias cadastradas
SELECT * FROM   categoriaplano;
--Verifica��o dos planos existentes
SELECT *
FROM   plano
WHERE  idcategoria IN
       (
              SELECT id
              FROM   categoriaplano
              WHERE  nome = 'Mensalista Professor' );

-- Verifica��o dos campos necess�rios para registo do contrato;
sp_help contrato;
id               int      --PRIMARY KEY (clustered)
idplano          int      --REFERENCES ImpactaEstacionamento.dbo.Plano (id)
idcliente        int      --REFERENCES ImpactaEstacionamento.dbo.cliente (id)
diavencimento    tinyint  --CHECK ([diaVencimento]=(25) OR [diaVencimento]=(20) OR
[diaVencimento]=(15) OR [diaVencimento]=(10) OR [diaVencimento]=(5))
datacontratacao  datetime --DEFAULT (getdate())
dateencerramento datetime 

-- Verifica��o dos campos necess�rios para registo das mensalidades;
sp_help mensalidade;
id				int idcontrato int --REFERENCES ImpactaEstacionamento.dbo.contrato (id)
mes				tinyint            --CHECK ([mes]>=(1) AND [mes]<=(12))
recebido		bit                --DEFAULT ((0))
datavencimento	datetime 
datapagamento	datetime 
valorrecebido	decimal 
multa 			decimal
----------------------------------------------------------------------------------------------------------------------------
Passo 3:Testes / Carga Manual - CONTRATO

Para completar a implementa��o de contratos, habilitando assim a fun��o
de planos para mensalistas, s�o necess�rios:
- Dado uma localidade('Faculdade Impacta - Paulista')
	, um cliente('Almir dos Santos') 
	e uma categoria ( 'Mensalista Professor' )

DECLARE @idLocalidade INT = 
( SELECT id FROM localidade WHERE identificacao ='Faculdade Impacta - Paulista' ) 

DECLARE @idCliente INT = 
( SELECT id FROM cliente WHERE nome = 'Almir dos Santos' ) 

DECLARE @idCategoriaPlano INT = 
( SELECT id FROM categoriaplano WHERE nome = 'Mensalista Professor' )

--Descobrir plano atualmente vigente para aquela categoria.
DECLARE @idPlano INT = 
( SELECT id FROM plano WHERE idcategoria = @idCategoriaPlano AND ativo = 1 )

-- Cadastrar um contrato com vencimento padr�o = anual ( 12 meses )
--  para o plano vigente atual daquela categoria.
DECLARE @diaVencimento TINYINT = 10, @DataContratacao datetime = getdate(),
@DataVencimento datetime = dateadd(month,12, getdate() )

INSERT INTO contrato (idplano, idcliente, diavencimento, datacontratacao, dateencerramento ) 
VALUES ( @idPlano, @idCliente, @diaVencimento, @DataContratacao, @DataVencimento ) 

--SELECT @idContrato = SCOPE_IDENTITY

SELECT * FROM contrato 
----------------------------------------------------------------------------------------------------------------------------
Passo 3: Testes / Carga Manual - MENSALIDADES
--Para calcular os vencimentos, podemos usar a procedure da quest�o 7
	--DROP TABLE IF EXISTS #DatasVencimento
	DECLARE @DiaUtilVencimento SMALLINT= 10
			, @numeroParcelas SMALLINT = 12
	CREATE TABLE #DatasVencimento ( dia DATE )

	INSERT INTO #DatasVencimento
	EXEC sp_calculaDatasVencimento @DiaUtilVencimento, @numeroParcelas

	SELECT * from #DatasVencimento

Ou seja, dado um ID de contrato, e uma lista de vencimentos, inserir uma linha
na tabela mensalidade para cada vencimento.
	DECLARE @idContrato INT = 1		

	INSERT INTO mensalidade (idContrato, mes, recebido, dataVencimento, dataPagamento, valorRecebido, multa )
	SELECT	@idContrato as idContrato		-- Id do contrato rec�m criado
			, datepart(month,dia) as mes	-- m�s da mensalidade
			, 0 as recebido					-- bit de recebimento, valor inicial = 0
			, dia as dataVencimento			-- o dia do vencimento foi calculado
											-- pela procedure sp_calculaDatasVencimento
			, NULL as dataPagamento			-- data ser� NULL at� o pagamento pelo cliente
			, 0 as valorRecebido			-- valor recebido ser� zero at� o pagamento			
			, 0 as multa					-- multa ser� zero at� o pagamento
	FROM	#DatasVencimento
	
	SELECT * FROM mensalidade
	--Testes de relat�rio
	SELECT	dataVencimento, valor
	FROM	mensalidade
			INNER JOIN contrato On mensalidade.idContrato = contrato.id
			INNER JOIN plano On contrato.idPlano = plano.id
	WHERE	contrato.id = 1--@idContrato
		
----------------------------------------------------------------------------------------------------------------------------
Passo 4. L�gica de implementa��o
	Declarar cabe�alho da procedure
		Receber cada par�metro de entrada em uma vari�vel
		Localidade, Cliente, Categoria, Dia �til, Dura��o do contrato
	Validar e/ou transformar os par�metros de entrada 
	Coletar os IDs necess�rios para inser��o na tabela contrato
	Realizar a inser��o na tabela contrato
	Coletar o ID do contrato recem inserido
	Calcular as datas de vencimento
		Salvar em tabela tempor�ria.
	Para cada vencimento, inserir uma linha na tabela mensalidade.
	Devolver o select solicitado
		Ex:		15/06/2021		R$100,00 --10� dia �til ( hipot�tico )
				14/07/2021		R$100,00 --10� dia �til ( hipot�tico )


----------------------------------------------------------------------------------------------------------------------------
Passo 5. C�digo / implementa��o
CREATE OR ALTER PROCEDURE Pr_CadastraContrato 
	@localidade VARCHAR(50)
	, @cliente VARCHAR(50)
	, @categoria VARCHAR(50)
	, @DiaUtilVencimento TINYINT
	, @numeroParcelas TINYINT
AS BEGIN

	DECLARE @idLocalidade INT = 
	( SELECT id FROM localidade WHERE identificacao = @localidade ) 

	DECLARE @idCliente INT = 
	( SELECT id FROM cliente WHERE nome = @cliente ) 

	DECLARE @idCategoriaPlano INT = 
	( SELECT id FROM categoriaplano WHERE nome = @categoria )

	--Descobrir plano atualmente vigente para aquela categoria.
	DECLARE @idPlano INT = 
	( SELECT id FROM plano WHERE idcategoria = @idCategoriaPlano AND ativo = 1 )

	-- Cadastrar um contrato com vencimento padr�o = anual ( 12 meses )
	--  para o plano vigente atual daquela categoria.
	DECLARE @DataContratacao datetime = getdate(),
			@DataVencimento datetime = dateadd(month,@numeroParcelas, getdate() )

	DECLARE @idContrato INT

	INSERT INTO contrato (idplano, idcliente, diavencimento, datacontratacao, dateencerramento ) 
	VALUES ( @idPlano, @idCliente, @DiaUtilVencimento, @DataContratacao, @DataVencimento ) 

	SET @idContrato = @@IDENTITY

	CREATE TABLE #DatasVencimento ( dia DATE )

	INSERT INTO #DatasVencimento
	EXEC sp_calculaDatasVencimento @DiaUtilVencimento, @numeroParcelas

	INSERT INTO mensalidade (idContrato, mes, recebido, dataVencimento, dataPagamento, valorRecebido, multa )
	SELECT	@idContrato as idContrato		-- Id do contrato rec�m criado
			, datepart(month,dia) as mes	-- m�s da mensalidade
			, 0 as recebido					-- bit de recebimento, valor inicial = 0
			, dia as dataVencimento			-- o dia do vencimento foi calculado
											-- pela procedure sp_calculaDatasVencimento
			, NULL as dataPagamento			-- data ser� NULL at� o pagamento pelo cliente
			, 0 as valorRecebido			-- valor recebido ser� zero at� o pagamento			
			, 0 as multa					-- multa ser� zero at� o pagamento
	FROM	#DatasVencimento

	SELECT	mensalidade.dataVencimento, plano.valor
	FROM	mensalidade
			INNER JOIN contrato on mensalidade.idContrato = contrato.id
			INNER JOIN plano on contrato.idPlano = plano.id
	WHERE 	contrato.id = @idContrato					
END
GO

Passo 6. Testes


Criem uma procedure que receba como par�metros:
 uma localidade()
 um cliente() --Podem cadastrar outros clientes para testes
 uma categoria (  )
 um dia �til ( ex: 5� )
 uma dura��o do contrato em meses ( de 1 a 12 )
Cadastre um contrato com vencimento para o plano vigente atual daquela categoria.
Com dura��o em meses equivalente ao par�metro de dura��o do contrato.
Cadastre os vencimentos das mensalidades no dia �til escolhido.
� e devolva uma lista com as datas e valores devidos a cada m�s.
Ex:		15/06/2021		R$100,00 --10� dia �til ( hipot�tico )
		14/07/2021		R$100,00 --10� dia �til ( hipot�tico )
		...

EXEC Pr_CadastraContrato 
	@localidade = 'Faculdade Impacta - Paulista'
	, @cliente = 'Almir dos Santos'
	, @categoria = 'Mensalista Professor'
	, @diaUtilVencimento =10
	, @numeroParcelas = 6

select * from contrato --where localize o ID do contrato recem inserido
select * from mensalidade -- where filtre pelo ID do contrato recem inserido.

----------------------------------------------------------------------------------------------------------------------------

2 - Postem uma evid�ncia dos testes realizados na execu��o da procedure 
realizada no item 1 
Print da tela contendo execu��o da procedure e select das tabelas 
contrato e mensalidade ( com �nfase nos dados rec�m inseridos).

------------------------------------------------------------------------

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
----------------------------------------------------------------------------------------------------------------------------
Passo 0. Esclarecimento:
	- Esta quest�o foi fornecida de forma muito similar na aula 03
	ver arquivo: Aula 03 - Tratamento de nulos e condicionais.sql
		/*declare uma vari�vel para receber o ID do ve�culo*/
		declare @idVeiculo int
				, @placa char(15) = 'GHY9543'
				, @tipo char(5) = 'moto'
		IF EXISTS (select id from veiculo where placa = @placa)
		BEGIN
			/* SE o ve�culo j� est� cadastrado, ou seja, n�o � a primeira vez que ele estaciona.
			Basca buscar o id do ve�culo pela placa.*/
			select @idVeiculo = id from veiculo where placa = @placa
		END
		ELSE BEGIN
			/* SEN�O, caso seja a primeira vez que ele estaciona, � necess�rio estacionar o ve�culo
			Como � um cliente horista, n�o preciso cadastrar um cliente ( apenas para mensalistas )*/
			Insert veiculo( tipo, placa, idCliente)
			VALUES ( @tipo, @placa, NULL )
			select @idVeiculo = SCOPE_IDENTITY()
		END
		/*conclus�o:
		a vari�vel @idVeiculo tem que conter o ID do ve�culo de placa'GHY6543'
		estando ele j� previamente inserido no banco ou n�o.
		*/
		SELECT 'O ticket do ve�culo estacionado � : ' + convert(varchar,@idVeiculo)

	- Portanto, bastaria alterar a l�gica para clientes e n�o ve�culos.
----------------------------------------------------------------------------------------------------------------------------
Passo 1. Planejamento: 
	par�metros de entrada: 
 		<- um nome do cliente ( 'Amauri Silva e Silva' )
		<- um CPF ( '123.456.789-09' )
 		<- um telefone ( '912345678')
		<- um bit para 0 = n�o � professor ou 1 = � professor
	Par�metros de sa�da 
		-> ID daquele Cliente ( tipo OUTPUT )
	Valores Retornados ( SELECTs internos na procedure )
		(NENHUM)
	Tipo de fun��o / procedimento
		Pelo Enunciado, deve ser uma procedure e n�o uma fun��o.
	Pesquisa - o que ser� �til para resolver esta quest�o ?
		Rever: INSERT - Aula 01 - Revisao SQL e entendimento de um banco de dados - Revis�o Linguagem SQL - GUIA DE ESTUDO.sql
		Rever: IF - Aula 03 - Tratamento de nulos e condicionais.sql
		Rever: WHILE - Aula 06 - Controle de fluxo.sql
----------------------------------------------------------------------------------------------------------------------------
Passo 2. Entendimento dos dados
Como registrar Clientes ?
	--Identifica��o dos clientes
	SELECT * FROM   Cliente;

	SP_HELP Cliente
	id			int --PRIMARY KEY
	nome		varchar
	cpf			char --UNIQUE, CHECK ([cpf] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
	telefone	varchar
	professor	bit --DEFAULT ((0))
	--FK com tabela Contrato 
	--FK com tabela Veiculo 

Como � a m�scara de CPF v�lido pela tabela ?

CHECK ([cpf] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
Ou seja, ele s� aceita d�gitos, 11 deles para ser exato.

----------------------------------------------------------------------------------------------------------------------------
Passo 3:Testes / Carga Manual - CLIENTE
	--Testes de recupera��o com base no CPF
	DECLARE @CPF CHAR(11) = '12345678909'
	IF EXISTS ( select top 1 1 FROM CLIENTE WHERE CPF = @CPF )
		print 'cliente j� cadastrado'
	else
		print 'cliente n�o cadastrado'
	GO
	--Testes de inser��o
	DECLARE @nome VARCHAR(50) = 'Amauri Silva e Silva'
		, @CPF CHAR(14) = '12345678909'
 		, @telefone VARCHAR(15) = '912345678'
		, @professor BIT = 0
		, @id INT --para recuperar o ID inserido

	INSERT INTO CLIENTE ( nome, CPF, telefone, professor )
	VALUES ( @nome, @CPF, @telefone, @professor )
	SELECT @id = SCOPE_IDENTITY() --OU @@IDENTITY
	SELECT * FROM Cliente WHERE ID = @id

----------------------------------------------------------------------------------------------------------------------------
Passo 4. L�gica de implementa��o
	Declarar cabe�alho da procedure
		Receber cada par�metro de entrada em uma vari�vel
		nome, CPF, telefone, professor
	Declarar par�metros de sa�da
	Validar e/ou transformar os par�metros de entrada
		Ex: cpf '123.456.789-09' -> '12345678909'
	Verificar se o cliente j� est� inserido testando seu CPF
	Se ele n�o estiver, inseri-lo
	Coletar o ID do cliente e armazen�-lo na vari�vel de sa�da
----------------------------------------------------------------------------------------------------------------------------
Passo 5. C�digo / implementa��o
CREATE OR ALTER PROCEDURE pr_insereCliente 
	@nome VARCHAR(50)
	, @CPF VARCHAR(14)
	, @telefone VARCHAR(50)
	, @professor BIT
	, @idCliente INT OUTPUT
AS BEGIN

	SELECT @idCliente = id FROM Cliente WHERE CPF = @CPF
	IF ( @idCliente IS NULL )
	BEGIN
		INSERT INTO CLIENTE ( nome, CPF, telefone, professor )
		VALUES ( @nome, @CPF, @telefone, @professor )

		SELECT @idCliente = SCOPE_IDENTITY() --OU @@IDENTITY
	END
	RETURN
END
GO

Passo 6. Testes

DECLARE @id INT

EXEC pr_insereCliente 
	@nome = 'Amauri Silva e Silva'
	, @CPF = '12345678910'
	, @telefone  = '912345678'
	, @professor  = 0
	, @idCliente = @id OUTPUT

SELECT 'ID: ' + convert(varchar,@id)
SELECT * FROM cliente where id = @id
select * from cliente

----------------------------------------------------------------------------------------------------------------------------

4 - Postem uma evid�ncia dos testes realizados na execu��o da procedure 
realizada no item 3 
Print da tela contendo execu��o da procedure, com testes para clientes 
com CPF novos e velhos, al�m do select da tabela cliente 
( com �nfase em demonstrar os dados rec�m inseridos ).

------------------------------------------------------------------------

5 - Postem o c�digo solicitado para o seguinte enunciado:

Alterem a procedure criada no item 4 para incluir uma valida��o no CPF 
recebido como par�metro.
De forma que, a procedure seja encerrada devolvendo -1 ( return -1 ) 
	caso o CPF n�o seja v�lido,
e continue com o prop�sito normal caso o CPF seja v�lido, devolvendo 1 ( return 1 )
	, ao final da execu��o se tudo foi ocorreu corretamente.
(utilize os c�digos da AC3 como refer�ncia para valida��o de CPFs )

----------------------------------------------------------------------------------------------------------------------------
Passo 0. Esclarecimento:
	- Os testes de valida��o de CPF foram passados na AC3
		ver: Aula 10 - AC3 - revis�o aulas 08 a 09 - CORRECAO.sql
	Ser� necess�rio criar:
		dbo.fn_limpaCPF
				CREATE OR ALTER FUNCTION dbo.fn_limpaCPF ( @CPF CHAR(14) )
				RETURNS CHAR(11)
				AS BEGIN
					SELECT @CPF = REPLACE(@CPF,'.','')
					SELECT @CPF = REPLACE(@CPF,'-','')
					RETURN @CPF
				END
				GO
		dbo.fn_calculaPrimeiroDigito
				CREATE OR ALTER FUNCTION fn_calculaPrimeiroDigito ( @CPF CHAR(11) )
				RETURNS INT AS
				BEGIN
					DECLARE @retorno INT
					SELECT @retorno = 
						  CONVERT(INT,SUBSTRING(@CPF,1,1)) * 10 
						+ CONVERT(INT,SUBSTRING(@CPF,2,1)) * 9 
						+ CONVERT(INT,SUBSTRING(@CPF,3,1)) * 8 
						+ CONVERT(INT,SUBSTRING(@CPF,4,1)) * 7 
						+ CONVERT(INT,SUBSTRING(@CPF,5,1)) * 6 
						+ CONVERT(INT,SUBSTRING(@CPF,6,1)) * 5 
						+ CONVERT(INT,SUBSTRING(@CPF,7,1)) * 4 
						+ CONVERT(INT,SUBSTRING(@CPF,8,1)) * 3 
						+ CONVERT(INT,SUBSTRING(@CPF,9,1)) * 2
					return (@retorno * 10) % 11 % 10
				END
				GO
		dbo.fn_calculaSegundoDigito
				CREATE OR ALTER FUNCTION fn_calculaSegundoDigito ( @CPF CHAR(11) )
				RETURNS INT AS
				BEGIN
					DECLARE @retorno INT =0, @i tinyint=1
					WHILE (@i <= 10)
					BEGIN
						SET @retorno += CONVERT(INT,SUBSTRING(@CPF,@i,1)) * (12-@i)
						SET @i+=1
					END
					return (@retorno * 10) % 11 % 10
				END
				GO
		pr_validaCPF
				CREATE OR ALTER PROCEDURE pr_validaCPF ( @CPF VARCHAR(255), @retorno VARCHAR(255) OUTPUT )
				AS BEGIN
					--Fun��o de limpeza feita na quest�o 06
					SELECT @CPF = dbo.fn_limpaCPF(@CPF)

					--Tratamento de erro pr�-montado na quest�o 07
					IF ( len(@CPF) <> 11 ) THROW 50000, 'Formato inv�lido',1
					IF ( ISNUMERIC(@CPF) <> 1 ) THROW 50001,'D�gitos inv�lidos',1

					--Tomada de decis�o feita na quest�o pr�-calculada na quest�o 11
					IF ( 
						--Fun��o do primeiro d�gito feito na quest�o 09--> 1 BUG a ser corrigido
						SUBSTRING(@CPF,10,1) = dbo.fn_calculaPrimeiroDigito(@CPF)		
						AND 
						--Fun��o do segundo d�gito feito na quest�o 10 --> 2 BUGs a serem corrigidos
						SUBSTRING(@CPF,11,1) = dbo.fn_calculaSegundoDigito(@CPF)
					)
						SELECT @retorno = 'V�LIDO'
					ELSE 
						SELECT @retorno = 'INVALIDO'
				END
				GO
	OU utilizem sua resposta da quest�o 14 da AC3 ( desde que correta e/ou validada )

	- A utiliza��o do RETURN dentro de procedimentos 
		ver: Aula 13 - AC4 - Fun��es e procedimentos - parte 4.sql

----------------------------------------------------------------------------------------------------------------------------
Passo 1. Planejamento: 
	par�metros de entrada: ( os mesmo da quest�o 3 ) 
 		<- um nome do cliente ( 'Amauri Silva e Silva' )
		<- um CPF ( '123.456.789-09' )
 		<- um telefone ( '912345678')
		<- um bit para 0 = n�o � professor ou 1 = � professor
	Par�metros de sa�da 
		-> ID daquele Cliente ( tipo OUTPUT )
	Valores Retornados ( via RETURN no procedimento )
		-1	-> se erro no CPF
		1	-> se tudo OK na inser��o do cliente
	Tipo de fun��o / procedimento
		Pelo Enunciado, deve ser uma procedure e n�o uma fun��o.
	Pesquisa - o que ser� �til para resolver esta quest�o ?
		Rever: INSERT - Aula 01 - Revisao SQL e entendimento de um banco de dados - Revis�o Linguagem SQL - GUIA DE ESTUDO.sql
		Rever: IF - Aula 03 - Tratamento de nulos e condicionais.sql
		Rever: WHILE - Aula 06 - Controle de fluxo.sql
		Rever: AC3 - Aula 10 - AC3 - revis�o aulas 08 a 09 - CORRECAO.sql
		Rever: Return em procedures - Aula 13 - AC4 - Fun��es e procedimentos - parte 4.sql

		----------------------------------------------------------------------------------------------------------------------------
Passo 2. Entendimento dos dados
Como registrar Clientes ?
	--Identifica��o dos clientes
	SELECT * FROM   Cliente;

	SP_HELP Cliente
	id			int --PRIMARY KEY
	nome		varchar
	cpf			char --UNIQUE, CHECK ([cpf] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
	telefone	varchar
	professor	bit --DEFAULT ((0))
	--FK com tabela Contrato 
	--FK com tabela Veiculo 

Como � a m�scara de CPF v�lido pela tabela ?

CHECK ([cpf] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
Ou seja, ele s� aceita d�gitos, 11 deles para ser exato.

----------------------------------------------------------------------------------------------------------------------------
Passo 3:Testes / valida��o CPF
	--Limpando CPFs
	DECLARE @CPF CHAR(14) = '529.982.247-25'
	SELECT dbo.fn_limpaCPF(@CPF)

	--Testes de c�lculo do primeiro d�gito
	DECLARE @CPF CHAR(14) = dbo.fn_limpaCPF('529.982.247-25')
	select dbo.fn_calculaPrimeiroDigito(@CPF)

	--Testes de c�lculo do primeiro d�gito
	DECLARE @CPF CHAR(14) = dbo.fn_limpaCPF('529.982.247-25')
	select dbo.fn_calculaSegundoDigito(@CPF)

	--Testes de valida��o de CPF
	DECLARE @CPF VARCHAR(255) = '529.982.247-25', @retorno VARCHAR(255)
	EXEC pr_validaCPF @CPF, @retorno OUTPUT
	SELECT 'O CPF : '+ @CPF + ' � ' + @retorno
	
----------------------------------------------------------------------------------------------------------------------------
Passo 4. L�gica de implementa��o
	Declarar cabe�alho da procedure
		Receber cada par�metro de entrada em uma vari�vel
		nome, CPF, telefone, professor
	Declarar par�metros de sa�da
	Validar e/ou transformar os par�metros de entrada
		Ex: cpf '123.456.789-09' -> '12345678909'
		validar CPF
			Se Inv�lido, sair da procedure retornando -1
	Verificar se o cliente j� est� inserido testando seu CPF
	Se ele n�o estiver, inseri-lo
	Coletar o ID do cliente e armazen�-lo na vari�vel de sa�da
	Se tudo ocorreu como planejado, sair da procedure retornando 1
----------------------------------------------------------------------------------------------------------------------------
Passo 5. C�digo / implementa��o

CREATE OR ALTER PROCEDURE pr_insereCliente_v2 --S� para mudar o nome 
	@nome VARCHAR(50)
	, @CPF VARCHAR(14)
	, @telefone VARCHAR(50)
	, @professor BIT
	, @idCliente INT OUTPUT
AS BEGIN

	DECLARE @retorno VARCHAR(255)
	EXEC pr_validaCPF @CPF, @retorno OUTPUT
	IF @retorno = 'INVALIDO'
		RETURN -1

	SELECT @idCliente = id FROM Cliente WHERE CPF = @CPF
	IF ( @idCliente IS NULL )
	BEGIN
		INSERT INTO CLIENTE ( nome, CPF, telefone, professor )
		VALUES ( @nome, @CPF, @telefone, @professor )

		SELECT @idCliente = SCOPE_IDENTITY() --OU @@IDENTITY
	END
	RETURN 1
END
GO

Passo 6. Testes

DECLARE @id INT
		, @retorno INT

EXEC @retorno = pr_insereCliente_v2 
	@nome = 'Amauri Silva e Silva'
	, @CPF = '12345678909'
	, @telefone  = '912345678'
	, @professor  = 0
	, @idCliente = @id OUTPUT

IF @retorno = 1 	print 'OK'
IF @retorno = -1 	print 'ERRO'

SELECT 'ID: ' + convert(varchar,@id)
SELECT * FROM cliente where id = @id
select * from cliente

----------------------------------------------------------------------------------------------------------------------------

6 - Postem uma evid�ncia dos testes realizados na execu��o da procedure 
realizada no item 5 
Print da tela contendo execu��o da procedure, com testes para clientes 
com CPF v�lidos e inv�lidos, al�m do  select da tabela cliente 
( com �nfase em demonstrar os dados rec�m inseridos ).

------------------------------------------------------------------------
