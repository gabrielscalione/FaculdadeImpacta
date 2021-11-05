select * from medico where nome = '%Jose%'

create index IX_nomeSobrenome on CLiente(nome, sobrenome)
	where nome = 'jose' and sobrenome 'silva'	--perfeito
	where nome = 'jose' -- OK
	where sobrenome 'silva' --n�o � ideal



create index IX_localidade1 on CLiente(cidade, estado, pais)
create index IX_localidade2 on CLiente(pais,estado,cidade)

where cidade = 'X' and estado = 'Y' and pais = 'Z' -- 1 ou 2
where cidade = 'X' and estado = 'Y' -- 1 melhor que 2
where cidade = 'X' -- 1 � muito melhor que 2

where pais = 'Z' -- 2 � muito melhor que 1
where pais = 'Z' and estado = 'Y' -- 2 � melhor que 1
where pais = 'Z' and estado = 'Y' and cidade = 'Z'-- 2 = 1

CLUSTERED	- INDICE SOBRE A PR�PRIA TABELA - LIMITADO A 1 (*)= PK
NONCLUSTERED- ESTRUTURAS EXTRAS ( OCUPAM ESPA�O ) - POSSO TER N

100 xxxYxxxxxxxxxxxxxxxxxxxxxxxxX
90  xxxYxxxxx xxxx xxxx xxxx xxxXXXXX


SELECT * FROM MEDICO WHERE ESPECIALIDADE = 'Pediatra'
GO 100


sp_help_index MEDICO

SELECT DataHora, Numero_Sala FROM CONSULTA WHERE DataHora BETWEEN GETDATE() AND GETDATE()-30
GO 100
sp_help_index CONSULTA
SP_SPACEUSED CONSULTA

--SET STATISTICS TIME ON
--SET STATISTICS IO ON
SELECT DataHora, Numero_Sala 
FROM CONSULTA 
WHERE DataHora BETWEEN GETDATE() AND GETDATE()-30

Tabela 'Consulta'. Contagem de verifica��es 1
, leituras l�gicas 3746, leituras f�sicas 0, leituras de servidor de p�ginas 0, leituras antecipadas 0, leituras antecipadas de servidor de p�ginas 0, leituras l�gicas de LOB 0, leituras f�sicas de LOB 0, leituras de servidor de p�ginas LOB 0, leituras antecipadas de LOB 0, leituras antecipadas do servidor de p�ginas LOB 0.
 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 79 ms, tempo decorrido = 71 ms.
 
 -- PREDICADO: DATAHORA
 -- OBJETO: IX_CONSULTA_PACIENTE
 -- SAIDA: DATAHORA, NUMEROSALA
 -- CUSTO ESTIMADO DA SUBARVORE 4.00631

 SP_HELPINDEX CONSULTA
 SP_HELP_INDEX CONSULTA


CREATE NONCLUSTERED INDEX IX_CONSULTA_DATAHORA_SOZINHA
ON [dbo].[Consulta] ([DataHora])
--WITH ( FILLFACTOR = 90, PAD_INDEX = ON, DATA_COMPRESSION = PAGE )
--ON [FG_INDEXES]

DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS

SELECT DataHora, Numero_Sala 
FROM CONSULTA 
WHERE DataHora BETWEEN GETDATE() AND GETDATE()-30
Tabela 'Worktable'. Contagem de verifica��es 0, leituras l�gicas 0, leituras f�sicas 0, leituras de servidor de p�ginas 0, leituras antecipadas 0, leituras antecipadas de servidor de p�ginas 0, leituras l�gicas de LOB 0, leituras f�sicas de LOB 0, leituras de servidor de p�ginas LOB 0, leituras antecipadas de LOB 0, leituras antecipadas do servidor de p�ginas LOB 0.
Tabela 'Consulta'. Contagem de verifica��es 1, leituras l�gicas 3, leituras f�sicas 0, leituras de servidor de p�ginas 0, leituras antecipadas 0, leituras antecipadas de servidor de p�ginas 0, leituras l�gicas de LOB 0, leituras f�sicas de LOB 0, leituras de servidor de p�ginas LOB 0, leituras antecipadas de LOB 0, leituras antecipadas do servidor de p�ginas LOB 0.

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
 -- CUSTO ESTIMADO DA SUBARVORE 0.0065704

CREATE NONCLUSTERED INDEX IX_CONSULTA_DATAHORA_NUMEROSALA
ON [dbo].[Consulta] ([DataHora])
INCLUDE ([Numero_Sala])


DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS

SELECT DataHora, Numero_Sala 
FROM CONSULTA 
WHERE DataHora BETWEEN GETDATE() AND GETDATE()-30

Tabela 'Consulta'. Contagem de verifica��es 1, leituras l�gicas 3, leituras f�sicas 2, leituras de servidor de p�ginas 0, leituras antecipadas 0, leituras antecipadas de servidor de p�ginas 0, leituras l�gicas de LOB 0, leituras f�sicas de LOB 0, leituras de servidor de p�ginas LOB 0, leituras antecipadas de LOB 0, leituras antecipadas do servidor de p�ginas LOB 0.

 Tempos de Execu��o do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
--0.0032831



