/*
BD_ADS_SI - 2S - LSQL - A03 - Tipos de Dados - Aula 17/08/2020
Exercício 1
	1 - Retorne (print ou select)  o resultado exato de 5 ÷ 2
	2 - Faça o seguinte cálculo 200 + ((500 ÷ 20) x 10,5)
	3 - Crie 5 variáveis:
 			time_coracao varchar (500) =  Nome do time
			titulos int = quantidade de títulos nacionais
			ultimo_titulo date = data do ultimo titulo “YYYYMMDD”
			ingresso decimal(10,2) = ingresso do jogo do seu time
	4 - Atualize o valor do ingresso para o dobro do inicial.
*/

-- 1 -- 
select (5.0 / 2) as resultado

-- 2 --
select 200 + ((500/20) * 10.5) as calculo

-- 3 --
	declare @time_coracao varchar (500) 
	set @time_coracao = 'São Paulo'
	
	declare @titulos int 
	set @titulos = 6

	declare @ultimo_titulo date 
	set @ultimo_titulo = '20121212'
	


	declare @ingresso decimal(10,2) 
	set @ingresso = 40 

	select 
		@time_coracao time_coracao, 
		@titulos titulos, 
	@ultimo_titulo ultimo_titulo, 
	@ingresso ingresso

-- 4 -- 
	set @ingresso = @ingresso*@ingresso

	select @ingresso as dobro_ingresso



