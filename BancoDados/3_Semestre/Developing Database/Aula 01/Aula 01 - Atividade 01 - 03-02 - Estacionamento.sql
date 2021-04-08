
select * from veiculo
select * from Cliente
select * from categoriaPlano
select * from Plano
select * from localidade
select * from estacionamento

/*
	Escreva os comandos em SQL ou Adicione comentários e explique sua lógica para:

#1 - Dado um tipo de veículo (ex: 'moto'), uma placa, ex:'GHY6543'
e um tipo de plano ( ex: 'Avulso Horista' )
A- verificar a capacidade do estacionamento neste momento.
B- registrar o início do estacionamento.
C- Devolver o "ID" ( que será impresso no ticket ) daquele estacionamento.
*/

declare @param_veiculo CHAR(5), 
		@param_placa CHAR(7), 
		@param_tipo_plano VARCHAR(255),
		@param_localidade VARCHAR(255)

set @param_veiculo = 'moto'
set @param_placa = 'GHY6543'
set @param_tipo_plano = 'Avulso Horista'
set @param_localidade = 'Faculdade Impacta - Paulista'

DECLARE @verifica_capacidade INT,
		@tamanho_estacionamento int,
		@cont_veiculos int

SET @tamanho_estacionamento = 10

Select 
	@cont_veiculos = count(*) 
from 
	estacionamento e
	inner join veiculo v 
		on v.id = e.id
	inner join localidade l
		on l.id = e.id
where l.localizacao = @param_localidade
	and v.tipo = @param_veiculo
		


IF @cont_veiculos < @tamanho_estacionamento
BEGIN
	SET @verifica_capacidade = 1
	PRINT('CAPACIDADE OK!')
END
ELSE
BEGIN 
	SET @verifica_capacidade = 0
	PRINT('CAPACIDADE NOK!')
END



