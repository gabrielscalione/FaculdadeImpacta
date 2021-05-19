CREATE OR ALTER FUNCTION fn_calculaSegundoDigito ( @CPF CHAR(11) )  
RETURNS INT AS  
BEGIN  
 DECLARE @retorno INT =0, @i tinyint=1  
 WHILE (@i <= 10)  
 BEGIN  
  SET @retorno += CONVERT(INT,SUBSTRING(@CPF,@i,1)) * (12-@i)  
  SET @i+=1  
 END  
 return (@retorno * 10) % 11 % 10  
END