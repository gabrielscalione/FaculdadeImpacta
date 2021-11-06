
create database controle_dba
go
use controle_dba
go

--tabela de controle ( criar s� 1 vez )
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


--job de backup database
DECLARE @NOME_BACKUP VARCHAR(255)
		, @CAMINHO VARCHAR(255) = 'C:\BD\BACKUPS\'
		, @fileName VARCHAR(512)
SELECT	@NOME_BACKUP 
		= 'IMPACTA_'
			+ CONVERT(VARCHAR(MAX),GETDATE(),112)
			+ LEFT(REPLACE(REPLACE(CONVERT(VARCHAR(MAX),CONVERT(TIME,GETDATE())),':',''),'.',''),6)
		+ '.BAK'
SELECT @fileName = @CAMINHO + @NOME_BACKUP 

BACKUP DATABASE IMPACTA 
	TO DISK = @fileName 
WITH INIT;

insert into TBL_CTRL_Backups(tipo, caminho, nome )
select 'DATABASE', @CAMINHO, @NOME_BACKUP


--teste: select * from TBL_CTRL_Backups

--job de restore database
DECLARE @fileName VARCHAR(512)
		, @id int

SELECT	TOP 1 
		@fileName = CAMINHO + nome
		, @id = id
FROM	TBL_CTRL_Backups 
WHERE	tipo = 'DATABASE' 
ORDER BY DATA DESC

RESTORE DATABASE IMPACTA 
	FROM DISK = @fileName
WITH REPLACE, RECOVERY;

UPDATE TBL_CTRL_Backups 
	SET restaurado = 1
where id = @id


--teste: select * from TBL_CTRL_Backups



-- demonstre que as tabelas est�o iguais...
	select * from [principal].impacta.dbo.ALUNOS
	select * from impacta.dbo.ALUNOS

-- incluir alguma diferen�a...
	
	INSERT INTO [principal].impacta.dbo.ALUNOS (NOME) VALUES ('FULANO'),('CICLANO'),('BELTRANO')
	GO 
	SELECT * FROM [principal].impacta.dbo.ALUNOS

-- demonstre que as tabelas est�o diferentes...
	select * from [principal].impacta.dbo.ALUNOS
	select * from impacta.dbo.ALUNOS

-- roda o passo 3 + 4 na m�o ( exibir o hist�rico ) 
-- espera-se at� 1 min para o job rodar sozinho..

--demonstre que as tabelas est�o iguais novamente...
	select * from [principal].impacta.dbo.ALUNOS
	select * from impacta.dbo.ALUNOS

-- Lista as Jobs
	select * from controle_dba..vw_consulta_jobs

-- Consulta tabela de controle: 
	select * from TBL_CTRL_Backups
