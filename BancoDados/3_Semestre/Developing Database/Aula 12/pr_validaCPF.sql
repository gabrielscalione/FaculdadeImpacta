CREATE OR ALTER PROCEDURE pr_validaCPF ( @CPF VARCHAR(255), @retorno VARCHAR(255) OUTPUT )  
AS BEGIN  
 --Função de limpeza feita na questão 06  
 SELECT @CPF = dbo.fn_limpaCPF(@CPF)  
  
 --Tratamento de erro pré-montado na questão 07  
 IF ( len(@CPF) <> 11 ) THROW 50000, 'Formato inválido',1  
 IF ( ISNUMERIC(@CPF) <> 1 ) THROW 50001,'Dígitos inválidos',1  
  
 --Tomada de decisão feita na questão pré-calculada na questão 11  
 IF (   
  --Função do primeiro dígito feito na questão 09--> 1 BUG a ser corrigido  
  SUBSTRING(@CPF,10,1) = dbo.fn_calculaPrimeiroDigito(@CPF)    
  AND   
  --Função do segundo dígito feito na questão 10 --> 2 BUGs a serem corrigidos  
  SUBSTRING(@CPF,11,1) = dbo.fn_calculaSegundoDigito(@CPF)  
 )  
  SELECT @retorno = 'VÁLIDO'  
 ELSE   
  SELECT @retorno = 'INVALIDO'  
END