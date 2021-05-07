CREATE TABLE feriados
	(	  id INT NOT NULL IDENTITY(1,1)
		, Dia DATE
		, Motivo Varchar(255) 
		, CONSTRAINT PK_feriados PRIMARY KEY ( id )
	)
GO
	INSERT INTO feriados ( Dia, Motivo ) 
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
GO 

select * FROM feriados

GO

--Implementa��o   
CREATE OR ALTER PROCEDURE sp_vencimentoemDiasUteis_v2   
 ( @DataInicial DATE
  , @VencimentoEmDiasUteis SMALLINT   
  , @DataVencimento DATE OUTPUT  
 )  
AS BEGIN  
	DECLARE @contadorDiasUteis SMALLINT = 1  
	SET @DataVencimento = @DataInicial
  
	WHILE ( @contadorDiasUteis <= @VencimentoEmDiasUteis )  
	BEGIN  
		
		SET @DataVencimento = DATEADD(day,1,@DataVencimento)  

		IF (@DataVencimento NOT IN ( SELECT dia FROM feriados )  
			AND dbo.fn_escalar_diaSemana_v1(@DataVencimento) NOT IN ( 's�bado', 'domingo' ) )  
			
			SET @contadorDiasUteis += 1  

	END  --fim do while
END   -- fim da procedure

GO

DECLARE @DataInicial DATE = GETDATE(), 
        @DiasVencimento SMALLINT= 7, 
	    @DataVencimento DATE
EXEC sp_vencimentoemDiasUteis_v2 @DataInicial, @DiasVencimento, @DataVencimento OUTPUT
SELECT @DataVencimento as DataVencimento