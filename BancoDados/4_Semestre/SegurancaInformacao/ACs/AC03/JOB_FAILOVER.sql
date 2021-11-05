
IF(SELECT state_desc FROM PRINCIPAL.master.Sys.databases as srv_principal where srv_principal.name = 'impacta') != 'ONLINE'
begin
	-- Comando para deixar a base ONLINE
	RESTORE DATABASE IMPACTA WITH RECOVERY

	exec msdb..sp_update_job @job_name = 'JOB_SETUP_RESTORE', @enabled = 0 --Disable
	exec msdb..sp_update_job @job_name = 'RESTORE_BD', @enabled = 0 --Disable
	exec msdb..sp_update_job @job_name = 'RESTORE_LOG', @enabled = 0 --Disable
end
