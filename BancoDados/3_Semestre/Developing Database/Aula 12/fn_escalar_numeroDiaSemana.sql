CREATE OR ALTER FUNCTION fn_escalar_numeroDiaSemana ( @diaSemana varchar(25) )
RETURNS VARCHAR(25)
AS BEGIN
	DECLARE @numDiaSemana smallint
	SELECT @numDiaSemana = case lower(@diaSemana)
				when 'domingo'		 then 1
				when 'segunda-feira' then 2
				when 'terça-feira'	 then 3
				when 'quarta-feira'	 then 4
				when 'quinta-feira'	 then 5
				when 'sexta-feira'	 then 6
				when 'sábado'		 then 7
			 else 0
			END
	RETURN @numDiaSemana
END


