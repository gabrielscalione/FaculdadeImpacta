USE ImpactaEstacionamento;
GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- AC4 
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

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
----------------------------------------------------------------------------------------------------------------------------
Passo 0. Esclarecimento:
	- Esta questão não é para se inspirar na resposta da 
	questão da 10 ( da aula 12 ), ela é EXATAMENTE a questão 10, 
	ou seja, quem a fez para casa na semana anterior, 
	poderia simples copiar e colar o resultado.

	- Portanto, eu não corrigi [ainda] a questão 10 da aula 12 
	pois ela é a questão 1 da AC4.
----------------------------------------------------------------------------------------------------------------------------
Passo 1. Planejamento: 

	parâmetros de entrada: 
		<- uma localidade('Faculdade Impacta - Paulista')
		<- um cliente('Almir dos Santos') --Podem cadastrar outros clientes para testes
		<- uma categoria ( 'Mensalista Professor' )
		<- um dia útil ( ex: 5º )
		<- uma duração do contrato em meses ( de 1 a 12 )
	Parâmetros de saída 
		-> NENHUM ( sem parâmetros do tipo OUTPUT )
	Valores Retornados ( SELECTs internos na procedure )
		-> lista com as datas e valores devidos a cada mês.
		Ex:		15/06/2021		R$100,00 --10º dia útil ( hipotético )
				14/07/2021		R$100,00 --10º dia útil ( hipotético )
	Tipo de função / procedimento
		Pelo Enunciado, deve ser uma procedure e não uma função.
	Pesquisa - o que será útil para resolver esta questão ?
		Rever: INSERT INTO TABELA ( ..., ... ) VALUES (..., ... )
			Aula 01 - Revisao SQL e entendimento de um banco de dados - Revisão Linguagem SQL - GUIA DE ESTUDO.sql
			WHILE...Aula 06 - Controle de fluxo.sql
		Rever: Questões 1 a 8 ( em especial a 7 )
			Aula 12 - Funções e procedimentos - parte 3.sql
			Aula 12 - Funções e procedimentos - parte 3 - CORREÇÃO.sql
----------------------------------------------------------------------------------------------------------------------------
Passo 2. Entendimento dos dados
Como registrar contratos e mensalidades (vencimentos) ?
--Identificação das categorias cadastradas
SELECT * FROM   categoriaplano;
--Verificação dos planos existentes
SELECT *
FROM   plano
WHERE  idcategoria IN
       (
              SELECT id
              FROM   categoriaplano
              WHERE  nome = 'Mensalista Professor' );

-- Verificação dos campos necessários para registo do contrato;
sp_help contrato;
id               int      --PRIMARY KEY (clustered)
idplano          int      --REFERENCES ImpactaEstacionamento.dbo.Plano (id)
idcliente        int      --REFERENCES ImpactaEstacionamento.dbo.cliente (id)
diavencimento    tinyint  --CHECK ([diaVencimento]=(25) OR [diaVencimento]=(20) OR
[diaVencimento]=(15) OR [diaVencimento]=(10) OR [diaVencimento]=(5))
datacontratacao  datetime --DEFAULT (getdate())
dateencerramento datetime 

-- Verificação dos campos necessários para registo das mensalidades;
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

Para completar a implementação de contratos, habilitando assim a função
de planos para mensalistas, são necessários:
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

-- Cadastrar um contrato com vencimento padrão = anual ( 12 meses )
--  para o plano vigente atual daquela categoria.
DECLARE @diaVencimento TINYINT = 10, @DataContratacao datetime = getdate(),
@DataVencimento datetime = dateadd(month,12, getdate() )

INSERT INTO contrato (idplano, idcliente, diavencimento, datacontratacao, dateencerramento ) 
VALUES ( @idPlano, @idCliente, @diaVencimento, @DataContratacao, @DataVencimento ) 

--SELECT @idContrato = SCOPE_IDENTITY

SELECT * FROM contrato 
----------------------------------------------------------------------------------------------------------------------------
Passo 3: Testes / Carga Manual - MENSALIDADES
--Para calcular os vencimentos, podemos usar a procedure da questão 7
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
	SELECT	@idContrato as idContrato		-- Id do contrato recém criado
			, datepart(month,dia) as mes	-- mês da mensalidade
			, 0 as recebido					-- bit de recebimento, valor inicial = 0
			, dia as dataVencimento			-- o dia do vencimento foi calculado
											-- pela procedure sp_calculaDatasVencimento
			, NULL as dataPagamento			-- data será NULL até o pagamento pelo cliente
			, 0 as valorRecebido			-- valor recebido será zero até o pagamento			
			, 0 as multa					-- multa será zero até o pagamento
	FROM	#DatasVencimento
	
	SELECT * FROM mensalidade
	--Testes de relatório
	SELECT	dataVencimento, valor
	FROM	mensalidade
			INNER JOIN contrato On mensalidade.idContrato = contrato.id
			INNER JOIN plano On contrato.idPlano = plano.id
	WHERE	contrato.id = 1--@idContrato
		
----------------------------------------------------------------------------------------------------------------------------
Passo 4. Lógica de implementação
	Declarar cabeçalho da procedure
		Receber cada parâmetro de entrada em uma variável
		Localidade, Cliente, Categoria, Dia útil, Duração do contrato
	Validar e/ou transformar os parâmetros de entrada 
	Coletar os IDs necessários para inserção na tabela contrato
	Realizar a inserção na tabela contrato
	Coletar o ID do contrato recem inserido
	Calcular as datas de vencimento
		Salvar em tabela temporária.
	Para cada vencimento, inserir uma linha na tabela mensalidade.
	Devolver o select solicitado
		Ex:		15/06/2021		R$100,00 --10º dia útil ( hipotético )
				14/07/2021		R$100,00 --10º dia útil ( hipotético )


----------------------------------------------------------------------------------------------------------------------------
Passo 5. Código / implementação
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

	-- Cadastrar um contrato com vencimento padrão = anual ( 12 meses )
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
	SELECT	@idContrato as idContrato		-- Id do contrato recém criado
			, datepart(month,dia) as mes	-- mês da mensalidade
			, 0 as recebido					-- bit de recebimento, valor inicial = 0
			, dia as dataVencimento			-- o dia do vencimento foi calculado
											-- pela procedure sp_calculaDatasVencimento
			, NULL as dataPagamento			-- data será NULL até o pagamento pelo cliente
			, 0 as valorRecebido			-- valor recebido será zero até o pagamento			
			, 0 as multa					-- multa será zero até o pagamento
	FROM	#DatasVencimento

	SELECT	mensalidade.dataVencimento, plano.valor
	FROM	mensalidade
			INNER JOIN contrato on mensalidade.idContrato = contrato.id
			INNER JOIN plano on contrato.idPlano = plano.id
	WHERE 	contrato.id = @idContrato					
END
GO

Passo 6. Testes


Criem uma procedure que receba como parâmetros:
 uma localidade()
 um cliente() --Podem cadastrar outros clientes para testes
 uma categoria (  )
 um dia útil ( ex: 5º )
 uma duração do contrato em meses ( de 1 a 12 )
Cadastre um contrato com vencimento para o plano vigente atual daquela categoria.
Com duração em meses equivalente ao parâmetro de duração do contrato.
Cadastre os vencimentos das mensalidades no dia útil escolhido.
… e devolva uma lista com as datas e valores devidos a cada mês.
Ex:		15/06/2021		R$100,00 --10º dia útil ( hipotético )
		14/07/2021		R$100,00 --10º dia útil ( hipotético )
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

2 - Postem uma evidência dos testes realizados na execução da procedure 
realizada no item 1 
Print da tela contendo execução da procedure e select das tabelas 
contrato e mensalidade ( com ênfase nos dados recém inseridos).

------------------------------------------------------------------------

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
----------------------------------------------------------------------------------------------------------------------------
Passo 0. Esclarecimento:
	- Esta questão foi fornecida de forma muito similar na aula 03
	ver arquivo: Aula 03 - Tratamento de nulos e condicionais.sql
		/*declare uma variável para receber o ID do veículo*/
		declare @idVeiculo int
				, @placa char(15) = 'GHY9543'
				, @tipo char(5) = 'moto'
		IF EXISTS (select id from veiculo where placa = @placa)
		BEGIN
			/* SE o veículo já está cadastrado, ou seja, não é a primeira vez que ele estaciona.
			Basca buscar o id do veículo pela placa.*/
			select @idVeiculo = id from veiculo where placa = @placa
		END
		ELSE BEGIN
			/* SENÃO, caso seja a primeira vez que ele estaciona, é necessário estacionar o veículo
			Como é um cliente horista, não preciso cadastrar um cliente ( apenas para mensalistas )*/
			Insert veiculo( tipo, placa, idCliente)
			VALUES ( @tipo, @placa, NULL )
			select @idVeiculo = SCOPE_IDENTITY()
		END
		/*conclusão:
		a variável @idVeiculo tem que conter o ID do veículo de placa'GHY6543'
		estando ele já previamente inserido no banco ou não.
		*/
		SELECT 'O ticket do veículo estacionado é : ' + convert(varchar,@idVeiculo)

	- Portanto, bastaria alterar a lógica para clientes e não veículos.
----------------------------------------------------------------------------------------------------------------------------
Passo 1. Planejamento: 
	parâmetros de entrada: 
 		<- um nome do cliente ( 'Amauri Silva e Silva' )
		<- um CPF ( '123.456.789-09' )
 		<- um telefone ( '912345678')
		<- um bit para 0 = não é professor ou 1 = é professor
	Parâmetros de saída 
		-> ID daquele Cliente ( tipo OUTPUT )
	Valores Retornados ( SELECTs internos na procedure )
		(NENHUM)
	Tipo de função / procedimento
		Pelo Enunciado, deve ser uma procedure e não uma função.
	Pesquisa - o que será útil para resolver esta questão ?
		Rever: INSERT - Aula 01 - Revisao SQL e entendimento de um banco de dados - Revisão Linguagem SQL - GUIA DE ESTUDO.sql
		Rever: IF - Aula 03 - Tratamento de nulos e condicionais.sql
		Rever: WHILE - Aula 06 - Controle de fluxo.sql
----------------------------------------------------------------------------------------------------------------------------
Passo 2. Entendimento dos dados
Como registrar Clientes ?
	--Identificação dos clientes
	SELECT * FROM   Cliente;

	SP_HELP Cliente
	id			int --PRIMARY KEY
	nome		varchar
	cpf			char --UNIQUE, CHECK ([cpf] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
	telefone	varchar
	professor	bit --DEFAULT ((0))
	--FK com tabela Contrato 
	--FK com tabela Veiculo 

Como é a máscara de CPF válido pela tabela ?

CHECK ([cpf] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
Ou seja, ele só aceita dígitos, 11 deles para ser exato.

----------------------------------------------------------------------------------------------------------------------------
Passo 3:Testes / Carga Manual - CLIENTE
	--Testes de recuperação com base no CPF
	DECLARE @CPF CHAR(11) = '12345678909'
	IF EXISTS ( select top 1 1 FROM CLIENTE WHERE CPF = @CPF )
		print 'cliente já cadastrado'
	else
		print 'cliente não cadastrado'
	GO
	--Testes de inserção
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
Passo 4. Lógica de implementação
	Declarar cabeçalho da procedure
		Receber cada parâmetro de entrada em uma variável
		nome, CPF, telefone, professor
	Declarar parâmetros de saída
	Validar e/ou transformar os parâmetros de entrada
		Ex: cpf '123.456.789-09' -> '12345678909'
	Verificar se o cliente já está inserido testando seu CPF
	Se ele não estiver, inseri-lo
	Coletar o ID do cliente e armazená-lo na variável de saída
----------------------------------------------------------------------------------------------------------------------------
Passo 5. Código / implementação
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

4 - Postem uma evidência dos testes realizados na execução da procedure 
realizada no item 3 
Print da tela contendo execução da procedure, com testes para clientes 
com CPF novos e velhos, além do select da tabela cliente 
( com ênfase em demonstrar os dados recém inseridos ).

------------------------------------------------------------------------

5 - Postem o código solicitado para o seguinte enunciado:

Alterem a procedure criada no item 4 para incluir uma validação no CPF 
recebido como parâmetro.
De forma que, a procedure seja encerrada devolvendo -1 ( return -1 ) 
	caso o CPF não seja válido,
e continue com o propósito normal caso o CPF seja válido, devolvendo 1 ( return 1 )
	, ao final da execução se tudo foi ocorreu corretamente.
(utilize os códigos da AC3 como referência para validação de CPFs )

----------------------------------------------------------------------------------------------------------------------------
Passo 0. Esclarecimento:
	- Os testes de validação de CPF foram passados na AC3
		ver: Aula 10 - AC3 - revisão aulas 08 a 09 - CORRECAO.sql
	Será necessário criar:
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
					--Função de limpeza feita na questão 06
					SELECT @CPF = dbo.fn_limpaCPF(@CPF)

					--Tratamento de erro pré-montado na questão 07
					IF ( len(@CPF) <> 11 ) THROW 50000, 'Formato inválido',1
					IF ( ISNUMERIC(@CPF) <> 1 ) THROW 50001,'Dígitos inválidos',1

					--Tomada de decisão feita na questão pré-calculada na questão 11
					IF ( 
						--Função do primeiro dígito feito na questão 09--> 1 BUG a ser corrigido
						SUBSTRING(@CPF,10,1) = dbo.fn_calculaPrimeiroDigito(@CPF)		
						AND 
						--Função do segundo dígito feito na questão 10 --> 2 BUGs a serem corrigidos
						SUBSTRING(@CPF,11,1) = dbo.fn_calculaSegundoDigito(@CPF)
					)
						SELECT @retorno = 'VÁLIDO'
					ELSE 
						SELECT @retorno = 'INVALIDO'
				END
				GO
	OU utilizem sua resposta da questão 14 da AC3 ( desde que correta e/ou validada )

	- A utilização do RETURN dentro de procedimentos 
		ver: Aula 13 - AC4 - Funções e procedimentos - parte 4.sql

----------------------------------------------------------------------------------------------------------------------------
Passo 1. Planejamento: 
	parâmetros de entrada: ( os mesmo da questão 3 ) 
 		<- um nome do cliente ( 'Amauri Silva e Silva' )
		<- um CPF ( '123.456.789-09' )
 		<- um telefone ( '912345678')
		<- um bit para 0 = não é professor ou 1 = é professor
	Parâmetros de saída 
		-> ID daquele Cliente ( tipo OUTPUT )
	Valores Retornados ( via RETURN no procedimento )
		-1	-> se erro no CPF
		1	-> se tudo OK na inserção do cliente
	Tipo de função / procedimento
		Pelo Enunciado, deve ser uma procedure e não uma função.
	Pesquisa - o que será útil para resolver esta questão ?
		Rever: INSERT - Aula 01 - Revisao SQL e entendimento de um banco de dados - Revisão Linguagem SQL - GUIA DE ESTUDO.sql
		Rever: IF - Aula 03 - Tratamento de nulos e condicionais.sql
		Rever: WHILE - Aula 06 - Controle de fluxo.sql
		Rever: AC3 - Aula 10 - AC3 - revisão aulas 08 a 09 - CORRECAO.sql
		Rever: Return em procedures - Aula 13 - AC4 - Funções e procedimentos - parte 4.sql

		----------------------------------------------------------------------------------------------------------------------------
Passo 2. Entendimento dos dados
Como registrar Clientes ?
	--Identificação dos clientes
	SELECT * FROM   Cliente;

	SP_HELP Cliente
	id			int --PRIMARY KEY
	nome		varchar
	cpf			char --UNIQUE, CHECK ([cpf] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
	telefone	varchar
	professor	bit --DEFAULT ((0))
	--FK com tabela Contrato 
	--FK com tabela Veiculo 

Como é a máscara de CPF válido pela tabela ?

CHECK ([cpf] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
Ou seja, ele só aceita dígitos, 11 deles para ser exato.

----------------------------------------------------------------------------------------------------------------------------
Passo 3:Testes / validação CPF
	--Limpando CPFs
	DECLARE @CPF CHAR(14) = '529.982.247-25'
	SELECT dbo.fn_limpaCPF(@CPF)

	--Testes de cálculo do primeiro dígito
	DECLARE @CPF CHAR(14) = dbo.fn_limpaCPF('529.982.247-25')
	select dbo.fn_calculaPrimeiroDigito(@CPF)

	--Testes de cálculo do primeiro dígito
	DECLARE @CPF CHAR(14) = dbo.fn_limpaCPF('529.982.247-25')
	select dbo.fn_calculaSegundoDigito(@CPF)

	--Testes de validação de CPF
	DECLARE @CPF VARCHAR(255) = '529.982.247-25', @retorno VARCHAR(255)
	EXEC pr_validaCPF @CPF, @retorno OUTPUT
	SELECT 'O CPF : '+ @CPF + ' é ' + @retorno
	
----------------------------------------------------------------------------------------------------------------------------
Passo 4. Lógica de implementação
	Declarar cabeçalho da procedure
		Receber cada parâmetro de entrada em uma variável
		nome, CPF, telefone, professor
	Declarar parâmetros de saída
	Validar e/ou transformar os parâmetros de entrada
		Ex: cpf '123.456.789-09' -> '12345678909'
		validar CPF
			Se Inválido, sair da procedure retornando -1
	Verificar se o cliente já está inserido testando seu CPF
	Se ele não estiver, inseri-lo
	Coletar o ID do cliente e armazená-lo na variável de saída
	Se tudo ocorreu como planejado, sair da procedure retornando 1
----------------------------------------------------------------------------------------------------------------------------
Passo 5. Código / implementação

CREATE OR ALTER PROCEDURE pr_insereCliente_v2 --Só para mudar o nome 
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

6 - Postem uma evidência dos testes realizados na execução da procedure 
realizada no item 5 
Print da tela contendo execução da procedure, com testes para clientes 
com CPF válidos e inválidos, além do  select da tabela cliente 
( com ênfase em demonstrar os dados recém inseridos ).

------------------------------------------------------------------------
