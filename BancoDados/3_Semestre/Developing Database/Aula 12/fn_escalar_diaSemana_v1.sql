CREATE OR ALTER FUNCTION fn_escalar_diaSemana_v1 ( @data datetime )  
RETURNS VARCHAR(25)  
AS BEGIN  
 RETURN DATENAME(dw,@data)  
END  