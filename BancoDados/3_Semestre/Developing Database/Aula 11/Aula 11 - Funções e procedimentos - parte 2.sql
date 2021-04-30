--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 11 - Funções e procedimentos - parte 2
--=X=-- 	Utilização de procedures para controle de processos.
--=X=-- 	Utilização de funções para automatização de processos de validação.
--=X=-- 	Criação de procedimentos para manipulação de processos.
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

/*
	Aula 09 - Funções e procedimentos - parte 1
		Utilização de procedures para controle de processos.
		Utilização de funções para automatização de processos de validação.
		Criação de funções para manipulação de processos.
		Criação de procedimentos para manipulação de processos.
	Aula 10 - AC3 - Revisão aulas 08 e 09
	Aula 11 - Funções e procedimentos - parte 2
		Stored Procedures, métodos acessores, parâmetros de saída.
		Funções ( escalar, in-line, multi-statement )
	Aula 12 - Sub-selects, pivot e unpivot, Conjuntos, CTE, Apply, tabelas derivadas.
		Uso de sub-selects: escalar, lista e tabular	
		Manipulação de conjuntos.
		Comparativo entre JOIN e Subqueries.
*/

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Recapitulando Aula 09 - Funções e procedimentos - parte 1
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
use ImpactaEstacionamento
GO

Lembram-se das visões, aprendidas em Ling.SQL ( se não viram, esta é uma pequena introdução ).

CREATE VIEW vw_resumoDiario as 
	SELECT 'PLACA: ' + placa
				+ ', DIA: ' + convert(varchar,dataHoraEntrada,103)
				+ ', VALOR RECEBIDO: ' + convert(VARCHAR,valorcobrado)
			as resumoDiario
	FROM	estacionamento
			INNER JOIN veiculo ON estacionamento.idVeiculo = veiculo.id
GO
SELECT * FROM vw_resumoDiario

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--Minha primeira função.
Relembrem o código para determinar a quantidade de veículos atualmente estacionados 
em uma localidade baseado no tipo de vecíulo ( moto / carro ).

/*variáveis utilizadas */
DECLARE @tipoVeiculo VARCHAR(50) = 'moto'
		, @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista'
		, @lotacaoAtual INT
		, @idLocalidade INT
/*coleto o id do estacionamento
Posso utilizá-lo para simpleficar as demas consultas*/
select @idLocalidade= id from localidade where identificacao = @nomeEstacionamento

		/*Para verificar a capacidade de uma localidade/estacionamento
		De um certo tipo de veículo em um certo momento
		Estão estacionados agora quaisquer veículos sem data de saída)*/
		SELECT @lotacaoAtual = COUNT(*) 
		FROM	estacionamento
				INNER JOIN veiculo ON idVeiculo = veiculo.id
				/*Não preciso do join com localidade pois já tenho o id da localidade dado seu nome*/
				--INNER JOIN localidade ON plano.idlocalidade = localidade.id
		WHERE	estacionamento.idLocalidade = @idLocalidade
				--localidade.identificacao = 'Faculdade Impacta - Paulista'	
				AND tipo = @tipoVeiculo
				AND dataHoraSaida IS NULL

--conferência
select @lotacaoAtual as LocataoAtual

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
CREATE OR ALTER FUNCTION fn_lotacaoAtual ( @idLocalidade INT, @tipoVeiculo VARCHAR(50) )
RETURNS INT
as BEGIN
	DECLARE @lotacaoAtual INT
		/*Para verificar a capacidade de uma localidade/estacionamento
		De um certo tipo de veículo em um certo momento
		Estão estacionados agora quaisquer veículos sem data de saída)*/
		SELECT @lotacaoAtual = COUNT(*) 
		FROM	estacionamento
				INNER JOIN veiculo ON idVeiculo = veiculo.id
				/*Não preciso do join com localidade pois já tenho o id da localidade dado seu nome*/
				--INNER JOIN localidade ON plano.idlocalidade = localidade.id
		WHERE	estacionamento.idLocalidade = @idLocalidade
				--localidade.identificacao = 'Faculdade Impacta - Paulista'	
				AND tipo = @tipoVeiculo
				AND dataHoraSaida IS NULL
	RETURN @lotacaoAtual
END
GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

/*variáveis utilizadas */
DECLARE @tipoVeiculo VARCHAR(50) = 'moto'
		, @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista'
		, @lotacaoAtual INT
		, @idLocalidade INT
/*coleto o id do estacionamento
Posso utilizá-lo para simplificar as demais consultas*/
select @idLocalidade= id from localidade where identificacao = @nomeEstacionamento

select @lotacaoAtual = dbo.fn_lotacaoAtual ( @idLocalidade, @tipoVeiculo )

--conferência
select @lotacaoAtual as LocataoAtual

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Outros exemplos de funções:

CREATE OR ALTER FUNCTION [dbo].[fn_mes_numero_para_palavra] 
		(@numMes tinyint, @idioma tinyint= 1)
RETURNS varchar(20)
AS
BEGIN

declare @m varchar(20)

if(@idioma = 1) --idioma 1= Portugues
SELECT @m = CASE @numMes 
	    WHEN 1 THEN 'Janeiro' WHEN 2 THEN 'Fevereiro' WHEN 3 THEN 'Março' WHEN 4 THEN 'Abril'  
	    WHEN 5 THEN 'Maio' WHEN 6 THEN 'Junho' WHEN 7 THEN 'Julho' WHEN 8 THEN 'Agosto' 
	    WHEN 9 THEN 'Setembro' WHEN 10 THEN 'Outubro' WHEN 11 THEN 'Novembro' WHEN 12 THEN 'Dezembro' END
 
if(@idioma = 2) -- idioma 2= Espanhol
SELECT @m = CASE @numMes 
	  WHEN 1 THEN 'Enero' WHEN 2 THEN 'Febrero' WHEN 3 THEN 'Marzo' WHEN 4 THEN 'Abril' 
	  WHEN 5 THEN 'Mayo'  WHEN 6 THEN 'Junio' WHEN 7 THEN 'Julio' WHEN 8 THEN 'Agosto' 
	  WHEN 9 THEN 'Septiembre'  WHEN 10 THEN 'Octubre' WHEN 11 THEN 'Noviembre' WHEN 12 THEN 'Diciembre' END 

if(@idioma = 3) -- idioma 3= Inglês
SELECT @m = CASE @numMes 
	  WHEN 1 THEN 'January' WHEN 2 THEN 'February' WHEN 3 THEN 'March' WHEN 4 THEN 'April' 
	  WHEN 5 THEN 'May' WHEN 6 THEN 'June' WHEN 7 THEN 'July' WHEN 8 THEN 'August' 
	  WHEN 9 THEN 'September' WHEN 10 THEN 'October' WHEN 11 THEN 'November' WHEN 12 THEN 'December' END 
RETURN @m

END
GO

select [dbo].[fn_mes_numero_para_palavra]( 12, 1 ) as [pt]
	, [dbo].[fn_mes_numero_para_palavra]( 12, 2 ) as [es]
	, [dbo].[fn_mes_numero_para_palavra]( 12, 3 ) as [en]
	

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Exercícios
Agora seja esta query para buscar a capacidade total do estacionamento.

	DECLARE @tipoVeiculo VARCHAR(50) = 'moto'
			, @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista'
			, @capacidadeMaxima INT
	/*Para verificar a capacidade máxima do estacionamento para aquele tipo de veículo*/
	SELECT @capacidadeMaxima = IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
	FROM localidade 
	WHERE identificacao = @nomeEstacionamento

	--conferência
	select @capacidadeMaxima as LocataoAtual

Substitua o select principal por uma função que receba como parâmetros de entrada
o tipo do veículo ( @tipoVeiculo ) e o nome do estacionamento ( @nomeEstacionamento ) 
e devolva a capacidade máxima daquele estacionamento para aquele tipo de veículo.

CREATE OR ALTER FUNCTION dbo.fn_capacidadeMaxima
 (@nomeEstacionamento VARCHAR(255), @tipoVeiculo VARCHAR(50))
RETURNS INT 
AS BEGIN
	DECLARE @capacidadeMaxima INT
	/*Para verificar a capacidade máxima do estacionamento para aquele tipo de veículo*/
	SELECT @capacidadeMaxima = 
		IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
	FROM localidade 
	WHERE identificacao = @nomeEstacionamento

	RETURN @capacidadeMaxima
END

Seu código deu certo se isso rodar:
	DECLARE @tipoVeiculo VARCHAR(50) = 'moto'
			, @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista'
			, @capacidadeMaxima INT
	/*Para verificar a capacidade máxima do estacionamento para aquele tipo de veículo*/
	SELECT @capacidadeMaxima = dbo.fn_capacidadeMaxima( @nomeEstacionamento, @tipoVeiculo )
	--conferência
	select @capacidadeMaxima as LocataoAtual

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 09 - Funções e procedimentos - parte 1 - procedimentos
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
A maneira mais simples de criar procedures é apenas encapsular códigos ( similar á uma visão ) 

--criação
CREATE OR ALTER PROCEDURE sp_resumodiario
AS
  SELECT 'PLACA: ' + placa + ', DIA: '
         + CONVERT(VARCHAR, datahoraentrada, 103)
         + ', VALOR RECEBIDO: '
         + CONVERT(VARCHAR, valorcobrado) AS resumoDiario
  FROM   estacionamento
         INNER JOIN veiculo
                 ON estacionamento.idveiculo = veiculo.id
go

--execução
EXEC sp_resumodiario 

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Procedures também podem receber parâmetros, lembram-se do processo de saída de um 
veículo do estacionamento ? 

Saida: Dado um ID ( que está presente no ticket impresso ) 
e um horário de saída ( 3 horas depois da entrada )
- Calcular valor a ser pago.
- Registrar a saída do estacionamento.

/*De posso do ticket, que contém o ID, é simples localidar o veículo estacionado
Porém, eu preciso acessar o plano contratado para descobrir o valor a cobrar
Poderia supor 3 horas exatas para simplificar o valor, 
porém, o correto é calcular a diferença em minutos e cobrar devidamente.
*/
/*variáveis utilizadas */
Declare @idEstacionamento INT = 14 /*suposto Ticket do estacionamento*/

/*
Dado o Id do estacionamento, declarado na variável, 
basta calcular o valor a ser cobrado = valor do plano * número de horas

Para nossa sorte, o número de horas já é automaticamente calculado 
na coluna: horasEstacionado 
	as ( 
		CEILING ( DATEDIFF(minute,dataHoraEntrada,ISNULL(dataHoraSaida, GETDATE() )) / 60.00 )
	)
*/

update estacionamento
	SET dataHoraSaida = GETDATE()
	, valorCobrado = plano.valor * horasEstacionado
FROM	estacionamento
		INNER JOIN Plano on estacionamento.idPlano = plano.id
WHERE	estacionamento.id = @idEstacionamento

/*conferindo os valores inseridos*/
select * from estacionamento where id = @idEstacionamento

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Criando a procedure que recebe o id do estacionamento e registra sua saída do estacionamento

CREATE OR ALTER PROCEDURE sp_saidaVeiculo 
	( @idEstacionamento INT )
AS BEGIN
	update estacionamento
		SET dataHoraSaida = GETDATE()
		, valorCobrado = plano.valor * horasEstacionado
	FROM	estacionamento
			INNER JOIN Plano on estacionamento.idPlano = plano.id
	WHERE	estacionamento.id = @idEstacionamento
END

--Testando-a
/*busco qualquer Ticket do estacionamento de qualquer veículo ainda estacionado */
Declare @idEstacionamento INT = (	select TOP 1 id from estacionamento where dataHoraSaida is null) 
--status antes da execução
select * from estacionamento where ID = @idEstacionamento
--execução da procedure
EXEC sp_saidaVeiculo @idEstacionamento
--status depois da execução
select * from estacionamento where ID = @idEstacionamento

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
As procedures também podem devolver parâmetros ( de 2 formas )
Imaginem o seguinte processo que, dado um tipo de veículo e uma placa, 
insiram-no no banco caso eles não estejam lá, devolvendo o ID recém inserido, 
OU apenas leiam e devolvam o ID caso já esteja lá.

/*variáveis utilizadas */
DECLARE		@idVeiculo INT
		,	@placaVeiculo VARCHAR(50) = 'GHY6543'
		,	@tipoVeiculo VARCHAR(50) = 'moto'

/*
SE o veículo já está cadastrado, ou seja, não é a primeira vez que ele estaciona.
Basca buscar o id do veículo pela placa.
*/
IF EXISTS (SELECT id FROM   veiculo WHERE  placa = @placaVeiculo)
  BEGIN	/* SE o veículo já está cadastrado, ou seja, não é a primeira vez que ele estaciona.
      Basca buscar o id do veículo pela placa.*/
      	SELECT @idVeiculo = id FROM   veiculo WHERE  placa = @placaVeiculo
  END
ELSE
  BEGIN /* SENÃO, caso seja a primeira vez que ele estaciona, é necessário estacionar o veículo
      	Como é um cliente horista, não preciso cadastrar um cliente ( para mensalistas )*/
      	INSERT veiculo (tipo, placa, idcliente) VALUES ( @tipoVeiculo, @placaVeiculo, NULL )
        SELECT @idVeiculo = Scope_identity()
  END

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Agora vejam o seguinte código, atenção para como as variáveis que retornam valores 
tem que declarar a cláusula OUTPUT 

CREATE OR ALTER PROCEDURE sp_UpsertVeiculo ( 
	@tipoVeiculo VARCHAR(50)
	, @placaVeiculo VARCHAR(50)
	, @idVeiculo INT OUTPUT
)
AS BEGIN
	/*
	SE o veículo já está cadastrado, ou seja, não é a primeira vez que ele estaciona.
	Basca buscar o id do veículo pela placa.
	*/
	IF EXISTS (SELECT id FROM   veiculo WHERE  placa = @placaVeiculo)
	  BEGIN	/* SE o veículo já está cadastrado, ou seja, não é a primeira vez que ele estaciona.
		  Basca buscar o id do veículo pela placa.*/
      		SELECT @idVeiculo = id FROM   veiculo WHERE  placa = @placaVeiculo
	  END
	ELSE
	  BEGIN /* SENÃO, caso seja a primeira vez que ele estaciona, é necessário estacionar o veículo
      		Como é um cliente horista, não preciso cadastrar um cliente ( para mensalistas )*/
      		INSERT veiculo (tipo, placa, idcliente) VALUES ( @tipoVeiculo, @placaVeiculo, NULL )
			SELECT @idVeiculo = Scope_identity()
	  END
END
GO

--Testando...
DECLARE		@idVeiculo INT
		,	@placaVeiculo VARCHAR(50) = 'ABC9234'
		,	@tipoVeiculo VARCHAR(50) = 'CARRO'

EXEC sp_UpsertVeiculo @tipoVeiculo, @placaVeiculo, @idVeiculo OUTPUT

SELECT @idVeiculo as ID

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Exercícios:

Agora seja esta [ MESMA ] query para buscar a capacidade máxima 
do estacionamento:
DECLARE @tipoVeiculo        VARCHAR(50) = 'moto',
        @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista',
        @capacidadeMaxima   INT

/*Para verificar a capacidade máxima do estacionamento para aquele tipo de veículo*/
SELECT @capacidadeMaxima = Iif(@tipoVeiculo = 'moto', capacidade_moto,capacidade_carro)
FROM   localidade
WHERE  identificacao = @nomeEstacionamento

--conferência
SELECT @capacidadeMaxima AS LocataoAtual 

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Agora, substitua o select principal por uma procedure que receba como parâmetros de entrada
o tipo do veículo ( @tipoVeiculo ) e o nome do estacionamento ( @nomeEstacionamento ) 
e devolva como parâmetro de saída ( @capacidadeMaxima ) a capacidade máxima daquele 
estacionamento para aquele tipo de veículo.

CREATE OR ALTER PROCEDURE sp_capacidadeMaxima 
	(@nomeEstacionamento VARCHAR(50)
	, @tipoVeiculo VARCHAR(50)
	,@capacidadeMaxima int output)
as BEGIN
	
	/*Para verificar a capacidade máxima do estacionamento para aquele tipo de veículo*/
	SELECT @capacidadeMaxima = IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
	FROM localidade 
	WHERE identificacao = @nomeEstacionamento

end

Seu código deu certo se isso rodar:
DECLARE @tipoVeiculo        VARCHAR(50) = 'moto',
        @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista',
        @capacidadeMaxima   INT

/*Para verificar a capacidade máxima do estacionamento para aquele tipo de veículo*/
EXEC sp_capacidademaxima 
	@nomeEstacionamento
	, @tipoVeiculo
	, @capacidadeMaxima OUTPUT

--conferência
SELECT @capacidadeMaxima AS LocataoAtual 

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 11 - Funções e procedimentos - parte 2
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

/*
Relembrem o código da visão que devolve o resumo diário :
	PLACA: GHY6543, DIA: 07/04/2021, VALOR RECEBIDO: 30.00
	PLACA: GHY6543, DIA: 07/04/2021, VALOR RECEBIDO: 0.00
	PLACA: GHY6543, DIA: 07/04/2021, VALOR RECEBIDO: 0.00
*/
CREATE VIEW vw_resumodiario
AS
  SELECT 'PLACA: ' + placa + ', DIA: '
         + CONVERT(VARCHAR, datahoraentrada, 103)
         + ', VALOR RECEBIDO: '
         + CONVERT(VARCHAR, valorcobrado) AS resumoDiario
  FROM   estacionamento
         INNER JOIN veiculo
                 ON estacionamento.idveiculo = veiculo.id
go

SELECT * FROM   vw_resumodiario 
GO
/*Que também foi reescrita como procedure na Aula 09*/
CREATE OR ALTER PROCEDURE Sp_resumodiario
AS
	SELECT	'PLACA: ' + placa 
			+ ', DIA: ' + CONVERT(VARCHAR, datahoraentrada, 103) 
			+ ', VALOR RECEBIDO: ' + CONVERT(VARCHAR, valorcobrado) AS resumoDiario
	FROM    estacionamento
			INNER JOIN veiculo
			ON estacionamento.idveiculo = veiculo.id
go

EXEC Sp_resumodiario
GO

/*Re-escrita como uma in-line tabular function ficaria*/
CREATE OR ALTER FUNCTION tvf_resumodiario_inline ( )
RETURNS TABLE
AS RETURN (
	SELECT	'PLACA: ' + placa 
			+ ', DIA: ' + CONVERT(VARCHAR, datahoraentrada, 103) 
			+ ', VALOR RECEBIDO: ' + CONVERT(VARCHAR, valorcobrado) AS resumoDiario
	FROM    estacionamento
			INNER JOIN veiculo
			ON estacionamento.idveiculo = veiculo.id
)
GO
SELECT * FROM dbo.tvf_resumodiario_inline()
GO

/*Re-escrita como uma Multi-Statement tabular function ficaria*/
CREATE OR ALTER FUNCTION tvf_resumodiario_multistatement ( )
RETURNS @TabelaDeRetorno TABLE( resumoDiario VARCHAR(MAX) )
AS BEGIN
	INSERT @TabelaDeRetorno ( resumoDiario )
	SELECT	'PLACA: ' + placa 
			+ ', DIA: ' + CONVERT(VARCHAR, datahoraentrada, 103) 
			+ ', VALOR RECEBIDO: ' + CONVERT(VARCHAR, valorcobrado) AS resumoDiario
	FROM    estacionamento
			INNER JOIN veiculo
			ON estacionamento.idveiculo = veiculo.id
	RETURN
END
GO
SELECT * FROM dbo.tvf_resumodiario_multistatement()
GO


--------------------------------------------------------------------------- 
-- Exercícios
--------------------------------------------------------------------------- 

Unindo as formas aprendidas:
--Visão
SELECT * FROM   vw_resumodiario

--Stored Procedure simples
EXEC Sp_resumodiario

--Inline Table Valuable Function
SELECT * FROM dbo.Tvf_resumodiario_inline()

--MultiStatement Table Valuable Function
SELECT * FROM dbo.Tvf_resumodiario_multistatement()

Algumas destas permitem filtros após a devolução, ou seja, depois de executadas 
Ex: 	SELECT * FROM   vw_resumodiario WHERE ... 
Outras permitem a passagem de parâmetros para filtrar os resultados internamente, desde que sejam recebidos como parâmetros:
Ex: 	EXEC Sp_resumodiario @dia

-------------------------------------------------------------------------- 
-- Exercícios
--------------------------------------------------------------------------- 

--Agora suponha que só nos interesse dados de um dia em específico.
DECLARE @dia DATE = '28/04/2021' 
--Demonstre uma forma de utilização das duas funções ( inline e multistatemente ) utilizando filtros simples ( WHERE ), de forma que apenas aquele dia seja devolvido.

--Inline Table Valuable Function
SELECT * FROM dbo.Tvf_resumodiario_inline() 
WHERE SUBSTRING(resumoDiario,CHARINDEX(convert(varchar, @dia, 103),resumoDiario,1),LEN(convert(varchar, @dia, 103)))= convert(varchar, @dia, 103)

--MultiStatement Table Valuable Function
SELECT * FROM dbo.Tvf_resumodiario_multistatement() 
WHERE SUBSTRING(resumoDiario,CHARINDEX(convert(varchar, @dia, 103),resumoDiario,1),LEN(convert(varchar, @dia, 103)))= convert(varchar, @dia, 103)

--Depois altere-as para que elas recebam tal dia como parâmetro e devolvam no relatório, dados apenas daquele dia:

/*Re-escrita como uma in-line tabular function ficaria*/
CREATE OR ALTER FUNCTION tvf_resumodiario_inline ( @dia Date)
RETURNS TABLE
AS RETURN (
	SELECT	'PLACA: ' + placa 
			+ ', DIA: ' + CONVERT(VARCHAR, datahoraentrada, 103) 
			+ ', VALOR RECEBIDO: ' + CONVERT(VARCHAR, valorcobrado) AS resumoDiario
	FROM    estacionamento
			INNER JOIN veiculo
			ON estacionamento.idveiculo = veiculo.id
		where CONVERT(varchar,datahoraentrada, 103) = @dia

)
GO
DECLARE @dia DATE = '28/04/2021' 
--Inline Table Valuable Function
SELECT * FROM dbo.Tvf_resumodiario_inline(@dia)



CREATE OR ALTER FUNCTION tvf_resumodiario_multistatement (@dia Date )
RETURNS @TabelaDeRetorno TABLE( resumoDiario VARCHAR(MAX) )
AS BEGIN
	INSERT @TabelaDeRetorno ( resumoDiario )
	SELECT	'PLACA: ' + placa 
			+ ', DIA: ' + CONVERT(VARCHAR, datahoraentrada, 103) 
			+ ', VALOR RECEBIDO: ' + CONVERT(VARCHAR, valorcobrado) AS resumoDiario
	FROM    estacionamento
			INNER JOIN veiculo
			ON estacionamento.idveiculo = veiculo.id
	where CONVERT(varchar,datahoraentrada, 103) = @dia
	RETURN
END

DECLARE @dia DATE = '28/04/2021' 
--MultiStatement Table Valuable Function
SELECT * FROM dbo.Tvf_resumodiario_multistatement(@dia)

-------------------------------------------------------------------------- 
-- Relembrando - VARIABLE TABLE 
--------------------------------------------------------------------------- 
DECLARE @TBTeste TABLE 
  ( 
     id TINYINT IDENTITY, 
     uf VARCHAR(2) NOT NULL 
  ) 

INSERT @TBTeste 
VALUES ('SP'), ('RJ'), ('MG') 

SELECT * FROM   @TBTeste 
GO

DECLARE @TBTeste TABLE 
  ( 
     id   SMALLINT IDENTITY(-32768, 1) PRIMARY KEY, 
     nota VARCHAR(100) UNIQUE 
  ) 

INSERT @TBTeste VALUES ('Apenas Teste de variable table em um batch') 

INSERT @TBTeste VALUES ('Apenas Teste de variable table em um batch') 


SELECT * FROM   @TBTeste 
---------------------------------------------------------------------------

--------------------------------------------------------------------------- 
-- TYPE como VARIABLE TABLE 
--------------------------------------------------------------------------- 
IF EXISTS (SELECT * FROM   sys.types WHERE  NAME = 'PadraoProduto') 
  	DROP type padraoproduto 
go 

CREATE type padraoproduto AS TABLE ( 
	id SMALLINT IDENTITY (32767, -1) PRIMARY KEY (id)
	, produto VARCHAR(20) NOT NULL UNIQUE
	, estadoprodutor UF 
		CHECK ( estadoprodutor IN ('SP', 'RJ', 'MG')) 
		DEFAULT ('SP')
	, valor MOEDA 
		CHECK (valor BETWEEN 10 AND 1000)
	, datacompra DATETIME DEFAULT Getdate() 
) 

-- Declarando Variável Table do TYPE criado 
DECLARE @TB PADRAOPRODUTO 

INSERT @TB (produto, valor) 
VALUES ('Caderno', 15.5) 

SELECT * FROM   @TB 
--------------------------------------------------------------------------- 

/*	Procedimentos - Parâmetros do tipo Tabela
	Vamos supor que, ao invés de um único dia, tenhamos que filtrar múltiplos dias
	Devo criar um Type do tipo tabela para que seja passado como parâmetro para 
	dentro da stored procedure.
*/
CREATE TYPE TipoListaDias AS TABLE ( Dia date )
GO
CREATE OR ALTER PROCEDURE Sp_resumodiario_ParamTable ( @dias TipoListaDias READONLY)
AS
	SELECT	'PLACA: ' + placa 
			+ ', DIA: ' + CONVERT(VARCHAR, datahoraentrada, 103) 
			+ ', VALOR RECEBIDO: ' + CONVERT(VARCHAR, valorcobrado) AS resumoDiario
	FROM    estacionamento
			INNER JOIN veiculo
			ON estacionamento.idveiculo = veiculo.id
			INNER JOIN  @dias ON CONVERT(DATE,dataHoraEntrada) = dia
go

DECLARE @dias TipoListaDias
INSERT @dias (dia) values ( '07/04/2021'), ('08/04/2021')
EXEC Sp_resumodiario_ParamTable @dias --> parâmetro do tipo tabela.
GO

--------------------------------------------------------------------------- 

/*	Procedimentos - Salvando o resultado em tabelas 

	Procedures também permitem que seus resultados sejam filtrados após sua execução,
	ou seja, sem a necessidade de sempre terem um parâmetro de entrada

	Porém, para isso, elas devem ter seus valores salvos em uma uma estrutura
	seja ela uma tabela temporária ou variável e só ai, os filtros ( WHERE )
	podem ser aplicados
*/

CREATE TABLE #resultadoProcedure ( resumoDiario VARCHAR(MAX) )

INSERT #resultadoProcedure(resumoDiario )
EXEC Sp_resumodiario

SELECT * FROM #resultadoProcedure WHERE...

--------------------------------------------------------------------------- 

/*	Procedimentos - comando RETURN */

Dentro de Procedimentos armazenados, o comando RETURN encerra o fluxo de execução
e retorna o controle para quem chamou a procedure.

ele é normalmente utilizado para:
	Encerrar sua execução após detecção de problemas
	indicar sucesso ou falha Ex: return 1 para sucesso ou return 0 para falha

--------------------------------------------------------------------------- 

Exercícios para casa:

1- Crie uma função escalar que, dado uma data, devolva o dia da semana
2- Crie uma função tabular (inLine ou Multistatement) que, dado um dia da semana,
	devolva os últimos 10 dias passados daquele dia da semana (ex: 10 últimas quartas-feiras )
3- Cria uma procedure que receba uma lista de datas ( contendo todos os feriados )
	e um número ( dias úteis para o vencimento de uma fatura, por exemplo)
	, e devolva a data exata do vencimento, não contando nem finais de semana, nem os feriados
	contidos na lista recebida.

Crie todas as funções ou procedimentos solicitados, teste-os e demonstre que estão funcionando.






