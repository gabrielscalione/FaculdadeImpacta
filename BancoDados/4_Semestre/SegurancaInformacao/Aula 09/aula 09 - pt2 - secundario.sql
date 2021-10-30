CREATE TABLE TBL_CTRL_Backups (
	id int not null IDENTITY(1,1)
	, tipo varchar(30) NOT NULL
		--constraint CK_tipo_TBL_CTRL_Backups
		CHECK ( tipo IN ('DATABASE','LOG' ) )
	, caminho varchar(255) NOT NULL
	, nome varchar(512) NOT NULL
	, autor varchar(255) NOT NULL
		--constraint DF_autor_TBL_CTRL_Backups 
		DEFAULT(SYSTEM_USER)
	, data datetime NOT NULL
		--constraint DF_Data_TBL_CTRL_Backups 
		DEFAULT(getdate())
	, restaurado bit 
		--constraint DF_Restaurado_TBL_CTRL_Backups 
		DEFAULT(0)
	, constraint PK_TBL_CTRL_Backups PRIMARY KEY(id)
)
GO

select * from SECUNDARIO.controle_dba.dbo.TBL_CTRL_Backups

--job de restore database
DECLARE @fileName VARCHAR(512)
		, @id int

SELECT	TOP 1 
		@fileName = CAMINHO + nome
		, @id = id
FROM	controle_dba.dbo.TBL_CTRL_Backups 
WHERE	tipo = 'DATABASE' 
ORDER BY DATA DESC

RESTORE DATABASE IMPACTA 
	FROM DISK = @fileName
WITH REPLACE, RECOVERY;

UPDATE controle_dba.dbo.TBL_CTRL_Backups 
	SET restaurado = 1
where id = @id



--job de restore LOG
DECLARE @fileName VARCHAR(512)
		, @id int

-- cursor com uma lista de arquivos a serem restaurados
DECLARE ARQUIVOS CURSOR LOCAL FOR (
	--Qual a lista de backups de log que devo restaurar ?
	--´primeiro backup de log não restaurado depois do último backup database
	SELECT	id	
			, CAMINHO + nome as fileName
	FROM	controle_dba.dbo.TBL_CTRL_Backups 
	WHERE	tipo = 'LOG' 
			AND restaurado = 0
			AND id > (
				SELECT	TOP 1 id
				FROM	controle_dba.dbo.TBL_CTRL_Backups 
				WHERE	tipo = 'DATABASE' 
				ORDER BY DATA DESC
			)
)
OPEN ARQUIVOS
FETCH NEXT FROM ARQUIVOS INTO @id, @fileName
WHILE ( @@FETCH_STATUS= 0)
BEGIN
	RESTORE LOG IMPACTA 
		FROM DISK = @fileName
	WITH standby = 'C:\BD\TRN\impacta.trn';   ---- sem isso o banco não fica disponível - ficando em Stand by

	UPDATE controle_dba.dbo.TBL_CTRL_Backups 
		SET restaurado = 1
	where id = @id
	
	FETCH NEXT FROM ARQUIVOS INTO @id, @fileName
END
CLOSE ARQUIVOS
DEALLOCATE ARQUIVOS

-- ConferÊncia
select * from controle_dba.dbo.TBL_CTRL_Backups

-- teste, resultado esperado, os dois bancos iguais...
SELECT * FROM [principal].IMPACTA.DBO.ALUNOS
SELECT * FROM IMPACTA.DBO.ALUNOS

--insert no banco principal
INSERT INTO  [principal].IMPACTA.DBO.ALUNOS(nome) VALUES ('FULANA'),('CICLANA'),('BELTRANA')

-- teste, resultado esperado, os dois bancos diferentes
-- 3 novos alunos estão no principal e não no secundario...
SELECT * FROM [principal].IMPACTA.DBO.ALUNOS
SELECT * FROM IMPACTA.DBO.ALUNOS

-- job de backup log foi executado
-- job de restore log foi executado

-- teste, resultado esperado, os dois bancos voltaram a ficar iguais...
SELECT * FROM [principal].IMPACTA.DBO.ALUNOS
SELECT * FROM IMPACTA.DBO.ALUNOS








