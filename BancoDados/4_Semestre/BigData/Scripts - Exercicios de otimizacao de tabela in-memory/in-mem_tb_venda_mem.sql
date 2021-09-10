--###################################################################
-- TABELA IN MEMORY
--###################################################################
create table venda_mem (
	  id int identity (1,1) constraint pk_venda_mem primary key nonclustered
	, data datetime2 not null default sysdatetime()
	, valor money not null
) with (
MEMORY_OPTIMIZED = ON
, DURABILITY = SCHEMA_AND_DATA
)
