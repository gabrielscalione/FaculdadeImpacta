CREATE OR ALTER FUNCTION tvf_multiStatement_Ultimos10PeloDiaSemana_v2 ( @diaSemanaDesejado VARCHAR(25) )  
RETURNS @ListaDias TABLE ( Dia DATE )  
AS BEGIN  
  
  DECLARE @diaSemanaAtual VARCHAR(25) = dbo.fn_escalar_diaSemana_v1(GETDATE())  
    , @diasNoPassado SMALLINT = 0   
  --Como esta solu��o usa o n�mero do dia da semana e n�o o nome  
  -- � preciso realizar a convers�o "de volta".  
  DECLARE @numeroDiaSemanaAtual SMALLINT =  dbo.fn_escalar_numeroDiaSemana(@diaSemanaAtual)

  DECLARE @numeroDiaSemanaDesejado SMALLINT =  dbo.fn_escalar_numeroDiaSemana(@diaSemanaDesejado)

  SET @diasNoPassado = (7 + ( @numeroDiaSemanaAtual - @numeroDiaSemanaDesejado )) %7  
  
  DECLARE @SemanasNoPassado SMALLINT = 0 --Valor inicial  
  WHILE ( @SemanasNoPassado > -10 )   --Condi��o de parada  
  BEGIN  
   INSERT @ListaDias(dia)  
   SELECT DATEADD(week,@SemanasNoPassado,GETDATE()-@diasNoPassado) --Calculo da Data   
   SET @SemanasNoPassado -= 1    --Decremento  
  END   
  RETURN  
END  