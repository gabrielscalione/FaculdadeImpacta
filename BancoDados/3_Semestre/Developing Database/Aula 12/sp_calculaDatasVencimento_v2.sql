USE master;  
GO  
EXEC sp_addmessage @msgnum = 60002, @severity = 16,   
   @msgtext = N'Error: Number of installments is greater than 12'
   ,@lang = 'us_english'
EXEC sp_addmessage @msgnum = 60002, @severity = 16,   
   @msgtext = N'Erro: Número de parcelas superior à 12'   
   ,@lang = 'Português (Brasil)'
   ,@replace = 'replace';
EXEC sp_addmessage @msgnum = 60001, @severity = 16,   
   @msgtext = N'Error: The working day of the month is not 5, 10, 15 or 20'
   ,@lang = 'us_english'
EXEC sp_addmessage @msgnum = 60001, @severity = 16,   
   @msgtext = N'Erro: O dia útil do mês não é 5, 10, 15 ou 20'   
   ,@lang = 'Português (Brasil)'
   ,@replace = 'replace';
GO  

USE ImpactaEstacionamento
GO 


CREATE OR ALTER PROCEDURE sp_calculaDatasVencimento_v2   
 (  @DiaUtilVencimento SMALLINT
  , @numeroParcelas SMALLINT   
 ) 
 AS BEGIN
			
	-- Verifica se o numeroParcelas é maior que 12 e retorna ERRO
	IF @numeroParcelas > 12
	BEGIN
		RAISERROR(60002,16,1)
	END
	ELSE
	BEGIN
		-- Pega a data de hoje
		DECLARE @dataUtilVencimento DATETIME 
				, @primeiroDiaDoMes DATETIME
				, @proximoMes DATETIME
				, @contadorDiasUteis SMALLINT

		-- Calcula o primeiro dia do mês seguinte
		SET @primeiroDiaDoMes = DATEADD(DAY, 1, EOMONTH (GETDATE()))
		-- Calcula o próximo mês com base na data do primeiroDiaMes
		SET @proximoMes = DATEADD(MONTH, 1, @primeiroDiaDoMes)
		-- Seta para inicializar o contadorDiasUteis
		SET @contadorDiasUteis = 1

		WHILE ( @contadorDiasUteis <= @numeroParcelas )
		BEGIN
		
			-- Retorna o dia útil
			EXEC sp_vencimentoemDiasUteis_v2 @primeiroDiaDoMes,@DiaUtilVencimento, @dataUtilVencimento OUTPUT
				
			IF DATEPART (day, @dataUtilVencimento) NOT IN (5,10,15,20)
			BEGIN
				RAISERROR(60001,16,1)
			END
			ELSE
			BEGIN
				-- Consulta variável
				SELECT @dataUtilVencimento
			END

			-- Atualiza @primeiroDiaDoMes com a data do @proximoMes calculado inicialmente.
			SET @primeiroDiaDoMes = @proximoMes
		
			-- Atualiza @proximoMes com base na data do @primeiroDiaDoMes atualizado.
			SET @proximoMes = DATEADD(MONTH, 1, @primeiroDiaDoMes)
		
			-- Atualiza o @contadorDiasUteis.
			SET @contadorDiasUteis += 1
	
		END -- Fim do While
	END -- Fim do if verifica número de parcela
	
 END -- Fim da sp
 
GO
DECLARE @DiaUtilVencimento SMALLINT= 2
	  , @numeroParcelas SMALLINT = 10

CREATE TABLE #DatasVencimento ( dia DATE )
INSERT INTO #DatasVencimento
EXEC sp_calculaDatasVencimento_v2 @DiaUtilVencimento, @numeroParcelas
SELECT * from #DatasVencimento

DROP TABLE #DatasVencimento 


GO  