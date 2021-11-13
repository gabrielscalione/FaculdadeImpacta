-- criando DATABASE na principal

USE
MASTER
CREATE
DATABASE Replicante_Impacta
CONTAINMENT = NONE
ON PRIMARY
(	NAME = N' Replicante_Impacta', 
	FILENAME = N'C:\BD\MDF\Replicante_Impacta.mdf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB )
LOG
ON
(	NAME = N'Replicante_Impacta_ log',
	FILENAME = N'C:\BD\LDF\Replicante_Impacta_log.ldf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB )
GO
USE
Replicante_Impacta
GO