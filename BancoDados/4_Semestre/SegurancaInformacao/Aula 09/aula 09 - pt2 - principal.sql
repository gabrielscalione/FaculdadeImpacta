--scripts para confer ncia da tabela de controle localizada
--no servidor secundario ( acessado via linkedserver )
select * from SECUNDARIO.controle_dba.dbo.TBL_CTRL_Backups


--job de backup database
DECLARE @NOME_BACKUP VARCHAR(255)
		, @CAMINHO VARCHAR(255) = 'C:\BD\BACKUPS\'
		--, @CAMINHO VARCHAR(255) = '\\ec2-35-173-61-48.compute-1.amazonaws.com\Backups\'
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

insert into SECUNDARIO.controle_dba.dbo.TBL_CTRL_Backups(tipo, caminho, nome )
select 'DATABASE', @CAMINHO, @NOME_BACKUP


--cmdexec ( passo 2 do job de backup database )
xcopy C:\BD\BACKUPS\*.bak \\ec2-3-224-236-132.compute-1.amazonaws.com\Backups\ /Y

exec master.dbo.xp_cmdshell 'xcopy C:\BD\BACKUPS\*.bak \\ec2-3-224-236-132.compute-1.amazonaws.com\Backups\ /Y'

--job de backup LOG
DECLARE @NOME_BACKUP VARCHAR(255)
		, @CAMINHO VARCHAR(255) = 'C:\BD\BACKUPS\'
		--, @CAMINHO VARCHAR(255) = '\\ec2-35-173-61-48.compute-1.amazonaws.com\Backups\'
		, @fileName VARCHAR(512)
SELECT	@NOME_BACKUP 
		= 'IMPACTA_'
			+ CONVERT(VARCHAR(MAX),GETDATE(),112)
			+ LEFT(REPLACE(REPLACE(CONVERT(VARCHAR(MAX),CONVERT(TIME,GETDATE())),':',''),'.',''),6)
		+ '.LOG'
SELECT @fileName = @CAMINHO + @NOME_BACKUP 

BACKUP LOG IMPACTA 
	TO DISK = @fileName 
WITH INIT;

insert into SECUNDARIO.controle_dba.dbo.TBL_CTRL_Backups(tipo, caminho, nome )
select 'LOG', @CAMINHO, @NOME_BACKUP


--cmdexec ( passo 2 do job de backup LOG )
xcopy C:\BD\BACKUPS\*.log \\ec2-35-173-61-48.compute-1.amazonaws.com\Backups\ /Y

exec master.dbo.xp_cmdshell 'xcopy C:\BD\BACKUPS\*.log \\ec2-3-224-236-132.compute-1.amazonaws.com\Backups\ /Y'



truncate table controle_dba.dbo.TBL_CTRL_Backups 
