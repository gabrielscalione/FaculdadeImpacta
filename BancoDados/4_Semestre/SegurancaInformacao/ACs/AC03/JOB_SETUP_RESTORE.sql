select * from controle_dba..vw_consulta_jobs


-- JOB_SETUP_RESTORE

  --job de restore database  
declare @filename varchar(512) ,
        @id int
select top 1 @filename = caminho + nome ,
             @id = id
from controle_dba.dbo.tbl_ctrl_backups
where tipo = 'DATABASE'
order by data desc restore database impacta
from disk = @filename with
replace, recovery;
update controle_dba.dbo.tbl_ctrl_backups
set restaurado = 1
where id = @id