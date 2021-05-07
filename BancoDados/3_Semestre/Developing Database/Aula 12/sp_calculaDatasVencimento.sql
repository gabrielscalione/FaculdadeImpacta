
CREATE OR ALTER PROCEDURE sp_calculaDatasVencimento   
 (  @DiaUtilVencimento SMALLINT
  , @numeroParcelas SMALLINT   
 ) 
 AS BEGIN
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
		-- Consulta variável
		SELECT @dataUtilVencimento

		-- Atualiza @primeiroDiaDoMes com a data do @proximoMes calculado inicialmente.
		SET @primeiroDiaDoMes = @proximoMes
		
		-- Atualiza @proximoMes com base na data do @primeiroDiaDoMes atualizado.
		SET @proximoMes = DATEADD(MONTH, 1, @primeiroDiaDoMes)
		
		-- Atualiza o @contadorDiasUteis.
		SET @contadorDiasUteis += 1
	
	END
 END
 
GO
DECLARE @DiaUtilVencimento SMALLINT= 10
	  , @numeroParcelas SMALLINT = 10

CREATE TABLE #DatasVencimento ( dia DATE )
INSERT INTO #DatasVencimento
EXEC sp_calculaDatasVencimento @DiaUtilVencimento, @numeroParcelas
SELECT * from #DatasVencimento

DROP TABLE #DatasVencimento 


GO  