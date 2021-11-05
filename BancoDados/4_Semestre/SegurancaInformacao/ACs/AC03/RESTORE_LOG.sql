select * from controle_dba..vw_consulta_jobs

-- RESTORE_LOG

--job de restore LOG  
DECLARE @fileName VARCHAR(512) ,
                  @id int -- cursor com uma lista de arquivos a serem restaurados
DECLARE ARQUIVOS
CURSOR LOCAL
FOR
   ( SELECT id ,
                 CAMINHO + nome as fileName
     FROM controle_dba.dbo.TBL_CTRL_Backups
     WHERE tipo = 'LOG'
         AND restaurado = 0
         AND id >
             (SELECT TOP 1 id
              FROM controle_dba.dbo.TBL_CTRL_Backups
              WHERE tipo = 'DATABASE'
              ORDER BY DATA DESC) ) OPEN ARQUIVOS FETCH NEXT
FROM ARQUIVOS INTO @id,
                   @fileName WHILE (@@FETCH_STATUS= 0) BEGIN RESTORE LOG IMPACTA
FROM DISK = @fileName WITH standby = 'C:\BD\TRN\impacta.trn';

UPDATE controle_dba.dbo.TBL_CTRL_Backups
SET restaurado = 1
where id = @id FETCH NEXT
    FROM ARQUIVOS INTO @id,
                       @fileName END CLOSE ARQUIVOS DEALLOCATE ARQUIVOS