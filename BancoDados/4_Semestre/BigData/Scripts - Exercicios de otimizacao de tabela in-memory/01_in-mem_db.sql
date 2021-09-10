--1. Criação do banco
create database in_memory
go

use in_memory
go

alter database CURRENT  
    SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = ON;  

--2. cria file group otimizado para memória
ALTER DATABASE in_memory 
ADD FILEGROUP fg_in_memory_opt CONTAINS MEMORY_OPTIMIZED_DATA

select * from sys.filegroups

--2b. adiciona arquivo de dados otimizado
ALTER DATABASE in_memory
 ADD FILE (name='f_in_memory_opt1',
 filename='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\in_memory_opt')
 TO FILEGROUP fg_in_memory_opt  

select * from sys.database_files


