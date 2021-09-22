USE master
GO

-- Gerenciando FILEGROUP e FILE 
-- Drop Database DBAula 
CREATE DATABASE DBAula 
ON PRIMARY(NAME = 'DBAula_Data', FILENAME = 'C:\BD\MDF\DBAula_Data.mdf', 
SIZE = 25 MB, MAXSIZE = 40 MB, FILEGROWTH = 10 MB) 
LOG ON (NAME = 'DBAula_log', FILENAME ='C:\BD\LDF\DBAula_Log.ldf', 
SIZE = 5 MB, FILEGROWTH = 10 %) 


exec sp_helpdb DBAula

-- Adicionando FILEGROUPs 
alter database DBAula add Filegroup NovaAula 

-- Adicionando File 
alter database DBAula 
add file (name = 'NovaAula_Data', filename = 'C:\BD\MDF\NovaAula_Data.ndf', size = 5MB, filegrowth=10%) to Filegroup NovaAula 

-- Removendo Arquivos File (vazio)  
alter database DBAula remove file NovaAula_Data 

-- Adicionando Files 
alter database DBAula 
add file 
(name = 'NovaAula_Data1', filename = 'C:\BD\MDF\NovaAula_Data1.ndf', size = 5MB, filegrowth=10%) , 
(name = 'NovaAula_Data2', filename = 'C:\BD\MDF\NovaAula_Data2.ndf', size = 5MB, filegrowth=10%) to Filegroup NovaAula 

-- Removendo Arquivos File (vazio) e Filegroup 
alter database DBAula remove file NovaAula_Data1 

alter database DBAula remove file NovaAula_Data2 alter database DBAula remove Filegroup NovaAula

