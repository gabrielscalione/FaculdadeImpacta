CREATE OR ALTER PROCEDURE pr_validaCPF ( @CPF VARCHAR(255), @retorno VARCHAR(255) OUTPUT )  
AS BEGIN  
 --Fun��o de limpeza feita na quest�o 06  
 SELECT @CPF = dbo.fn_limpaCPF(@CPF)  
  
 --Tratamento de erro pr�-montado na quest�o 07  
 IF ( len(@CPF) <> 11 ) THROW 50000, 'Formato inv�lido',1  
 IF ( ISNUMERIC(@CPF) <> 1 ) THROW 50001,'D�gitos inv�lidos',1  
  
 --Tomada de decis�o feita na quest�o pr�-calculada na quest�o 11  
 IF (   
  --Fun��o do primeiro d�gito feito na quest�o 09--> 1 BUG a ser corrigido  
  SUBSTRING(@CPF,10,1) = dbo.fn_calculaPrimeiroDigito(@CPF)    
  AND   
  --Fun��o do segundo d�gito feito na quest�o 10 --> 2 BUGs a serem corrigidos  
  SUBSTRING(@CPF,11,1) = dbo.fn_calculaSegundoDigito(@CPF)  
 )  
  SELECT @retorno = 'V�LIDO'  
 ELSE   
  SELECT @retorno = 'INVALIDO'  
END