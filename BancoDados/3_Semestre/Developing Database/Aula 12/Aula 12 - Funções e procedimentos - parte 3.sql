--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 12 - Fun��es e procedimentos - parte 3
--=X=-- 	Exerc�cios de fixa��o sobre fun��es e procedures 
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

-------------------------------------------------------------------------- 
-- Corre��o Exerc�cios para casa
--------------------------------------------------------------------------- 

1- Crie uma fun��o escalar que, dado uma data, devolva o dia da semana.

Planejamento: 
	par�metros de entrada <- Data = DATETIME -- EX: 15/02/1989
	Par�metros de sa�da -> dia da semana = TEXTO = VARCHAR --EX: Quarta-feira
	Tipo de fun��o
		S� devolvo 1 valor ( e n�o uma lista ou tabela ) = ESCALAR
	Pesquisa - fun��es de data --Descobrir como chegar ao dia da semana.
		Rever: Aula 01 - Revisao SQL e entendimento de um banco de dados - Revis�o Linguagem SQL - GUIA DE ESTUDO.sql
			DATEPART(datepart,date )
			DATENAME ( datepart , date )  
				datepart	Abrevia��es
				----------- -------------
				year		yy, yyyy
				month		mm, m
				day			d, d
				week		wk, ww
				weekday		dw
				...
		Google: mssql fun��es de data dia da semana
			https://docs.microsoft.com/pt-br/sql/t-sql/functions/datepart-transact-sql?view=sql-server-ver15			
	Testes iniciais:
		select datepart(dw,getdate()) --descobrir o n�mero do dia da semana
		select datename(dw,getdate()) --descobrir o nome do dia da semana
		OU
		select datepart(weekday,getdate()) --descobrir o n�mero do dia da semana
		select datename(weekday,getdate()) --descobrir o nome do dia da semana

GO
--Implementa��o: vers�o simplificada
CREATE OR ALTER FUNCTION fn_escalar_diaSemana_v1 ( @data datetime )
RETURNS VARCHAR(25)
AS BEGIN
	RETURN DATENAME(dw,@data)
END
GO
--Implementa��o: vers�o com condicionais
CREATE OR ALTER FUNCTION fn_escalar_diaSemana_v2 ( @data datetime )
RETURNS VARCHAR(25)
AS BEGIN
	DECLARE @diaSemana VARCHAR(25)
	SELECT @diaSemana = case datepart(dw,@data)
				when 1 then 'Domingo'
				when 2 then 'Segunda-Feira'
				when 3 then 'Ter�a-Feira'
				when 4 then 'Quarta-Feira'
				when 5 then 'Quinta-Feira'
				when 6 then 'Sexta-Feira'
				when 7 then 'S�bado'
			END
	RETURN @diaSemana
END
GO

--Testes finais;
	SELECT	dbo.fn_escalar_diaSemana_v1(GETDATE())
			, dbo.fn_escalar_diaSemana_v1('15/02/1989')
	SELECT dbo.fn_escalar_diaSemana_v2(GETDATE())
			, dbo.fn_escalar_diaSemana_v2('15/02/1989')

--------------------------------------------------------------------------- 

2- Crie uma fun��o tabular (inLine ou Multistatement) que
	, dado um dia da semana,devolva os �ltimos 10 dias passados 
	daquele dia da semana (ex: 10 �ltimas quartas-feiras )

Planejamento: 
	par�metros de entrada <- Dia da semana = TEXTO = VARCHAR 
		--EX: Quarta-feira
	Par�metros de sa�da -> Lista de Dias = DATA/DATETIME 
		--EX: 05/05/2021, 28/04/2021, , 21/04/2021etc
	Tipo de fun��o
		Devolvo uma lista de valores = inLine ou Multistatement
		Pela l�gica ( ver abaixo ) vou precisar de mais do que 1 comando ( statement ) 
			para concluir o processo, ou seja
			vou precisar de usar: IF, CASE, WHILE, etc
		Tipo de fun��o recomendada: Multistatement
	Pesquisa - fun��es de data --Descobrir como chegar ao dia da semana.
		Rever: Aula 01 - Revisao SQL e entendimento de um banco de dados - Revis�o Linguagem SQL - GUIA DE ESTUDO.sql
			DATEPART(datepart,date )
			DATEADD(datepart,date )
	Google: mssql fun��es de data subtra��o
		https://docs.microsoft.com/pt-br/sql/t-sql/functions/dateadd-transact-sql?view=sql-server-ver15
	Testes iniciais:
		SELECT DATEADD(WEEK,1,GETDATE())  --somar uma semana � uma data atual
		SELECT DATEADD(WEEK,-1,GETDATE()) --subtrair uma semana � uma data atual
	Testes da l�gica:
		Caso f�cil
			Se hoje � quarta-feira e eu recebi como par�metro quarta-feira
			ou seja, nenhum ajuste de data � necess�rio
			basta subtrair 1 semana 10x e devolver as datas coletadas.
			Testes:
				DECLARE @SemanasNoPassado SMALLINT = 0	--Valor inicial
				WHILE ( @SemanasNoPassado > -10 )			--Condi��o de parada
				BEGIN
					SELECT DATEADD(week,@SemanasNoPassado,GETDATE()) --Calculo da Data	
					SET @SemanasNoPassado -= 1				--Decremento
				END	
		Caso dif�cil
			Se hoje � quarta-feira e eu recebi como par�metro quinta-feira
				devo descobrir qual foi a �ltima quinta-feira
				tal data estar� de 1 a 6 dias no passado
			e a partir dela subtrair 1 semana 10x e devolver as datas coletadas
			Testes:
			L�gica de resolu��o 1 - (repeti��o / tentativa e erro)
				Se tal data esta de 1 a 6 dias no passado
				Volto 1 dia de cada vez, at� bater o dia da semana
				Ent�o, continuo a subtrair 1 semana 10x e devolver as datas coletadas 
			DECLARE @diaSemanaAtual VARCHAR(25) = dbo.fn_escalar_diaSemana_v1(GETDATE())
					, @diaSemanaDesejado VARCHAR(25) = 'quinta-feira'
					, @diasNoPassado SMALLINT = 0
			WHILE ( @diaSemanaAtual <> @diaSemanaDesejado )
			BEGIN
				SET @diasNoPassado += 1
				SELECT @diaSemanaAtual = dbo.fn_escalar_diaSemana_v1(GETDATE()-@diasNoPassado)
			END
			SELECT	@diasNoPassado
					, dbo.fn_escalar_diaSemana_v1(GETDATE()-@diasNoPassado)

			L�gica de resolu��o 2 - (matem�tica)
				Calculo a diferen�a em dias pelo dia da semana
				Dia da semana atual - Dia da semana desejado
					Se positivo --Ex: dia da quarta (4) - ter�a(3) = +1
						A diferen�a � a quantidade de dias no passado 
							at� o dia da semana desejado
					Se negativo --Ex: dia da quarta (4) - quinta(5) = -1
						A diferen�a � a quantidade de dias a partir 
							da semana passada para chegar ao dia da semana.
				OU, usando matem�gica
					(7 + ( dia da semana atual - dia da semana desejado )) % 7
			DECLARE @diaSemanaAtual VARCHAR(25) = dbo.fn_escalar_diaSemana_v1(GETDATE())
					, @diaSemanaDesejado VARCHAR(25) = 'quinta-feira'
					, @diasNoPassado SMALLINT = 0	
			--Como esta solu��o usa o n�mero do dia da semana e n�o o nome
			-- � preciso realizar a convers�o "de volta".
			DECLARE @numeroDiaSemanaAtual SMALLINT = 
				case @diaSemanaAtual when 'Domingo' then 1
					when 'Segunda-feira' then 2 when 'Ter�a-feira' then 3
					when 'Quarta-feira' then 4 when 'Quinta-feira' then 5
					when 'Sexta-feira' then 6 when 'S�bado' then 7
				end
			DECLARE @numeroDiaSemanaDesejado SMALLINT= 
				case @diaSemanaDesejado when 'Domingo' then 1
					when 'Segunda-feira' then 2 when 'Ter�a-feira' then 3
					when 'Quarta-feira' then 4 when 'Quinta-feira' then 5
					when 'Sexta-feira' then 6 when 'S�bado' then 7
				end
			select @diaSemanaAtual, @numeroDiaSemanaAtual 
			select @diaSemanaDesejado, @numeroDiaSemanaDesejado

			SET @diasNoPassado = (7 + ( @numeroDiaSemanaAtual - @numeroDiaSemanaDesejado )) %7
			SELECT @diasNoPassado					
					, dbo.fn_escalar_diaSemana_v1(GETDATE()-@diasNoPassado)
			
--Implementa��o L�gica de resolu��o 1 - (repeti��o / tentativa e erro)
CREATE OR ALTER FUNCTION tvf_multiStatement_Ultimos10PeloDiaSemana_v1 ( @diaSemanaDesejado VARCHAR(25) )
RETURNS @ListaDias TABLE ( Dia DATE )
AS BEGIN

	DECLARE @diaSemanaAtual VARCHAR(25) = dbo.fn_escalar_diaSemana_v1(GETDATE())
			, @diasNoPassado SMALLINT = 0
	WHILE ( @diaSemanaAtual <> @diaSemanaDesejado )
	BEGIN
		SET @diasNoPassado += 1
		SELECT @diaSemanaAtual = dbo.fn_escalar_diaSemana_v1(GETDATE()-@diasNoPassado)
	END

	DECLARE @SemanasNoPassado SMALLINT = 0		--Valor inicial
	WHILE ( @SemanasNoPassado > -10 )			--Condi��o de parada
	BEGIN
		INSERT @ListaDias(dia)
		SELECT DATEADD(week,@SemanasNoPassado,GETDATE()-@diasNoPassado) --Calculo da Data	
		SET @SemanasNoPassado -= 1				--Decremento
	END	
	RETURN
END
GO
--Testes
SELECT * FROM dbo.tvf_multiStatement_Ultimos10PeloDiaSemana_v1('quinta-feira')
GO
SELECT * FROM dbo.tvf_multiStatement_Ultimos10PeloDiaSemana_v1('domingo')
GO

--Implementa��o L�gica de resolu��o 2 - (matem�tica)
CREATE OR ALTER FUNCTION tvf_multiStatement_Ultimos10PeloDiaSemana_v2 ( @diaSemanaDesejado VARCHAR(25) )
RETURNS @ListaDias TABLE ( Dia DATE )
AS BEGIN

		DECLARE @diaSemanaAtual VARCHAR(25) = dbo.fn_escalar_diaSemana_v1(GETDATE())
				, @diasNoPassado SMALLINT = 0	
		--Como esta solu��o usa o n�mero do dia da semana e n�o o nome
		-- � preciso realizar a convers�o "de volta".
		DECLARE @numeroDiaSemanaAtual SMALLINT = 
			case @diaSemanaAtual when 'Domingo' then 1
				when 'Segunda-feira' then 2 when 'Ter�a-feira' then 3
				when 'Quarta-feira' then 4 when 'Quinta-feira' then 5
				when 'Sexta-feira' then 6 when 'S�bado' then 7
			end
		DECLARE @numeroDiaSemanaDesejado SMALLINT= 
			case @diaSemanaDesejado when 'Domingo' then 1
				when 'Segunda-feira' then 2 when 'Ter�a-feira' then 3
				when 'Quarta-feira' then 4 when 'Quinta-feira' then 5
				when 'Sexta-feira' then 6 when 'S�bado' then 7
			end

		SET @diasNoPassado = (7 + ( @numeroDiaSemanaAtual - @numeroDiaSemanaDesejado )) %7

		DECLARE @SemanasNoPassado SMALLINT = 0	--Valor inicial
		WHILE ( @SemanasNoPassado > -10 )			--Condi��o de parada
		BEGIN
			INSERT @ListaDias(dia)
			SELECT DATEADD(week,@SemanasNoPassado,GETDATE()-@diasNoPassado) --Calculo da Data	
			SET @SemanasNoPassado -= 1				--Decremento
		END	
		RETURN
END
GO
--Testes
SELECT * FROM dbo.tvf_multiStatement_Ultimos10PeloDiaSemana_v2('quinta-feira')
GO
SELECT * FROM dbo.tvf_multiStatement_Ultimos10PeloDiaSemana_v2('domingo')
GO

--------------------------------------------------------------------------- 

3- Cria uma procedure que receba uma lista de datas ( contendo todos os feriados )
	e um n�mero ( dias �teis para o vencimento de uma fatura, por exemplo)
e devolva a data exata do vencimento, n�o contando nem finais de semana, nem os feriados
	contidos na lista recebida.

Crie todas as fun��es ou procedimentos solicitados, teste-os e demonstre que est�o funcionando.

Planejamento: 
	par�metros de entrada 
		<- Lista de datas ( tabela ) = os feriados --Ex: 21/04/2021, 01/05/2021, ...
		<- n�mero de dias ( inteiro ) = vencimento em dias --Ex: 7
	Par�metros de sa�da 
		-> data do vencimento ( ignorando finais de semana e feriados )	--EX: 07/05/2021
	Tipo de procedure
		Diferente de fun��es, procedures n�o tem tipos.
	Pesquisa
		Rever: Aula 01 - Revisao SQL e entendimento de um banco de dados - Revis�o Linguagem SQL - GUIA DE ESTUDO.sql
			DATEPART(datepart,date )
			DATEADD(datepart,date )
		Rever: Aula 05 - Tabelas tempor�rias, vari�veis do tipo tabela, tipos.sql
	Testes da l�gica:
		Contador de dias �teis ( while que testa dia a dia )
		Enquanto n�o conseguir avan�ar X dias �teis
			Se hoje n�o � feriado, nem emenda ( lista recebida de par�metro )
				nem � final de semana ( s�bado ou domingo )
			Conto +1 ao contador de dias �teis
		Devolvo a data final.
			DECLARE @DataVencimento DATE = GETDATE()
					, @contadorDiasUteis SMALLINT = 1
					, @VencimentoEmDiasUteis SMALLINT = 7
			DECLARE @listaFeriados TABLE ( Dia DATE )
				INSERT INTO @listaFeriados ( DIA ) VALUES ( '21/04/2021'), ('01/05/2021')
			WHILE ( @contadorDiasUteis <= @VencimentoEmDiasUteis )
			BEGIN
				SET @DataVencimento = DATEADD(day,1,@DataVencimento)
				IF (@DataVencimento NOT IN ( SELECT dia FROM @listaFeriados )
					AND dbo.fn_escalar_diaSemana_v1(@DataVencimento) NOT IN ( 's�bado', 'domingo' )
				)
					SET @contadorDiasUteis += 1
			END
			SELECT	@DataVencimento as DataVencimento
					, dbo.fn_escalar_diaSemana_v1(@DataVencimento)
					, @contadorDiasUteis
					, @VencimentoEmDiasUteis
	Carga de dados
		Lista de feriados e pontos facultativos:
		https://www.metropoles.com/brasil/feriados-2021

		DECLARE @listaFeriados TABLE ( Dia DATE, Motivo Varchar(255) )
		INSERT INTO @listaFeriados ( Dia, Motivo ) 
		VALUES ( '01/01/2021', 'Confraterniza��o Universal (feriado nacional)')
			, ('15/02/2021', 'Carnaval (ponto facultativo)')
			, ('16/02/2021', 'Carnaval (ponto facultativo)')
			, ('17/02/2021', 'quarta-feira de cinzas (ponto facultativo at� as 14h)')
			, ('02/04/2021', 'Paix�o de Cristo (feriado nacional)')
			, ('21/04/2021', 'Tiradentes (feriado nacional)')
			, ('01/05/2021', 'Dia Mundial do Trabalho (feriado nacional)')
			, ('03/06/2021', 'Corpus Christi (ponto facultativo)')
			, ('07/09/2021', 'Independ�ncia do Brasil (feriado nacional)')
			, ('12/10/2021', 'Nossa Senhora Aparecida (feriado nacional)')
			, ('28/10/2021', 'Dia do Servidor P�blico � art. 236 da Lei n� 8.112, de 11 de dezembro de 1990, a ser comemorado no dia 01 de novembro (ponto facultativo)')
			, ('02/11/2021', 'Finados (feriado nacional)')
			, ('15/11/2021', 'Proclama��o da Rep�blica (feriado nacional)')
			, ('24/12/2021', 'v�spera de natal (ponto facultativo ap�s �s 14h)')
			, ('25/12/2021', 'Natal (feriado nacional)')
			, ('31/12/2021', 'v�spera de ano novo (ponto facultativo ap�s �s 14h)')
		select * FROM @listaFeriados

	Cria��o do tipo de dados para lista de feriados
		CREATE TYPE listaDatas AS TABLE ( Dia DATE, Motivo Varchar(255) )

--Implementa��o 
CREATE OR ALTER PROCEDURE sp_vencimentoemDiasUteis 
	(	@listaFeriados listaDatas READONLY
		, @VencimentoEmDiasUteis SMALLINT 
		, @DataVencimento DATE OUTPUT
	)
AS BEGIN
	DECLARE @contadorDiasUteis SMALLINT = 1
	SET @DataVencimento = GETDATE()

	WHILE ( @contadorDiasUteis <= @VencimentoEmDiasUteis )
	BEGIN
		SET @DataVencimento = DATEADD(day,1,@DataVencimento)
		IF (@DataVencimento NOT IN ( SELECT dia FROM @listaFeriados )
			AND dbo.fn_escalar_diaSemana_v1(@DataVencimento) NOT IN ( 's�bado', 'domingo' )
		)
			SET @contadorDiasUteis += 1
	END
END
GO

--Uso da procedure
		DECLARE @listaFeriados listaDatas
		INSERT INTO @listaFeriados ( Dia, Motivo ) 
		VALUES ( '01/01/2021', 'Confraterniza��o Universal (feriado nacional)')
			, ('15/02/2021', 'Carnaval (ponto facultativo)')
			, ('16/02/2021', 'Carnaval (ponto facultativo)')
			, ('17/02/2021', 'quarta-feira de cinzas (ponto facultativo at� as 14h)')
			, ('02/04/2021', 'Paix�o de Cristo (feriado nacional)')
			, ('21/04/2021', 'Tiradentes (feriado nacional)')
			, ('01/05/2021', 'Dia Mundial do Trabalho (feriado nacional)')
			, ('03/06/2021', 'Corpus Christi (ponto facultativo)')
			, ('07/09/2021', 'Independ�ncia do Brasil (feriado nacional)')
			, ('12/10/2021', 'Nossa Senhora Aparecida (feriado nacional)')
			, ('28/10/2021', 'Dia do Servidor P�blico � art. 236 da Lei n� 8.112, de 11 de dezembro de 1990, a ser comemorado no dia 01 de novembro (ponto facultativo)')
			, ('02/11/2021', 'Finados (feriado nacional)')
			, ('15/11/2021', 'Proclama��o da Rep�blica (feriado nacional)')
			, ('24/12/2021', 'v�spera de natal (ponto facultativo ap�s �s 14h)')
			, ('25/12/2021', 'Natal (feriado nacional)')
			, ('31/12/2021', 'v�spera de ano novo (ponto facultativo ap�s �s 14h)')

		DECLARE @DataVencimento DATE
		EXEC sp_vencimentoemDiasUteis 
				@listaFeriados 
				, 7
				, @DataVencimento OUTPUT
		SELECT @DataVencimento as DataVencimento
				, dbo.fn_escalar_diaSemana_v1(@DataVencimento)

-------------------------------------------------------------------------- 
-- Extens�o - Exerc�cios
--------------------------------------------------------------------------- 

4.	Criar uma fun��o com a fun��o similar � da quest�o 1.
	Ou seja, uma fun��o escalar que, dado um dia da semana
	devolva o n�mero daquele dia da semana.
	Ex:	select dbo.fn_escalar_numeroDiaSemana('domingo') --> 1
	
5.	Altere a fun��o tvf_multiStatement_Ultimos10PeloDiaSemana_v2
	para ao inv�s de calcular internamente o n�mero do dia da semana,
	agora ela passe a usar a fun��o recem criada no item 4.
	Ela deve manter sua funcionalidade:
	SELECT * FROM dbo.tvf_multiStatement_Ultimos10PeloDiaSemana_v2('domingo')

6.	Crie uma nova procedure sp_vencimentoemDiasUteis_v2
	Por�m, esta n�o recebe mais a lista de feriados ( e pontos facultativos )
	como par�metro, tais dados devem ser salvos em uma tabela tradicional.
	Ela deve passar a receber um par�metro de uma data inicial
	Ela deve continuar recebendo o par�metro de vencimento em dias uteis
	Ela deve continuar devolvendo a Data de vencimento.
	Por�m, tal vencimento agora � calculado � partir da inicial fornecida
	como par�metro.
		DECLARE @DataInicial DATE = GETDATE(), @DiasVencimento SMALLINT= 7, @DataVencimento DATE
		EXEC sp_vencimentoemDiasUteis_v2 @DataInicial, @DiasVencimento, @DataVencimento OUTPUT
		SELECT @DataVencimento as DataVencimento

7. Crie um novo procedimento que receba 2 argumentos:
		Dia �til do m�s - n�mero cardinal ( 5� dia, 10� dia, 20�dia )
		N�mero de parcelas ( n�mero de futuros vencimentos )
	Devolva uma lista de X vencimentos no dia especificado
	pulando feriados e finais de semana.
	Para simplificar, n�o h� vencimentos no m�s atual
		, ou seja, todas as parcelas vencem a partir do m�s seguinte.
		DECLARE @DiaUtilVencimento SMALLINT= 10
				, @numeroParcelas SMALLINT = 10
		CREATE TABLE #DatasVencimento ( dia DATE )
		INSERT INTO #DatasVencimento
		EXEC sp_calculaDatasVencimento @DiaUtilVencimento, @numeroParcelas
		SELECT * from #DatasVencimento

8. Altere o procedimento criado na quest�o 7 para que ele:
	- Devolva um erro caso o dia �til do m�s n�o seja 5,10,15,20
	- Devolve um erro caso o n�mero de parcelas seja superior � 12
		DECLARE @DiaUtilVencimento SMALLINT= 21 --ERRO
				, @numeroParcelas SMALLINT = 13 --ERRO

-------------------------------------------------------------------------- 
-- Extens�o - Exerc�cios para casa
--------------------------------------------------------------------------- 
use ImpactaEstacionamento
go

Especifica��o:
Para completar a implementa��o de contratos, habilitando assim a fun��o
de planos para mensalistas, s�o necess�rios:
- Dado uma localidade('Faculdade Impacta - Paulista')
	, um cliente('Almir dos Santos') 
	e uma categoria ( 'Mensalista Professor' )
- Cadastrar um contrato com vencimento padr�o = anual ( 12 meses )
	para o plano vigente atual daquela categoria.
- Cada contrato j� deve ter todas as mensalidades futuras pr�-calculadas
  e inseridas.
- Os vencimentos das mensalidades s� podem ser em dias �teis (5�, 10�, 15�, 20�)
	ou seja, n�o podem cair em feriados, emendas nem finais de semana.

--------------------------------------------------------------------------- 

Passo 1. Entendimento dos dados
Como registrar contratos e mensalidades (vencimentos) ?

--Identifica��o das categorias cadastradas
select * from categoriaPlano; 
	1	Mensalista Diurno
	2	Mensalista Noturno
	3	Mensalista Professor

--Verifica��o dos planos existentes
select * 
from Plano 
where idCategoria IN ( 
	select id from categoriaPlano where nome = 'Mensalista Professor'
); 

-- Verifica��o dos campos necess�rios para registo do contrato;
sp_help contrato;
id	int --PRIMARY KEY (clustered)
idPlano	int --REFERENCES ImpactaEstacionamento.dbo.Plano (id)
idCliente	int --REFERENCES ImpactaEstacionamento.dbo.cliente (id) 
diaVencimento	tinyint --CHECK ([diaVencimento]=(25) OR [diaVencimento]=(20) OR [diaVencimento]=(15) OR [diaVencimento]=(10) OR [diaVencimento]=(5))
dataContratacao	datetime --DEFAULT (getdate())
dateEncerramento	datetime

-- Verifica��o dos campos necess�rios para registo das mensalidades;
sp_help mensalidade;
id	int
idContrato	int --REFERENCES ImpactaEstacionamento.dbo.contrato (id)
mes	tinyint --CHECK ([mes]>=(1) AND [mes]<=(12))
recebido	bit --DEFAULT ((0))
dataVencimento	datetime
dataPagamento	datetime
valorRecebido	decimal
multa	decimal

--------------------------------------------------------------------------- 

Passo 2. Testes / Carga Manual.

/*Para completar a implementa��o de contratos, habilitando assim a fun��o
de planos para mensalistas, s�o necess�rios:
- Dado uma localidade('Faculdade Impacta - Paulista')
	, um cliente('Almir dos Santos') 
	e uma categoria ( 'Mensalista Professor' )
*/
DECLARE @idLocalidade INT = ( select id from localidade where identificacao = 'Faculdade Impacta - Paulista' )
DECLARE @idCliente INT = ( select id from cliente where nome = 'Almir dos Santos' )
DECLARE @idCategoriaPlano INT = ( select id from CategoriaPlano where nome = 'Mensalista Professor' )

--Descobrir plano atualmente vigente para aquela categoria.
DECLARE @idPlano INT = ( 
	select id
	from Plano
	where	idCategoria = @idCategoriaPlano
			AND ativo = 1
)

-- Cadastrar um contrato com vencimento padr�o = anual ( 12 meses )
--	para o plano vigente atual daquela categoria.
DECLARE @diaVencimento TINYINT = 10
		, @DataContratacao DATETIME = GETDATE()
		, @DataVencimento DATETIME = DATEADD(month,GETDATE()
INSERT INTO contrato ( idPlano, idCliente, diaVencimento, dataContratacao, dateEncerramento )
VALUES ( @idPlano, @idCliente, @diaVencimento, @DataContratacao )

/*Cada contrato j� deve ter todas as mensalidades futuras pr�-calculadas
  e inseridas.
  Os vencimentos das mensalidades s� podem ser em dias �teis (5�, 10�, 15�, 20�)
	ou seja, n�o podem cair em feriados, emendas nem finais de semana.
*/
--Dica, para calcular os vencimentos, podemos usar a procedure da quest�o 7
	DECLARE @DiaUtilVencimento SMALLINT= 10
			, @numeroParcelas SMALLINT = 12
	CREATE TABLE #DatasVencimento ( dia DATE )

	INSERT INTO #DatasVencimento
	EXEC sp_calculaDatasVencimento @DiaUtilVencimento, @numeroParcelas

	SELECT * from #DatasVencimento
	....

-------------------------------------------------------------------------
-- Agora � com voc�s
-------------------------------------------------------------------------

9. completem o teste de inser��o das 12 mensalidades
todas com vencimento para o 10� dia �til de cada m�s.
INSERT INTO mensalidade...

-------------------------------------------------------------------------
10. Criem uma procedure que receba 
 uma localidade('Faculdade Impacta - Paulista')
 um cliente('Almir dos Santos') --Podem cadastrar outros clientes para testes
 uma categoria ( 'Mensalista Professor' )
 um dia �til ( ex: 5� )
 uma dura��o do contrato em meses ( de 1 a 12 )

Cadastre um contrato com vencimento para o plano vigente atual daquela categoria.
	Com dura��o em meses equivalente ao parametro de dura��o do contrato.
Cadastre os vencimentos das mensalidades no dia �til escolhido.

Devolva uma lista com as dastas e valores devidos a cada m�s.
Ex:		15/06/2021		R$100,00 --10� dia �til ( hipot�tico )
		14/06/2021		R$100,00 --10� dia �til ( hipot�tico )
		...

-------------------------------------------------------------------------
11. Altere a procedure criada na quest�o 10 para que ela:
Valide os seguintes erros ( dando uma mensagem de erro espec�fica em caso de n�o conformidade)
 Localidade n�o existente ou n�o cadastrada
 cliente n�o existente ou n�o cadastrado
 categoria n�o existente ou n�o cadastrado
 plano da categoria vigente inexistente ou n�o cadastrado ou sem plano vigente.
 Dia �til deve ser 5,10,15,20
 Dura��o deve ser de 1 a 12









