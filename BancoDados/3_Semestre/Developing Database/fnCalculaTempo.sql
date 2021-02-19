

CREATE FUNCTION dbo.fnCalculaTempo 
(
    @entrada DATETIME, @saida DATETIME
)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @temp DATETIME
    
	IF (@entrada > @saida)
    BEGIN
        SET @temp = @entrada
        SET @entrada = @saida
        SET @saida = @temp
    END

    RETURN  CEILING(datediff(minute,@entrada,isnull(@saida,getDATE()))/60.00)
END
GO

SELECT DBO.fnCalculaTempo('2021-02-08 21:20:00', '2021-02-10 23:20:10')

