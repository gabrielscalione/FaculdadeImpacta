----------------------------------------------------
-- Backup de todos os bancos da instancia
----------------------------------------------------
execute sp_msforeachdb '
    use [?]
    if db_name() not in (''tempdb'', ''model'')
        begin
            declare @nm_pasta varchar(100) 
            set @nm_pasta = ''c:\temp\''
            declare @nm_arquivo varchar(1000) 
            -- Nome do arquivo: c:\tmp\aaaa-mm-dd__NomeInstancia__NomeBanco.bak
            set @nm_arquivo = 
                replace(convert(varchar, getdate(), 102), ''.'', ''-'') + ''__'' + 
                replace(@@servername, ''\'', ''-'') + ''__'' + 
                replace(db_name(), ''\'', ''-'')
            set @nm_arquivo = @nm_pasta + @nm_arquivo + ''.bak''
            print ''Iniciando o backup: '' + @nm_arquivo
            backup database [?] to disk = @nm_arquivo with init, copy_only, compression
        end
    else
        print ''Backup do banco ? ignorado.''
     
    '