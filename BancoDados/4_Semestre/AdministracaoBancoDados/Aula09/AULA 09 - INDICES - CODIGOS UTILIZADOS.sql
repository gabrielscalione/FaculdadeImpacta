select * from medico where nome = '%Jose%'

create index IX_nomeSobrenome on CLiente(nome, sobrenome)
	where nome = 'jose' and sobrenome 'silva'	--perfeito
	where nome = 'jose' -- OK
	where sobrenome 'silva' --não é ideal



create index IX_localidade1 on CLiente(cidade, estado, pais)
create index IX_localidade2 on CLiente(pais,estado,cidade)

where cidade = 'X' and estado = 'Y' and pais = 'Z' -- 1 ou 2
where cidade = 'X' and estado = 'Y' -- 1 melhor que 2
where cidade = 'X' -- 1 é muito melhor que 2

where pais = 'Z' -- 2 é muito melhor que 1
where pais = 'Z' and estado = 'Y' -- 2 é melhor que 1
where pais = 'Z' and estado = 'Y' and cidade = 'Z'-- 2 = 1

CLUSTERED	- INDICE SOBRE A PRÓPRIA TABELA - LIMITADO A 1 (*)= PK
NONCLUSTERED- ESTRUTURAS EXTRAS ( OCUPAM ESPAÇO ) - POSSO TER N

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

Tabela 'Consulta'. Contagem de verificações 1
, leituras lógicas 3746, leituras físicas 0, leituras de servidor de páginas 0, leituras antecipadas 0, leituras antecipadas de servidor de páginas 0, leituras lógicas de LOB 0, leituras físicas de LOB 0, leituras de servidor de páginas LOB 0, leituras antecipadas de LOB 0, leituras antecipadas do servidor de páginas LOB 0.
 Tempos de Execução do SQL Server:
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
Tabela 'Worktable'. Contagem de verificações 0, leituras lógicas 0, leituras físicas 0, leituras de servidor de páginas 0, leituras antecipadas 0, leituras antecipadas de servidor de páginas 0, leituras lógicas de LOB 0, leituras físicas de LOB 0, leituras de servidor de páginas LOB 0, leituras antecipadas de LOB 0, leituras antecipadas do servidor de páginas LOB 0.
Tabela 'Consulta'. Contagem de verificações 1, leituras lógicas 3, leituras físicas 0, leituras de servidor de páginas 0, leituras antecipadas 0, leituras antecipadas de servidor de páginas 0, leituras lógicas de LOB 0, leituras físicas de LOB 0, leituras de servidor de páginas LOB 0, leituras antecipadas de LOB 0, leituras antecipadas do servidor de páginas LOB 0.

 Tempos de Execução do SQL Server:
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

Tabela 'Consulta'. Contagem de verificações 1, leituras lógicas 3, leituras físicas 2, leituras de servidor de páginas 0, leituras antecipadas 0, leituras antecipadas de servidor de páginas 0, leituras lógicas de LOB 0, leituras físicas de LOB 0, leituras de servidor de páginas LOB 0, leituras antecipadas de LOB 0, leituras antecipadas do servidor de páginas LOB 0.

 Tempos de Execução do SQL Server:
 Tempo de CPU = 0 ms, tempo decorrido = 0 ms.
--0.0032831



