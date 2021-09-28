--Criando um backup total com a opção de criar um novo cabeçalho
-- e sobrescrevendo-o caso um arquivo como mesmo nome já existir
BACKUP DATABASE ConsultorioAC1
TO DISK = 'C:\BD\Backups\ConsultorioAC1.bak'
WITH FORMAT, INIT;
GO
--Criando um backup distribuido em 3 arquivos
-- , cada um com sua exclusiva cópia de espelho:
BACKUP DATABASE ConsultorioAC1
TO DISK = 'C:\BD\Backups\ConsultorioAC1_1a.bak',
DISK = 'C:\BD\Backups\ConsultorioAC1_2a.bak',
DISK = 'C:\BD\Backups\ConsultorioAC1_3a.bak'
MIRROR TO DISK = 'C:\BD\Backups\ConsultorioAC1_1b.bak',
DISK = 'C:\BD\Backups\ConsultorioAC1_2b.bak',
DISK = 'C:\BD\Backups\ConsultorioAC1_3b.bak'
WITH FORMAT;

--Criando um backup diferencial
BACKUP DATABASE ConsultorioAC1
TO DISK = 'C:\BD\Backups\ConsultorioAC1.bak'
WITH DIFFERENTIAL
GO
--Criando um backup cujo destino é uma fita:
BACKUP DATABASE ConsultorioAC1
TO TAPE = '\\.\tape0'
MIRROR TO TAPE = '\\.\tape1'
WITH FORMAT,
	MEDIANAME = 'ConsultorioAC1Set0'

--Criando um backup com compressão de dados
BACKUP DATABASE ConsultorioAC1
TO DISK = 'C:\BD\Backups\ConsultorioAC1.bak'
WITH FORMAT, COMPRESSION

--Criando um backup sem ponto de restauração
-- últil para não interferir na estratégia de restauração
BACKUP DATABASE ConsultorioAC1
TO DISK = 'C:\BD\Backups\ConsultorioAC1.bak'
WITH COPY_ONLY

--Criando um backup deixando-o não operacional ( NORECOVERY )
-- útil em migrações, para a garantia de não 'perder' nada.
BACKUP DATABASE ConsultorioAC1
TO DISK = 'C:\BD\Backups\ConsultorioAC1.bak'
WITH NORECOVERY 

-- Backup com feedback a cada 10% concluídos
BACKUP DATABASE ConsultorioAC1 
TO DISK = 'C:\BD\Backups\ConsultorioAC1.bak' 
WITH STATS = 10

--Criando chave mestre para criptografia
USE master;  
GO  
CREATE MASTER KEY ENCRYPTION BY PASSWORD = N'!@@QW#E#$R%dreud76';
GO 
-- Criando certificado para autenticação
CREATE CERTIFICATE MeuCertificadoParaBackups 
   WITH SUBJECT = 'Database Encryption Certificate';  
GO 
--Backup com criptografia
BACKUP DATABASE ConsultorioAC1
TO DISK = 'C:\BD\Backups\ConsultorioAC1.bak'
WITH ENCRYPTION (ALGORITHM = AES_256, 
   SERVER CERTIFICATE =  MeuCertificadoParaBackups)

-- Sintaxe – Backup Log
-- opção NOINIT permite a adição de vários backups 
-- no mesmo arquivo.
BACKUP LOG ConsultorioAC1
TO DISK = 'C:\BD\Backups\ConsultorioAC1.log'
WITH NOINIT--, FORMAT

-- Backup de logs que expiram em uma data fixa
BACKUP LOG ConsultorioAC1
TO DISK = 'C:\BD\Backups\ConsultorioAC1.log'
WITH NOINIT, EXPIREDATE = '20210930'

-- Backup de logs que expiram em 7 dias
BACKUP LOG ConsultorioAC1
TO DISK = 'C:\BD\Backups\ConsultorioAC1.log'
WITH NOINIT, RETAINDAYS = 7

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--Backup de um banco ONLINE
-- NÃO aceita futuros restores em continuação
drop database ConsultorioAC1
go 

restore database ConsultorioAC1 
from disk = 'c:\bd\backups\ConsultorioAC1.bak'
with RECOVERY, REPLACE
--Backup de um banco OFFLINE 
-- mas que aceita futuros restores em continuação
restore database ConsultorioAC1 
from disk = 'c:\bd\backups\ConsultorioAC1.bak'
with STANDBY = 'c:\bd\TRN\ConsultorioAC1.trn'
--Backup de um banco STANDBY / READONLY 
-- mas que aceita futuros restores em continuação
restore database ConsultorioAC1 
from disk = 'c:\bd\backups\ConsultorioAC1.bak'
with NORECOVERY

--Listar os backups dentro de um arquivo
RESTORE FILELISTONLY 
FROM DISK = 'c:\bd\backups\ConsultorioAC1.bak'
--Ver detalhes dos bancos
exec sp_helpdb
--Ver detalhes de um banco
exec sp_helpdb 'ConsultorioAC1_clone'

--Para evitar que um banco seja restaurado sobre
-- os mesmos arquivos físicos ( MDF, LDF ) um novo
-- caminho pode ser fornecido.
RESTORE DATABASE ConsultorioAC1_Clone
FROM DISK = 'c:\bd\backups\ConsultorioAC1.bak'
WITH NORECOVERY,
MOVE 'ConsultorioAC1' TO 'c:\bd\mdf\ConsultorioAC1_Clone.mdf',
MOVE 'ConsultorioAC1_log' TO 'c:\bd\mdf\ConsultorioAC1_Clone_log.ldf'




--Listar os backups dentro de um arquivo
RESTORE filelistonly FROM DISK = 'c:\bd\backups\impacta.bak' 
--Ver detalhes dos bancos
EXEC Sp_helpdb
--Ver detalhes de um banco específico
EXEC Sp_helpdb 'impacta' 


select FORMAT(getdate(),'yyyyMMddHHmm')