
--###################################################################
-- SEM OTIMIZAÇÃO
--###################################################################

create or alter proc carga_venda @a int = 10000
as
	set nocount on

	declare @dt datetime2 = SYSDATETIME()
	, @b int = @a


	while @a > 1 
	begin
		insert venda (valor) values (90 * rand() + 10)
		set @a -= 1
	end

	select datediff(MICROSECOND, @dt , SYSDATETIME()) / 1000000.0 [tempo (s)]
	, @b / (datediff(MICROSECOND, @dt , SYSDATETIME()) / 1000000.0) as [transacoes (inserts/s)]

go

--###################################################################
-- PROCEDURE OTIMIZADA IN MEMORY
--###################################################################

create or alter proc carga_venda_mem @a int = 10000

WITH NATIVE_COMPILATION, SCHEMABINDING
as
	
BEGIN ATOMIC 
WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT,
		LANGUAGE = N'us_english' )

	declare @dt datetime2 = SYSDATETIME()
	, @b int = @a

	while @a > 1 
	begin
		insert dbo.venda_mem (valor) values (90 * rand() + 10)
		set @a -= 1
	end

	select datediff(MICROSECOND, @dt , SYSDATETIME()) / 1000000.0 [tempo (s)]
	, @b / (datediff(MICROSECOND, @dt , SYSDATETIME()) / 1000000.0) as [transacoes (inserts/s)]

END

GO

execute carga_venda
go

execute carga_venda_mem
go

