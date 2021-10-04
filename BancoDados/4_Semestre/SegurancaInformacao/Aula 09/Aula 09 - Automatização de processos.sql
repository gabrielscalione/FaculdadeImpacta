/*
Pr�via AC3 - parte 1
*/
-- Crie um Banco de dados chamado IMPACTA, em modo de recupera��o cheio ( FULL ), com arquivo f�sico ( MDF ) localizado em C:\BD\MDF e arquivo de logs ( LDF ) em C:\BD\LDF.
USE MASTER
GO
CREATE DATABASE [IMPACTA]
 ON  PRIMARY 
( NAME = N'IMPACTA', FILENAME = N'C:\BD\MDF\IMPACTA.MDF' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'IMPACTA_LOG', FILENAME = N'C:\BD\LDF\IMPACTA_LOG.LDF' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
--for�ando o modo de recupera��o cheio ( FULL )
ALTER DATABASE [IMPACTA] SET RECOVERY FULL 
GO
-- Popule este banco com alguma tabela  e alguns dados ( apenas para que ele n�o fique em branco ).
USE IMPACTA;
GO
CREATE TABLE ALUNOS(
	ID INT PRIMARY KEY IDENTITY,
	NOME VARCHAR(45)
)
INSERT INTO ALUNOS VALUES ('FULANO'),('CICLANO'),('BELTRANO')
GO
SELECT * FROM IMPACTA.DBO.ALUNOS
GO
-- Realize o BACKUP FULL deste banco e armazene-o em C:\BD\Backups ( de o nome que achar melhor).
BACKUP DATABASE [IMPACTA]
TO DISK = 'C:\BD\Backups\BKP_IMPACTA.BAK'
WITH FORMAT, INIT;
GO
-- Realize o RESTORE deste banco no mesmo servidor em modo NORECOVERY, com nome IMPACTA_HA ( lembre-se de alterar o destino dos arquivos f�sicos ).
USE MASTER
GO
RESTORE DATABASE IMPACTA_HA
FROM DISK = 'C:\BD\Backups\BKP_IMPACTA.BAK'
WITH NORECOVERY
, MOVE 'IMPACTA' TO 'C:\BD\MDF\IMPACTA_HA.MDF'
, MOVE 'IMPACTA_LOG' TO 'C:\BD\LDF\IMPACTA_HA_LOG.LDF'
GO
-- Fa�a alguma altera��o no banco de dados IMPACTA ( como inserir novas linhas na tabela de testes ).
INSERT INTO IMPACTA.DBO.ALUNOS VALUES ('FULANA'),('CICLANA'),('BELTRANA')
GO
--Neste momento os bancos est�o diferentes.
SELECT * FROM IMPACTA.DBO.ALUNOS
SELECT * FROM IMPACTA_HA.DBO.ALUNOS
GO
-- Fa�a um BACKUP de LOG do banco IMPACTA e tamb�m armazene-o em C:\BD\Backups.
BACKUP LOG [IMPACTA]
TO DISK = 'C:\BD\Backups\IMPACTA_LOG.LOG'
WITH INIT
GO
-- Realize o RESTORE do LOG em modo STANDBY ( aponte o arquivo de standby para C:\BD\TRN ), do backup do LOG DO BANCO IMPACTA no banco IMPACTA_HA.
RESTORE LOG [IMPACTA_HA]
FROM DISK = 'C:\BD\Backups\IMPACTA_LOG.LOG'
WITH STANDBY = 'C:\BD\TRN\IMPACTA.TRN'
GO
-- Confira, executando um SELECT no banco IMPACTA_HA, se as informa��es adicionais criadas no banco IMPACTA est�o presentes no banco IMPACTA_HA.
--Neste momento os bancos voltaram a ficar iguais.
SELECT * FROM IMPACTA.DBO.ALUNOS
SELECT * FROM IMPACTA_HA.DBO.ALUNOS
/*
Extra, pensem em como resolver o seguinte problema:
Agora, voc� tem que armazenar N backups de LOG ( gerados de 5 em 5 mins ) e em algum momento futuro, voc� pode/deve restaur�-los, tais backups n�o podem se sobrescrever nem tampouco posso perder um deles. 
O processo deve ser todo autom�tico, sem interven��o humana.
*/
--Declaro vari�vel
DECLARE @NOME_BACKUP VARCHAR(255)
--Gero um nome aleat�rio baseado na data
SELECT	@NOME_BACKUP 
		= 'C:\BD\BACKUPS\IMPACTA_'
			+ CONVERT(VARCHAR(MAX),GETDATE(),112)
			+ LEFT(REPLACE(REPLACE(CONVERT(VARCHAR(MAX),CONVERT(TIME,GETDATE())),':',''),'.',''),6)
		+ '.BAK'
--imprimo o nome s� para confer�ncia
SELECT @NOME_BACKUP -- C:\BD\BACKUPS\IMPACTA_20210426144143.BAK
--Realizo o backup cujo destino ser� o caminho definido na vari�vel.
BACKUP DATABASE IMPACTA 
	TO DISK = @NOME_BACKUP 
WITH INIT;



