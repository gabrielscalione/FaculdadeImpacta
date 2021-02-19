--- Adicionar uma coluna na tabela estacionamento
DECLARE @entrada DATETIME = '2021-02-08 21:20:00'
DECLARE @saida DATETIME = '2021-02-10 23:20:10'

ALTER TABLE estacionamento
	ADD horasEstacionamento 
	as (
			CEILING(datediff(minute,@entrada,ISNULL(@saida,GETDATE())/60.00
	)





