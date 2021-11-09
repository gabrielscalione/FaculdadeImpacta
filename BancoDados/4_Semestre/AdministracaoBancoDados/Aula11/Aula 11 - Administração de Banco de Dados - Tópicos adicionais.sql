

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- System Versioned Tables
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

“System Versioned Tables” ou de versão do sistema foram introduzidas como um recurso 
de banco de dados no SQL Server 2016. Nos permite criar  um tipo de tabela que nos 
fornece informações sobre os dados que foram armazenados em qualquer horário especificado, 
em vez de apenas os dados que são atuais.
Limitações:
Não é possível utilizar os comandos DDL para exclusão, adição ou exclusão de colunas.
Não é possível utilizar FILETABLE e FILESTREAM.
Excluir os dados através do comando TRUNCATE TABLE não é permitido.
Linked Server não é suportado nas consultas aos dados de Temporal Tables.
Vantagens:
Ela permite que o SQL Server mantenha e gerencie o histórico dos dados na tabela automaticamente.
Auditoria reconstruindo os dados em caso de alterações inadvertidas projetando e relatando para análise de tendência histórica protegendo os dados em caso de perda acidental de dados

--Original
CREATE TABLE Consulta (
	ID INT NOT NULL IDENTITY(1,1)
	, ID_Paciente INT NOT NULL
	, ID_Medico INT NOT NULL
	, Numero_Sala INT NOT NULL
	, DataHora DATETIME NOT NULL
	, Duracao TINYINT NOT NULL
	, CONSTRAINT PK_Consulta PRIMARY KEY ( ID )
	, CONSTRAINT FK_ConsultaMedico FOREIGN KEY ( Id_medico ) REFERENCES Medico( ID )
	, CONSTRAINT FK_ConsultaPaciente FOREIGN KEY ( Id_paciente ) REFERENCES paciente( ID )
	, CONSTRAINT FK_ConsultaSala FOREIGN KEY ( Numero_Sala ) REFERENCES Sala( Numero )
)
GO
--Versionada
CREATE TABLE Consulta_versionada (
	ID INT NOT NULL IDENTITY(1,1)
	, ID_Paciente INT NOT NULL
	, ID_Medico INT NOT NULL
	, Numero_Sala INT NOT NULL
	, DataHora DATETIME NOT NULL
	, Duracao TINYINT NOT NULL
	, [ValidFrom] /*OU SysStartTime*/ datetime2 GENERATED ALWAYS AS ROW START
	, [ValidTo] /*OU SysEndTime*/ datetime2 GENERATED ALWAYS AS ROW END
	, PERIOD FOR SYSTEM_TIME (ValidFrom /*OU SysStartTime*/, ValidTo /*OU SysEndTime*/)
	, CONSTRAINT PK_Consulta_versionada PRIMARY KEY ( ID )
	, CONSTRAINT FK_ConsultaMedico_versionada FOREIGN KEY ( Id_medico ) REFERENCES Medico( ID )
	, CONSTRAINT FK_ConsultaPaciente_versionada FOREIGN KEY ( Id_paciente ) REFERENCES paciente( ID )
	, CONSTRAINT FK_ConsultaSala_versionada FOREIGN KEY ( Numero_Sala ) REFERENCES Sala( Numero )
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Consulta_historica))
GO

--Tabelas vazias ( recém criadas )
select * from Consulta_versionada
select * from Consulta_historica
--Inserção de alguns valores
INSERT INTO Consulta_versionada (ID_Paciente, ID_Medico, Numero_Sala, DataHora, Duracao )
SELECT	(select top 1 paciente.id from paciente order by newid())
	,	(select top 1 medico.id from medico order by newid())
	,	(select top 1 sala.numero from sala order by newid())
	,	(dateadd(minute,(convert(int,rand()*2553)%4)*15,
			dateadd(hour, (convert(int,rand()*2553)%8)+8,
				convert(datetime
					,dateadd(day,-1*convert(int,rand()*1000),convert(date,getdate()) )
				)
			)
		 )
		) 
	, ((convert(int,rand()*2553)%2)+1)*15;
waitfor delay '00:00:01';
GO 10
--Após inserts originais
select * from Consulta_versionada
select * from Consulta_historica
--Alterações do número da sala de uma consulta
update Consulta_versionada 
	set Numero_Sala = (select top 1 sala.numero from sala order by newid())
where id = 1
--Após alterações
select * from Consulta_versionada
select * from Consulta_historica
--Voltando no tempo

select * from Consulta_versionada 
	FOR SYSTEM_TIME between '2021-05-13 14:43:57.9067698' and '2021-05-13 14:44:12.0357326'
select * from Consulta_versionada FOR SYSTEM_TIME AS OF '2021-05-13 14:43:57.9067698'
select * from Consulta_versionada FOR SYSTEM_TIME AS OF '2021-05-13 14:44:12.0357326'
--desfazendo
alter table Consulta_versionada SET (SYSTEM_VERSIONING = OFF ) 
drop table Consulta_versionada
drop table Consulta_historica


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- In-Memory
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

https://docs.microsoft.com/pt-br/sql/relational-databases/in-memory-oltp/in-memory-oltp-in-memory-optimization?view=sql-server-ver15
https://www.youtube.com/watch?v=l5l5eophmK4

use master
go

ALTER DATABASE consultorio 
	ADD FILEGROUP FG_InMemory CONTAINS MEMORY_OPTIMIZED_DATA;
GO

-- sp_helpdb consultorio
ALTER DATABASE consultorio
	ADD FILE ( name = 'consultorio_inMemory', filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\consultorio.ndf')
	TO FILEGROUP FG_InMemory
GO

use consultorio
go

--Sem suporte para indices clusterizados
--Sem suporte para foreign key
CREATE TABLE Consulta_inMemory (
	ID INT NOT NULL IDENTITY(1,1)
	, ID_Paciente INT NOT NULL
	, ID_Medico INT NOT NULL
	, Numero_Sala INT NOT NULL
	, DataHora DATETIME NOT NULL
	, Duracao TINYINT NOT NULL
	, CONSTRAINT PK_Consulta_inMemory PRIMARY KEY NONCLUSTERED ( ID )
)
WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA)
GO
--sp_help Consulta_inMemory

--inserção de alguns valores
INSERT INTO Consulta_inMemory (ID_Paciente, ID_Medico, Numero_Sala, DataHora, Duracao )
SELECT	(select top 1 paciente.id from paciente order by newid())
	,	(select top 1 medico.id from medico order by newid())
	,	(select top 1 sala.numero from sala order by newid())
	,	(dateadd(minute,(convert(int,rand()*2553)%4)*15,
			dateadd(hour, (convert(int,rand()*2553)%8)+8,
				convert(datetime
					,dateadd(day,-1*convert(int,rand()*1000),convert(date,getdate()) )
				)
			)
		 )
		) 
	, ((convert(int,rand()*2553)%2)+1)*15;
GO 1000000

--Comparação pela PK
select * from Consulta_inMemory where id = 1234
select * from Consulta where id = 1234

-- Indices InMemory
ALTER TABLE Consulta_inMemory  
    ADD CONSTRAINT UQ_Consulta_inMemory_DataHora
    UNIQUE NONCLUSTERED (DataHora, ID);  --Unique
go

ALTER TABLE Consulta_inMemory  
    ADD INDEX idx_hash_Consulta_inMemory_paciente  
    HASH (ID_Paciente) WITH (BUCKET_COUNT = 64);  -- Nonunique.  
go 

---Criando os equivalentes na versão normal
ALTER TABLE Consulta
    ADD CONSTRAINT UQ_Consulta_DataHora
    UNIQUE NONCLUSTERED (DataHora, ID);  --Unique
go
CREATE INDEX idx_Consulta_paciente 
	ON Consulta (ID_Paciente) -- Nonunique.  
go 

--Comparação pelo índice UQ
declare @min_normal datetime, @max_normal datetime
	, @min_inmemory datetime, @max_inMemory datetime
select @min_normal = min(datahora), @max_normal = max(datahora)
from ( select top 100 datahora from consulta order by datahora ASC) aux
select @min_inmemory = min(datahora), @max_inMemory = max(datahora)
from ( select top 100 datahora from Consulta_inMemory order by datahora ASC) aux

select COUNT(*) from Consulta_inMemory 
	where datahora = @min_inmemory
select COUNT(*) from Consulta 
	where datahora = @min_normal


select COUNT(*) from Consulta_inMemory 
	where datahora between @min_inmemory and @max_inMemory
select COUNT(*) from Consulta 
	where datahora between @min_normal and @max_normal


GO
--Comparação pelo índice HASH
declare @min_normal datetime, @max_normal datetime
	, @min_inmemory datetime, @max_inMemory datetime
select @min_normal = min(ID_Paciente), @max_normal = max(ID_Paciente)
from ( select top 10 ID_Paciente from consulta order by datahora ASC) aux
select @min_inmemory = min(ID_Paciente), @max_inMemory = max(ID_Paciente)
from ( select top 10 ID_Paciente from Consulta_inMemory order by datahora ASC) aux

select COUNT(*) from Consulta_inMemory 
	where ID_Paciente = @min_inmemory 
select COUNT(*) from Consulta 
	where ID_Paciente = @min_normal 


select COUNT(*) from Consulta_inMemory 
	where ID_Paciente between @min_inmemory and @max_inMemory
select COUNT(*) from Consulta 
	where ID_Paciente between @min_normal and @max_normal

--Verificando alocação em memória dos objetos
SELECT object_name(t.object_id) AS [Table Name]  
     , memory_allocated_for_table_kb  
	 , memory_allocated_for_indexes_kb  
FROM sys.dm_db_xtp_table_memory_stats dms JOIN sys.tables t   
ON dms.object_id=t.object_id  
WHERE t.type='U' 


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- CDC - Change Data Capture
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

--habilitando o CDC no banco de dados
EXEC sys.sp_cdc_enable_db
GO

--Habilitando o trace sobre uma tabela
EXEC	sys.sp_cdc_enable_table
		@source_schema = N'dbo',
		@source_name = N'consulta',
		@role_name = NULL,
		@filegroup_name = 'primary'
GO

--Mudando algo
INSERT INTO Consulta (ID_Paciente, ID_Medico, Numero_Sala, DataHora, Duracao )
SELECT	(select top 1 paciente.id from paciente order by newid())
	,	(select top 1 medico.id from medico order by newid())
	,	(select top 1 sala.numero from sala order by newid())
	,	(dateadd(minute,(convert(int,rand()*2553)%4)*15,
			dateadd(hour, (convert(int,rand()*2553)%8)+8,
				convert(datetime
					,dateadd(day,-1*convert(int,rand()*1000),convert(date,getdate()) )
				)
			)
		 )
		) 
	, ((convert(int,rand()*2553)%2)+1)*15;
GO

update Consulta
	set Numero_Sala = (select top 1 sala.numero from sala order by newid())
where id = 1
GO

DELETE TOP(1) from consulta where id = 2
GO

--Conferindo as entradas
select * from cdc.dbo_consulta_CT


--limpeza dos jobs
sys.sp_MScdc_cleanup_job

-- Lista tabelas com CDC habilidatas
EXEC sys.sp_cdc_help_change_data_capture    

--Desabilitando o trace
EXECUTE sys.sp_cdc_disable_table 
    @source_schema = N'dbo', 
    @source_name = N'consulta',
    @capture_instance = N'dbo_consulta';
GO

--Desabilitando o CDC
EXEC sys.sp_cdc_disable_db 
GO 


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Column Store Index
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

-- Indices clusterizados deixam toda a tabela em modo COLUNAR. 
-- não vamos rodar em nosso exemplo.
CREATE CLUSTERED COLUMNSTORE INDEX IX_consulta_columnStore ON consulta;

--Indices não clusterizados funcionam como indices não clusterizados comuns
-- Uma das grandes vantagens de utilização de columnStore é a compressão das páginas.
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_consulta_columnStore_Medico_compress
    ON consulta ( ID_Medico )
	WITH ( data_Compression = COLUMNSTORE  );

--Criando o indice normal equivalente 
CREATE NONCLUSTERED INDEX IX_consulta_normal_Medico_compress
    ON consulta ( ID_Medico )
	WITH ( data_Compression = PAGE );--OU ROW

--comparando os indices
EXEC sp_help_index consulta

select count(*) 
from consulta with(index=IX_consulta_columnStore_Medico_compress ) 
where id_medico = 1

select count(*) 
from consulta with(index=IX_consulta_normal_Medico_compress ) 
where id_medico = 1

--comparando os indices com group by 
select id_medico, count(*) 
from consulta with(index=IX_consulta_columnStore_Medico_compress ) 
group by id_medico

select id_medico, count(*) 
from consulta with(index=IX_consulta_normal_Medico_compress ) 
group by id_medico
