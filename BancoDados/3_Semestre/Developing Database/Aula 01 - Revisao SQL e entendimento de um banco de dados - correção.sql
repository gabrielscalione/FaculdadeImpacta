

Dado um tipo de veículo (ex: 'moto'), uma placa, ex:'GHY6543'
e um tipo de plano ( ex: 'Avulso Horista' )
- verificar a capacidade do estacionamento neste momento.
- registrar o início do estacionamento.
- Devolver o "ID" ( que será impresso no ticket ) daquele estacionamento.

SELECT	COUNT(*) as total
FROM	estacionamento
		INNER JOIN veiculo ON idVeiculo = veiculo.id
		INNER JOIN localidade ON idLocalidade = localidade.id
WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
		AND tipo = 'moto'
		AND dataHoraSaida IS NULL

--coleto o id do estacionamento
select id from localidade where identificacao = 'Faculdade Impacta - Paulista'
--coleto o id do veículo
SE já cadastrado
	select id from veiculo where placa = 'GHY6543'
SENÂO
	insert...
-- coleto o id do plano
select	plano.id 
from	plano 
		INNER JOIN categoriaPlano on idCategoria= categoriaPlano.id	
where	categoriaPlano.nome = 'Avulso Horista'
		and plano.ativo = 1

INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
--OUTPUT ...
VALUES ( 1, 4, 6 )

--descubro o último ID utilizado para devolve-lo.
select @@identity
--select max(id) from estacionamento


Dado um ID ( que está presente no ticket impresso ) 
e um horário de saída ( 3 horas depois da entrada )
- Calcular valor a ser pago.
- Registrar a saída do estacionamento.

update estacionamento
	SET dataHoraSaida = GETDATE()--dateadd(hour,3,datahoraEntrada)
	, valorCobrado = plano.valor * 3 /*?*/
FROM	estacionamento
		INNER JOIN Plano on estacionamento.idPlano = plano.id
WHERE	estacionamento.id = 3/*?*/

select * from estacionamento
