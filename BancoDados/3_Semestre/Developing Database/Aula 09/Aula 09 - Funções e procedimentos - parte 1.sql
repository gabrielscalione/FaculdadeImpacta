--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 09 - Fun��es e procedimentos - parte 1
--=X=-- 	Utiliza��o de procedures para controle de processos.
--=X=-- 	Utiliza��o de fun��es para automatiza��o de processos de valida��o.
--=X=-- 	Cria��o de procedimentos para manipula��o de processos.
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

/*
ANTES:
	Aula 09 - Sub-selects, pivot e unpivot, Conjuntos, CTE, Apply, tabelas derivadas.
		Uso de sub-selects: escalar, lista e tabular	
		Manipula��o de conjuntos.
		Comparativo entre JOIN e Subqueries.
	Aula 10 - AC3 - Revis�o aulas 08 e 09
	Aula 11 - Fun��es ( escalar, in-line, multi-statement )
		Cria��o de fun��es e manipula��o de fun��es.
		Utiliza��o de fun��es para automatiza��o de processos de valida��o.
	Aula 12 - Stored Procedures, m�todos acessores.
		Utiliza��o de procedures para controle de processos.
		M�todos acessores.

NOVA PROPOSTA:
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
--=X=-- Aula 09 - Fun��es e procedimentos - parte 1
--=X=-- Recapitulando
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
use ImpactaEstacionamento
GO

Nas Aulas anteriores aprendemos muito conte�do.
Em Ling.SQL voc�s aprenderam sobre o modelo f�sico, as regras de utiliza��o individuais das tabelas, os c�digos b�sicos para manipula��o de dados em instru��es �nicas
Ex:
/*Para verificar a capacidade de uma localidade/estacionamento de um certo tipo de ve�culo em um certo momento Est�o estacionados agora quaisquer ve�culos sem data de sa�da)*/
SELECT Count(*) AS total
FROM   estacionamento
       INNER JOIN veiculo ON idveiculo = veiculo.id
       INNER JOIN localidade ON idlocalidade = localidade.id
WHERE  localidade.identificacao = 'Faculdade Impacta - Paulista'
       AND tipo = 'moto'
       AND datahorasaida IS NULL 
Para mais detalhes, rever aula 01
	Aula 01 - Revisao SQL e entendimento de um banco de dados - corre��o.sql
	Aula 01 - Revisao SQL e entendimento de um banco de dados.sql
	Aula 01 - Revisao SQL e entendimento de um banco de dados - Revis�o Linguagem SQL - GUIA DE ESTUDO.sql
	Aula 01 - Revisao SQL e entendimento de um banco de dados - Entendimento de um banco de dados - GUIA DE ESTUDO.sql


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Depois aprendemos que, para evitar a repeti��o de valores, simplificar a coleta de argumentos ou par�metros, ou mesmo salvar valores para serem usados depois, podemos utilizar vari�veis.
De:	/*coleto o id do estacionamento Posso utiliz�-lo para simpleficar as demas consultas*/
SELECT id FROM   localidade WHERE  identificacao = 'Faculdade Impacta - Paulista'
/*Finalmente, basta inserir a entrada de um ve�culo em uma localidade*/
INSERT INTO estacionamento (idlocalidade,idveiculo,idplano) VALUES ( 1, 11,6 ) 

Para: /* Declaro todas as vari�veis que ser�o utilizadas para coleta de dados */
DECLARE @idLocalidade INT,@idVeiculo INT,@idCategoriaPlano INT,@idPlano INT,@idEstacionamento INT
/*coleto o id do estacionamento Posso utiliz�-lo para simpleficar as demas consultas*/
SELECT @idLocalidade = id FROM   localidade WHERE  identificacao = 'Faculdade Impacta - Paulista'
/*Finalmente, basta inserir a entrada de um ve�culo em uma localidade*/
INSERT INTO estacionamento (idlocalidade, idveiculo,idplano) 
VALUES ( @idLocalidade, @idVeiculo, @idPlano )  
Para mais detalhes, rever aula 02
	Aula 02 - Tipos, Conversoes e Variaveis.sql
Aula 02 - Tipos, Conversoes e Variaveis - corre��o.sql
Aula 02 - Tipos, Conversoes e Variaveis - GUIA DE ESTUDOS.sql
Aula 02 - Tipos, Conversoes e Variaveis - Entendimento do banco de dados, usando vari�veis - GUIA DE ESTUDOS.sql

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Depois aprendemos que, podemos utilizar processos condicionais ( IF ) para desvio de fluxo e criar cl�usulas decis�rias no meio do processo.
Ex: /*declare uma vari�vel para receber o ID do ve�culo*/
DECLARE @idVeiculo INT, @placa     CHAR(15) = 'GHY9543',@tipo      CHAR(5) = 'moto'
IF EXISTS (SELECT id FROM   veiculo WHERE  placa = @placa)
  BEGIN	/* SE o ve�culo j� est� cadastrado, ou seja, n�o � a primeira vez que ele estaciona.
      Basca buscar o id do ve�culo pela placa.*/
      	SELECT @idVeiculo = id FROM   veiculo WHERE  placa = @placa
  END
ELSE
  BEGIN /* SEN�O, caso seja a primeira vez que ele estaciona, � necess�rio estacionar o ve�culo
      	Como � um cliente horista, n�o preciso cadastrar um cliente ( para mensalistas )*/
      	INSERT veiculo (tipo, placa, idcliente) VALUES ( @tipo, @placa, NULL )
      SELECT @idVeiculo = Scope_identity()
  END
/*conclus�o: a vari�vel @idVeiculo tem que conter o ID do ve�culo de placa'GHY6543'
estando ele j� previamente inserido no banco ou n�o. */
Para mais detalhes, rever aula 03
	Aula 03 - Tratamento de nulos e condicionais.sql


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Depois praticamos o que foi aprendido das aulas 01 a 03 na AC1 ( aula 04 ) e revisamos processos de transforma��o de dados utilizando fun��es que facilitam tais processos.
Ex: 
/*Um antigo desenvolvedor, resolveu salvar o documento(CPF) de uma certa pessoa em uma string, sempre no mesmo formato, Ex: DECLARE @CPF VARCHAR(20) = 'CPF: 123.456.789-01'
Por�m, no novo sistema, o CPF deve ser armazenado sem nada al�m de n�meros. ou seja, o correto seria '12345678901'. 
Qual a fun��o para validar tratar a string original s� deixando n�meros independente dos valores de CPF fornecidos ?*/
--A)  
DECLARE @CPF VARCHAR(20) = 'CPF: 123.456.789-01'
SELECT Replace(Replace(Replace(@CPF, 'CPF: ', ''), '.', ''), '-', '')
--B)  
DECLARE @CPF VARCHAR(20) = 'CPF: 123.456.789-01'
SELECT Substring(@CPF, 6, 3) 
+ Substring(@CPF, 10, 3)
       	+ Substring(@CPF, 14, 3) 
+ Substring(@CPF, 18, 2) 
Para mais detalhes, rever aula 04
	Aula 04 - AC1 - revis�o aulas 01 a 03.sql


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Depois aprendemos que podemos utilizar tabelas tempor�rias (#) ou vari�veis do tipo tabela (@), para salvar um conjunto de dados e n�o apenas valores escalares ( �nicos ).
Ex: 
/*Declara��o de vari�vel do tipo tabela para guardar , mesmo que temporariamente, os valores que ser�o retornados. Os tipos de dados devem ser os mesmos dos dados retornados*/
DECLARE @saida TABLE ( id INT );
--Entrada de ve�culos 
/*INSERT COM OUTPUT n�o s� salva os dados na tabela, como 
devolve e exporta para a vari�vel os dados solicitados */
INSERT INTO estacionamento (idlocalidade, idveiculo, idplano)
output      inserted.id INTO @saida(id)
VALUES      ( @idLocalidade,@idVeiculo1, @idPlano )
,( @idLocalidade,@idVeiculo2,@idPlano )
/*A tabela do tipo vari�vel est� dispon�vel para uso 
at� o final deste batch/lote*/
SELECT * FROM   @saida 
Para mais detalhes, rever aula 05
	Aula 05 - Tabelas tempor�rias, vari�veis do tipo tabela, tipos.sql
Aula 05 - Tabelas tempor�rias, vari�veis do tipo tabela, tipos - RESPOSTAS.sql



--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Depois aprendemos que podemos utilizar outras formas de controle de fluxo, como por exemplo gerenciar blocos de repeti��o ( WHILE, CURSOR ).
Ex:  /*Percorrer a tabela, imprimindo PLACA: YJB8742, DIA: 19/02/2021, VALOR RECEBIDO: 0.00 */
DECLARE @ID  INT = 0,@msg VARCHAR(200)
-- Percorrendo todas as linhas da tabela enquanto existir ID superior ao de controle.
WHILE EXISTS (SELECT * FROM   estacionamento WHERE  id > @ID)
  BEGIN
   --Pego o primeiro ID acima do valor atual ( ou seja, os ID da pr�xima linha )
   SELECT @ID = Min(id) FROM   estacionamento WHERE  id > @ID
   SELECT @msg = 'PLACA: ' + veiculo.placa + ', DIA: ' + CONVERT(VARCHAR(10), datahoraentrada, 103)
                 + ', VALOR RECEBIDO: ' + Cast(valorcobrado AS VARCHAR(15))
   FROM   estacionamento
          INNER JOIN veiculo ON estacionamento.idveiculo = veiculo.id
   WHERE  estacionamento.id = @ID
   --imprimir algo como PLACA: YJB8742, DIA: 19/02/2021, VALOR RECEBIDO: 0.00
   PRINT @msg
  END 
Para mais detalhes, rever aula 06
	Aula 06 - Controle de fluxo.sql
Aula 06 - Controle de fluxo - CORRECAO.sql



--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Depois aprendemos a simular, na AC2, as etapas de aquisi��o de dados, entendimento e tratamento dos dados utilizando parte do conhecimento adquirido nas aulas anteriores.
Entendimento do neg�cio:
Acessem: http://archive.ics.uci.edu/ml/datasets/in-vehicle+coupon+recommendation
Objetivo � determinar sob quais condi��es espec�ficas um cupom de desconto tem mais chances de serem 'bem aceitos'
quando oferecidos aos motoristas por seus pr�prios  dispositivos internos do carro.
Ex:	Se	O cliente vai � uma cafeteria mais de uma vez por m�s
		E seu destino n�o � algo espec�fico nem urgente
		(indo para casa talvez )
		E n�o h� crian�as como passageiro 
	OU
		O cliente vai � uma cafeteria mais de uma vez por m�s
		O tempo de expira��o do cupon � de 1 dia 		
	ENT�O
		Predizer se o cliente ir� aceitar o cupon para a cafeteria.

Para mais detalhes, rever aula 07
	Aula 07 - AC2 - revis�o aulas 05 a 06.sql
Aula 07 - AC2 - revis�o aulas 05 a 06 - CORRECAO.sql

Depois aprendemos a simular, na AC2, as etapas de aquisi��o de dados, entendimento e tratamento dos dados utilizando parte do conhecimento adquirido nas aulas anteriores.
Aquisi��o dos dados:
Em Data Folder > de download do arquivo: in-vehicle-coupon-recommendation.csv
( http://archive.ics.uci.edu/ml/machine-learning-databases/00603/in-vehicle-coupon-recommendation.csv )
NO SSSM ( SQL Server Management Studio )
Expandir aba Databases, clicar com o bot�o direito sobre o banco AC2
selecionar Tarefas > Importar dados.
Cliquem em NEXT > Flat File Source > Aponte para o nome do arquivo > NEXT > NEXT
OLE DB PROVIDER ou NATIVE CLIENT > Se autentique no seu servidor > banco AC2
NEXT > NEXT > FINISH > CLOSE

--Testes:
USE AC2
GO
select * from [in-vehicle-coupon-recommendation]
Para mais detalhes, rever aula 07
	Aula 07 - AC2 - revis�o aulas 05 a 06.sql
Aula 07 - AC2 - revis�o aulas 05 a 06 - CORRECAO.sql

Depois aprendemos a simular, na AC2, as etapas de aquisi��o de dados, entendimento e tratamento dos dados utilizando parte do conhecimento adquirido nas aulas anteriores.
Entendimento dos dados:
Seu empregador deseja a constru��o de testes apenas para bares, e apenas com alguns vari�veis, ent�o s� algumas 
colunas da base ser�o usadas, s�o elas:
-- Destino do ve�culo
	destination:	No Urgent Place, Home, Work
-- Quem s�o os passageiros neste momento com o motorista
	passanger:		Alone, Friend(s), Kid(s), Partner 
--	Tempo de expira��o do cupom ( 1 dia ou 2 horas )
	expiration:		1d, 2h 
--	Hora da oferta do cupom
	time: 2PM, 10AM, 6PM, 7AM, 10PM
...etc


Para mais detalhes, rever aula 07
	Aula 07 - AC2 - revis�o aulas 05 a 06.sql
Aula 07 - AC2 - revis�o aulas 05 a 06 - CORRECAO.sql


Tratamento dos dados:
Para transforma��es como as da coluna income ( renda ).
E sua divis�o em duas colunas, como sugerido:
	Income			-> 	RendaMin	RendaMax
---------------				---------------	----------------
$62500 - $74999			62500		74999
	Less than $12500			0		12500
	$100000 or More			100000	250000
DECLARE @income_caso1 VARCHAR(50) = '$62500 - $74999'
SELECT @income_caso1 = Replace(@income_caso1, '$', '')
SELECT CONVERT(DECIMAL(9, 2)
, Substring (@income_caso1, 0,Charindex(' - ', @income_caso1, 0))) AS RendaMin
, CONVERT(DECIMAL(9, 2)
, Substring (@income_caso1
,Charindex(' - ', @income_caso1,0) + 3, Len( @income_caso1))
) AS RendaMax 
Para mais detalhes, rever aula 07
	Aula 07 - AC2 - revis�o aulas 05 a 06.sql
Aula 07 - AC2 - revis�o aulas 05 a 06 - CORRECAO.sql


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Depois aprendemos sobre transa��es e de formas de garantir a execu��o de blocos de c�digo pelas premissas do ACID,  isolados de demais processos, com tratamento de erros.
Ex: 
BEGIN TRAN
DECLARE @linhasAfetadas INT = 0
SELECT @linhasAfetadas = Count(*) ROM   estacionamento WHERE  idveiculo = 1

UPDATE estacionamento SET    valorcobrado += 0.10

IF @@ROWCOUNT = @linhasAfetadas
COMMIT
ELSE
ROLLBACK

IF @@TRANCOUNT > 0
 RAISERROR('OOps, voc� n�o deveria ainda estar dentro de uma transa��o',16, 1) 
Para mais detalhes, rever aula 08
	Aula 08 - Transa��es e tratamento de erros.sql
Aula 08 - Transa��es e tratamento de erros - Exerc�cios.sql



--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Depois aprendemos sobre gera��o, captura e tratamento de erros.
Ex: 
BEGIN try
    -- Generate a divide-by-zero error.  
    SELECT 1 / 0;
END try
BEGIN catch
    SELECT Error_number()    AS ErrorNumber,
           Error_severity()  AS ErrorSeverity,
           Error_state()     AS ErrorState,
           Error_procedure() AS ErrorProcedure,
           Error_line()      AS ErrorLine,
           Error_message()   AS ErrorMessage;

    THROW;
END catch;
go 
Para mais detalhes, rever aula 08
	Aula 08 - Transa��es e tratamento de erros.sql
Aula 08 - Transa��es e tratamento de erros - Exerc�cios.sql

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 09 - Fun��es e procedimentos - parte 1 - fun��es
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
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

CREATE OR ALTER FUNCTION [dbo].[fn_mes_numero_para_palavra] (@numMes tinyint, @idioma tinyint= 1)
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

Seu c�digo deu certo se isso rodar:
	DECLARE @tipoVeiculo VARCHAR(50) = 'moto'
			, @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista'
			, @capacidadeMaxima INT
	/*Para verificar a capacidade m�xima do estacionamento para aquele tipo de ve�culo*/
	SELECT @capacidadeMaxima = dbo.fn_capacidadeMaxima( @nomeEstacionamento, @tipoVeiculo )

	--confer�ncia
	select @capacidadeMaxima as LocataoAtual

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 09 - Fun��es e procedimentos - parte 2 - procedimentos
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

CREATE OR ALTER PROCEDURE sp_saidaVeiculo ( @idEstacionamento INT )
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
Declare @idEstacionamento INT = (select TOP 1 id from estacionamento where dataHoraSaida is null) 
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
		,	@placaVeiculo VARCHAR(50) = 'GHY6543'
		,	@tipoVeiculo VARCHAR(50) = 'moto'

EXEC sp_UpsertVeiculo @tipoVeiculo, @placaVeiculo, @idVeiculo OUTPUT

SELECT @idVeiculo as ID

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Exerc�cios:

Agora seja esta [ MESMA ] query para buscar a capacidade m�xima do estacionamento:
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

Seu c�digo deu certo se isso rodar:
DECLARE @tipoVeiculo        VARCHAR(50) = 'moto',
        @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista',
        @capacidadeMaxima   INT

/*Para verificar a capacidade m�xima do estacionamento para aquele tipo de ve�culo*/
EXEC sp_capacidademaxima @nomeEstacionamento, @tipoVeiculo, @capacidadeMaxima OUTPUT

--confer�ncia
SELECT @capacidadeMaxima AS LocataoAtual 


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Agora que tal um desafio ?
Crie uma procedure que receba os valores fornecidos na entrada de um ve�culo no estacionamento, ou seja:
/* Declaro vari�veis para indicar os dados que ser�o recebidos pelo processo
*/
DECLARE @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista',
        @categoriaPlano     VARCHAR(50) = 'Avulso Horista',
        @placaVeiculo       VARCHAR(50) = 'GHY6543',
        @tipoVeiculo        VARCHAR(50) = 'moto' 

E devolva o ID do estacionamento ou uma mensagem de erro caso ele n�o possa estacionar.
DECLARE @idEstacionamento INT

EXEC sp_estacionaVeiculo 
	@nomeEstacionamento
	, @categoriaPlano
	, @placaVeiculo
	, @tipoVeiculo
	, @idEstacionamento OUTPUT

SELECT @idEstacionamento AS ID

Como refer�ncia usem o c�digo atualizado no FINAL do arquivo:  
Aula 08 - Transa��es e tratamento de erros - Exerc�cios.sql

