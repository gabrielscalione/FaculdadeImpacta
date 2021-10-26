
--●	(1) Visão que devolva: Lista com Nome do Paciente, número do telefone, Data e hora da consulta, duração da consulta, nome do Médico e Sala em que foi feito o atendimento. ( consulta idêntica ao exemplo original ).


CREATE VIEW view_medicoSala
AS

SELECT 
	Pa.Nome as Paciente,
	pa.Telefone as Contato,
	CONVERT(varchar, co.DataHora, 103) + ' ' + FORMAT (co.DataHora, 'HH:mm') as 'Consulta (data/hora)',
	co.Duracao as Duração,
	me.Nome as Médico,
	me.Especialidade,
	sa.Numero as Sala
FROM 
	Consulta CO
	INNER JOIN Medico ME
		ON ME.ID = CO.ID_Medico
	INNER JOIN Sala SA
		ON SA.Numero = CO.Numero_Sala
	INNER JOIN Paciente PA
		ON PA.ID = CO.ID_PACIENTE

SELECT * FROM view_medicoSala

-- ●	(2) Função que, dado o nome do paciente, devolva seu telefone. 

CREATE OR ALTER FUNCTION dbo.fn_RetornaContato(@ST VARCHAR(max))
	RETURNS int
	AS
	BEGIN
		declare @contato int
		
		select @contato = Telefone 
		from Paciente
		where Nome like @ST
		
		return @contato
	END
	GO

select dbo.fn_RetornaContato('Lucas do Nascimento Galdino da Silva') Contato





-- ●	(3) Função para, dado o telefone, devolver o nome do paciente.
CREATE OR ALTER FUNCTION dbo.fn_RetornaPaciente(@contato int)
	RETURNS VARCHAR(50)
	AS
	BEGIN
		declare @paciente VARCHAR(50)
		
		select @paciente = Nome
		from Paciente
		where Telefone = @contato
		
		return @paciente
	END
	GO

select dbo.fn_RetornaPaciente(dbo.fn_RetornaContato('Lucas do Nascimento Galdino da Silva')) Paciente

--●	(4) Procedure que, dado o numero de uma sala e um dia, devolva todas as consultas naquele dia, naquela sala. Devolva o nome do paciente, nome do médico, horário e duração da consulta

CREATE OR ALTER procedure dbo.consultasDias @sala int, @dia date
As
	SELECT 
		Pa.Nome as Paciente,
		pa.Telefone as Contato,
		CONVERT(varchar, co.DataHora, 103) + ' ' + FORMAT (co.DataHora, 'HH:mm') as 'Consulta (data/hora)',
		co.Duracao as Duração,
		me.Nome as Médico,
		me.Especialidade,
		sa.Numero as Sala
	FROM 
		Consulta CO
		INNER JOIN Medico ME
			ON ME.ID = CO.ID_Medico
		INNER JOIN Sala SA
			ON SA.Numero = CO.Numero_Sala
		INNER JOIN Paciente PA
			ON PA.ID = CO.ID_PACIENTE
	where
		sa.Numero = @sala
		and convert(date, co.DataHora) = @dia
	
declare @data datetime = getdate()-1

exec consultasDias 379, @data



-- ●	(5) Procedure que, dado o nome OU CRM do médico, devolva as últimas 10 consultas que ele realizou. Apresente o nome do paciente, data, hora e duração da consulta e número da sala.

CREATE OR ALTER procedure dbo.ultimasDezConsultas @crm int
As
	SELECT top 10
		Pa.Nome as Paciente,
		pa.Telefone as Contato,
		CONVERT(varchar, co.DataHora, 103) + ' ' + FORMAT (co.DataHora, 'HH:mm') as 'Consulta (data/hora)',
		co.Duracao as Duração,
		me.Nome as Médico,
		me.Especialidade,
		sa.Numero as Sala
	FROM 
		Consulta CO
		INNER JOIN Medico ME
			ON ME.ID = CO.ID_Medico
		INNER JOIN Sala SA
			ON SA.Numero = CO.Numero_Sala
		INNER JOIN Paciente PA
			ON PA.ID = CO.ID_PACIENTE
	where
		me.CRM = @crm
	order by co.DataHora desc


exec ultimasDezConsultas 88666




