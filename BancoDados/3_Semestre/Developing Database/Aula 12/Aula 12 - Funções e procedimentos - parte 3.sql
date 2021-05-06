--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 12 - Funções e procedimentos - parte 3
--=X=-- 	Exercícios de fixação sobre funções e procedures 
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

-------------------------------------------------------------------------- 
-- Correção Exercícios para casa
--------------------------------------------------------------------------- 

1- Crie uma função escalar que, dado uma data, devolva o dia da semana.

Planejamento: 
	parâmetros de entrada <- Data = DATETIME -- EX: 15/02/1989
	Parâmetros de saída -> dia da semana = TEXTO = VARCHAR --EX: Quarta-feira
	Tipo de função
		Só devolvo 1 valor ( e não uma lista ou tabela ) = ESCALAR
	Pesquisa - funções de data --Descobrir como chegar ao dia da semana.
		Rever: Aula 01 - Revisao SQL e entendimento de um banco de dados - Revisão Linguagem SQL - GUIA DE ESTUDO.sql
			DATEPART(datepart,date )
			DATENAME ( datepart , date )  
				datepart	Abreviações
				----------- -------------
				year		yy, yyyy
				month		mm, m
				day			d, d
				week		wk, ww
				weekday		dw
				...
		Google: mssql funções de data dia da semana
			https://docs.microsoft.com/pt-br/sql/t-sql/functions/datepart-transact-sql?view=sql-server-ver15			
	Testes iniciais:
		select datepart(dw,getdate()) --descobrir o número do dia da semana
		select datename(dw,getdate()) --descobrir o nome do dia da semana
		OU
		select datepart(weekday,getdate()) --descobrir o número do dia da semana
		select datename(weekday,getdate()) --descobrir o nome do dia da semana

GO
--Implementação: versão simplificada
CREATE OR ALTER FUNCTION fn_escalar_diaSemana_v1 ( @data datetime )
RETURNS VARCHAR(25)
AS BEGIN
	RETURN DATENAME(dw,@data)
END
GO
--Implementação: versão com condicionais
CREATE OR ALTER FUNCTION fn_escalar_diaSemana_v2 ( @data datetime )
RETURNS VARCHAR(25)
AS BEGIN
	DECLARE @diaSemana VARCHAR(25)
	SELECT @diaSemana = case datepart(dw,@data)
				when 1 then 'Domingo'
				when 2 then 'Segunda-Feira'
				when 3 then 'Terça-Feira'
				when 4 then 'Quarta-Feira'
				when 5 then 'Quinta-Feira'
				when 6 then 'Sexta-Feira'
				when 7 then 'Sábado'
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

2- Crie uma função tabular (inLine ou Multistatement) que
	, dado um dia da semana,devolva os últimos 10 dias passados 
	daquele dia da semana (ex: 10 últimas quartas-feiras )

Planejamento: 
	parâmetros de entrada <- Dia da semana = TEXTO = VARCHAR 
		--EX: Quarta-feira
	Parâmetros de saída -> Lista de Dias = DATA/DATETIME 
		--EX: 05/05/2021, 28/04/2021, , 21/04/2021etc
	Tipo de função
		Devolvo uma lista de valores = inLine ou Multistatement
		Pela lógica ( ver abaixo ) vou precisar de mais do que 1 comando ( statement ) 
			para concluir o processo, ou seja
			vou precisar de usar: IF, CASE, WHILE, etc
		Tipo de função recomendada: Multistatement
	Pesquisa - funções de data --Descobrir como chegar ao dia da semana.
		Rever: Aula 01 - Revisao SQL e entendimento de um banco de dados - Revisão Linguagem SQL - GUIA DE ESTUDO.sql
			DATEPART(datepart,date )
			DATEADD(datepart,date )
	Google: mssql funções de data subtração
		https://docs.microsoft.com/pt-br/sql/t-sql/functions/dateadd-transact-sql?view=sql-server-ver15
	Testes iniciais:
		SELECT DATEADD(WEEK,1,GETDATE())  --somar uma semana à uma data atual
		SELECT DATEADD(WEEK,-1,GETDATE()) --subtrair uma semana à uma data atual
	Testes da lógica:
		Caso fácil
			Se hoje é quarta-feira e eu recebi como parâmetro quarta-feira
			ou seja, nenhum ajuste de data é necessário
			basta subtrair 1 semana 10x e devolver as datas coletadas.
			Testes:
				DECLARE @SemanasNoPassado SMALLINT = 0	--Valor inicial
				WHILE ( @SemanasNoPassado > -10 )			--Condição de parada
				BEGIN
					SELECT DATEADD(week,@SemanasNoPassado,GETDATE()) --Calculo da Data	
					SET @SemanasNoPassado -= 1				--Decremento
				END	
		Caso difícil
			Se hoje é quarta-feira e eu recebi como parâmetro quinta-feira
				devo descobrir qual foi a última quinta-feira
				tal data estará de 1 a 6 dias no passado
			e a partir dela subtrair 1 semana 10x e devolver as datas coletadas
			Testes:
			Lógica de resolução 1 - (repetição / tentativa e erro)
				Se tal data esta de 1 a 6 dias no passado
				Volto 1 dia de cada vez, até bater o dia da semana
				Então, continuo a subtrair 1 semana 10x e devolver as datas coletadas 
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

			Lógica de resolução 2 - (matemática)
				Calculo a diferença em dias pelo dia da semana
				Dia da semana atual - Dia da semana desejado
					Se positivo --Ex: dia da quarta (4) - terça(3) = +1
						A diferença é a quantidade de dias no passado 
							até o dia da semana desejado
					Se negativo --Ex: dia da quarta (4) - quinta(5) = -1
						A diferença é a quantidade de dias a partir 
							da semana passada para chegar ao dia da semana.
				OU, usando matemágica
					(7 + ( dia da semana atual - dia da semana desejado )) % 7
			DECLARE @diaSemanaAtual VARCHAR(25) = dbo.fn_escalar_diaSemana_v1(GETDATE())
					, @diaSemanaDesejado VARCHAR(25) = 'quinta-feira'
					, @diasNoPassado SMALLINT = 0	
			--Como esta solução usa o número do dia da semana e não o nome
			-- é preciso realizar a conversão "de volta".
			DECLARE @numeroDiaSemanaAtual SMALLINT = 
				case @diaSemanaAtual when 'Domingo' then 1
					when 'Segunda-feira' then 2 when 'Terça-feira' then 3
					when 'Quarta-feira' then 4 when 'Quinta-feira' then 5
					when 'Sexta-feira' then 6 when 'Sábado' then 7
				end
			DECLARE @numeroDiaSemanaDesejado SMALLINT= 
				case @diaSemanaDesejado when 'Domingo' then 1
					when 'Segunda-feira' then 2 when 'Terça-feira' then 3
					when 'Quarta-feira' then 4 when 'Quinta-feira' then 5
					when 'Sexta-feira' then 6 when 'Sábado' then 7
				end
			select @diaSemanaAtual, @numeroDiaSemanaAtual 
			select @diaSemanaDesejado, @numeroDiaSemanaDesejado

			SET @diasNoPassado = (7 + ( @numeroDiaSemanaAtual - @numeroDiaSemanaDesejado )) %7
			SELECT @diasNoPassado					
					, dbo.fn_escalar_diaSemana_v1(GETDATE()-@diasNoPassado)
			
--Implementação Lógica de resolução 1 - (repetição / tentativa e erro)
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
	WHILE ( @SemanasNoPassado > -10 )			--Condição de parada
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

--Implementação Lógica de resolução 2 - (matemática)
CREATE OR ALTER FUNCTION tvf_multiStatement_Ultimos10PeloDiaSemana_v2 ( @diaSemanaDesejado VARCHAR(25) )
RETURNS @ListaDias TABLE ( Dia DATE )
AS BEGIN

		DECLARE @diaSemanaAtual VARCHAR(25) = dbo.fn_escalar_diaSemana_v1(GETDATE())
				, @diasNoPassado SMALLINT = 0	
		--Como esta solução usa o número do dia da semana e não o nome
		-- é preciso realizar a conversão "de volta".
		DECLARE @numeroDiaSemanaAtual SMALLINT = 
			case @diaSemanaAtual when 'Domingo' then 1
				when 'Segunda-feira' then 2 when 'Terça-feira' then 3
				when 'Quarta-feira' then 4 when 'Quinta-feira' then 5
				when 'Sexta-feira' then 6 when 'Sábado' then 7
			end
		DECLARE @numeroDiaSemanaDesejado SMALLINT= 
			case @diaSemanaDesejado when 'Domingo' then 1
				when 'Segunda-feira' then 2 when 'Terça-feira' then 3
				when 'Quarta-feira' then 4 when 'Quinta-feira' then 5
				when 'Sexta-feira' then 6 when 'Sábado' then 7
			end

		SET @diasNoPassado = (7 + ( @numeroDiaSemanaAtual - @numeroDiaSemanaDesejado )) %7

		DECLARE @SemanasNoPassado SMALLINT = 0	--Valor inicial
		WHILE ( @SemanasNoPassado > -10 )			--Condição de parada
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
	e um número ( dias úteis para o vencimento de uma fatura, por exemplo)
e devolva a data exata do vencimento, não contando nem finais de semana, nem os feriados
	contidos na lista recebida.

Crie todas as funções ou procedimentos solicitados, teste-os e demonstre que estão funcionando.

Planejamento: 
	parâmetros de entrada 
		<- Lista de datas ( tabela ) = os feriados --Ex: 21/04/2021, 01/05/2021, ...
		<- número de dias ( inteiro ) = vencimento em dias --Ex: 7
	Parâmetros de saída 
		-> data do vencimento ( ignorando finais de semana e feriados )	--EX: 07/05/2021
	Tipo de procedure
		Diferente de funções, procedures não tem tipos.
	Pesquisa
		Rever: Aula 01 - Revisao SQL e entendimento de um banco de dados - Revisão Linguagem SQL - GUIA DE ESTUDO.sql
			DATEPART(datepart,date )
			DATEADD(datepart,date )
		Rever: Aula 05 - Tabelas temporárias, variáveis do tipo tabela, tipos.sql
	Testes da lógica:
		Contador de dias úteis ( while que testa dia a dia )
		Enquanto não conseguir avançar X dias úteis
			Se hoje não é feriado, nem emenda ( lista recebida de parâmetro )
				nem é final de semana ( sábado ou domingo )
			Conto +1 ao contador de dias úteis
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
					AND dbo.fn_escalar_diaSemana_v1(@DataVencimento) NOT IN ( 'sábado', 'domingo' )
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
		VALUES ( '01/01/2021', 'Confraternização Universal (feriado nacional)')
			, ('15/02/2021', 'Carnaval (ponto facultativo)')
			, ('16/02/2021', 'Carnaval (ponto facultativo)')
			, ('17/02/2021', 'quarta-feira de cinzas (ponto facultativo até as 14h)')
			, ('02/04/2021', 'Paixão de Cristo (feriado nacional)')
			, ('21/04/2021', 'Tiradentes (feriado nacional)')
			, ('01/05/2021', 'Dia Mundial do Trabalho (feriado nacional)')
			, ('03/06/2021', 'Corpus Christi (ponto facultativo)')
			, ('07/09/2021', 'Independência do Brasil (feriado nacional)')
			, ('12/10/2021', 'Nossa Senhora Aparecida (feriado nacional)')
			, ('28/10/2021', 'Dia do Servidor Público – art. 236 da Lei nº 8.112, de 11 de dezembro de 1990, a ser comemorado no dia 01 de novembro (ponto facultativo)')
			, ('02/11/2021', 'Finados (feriado nacional)')
			, ('15/11/2021', 'Proclamação da República (feriado nacional)')
			, ('24/12/2021', 'véspera de natal (ponto facultativo após às 14h)')
			, ('25/12/2021', 'Natal (feriado nacional)')
			, ('31/12/2021', 'véspera de ano novo (ponto facultativo após às 14h)')
		select * FROM @listaFeriados

	Criação do tipo de dados para lista de feriados
		CREATE TYPE listaDatas AS TABLE ( Dia DATE, Motivo Varchar(255) )

--Implementação 
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
			AND dbo.fn_escalar_diaSemana_v1(@DataVencimento) NOT IN ( 'sábado', 'domingo' )
		)
			SET @contadorDiasUteis += 1
	END
END
GO

--Uso da procedure
		DECLARE @listaFeriados listaDatas
		INSERT INTO @listaFeriados ( Dia, Motivo ) 
		VALUES ( '01/01/2021', 'Confraternização Universal (feriado nacional)')
			, ('15/02/2021', 'Carnaval (ponto facultativo)')
			, ('16/02/2021', 'Carnaval (ponto facultativo)')
			, ('17/02/2021', 'quarta-feira de cinzas (ponto facultativo até as 14h)')
			, ('02/04/2021', 'Paixão de Cristo (feriado nacional)')
			, ('21/04/2021', 'Tiradentes (feriado nacional)')
			, ('01/05/2021', 'Dia Mundial do Trabalho (feriado nacional)')
			, ('03/06/2021', 'Corpus Christi (ponto facultativo)')
			, ('07/09/2021', 'Independência do Brasil (feriado nacional)')
			, ('12/10/2021', 'Nossa Senhora Aparecida (feriado nacional)')
			, ('28/10/2021', 'Dia do Servidor Público – art. 236 da Lei nº 8.112, de 11 de dezembro de 1990, a ser comemorado no dia 01 de novembro (ponto facultativo)')
			, ('02/11/2021', 'Finados (feriado nacional)')
			, ('15/11/2021', 'Proclamação da República (feriado nacional)')
			, ('24/12/2021', 'véspera de natal (ponto facultativo após às 14h)')
			, ('25/12/2021', 'Natal (feriado nacional)')
			, ('31/12/2021', 'véspera de ano novo (ponto facultativo após às 14h)')

		DECLARE @DataVencimento DATE
		EXEC sp_vencimentoemDiasUteis 
				@listaFeriados 
				, 7
				, @DataVencimento OUTPUT
		SELECT @DataVencimento as DataVencimento
				, dbo.fn_escalar_diaSemana_v1(@DataVencimento)

-------------------------------------------------------------------------- 
-- Extensão - Exercícios
--------------------------------------------------------------------------- 

4.	Criar uma função com a função similar à da questão 1.
	Ou seja, uma função escalar que, dado um dia da semana
	devolva o número daquele dia da semana.
	Ex:	select dbo.fn_escalar_numeroDiaSemana('domingo') --> 1
	
5.	Altere a função tvf_multiStatement_Ultimos10PeloDiaSemana_v2
	para ao invés de calcular internamente o número do dia da semana,
	agora ela passe a usar a função recem criada no item 4.
	Ela deve manter sua funcionalidade:
	SELECT * FROM dbo.tvf_multiStatement_Ultimos10PeloDiaSemana_v2('domingo')

6.	Crie uma nova procedure sp_vencimentoemDiasUteis_v2
	Porém, esta não recebe mais a lista de feriados ( e pontos facultativos )
	como parâmetro, tais dados devem ser salvos em uma tabela tradicional.
	Ela deve passar a receber um parâmetro de uma data inicial
	Ela deve continuar recebendo o parâmetro de vencimento em dias uteis
	Ela deve continuar devolvendo a Data de vencimento.
	Porém, tal vencimento agora é calculado à partir da inicial fornecida
	como parâmetro.
		DECLARE @DataInicial DATE = GETDATE(), @DiasVencimento SMALLINT= 7, @DataVencimento DATE
		EXEC sp_vencimentoemDiasUteis_v2 @DataInicial, @DiasVencimento, @DataVencimento OUTPUT
		SELECT @DataVencimento as DataVencimento

7. Crie um novo procedimento que receba 2 argumentos:
		Dia útil do mês - número cardinal ( 5º dia, 10º dia, 20ºdia )
		Número de parcelas ( número de futuros vencimentos )
	Devolva uma lista de X vencimentos no dia especificado
	pulando feriados e finais de semana.
	Para simplificar, não há vencimentos no mês atual
		, ou seja, todas as parcelas vencem a partir do mês seguinte.
		DECLARE @DiaUtilVencimento SMALLINT= 10
				, @numeroParcelas SMALLINT = 10
		CREATE TABLE #DatasVencimento ( dia DATE )
		INSERT INTO #DatasVencimento
		EXEC sp_calculaDatasVencimento @DiaUtilVencimento, @numeroParcelas
		SELECT * from #DatasVencimento

8. Altere o procedimento criado na questão 7 para que ele:
	- Devolva um erro caso o dia útil do mês não seja 5,10,15,20
	- Devolve um erro caso o número de parcelas seja superior à 12
		DECLARE @DiaUtilVencimento SMALLINT= 21 --ERRO
				, @numeroParcelas SMALLINT = 13 --ERRO

-------------------------------------------------------------------------- 
-- Extensão - Exercícios para casa
--------------------------------------------------------------------------- 
use ImpactaEstacionamento
go

Especificação:
Para completar a implementação de contratos, habilitando assim a função
de planos para mensalistas, são necessários:
- Dado uma localidade('Faculdade Impacta - Paulista')
	, um cliente('Almir dos Santos') 
	e uma categoria ( 'Mensalista Professor' )
- Cadastrar um contrato com vencimento padrão = anual ( 12 meses )
	para o plano vigente atual daquela categoria.
- Cada contrato já deve ter todas as mensalidades futuras pré-calculadas
  e inseridas.
- Os vencimentos das mensalidades só podem ser em dias úteis (5º, 10º, 15º, 20º)
	ou seja, não podem cair em feriados, emendas nem finais de semana.

--------------------------------------------------------------------------- 

Passo 1. Entendimento dos dados
Como registrar contratos e mensalidades (vencimentos) ?

--Identificação das categorias cadastradas
select * from categoriaPlano; 
	1	Mensalista Diurno
	2	Mensalista Noturno
	3	Mensalista Professor

--Verificação dos planos existentes
select * 
from Plano 
where idCategoria IN ( 
	select id from categoriaPlano where nome = 'Mensalista Professor'
); 

-- Verificação dos campos necessários para registo do contrato;
sp_help contrato;
id	int --PRIMARY KEY (clustered)
idPlano	int --REFERENCES ImpactaEstacionamento.dbo.Plano (id)
idCliente	int --REFERENCES ImpactaEstacionamento.dbo.cliente (id) 
diaVencimento	tinyint --CHECK ([diaVencimento]=(25) OR [diaVencimento]=(20) OR [diaVencimento]=(15) OR [diaVencimento]=(10) OR [diaVencimento]=(5))
dataContratacao	datetime --DEFAULT (getdate())
dateEncerramento	datetime

-- Verificação dos campos necessários para registo das mensalidades;
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

/*Para completar a implementação de contratos, habilitando assim a função
de planos para mensalistas, são necessários:
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

-- Cadastrar um contrato com vencimento padrão = anual ( 12 meses )
--	para o plano vigente atual daquela categoria.
DECLARE @diaVencimento TINYINT = 10
		, @DataContratacao DATETIME = GETDATE()
		, @DataVencimento DATETIME = DATEADD(month,GETDATE()
INSERT INTO contrato ( idPlano, idCliente, diaVencimento, dataContratacao, dateEncerramento )
VALUES ( @idPlano, @idCliente, @diaVencimento, @DataContratacao )

/*Cada contrato já deve ter todas as mensalidades futuras pré-calculadas
  e inseridas.
  Os vencimentos das mensalidades só podem ser em dias úteis (5º, 10º, 15º, 20º)
	ou seja, não podem cair em feriados, emendas nem finais de semana.
*/
--Dica, para calcular os vencimentos, podemos usar a procedure da questão 7
	DECLARE @DiaUtilVencimento SMALLINT= 10
			, @numeroParcelas SMALLINT = 12
	CREATE TABLE #DatasVencimento ( dia DATE )

	INSERT INTO #DatasVencimento
	EXEC sp_calculaDatasVencimento @DiaUtilVencimento, @numeroParcelas

	SELECT * from #DatasVencimento
	....

-------------------------------------------------------------------------
-- Agora é com vocês
-------------------------------------------------------------------------

9. completem o teste de inserção das 12 mensalidades
todas com vencimento para o 10º dia útil de cada mês.
INSERT INTO mensalidade...

-------------------------------------------------------------------------
10. Criem uma procedure que receba 
 uma localidade('Faculdade Impacta - Paulista')
 um cliente('Almir dos Santos') --Podem cadastrar outros clientes para testes
 uma categoria ( 'Mensalista Professor' )
 um dia útil ( ex: 5º )
 uma duração do contrato em meses ( de 1 a 12 )

Cadastre um contrato com vencimento para o plano vigente atual daquela categoria.
	Com duração em meses equivalente ao parametro de duração do contrato.
Cadastre os vencimentos das mensalidades no dia útil escolhido.

Devolva uma lista com as dastas e valores devidos a cada mês.
Ex:		15/06/2021		R$100,00 --10º dia útil ( hipotético )
		14/06/2021		R$100,00 --10º dia útil ( hipotético )
		...

-------------------------------------------------------------------------
11. Altere a procedure criada na questão 10 para que ela:
Valide os seguintes erros ( dando uma mensagem de erro específica em caso de não conformidade)
 Localidade não existente ou não cadastrada
 cliente não existente ou não cadastrado
 categoria não existente ou não cadastrado
 plano da categoria vigente inexistente ou não cadastrado ou sem plano vigente.
 Dia útil deve ser 5,10,15,20
 Duração deve ser de 1 a 12









