--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 11 - Fun��es e procedimentos - parte 2
--=X=-- 	Utiliza��o de procedures para controle de processos.
--=X=-- 	Utiliza��o de fun��es para automatiza��o de processos de valida��o.
--=X=-- 	Cria��o de procedimentos para manipula��o de processos.
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

/*
	Aula 09 - Fun��es e procedimentos - parte 1
		Utiliza��o de procedures para controle de processos.
		Utiliza��o de fun��es para automatiza��o de processos de valida��o.
		Cria��o de fun��es para manipula��o de processos.
		Cria��o de procedimentos para manipula��o de processos.
	Aula 10 - AC3 - Revis�o aulas 08 e 09
	Aula 11 - Fun��es e procedimentos - parte 2
		Stored Procedures, m�todos acessores, par�metros de sa�da.
		Fun��es ( escalar, in-line, multi-statement )
	Aula 12 - Sub-selects, pivot e unpivot, Conjuntos, CTE, Apply, tabelas derivadas.
		Uso de sub-selects: escalar, lista e tabular	
		Manipula��o de conjuntos.
		Comparativo entre JOIN e Subqueries.
*/

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Recapitulando Aula 09 - Fun��es e procedimentos - parte 1
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
use ImpactaEstacionamento
GO

Lembram-se das vis�es, aprendidas em Ling.SQL ( se n�o viram, esta � uma pequena introdu��o ).

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
--Minha primeira fun��o.
Relembrem o c�digo para determinar a quantidade de ve�culos atualmente estacionados 
em uma localidade baseado no tipo de vec�ulo ( moto / carro ).

/*vari�veis utilizadas */
DECLARE @tipoVeiculo VARCHAR(50) = 'moto'
		, @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista'
		, @lotacaoAtual INT
		, @idLocalidade INT
/*coleto o id do estacionamento
Posso utiliz�-lo para simpleficar as demas consultas*/
select @idLocalidade= id from localidade where identificacao = @nomeEstacionamento

		/*Para verificar a capacidade de uma localidade/estacionamento
		De um certo tipo de ve�culo em um certo momento
		Est�o estacionados agora quaisquer ve�culos sem data de sa�da)*/
		SELECT @lotacaoAtual = COUNT(*) 
		FROM	estacionamento
				INNER JOIN veiculo ON idVeiculo = veiculo.id
				/*N�o preciso do join com localidade pois j� tenho o id da localidade dado seu nome*/
				--INNER JOIN localidade ON plano.idlocalidade = localidade.id
		WHERE	estacionamento.idLocalidade = @idLocalidade
				--localidade.identificacao = 'Faculdade Impacta - Paulista'	
				AND tipo = @tipoVeiculo
				AND dataHoraSaida IS NULL

--confer�ncia
select @lotacaoAtual as LocataoAtual

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
CREATE OR ALTER FUNCTION fn_lotacaoAtual ( @idLocalidade INT, @tipoVeiculo VARCHAR(50) )
RETURNS INT
as BEGIN
	DECLARE @lotacaoAtual INT
		/*Para verificar a capacidade de uma localidade/estacionamento
		De um certo tipo de ve�culo em um certo momento
		Est�o estacionados agora quaisquer ve�culos sem data de sa�da)*/
		SELECT @lotacaoAtual = COUNT(*) 
		FROM	estacionamento
				INNER JOIN veiculo ON idVeiculo = veiculo.id
				/*N�o preciso do join com localidade pois j� tenho o id da localidade dado seu nome*/
				--INNER JOIN localidade ON plano.idlocalidade = localidade.id
		WHERE	estacionamento.idLocalidade = @idLocalidade
				--localidade.identificacao = 'Faculdade Impacta - Paulista'	
				AND tipo = @tipoVeiculo
				AND dataHoraSaida IS NULL
	RETURN @lotacaoAtual
END
GO

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

/*vari�veis utilizadas */
DECLARE @tipoVeiculo VARCHAR(50) = 'moto'
		, @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista'
		, @lotacaoAtual INT
		, @idLocalidade INT
/*coleto o id do estacionamento
Posso utiliz�-lo para simplificar as demais consultas*/
select @idLocalidade= id from localidade where identificacao = @nomeEstacionamento

select @lotacaoAtual = dbo.fn_lotacaoAtual ( @idLocalidade, @tipoVeiculo )

--confer�ncia
select @lotacaoAtual as LocataoAtual

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Outros exemplos de fun��es:

CREATE OR ALTER FUNCTION [dbo].[fn_mes_numero_para_palavra] 
		(@numMes tinyint, @idioma tinyint= 1)
RETURNS varchar(20)
AS
BEGIN

declare @m varchar(20)

if(@idioma = 1) --idioma 1= Portugues
SELECT @m = CASE @numMes 
	    WHEN 1 THEN 'Janeiro' WHEN 2 THEN 'Fevereiro' WHEN 3 THEN 'Mar�o' WHEN 4 THEN 'Abril'  
	    WHEN 5 THEN 'Maio' WHEN 6 THEN 'Junho' WHEN 7 THEN 'Julho' WHEN 8 THEN 'Agosto' 
	    WHEN 9 THEN 'Setembro' WHEN 10 THEN 'Outubro' WHEN 11 THEN 'Novembro' WHEN 12 THEN 'Dezembro' END
 
if(@idioma = 2) -- idioma 2= Espanhol
SELECT @m = CASE @numMes 
	  WHEN 1 THEN 'Enero' WHEN 2 THEN 'Febrero' WHEN 3 THEN 'Marzo' WHEN 4 THEN 'Abril' 
	  WHEN 5 THEN 'Mayo'  WHEN 6 THEN 'Junio' WHEN 7 THEN 'Julio' WHEN 8 THEN 'Agosto' 
	  WHEN 9 THEN 'Septiembre'  WHEN 10 THEN 'Octubre' WHEN 11 THEN 'Noviembre' WHEN 12 THEN 'Diciembre' END 

if(@idioma = 3) -- idioma 3= Ingl�s
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
Exerc�cios
Agora seja esta query para buscar a capacidade total do estacionamento.

	DECLARE @tipoVeiculo VARCHAR(50) = 'moto'
			, @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista'
			, @capacidadeMaxima INT
	/*Para verificar a capacidade m�xima do estacionamento para aquele tipo de ve�culo*/
	SELECT @capacidadeMaxima = IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
	FROM localidade 
	WHERE identificacao = @nomeEstacionamento

	--confer�ncia
	select @capacidadeMaxima as LocataoAtual

Substitua o select principal por uma fun��o que receba como par�metros de entrada
o tipo do ve�culo ( @tipoVeiculo ) e o nome do estacionamento ( @nomeEstacionamento ) 
e devolva a capacidade m�xima daquele estacionamento para aquele tipo de ve�culo.

CREATE OR ALTER FUNCTION dbo.fn_capacidadeMaxima
 (@nomeEstacionamento VARCHAR(255), @tipoVeiculo VARCHAR(50))
RETURNS INT 
AS BEGIN
	DECLARE @capacidadeMaxima INT
	/*Para verificar a capacidade m�xima do estacionamento para aquele tipo de ve�culo*/
	SELECT @capacidadeMaxima = 
		IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
	FROM localidade 
	WHERE identificacao = @nomeEstacionamento

	RETURN @capacidadeMaxima
END

Seu c�digo deu certo se isso rodar:
	DECLARE @tipoVeiculo VARCHAR(50) = 'moto'
			, @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista'
			, @capacidadeMaxima INT
	/*Para verificar a capacidade m�xima do estacionamento para aquele tipo de ve�culo*/
	SELECT @capacidadeMaxima = dbo.fn_capacidadeMaxima( @nomeEstacionamento, @tipoVeiculo )
	--confer�ncia
	select @capacidadeMaxima as LocataoAtual

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 09 - Fun��es e procedimentos - parte 1 - procedimentos
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
A maneira mais simples de criar procedures � apenas encapsular c�digos ( similar � uma vis�o ) 

--cria��o
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

--execu��o
EXEC sp_resumodiario 

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Procedures tamb�m podem receber par�metros, lembram-se do processo de sa�da de um 
ve�culo do estacionamento ? 

Saida: Dado um ID ( que est� presente no ticket impresso ) 
e um hor�rio de sa�da ( 3 horas depois da entrada )
- Calcular valor a ser pago.
- Registrar a sa�da do estacionamento.

/*De posso do ticket, que cont�m o ID, � simples localidar o ve�culo estacionado
Por�m, eu preciso acessar o plano contratado para descobrir o valor a cobrar
Poderia supor 3 horas exatas para simplificar o valor, 
por�m, o correto � calcular a diferen�a em minutos e cobrar devidamente.
*/
/*vari�veis utilizadas */
Declare @idEstacionamento INT = 14 /*suposto Ticket do estacionamento*/

/*
Dado o Id do estacionamento, declarado na vari�vel, 
basta calcular o valor a ser cobrado = valor do plano * n�mero de horas

Para nossa sorte, o n�mero de horas j� � automaticamente calculado 
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
Criando a procedure que recebe o id do estacionamento e registra sua sa�da do estacionamento

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
/*busco qualquer Ticket do estacionamento de qualquer ve�culo ainda estacionado */
Declare @idEstacionamento INT = (	select TOP 1 id from estacionamento where dataHoraSaida is null) 
--status antes da execu��o
select * from estacionamento where ID = @idEstacionamento
--execu��o da procedure
EXEC sp_saidaVeiculo @idEstacionamento
--status depois da execu��o
select * from estacionamento where ID = @idEstacionamento

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
As procedures tamb�m podem devolver par�metros ( de 2 formas )
Imaginem o seguinte processo que, dado um tipo de ve�culo e uma placa, 
insiram-no no banco caso eles n�o estejam l�, devolvendo o ID rec�m inserido, 
OU apenas leiam e devolvam o ID caso j� esteja l�.

/*vari�veis utilizadas */
DECLARE		@idVeiculo INT
		,	@placaVeiculo VARCHAR(50) = 'GHY6543'
		,	@tipoVeiculo VARCHAR(50) = 'moto'

/*
SE o ve�culo j� est� cadastrado, ou seja, n�o � a primeira vez que ele estaciona.
Basca buscar o id do ve�culo pela placa.
*/
IF EXISTS (SELECT id FROM   veiculo WHERE  placa = @placaVeiculo)
  BEGIN	/* SE o ve�culo j� est� cadastrado, ou seja, n�o � a primeira vez que ele estaciona.
      Basca buscar o id do ve�culo pela placa.*/
      	SELECT @idVeiculo = id FROM   veiculo WHERE  placa = @placaVeiculo
  END
ELSE
  BEGIN /* SEN�O, caso seja a primeira vez que ele estaciona, � necess�rio estacionar o ve�culo
      	Como � um cliente horista, n�o preciso cadastrar um cliente ( para mensalistas )*/
      	INSERT veiculo (tipo, placa, idcliente) VALUES ( @tipoVeiculo, @placaVeiculo, NULL )
        SELECT @idVeiculo = Scope_identity()
  END

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Agora vejam o seguinte c�digo, aten��o para como as vari�veis que retornam valores 
tem que declarar a cl�usula OUTPUT 

CREATE OR ALTER PROCEDURE sp_UpsertVeiculo ( 
	@tipoVeiculo VARCHAR(50)
	, @placaVeiculo VARCHAR(50)
	, @idVeiculo INT OUTPUT
)
AS BEGIN
	/*
	SE o ve�culo j� est� cadastrado, ou seja, n�o � a primeira vez que ele estaciona.
	Basca buscar o id do ve�culo pela placa.
	*/
	IF EXISTS (SELECT id FROM   veiculo WHERE  placa = @placaVeiculo)
	  BEGIN	/* SE o ve�culo j� est� cadastrado, ou seja, n�o � a primeira vez que ele estaciona.
		  Basca buscar o id do ve�culo pela placa.*/
      		SELECT @idVeiculo = id FROM   veiculo WHERE  placa = @placaVeiculo
	  END
	ELSE
	  BEGIN /* SEN�O, caso seja a primeira vez que ele estaciona, � necess�rio estacionar o ve�culo
      		Como � um cliente horista, n�o preciso cadastrar um cliente ( para mensalistas )*/
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
Exerc�cios:

Agora seja esta [ MESMA ] query para buscar a capacidade m�xima 
do estacionamento:
DECLARE @tipoVeiculo        VARCHAR(50) = 'moto',
        @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista',
        @capacidadeMaxima   INT

/*Para verificar a capacidade m�xima do estacionamento para aquele tipo de ve�culo*/
SELECT @capacidadeMaxima = Iif(@tipoVeiculo = 'moto', capacidade_moto,capacidade_carro)
FROM   localidade
WHERE  identificacao = @nomeEstacionamento

--confer�ncia
SELECT @capacidadeMaxima AS LocataoAtual 

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Agora, substitua o select principal por uma procedure que receba como par�metros de entrada
o tipo do ve�culo ( @tipoVeiculo ) e o nome do estacionamento ( @nomeEstacionamento ) 
e devolva como par�metro de sa�da ( @capacidadeMaxima ) a capacidade m�xima daquele 
estacionamento para aquele tipo de ve�culo.

CREATE OR ALTER PROCEDURE sp_capacidadeMaxima 
	(@nomeEstacionamento VARCHAR(50)
	, @tipoVeiculo VARCHAR(50)
	,@capacidadeMaxima int output)
as BEGIN
	
	/*Para verificar a capacidade m�xima do estacionamento para aquele tipo de ve�culo*/
	SELECT @capacidadeMaxima = IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
	FROM localidade 
	WHERE identificacao = @nomeEstacionamento

end

Seu c�digo deu certo se isso rodar:
DECLARE @tipoVeiculo        VARCHAR(50) = 'moto',
        @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista',
        @capacidadeMaxima   INT

/*Para verificar a capacidade m�xima do estacionamento para aquele tipo de ve�culo*/
EXEC sp_capacidademaxima 
	@nomeEstacionamento
	, @tipoVeiculo
	, @capacidadeMaxima OUTPUT

--confer�ncia
SELECT @capacidadeMaxima AS LocataoAtual 

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 11 - Fun��es e procedimentos - parte 2
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

/*
Relembrem o c�digo da vis�o que devolve o resumo di�rio :
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
/*Que tamb�m foi reescrita como procedure na Aula 09*/
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
-- Exerc�cios
--------------------------------------------------------------------------- 

Unindo as formas aprendidas:
--Vis�o
SELECT * FROM   vw_resumodiario

--Stored Procedure simples
EXEC Sp_resumodiario

--Inline Table Valuable Function
SELECT * FROM dbo.Tvf_resumodiario_inline()

--MultiStatement Table Valuable Function
SELECT * FROM dbo.Tvf_resumodiario_multistatement()

Algumas destas permitem filtros ap�s a devolu��o, ou seja, depois de executadas 
Ex: 	SELECT * FROM   vw_resumodiario WHERE ... 
Outras permitem a passagem de par�metros para filtrar os resultados internamente, desde que sejam recebidos como par�metros:
Ex: 	EXEC Sp_resumodiario @dia

-------------------------------------------------------------------------- 
-- Exerc�cios
--------------------------------------------------------------------------- 

--Agora suponha que s� nos interesse dados de um dia em espec�fico.
DECLARE @dia DATE = '28/04/2021' 
--Demonstre uma forma de utiliza��o das duas fun��es ( inline e multistatemente ) utilizando filtros simples ( WHERE ), de forma que apenas aquele dia seja devolvido.

--Inline Table Valuable Function
SELECT * FROM dbo.Tvf_resumodiario_inline() 
WHERE SUBSTRING(resumoDiario,CHARINDEX(convert(varchar, @dia, 103),resumoDiario,1),LEN(convert(varchar, @dia, 103)))= convert(varchar, @dia, 103)

--MultiStatement Table Valuable Function
SELECT * FROM dbo.Tvf_resumodiario_multistatement() 
WHERE SUBSTRING(resumoDiario,CHARINDEX(convert(varchar, @dia, 103),resumoDiario,1),LEN(convert(varchar, @dia, 103)))= convert(varchar, @dia, 103)

--Depois altere-as para que elas recebam tal dia como par�metro e devolvam no relat�rio, dados apenas daquele dia:

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

-- Declarando Vari�vel Table do TYPE criado 
DECLARE @TB PADRAOPRODUTO 

INSERT @TB (produto, valor) 
VALUES ('Caderno', 15.5) 

SELECT * FROM   @TB 
--------------------------------------------------------------------------- 

/*	Procedimentos - Par�metros do tipo Tabela
	Vamos supor que, ao inv�s de um �nico dia, tenhamos que filtrar m�ltiplos dias
	Devo criar um Type do tipo tabela para que seja passado como par�metro para 
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
EXEC Sp_resumodiario_ParamTable @dias --> par�metro do tipo tabela.
GO

--------------------------------------------------------------------------- 

/*	Procedimentos - Salvando o resultado em tabelas 

	Procedures tamb�m permitem que seus resultados sejam filtrados ap�s sua execu��o,
	ou seja, sem a necessidade de sempre terem um par�metro de entrada

	Por�m, para isso, elas devem ter seus valores salvos em uma uma estrutura
	seja ela uma tabela tempor�ria ou vari�vel e s� ai, os filtros ( WHERE )
	podem ser aplicados
*/

CREATE TABLE #resultadoProcedure ( resumoDiario VARCHAR(MAX) )

INSERT #resultadoProcedure(resumoDiario )
EXEC Sp_resumodiario

SELECT * FROM #resultadoProcedure WHERE...

--------------------------------------------------------------------------- 

/*	Procedimentos - comando RETURN */

Dentro de Procedimentos armazenados, o comando RETURN encerra o fluxo de execu��o
e retorna o controle para quem chamou a procedure.

ele � normalmente utilizado para:
	Encerrar sua execu��o ap�s detec��o de problemas
	indicar sucesso ou falha Ex: return 1 para sucesso ou return 0 para falha

--------------------------------------------------------------------------- 

Exerc�cios para casa:

1- Crie uma fun��o escalar que, dado uma data, devolva o dia da semana
2- Crie uma fun��o tabular (inLine ou Multistatement) que, dado um dia da semana,
	devolva os �ltimos 10 dias passados daquele dia da semana (ex: 10 �ltimas quartas-feiras )
3- Cria uma procedure que receba uma lista de datas ( contendo todos os feriados )
	e um n�mero ( dias �teis para o vencimento de uma fatura, por exemplo)
	, e devolva a data exata do vencimento, n�o contando nem finais de semana, nem os feriados
	contidos na lista recebida.

Crie todas as fun��es ou procedimentos solicitados, teste-os e demonstre que est�o funcionando.






