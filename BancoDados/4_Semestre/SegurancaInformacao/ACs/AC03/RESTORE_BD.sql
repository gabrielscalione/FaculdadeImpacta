select * from controle_dba..vw_consulta_jobs

-- RESTORE_BD

  --job de restore database  
DECLARE @fileName VARCHAR(512) ,
                  @id int
SELECT TOP 1 @fileName = CAMINHO + nome ,
             @id = id
FROM controle_dba.dbo.TBL_CTRL_Backups
WHERE tipo = 'DATABASE'
ORDER BY DATA DESC RESTORE DATABASE IMPACTA
FROM DISK = @fileName WITH
REPLACE, NORECOVERY;

UPDATE controle_dba.dbo.TBL_CTRL_Backups
SET restaurado = 1
where id = @id