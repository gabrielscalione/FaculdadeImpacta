USE master
GO

--Crie um database (nome: ConsultorioAC1 ), com 1 Filegroups adicional, arquivo(.NDF), denominados:
-- FG_historico ( FG_historico_consultorio.ndf )

CREATE DATABASE ConsultorioAC1 
ON PRIMARY(NAME = 'ConsultorioAC1_Data', FILENAME = 'C:\BD\MDF\ConsultorioAC1_Data.mdf', 
SIZE = 25 MB, MAXSIZE = 40 MB, FILEGROWTH = 10 MB) 
LOG ON (NAME = 'ConsultorioAC1_log', FILENAME ='C:\BD\LDF\ConsultorioAC1_Log.ldf', 
SIZE = 5 MB, FILEGROWTH = 10 %) 


exec sp_helpdb ConsultorioAC1

-- Adicionando FILEGROUPs 
alter database ConsultorioAC1 add Filegroup FG_historico

-- Adicionando File 
alter database ConsultorioAC1 
add file (name = 'FG_historico_consultorio', filename = 'C:\BD\MDF\FG_historico_consultorio.ndf', size = 5MB, filegrowth=10%) to Filegroup FG_historico 

GO

USE ConsultorioAC1
GO

-- Altere os códigos de criação de todas as tabelas, com as seguintes especificações:
---- Todas as tabelas básicas ( Paciente, Médico, Sala ) ficarão na partição PRIMARY.
CREATE TABLE Paciente (
	ID INT NOT NULL IDENTITY(1,1)
	, Nome VARCHAR(50) NOT NULL
	, Telefone INT NULL
	, CONSTRAINT PK_Paciente PRIMARY KEY nonclustered ( ID )
) ON [PRIMARY]
GO
CREATE TABLE Sala (
	Numero INT NOT NULL 
	, CONSTRAINT PK_Sala PRIMARY KEY ( Numero )
) ON [PRIMARY]
GO
CREATE TABLE Medico (
	ID INT NOT NULL IDENTITY(1,1)
	, CRM VARCHAR(10) NOT NULL
	, Nome VARCHAR(50) NOT NULL
	, Especialidade VARCHAR(30) NULL
	, CONSTRAINT PK_Medico PRIMARY KEY ( ID )
) ON [PRIMARY]
GO

SP_HELP Paciente
GO
SP_HELP Sala
GO
SP_HELP Medico
GO


--- Crie uma função de particionamento para a tabela Consulta, segregando os dados anteriores à 2019 dos demais.
CREATE partition FUNCTION [PF_Consulta] (datetime)
AS range RIGHT
FOR VALUES('2019-01-01 00:00:00.000')

GO


-- Crie um esquema de partição, utilizando a função criada acima, para segregar os dados entre duas partições:
-- anteriores à 2019 na partição FG_historico e posteriores na partição padrão.
CREATE partition scheme [PS_Consulta]
AS partition pf_Consulta TO ( [FG_HISTORICO], [PRIMARY])

GO

-- Crie a tabela Consulta orientando-a a seguir as regras da partição recentemente criada. Inclua ( ou garanta que
-- existam ) valores com datas anteriores à 2019, entre 2019 e 2020 e posteriores à 2020 ( para teste ).

CREATE TABLE Consulta (
	ID INT NOT NULL IDENTITY(1,1)
	, ID_Paciente INT NOT NULL
	, ID_Medico INT NOT NULL
	, Numero_Sala INT NOT NULL
	, DataHora DATETIME NOT NULL
	, Duracao TINYINT NOT NULL
	, CONSTRAINT PK_Consulta PRIMARY KEY ( ID, DataHora ) ON PS_Consulta (DataHora)
	, CONSTRAINT FK_ConsultaMedico FOREIGN KEY ( Id_medico ) REFERENCES Medico( ID )
	, CONSTRAINT FK_ConsultaPaciente FOREIGN KEY ( Id_paciente ) REFERENCES paciente( ID )
	, CONSTRAINT FK_ConsultaSala FOREIGN KEY ( Numero_Sala ) REFERENCES Sala( Numero )
)
GO


--a) Faça um SPLIT da partição atual em 2 grupos, de 2019 a 2020 e de 2020 até hoje.
ALTER partition scheme ps_Consulta next used fg_historico;
ALTER partition function pf_Consulta() split range ('2020-01-01 00:00:00.000');

GO


--b) Faça um MERGE da partição de 2019 a 2020 com a partição histórica que já continha dados <= 2019.
ALTER partition function pf_Consulta() merge range ('2020-01-01 00:00:00.000');

GO

--Validação da separação dos dados.
SELECT p.partition_number,
fg.NAME,
p.rows
FROM sys.partitions p
INNER JOIN sys.allocation_units au
ON au.container_id = p.hobt_id
INNER JOIN sys.filegroups fg
ON fg.data_space_id = au.data_space_id
WHERE p.object_id = Object_id('Consulta')
GO