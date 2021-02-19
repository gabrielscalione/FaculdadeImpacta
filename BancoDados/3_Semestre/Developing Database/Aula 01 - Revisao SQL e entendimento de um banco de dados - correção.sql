

Dado um tipo de veículo (ex: 'moto'), uma placa, ex:'GHY6543'
um tipo de plano para cobrança( ex: 'Avulso Horista' )
e um local para estacionamento(ex: 'Faculdade Impacta - Paulista')
- verificar a capacidade do estacionamento neste momento.
- verificar se o período do plano escolhido é aceito pela localidade.
- verificar se a hora atual está condizente com o plano de cobrança.
- registrar o início do estacionamento.
- Devolver o "ID" ( que será impresso no ticket ) daquele estacionamento.

/*coleto o id do estacionamento
Posso utilizá-lo para simpleficar as demas consultas*/
select id from localidade where identificacao = 'Faculdade Impacta - Paulista'

/*coleto o id do veículo
Posso utilizá-lo para simpleficar as demas consultas*/
select id from veiculo where placa = 'GHY6543'

/*coleto o id do veículo*/
SE o veículo já está cadastrado, ou seja, não é a primeira vez que ele estaciona.
Basca buscar o id do veículo pela placa.
	select id from veiculo where placa = 'GHY6543'
SENÃO, caso seja a primeira vez que ele estaciona, é necessário estacionar o veículo
Como é um cliente horista, não preciso cadastrar um cliente ( apenas para mensalistas )
	Insert veiculo( tipo, placa, idCliente)
	VALUES ( 'moto', 'GHY6543', NULL )

/*Verificar se aquela localidade aceita aquele plano, 
Devolver o ID do plano atual naquele horário de atuação.
ou seja, o plano que será utilizado para a cobrança;
O plano pertence à uma categoria que determina o horário de atuação
Apenas um plano pode estar ativo por vez por categoria.
*/
SELECT	plano.id
FROM	plano 
		INNER JOIN categoriaPlano ON plano.idcategoria = categoriaPlano.id
		INNER JOIN localidade ON plano.idlocalidade = localidade.id
WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
		AND categoriaPlano.nome = 'Avulso Horista'	
		AND CONVERT(TIME,GETDATE()) between categoriaPlano.horarioInicio AND categoriaPlano.horarioTermino
		AND plano.ativo = 1

/*Para verificar a capacidade de uma localidade/estacionamento
De um certo tipo de veículo em um certo momento
Estão estacionados agora quaisquer veículos sem data de saída)*/
SELECT	COUNT(*) as total
FROM	estacionamento
		INNER JOIN veiculo ON idVeiculo = veiculo.id
		INNER JOIN localidade ON idLocalidade = localidade.id
WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
		AND tipo = 'moto'
		AND dataHoraSaida IS NULL

/*Finalmente, basta inserir a entrada de um veículo em uma localidade*/
INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
VALUES ( 1, 4, 6 )

/*descubro o último ID utilizado para devolve-lo.*/
select @@identity
--select max(id) from estacionamento where ... /*arriscado sem o devido WHERE*/
--OUTPUT seria ótima solução, vamos aprender sobre ele mais tarde.


Dado um ID ( que está presente no ticket impresso ) 
e um horário de saída ( 3 horas depois da entrada )
- Calcular valor a ser pago.
- Registrar a saída do estacionamento.

/*De posso do ticket, que contém o ID, é simples localidar o veículo estacionado
Porém, eu preciso acessar o plano contratado para descobrir o valor a cobrar
Poderia supor 3 horas exatas para simplificar o valor, 
porém, o correto é calcular a diferença em minutos e cobrar devidamente.
*/
update estacionamento
	SET dataHoraSaida = GETDATE()--dateadd(hour,3,datahoraEntrada)
	, valorCobrado = plano.valor * 3 /*Suporto Número de horas*/
FROM	estacionamento
		INNER JOIN Plano on estacionamento.idPlano = plano.id
WHERE	estacionamento.id = 3 /*suposto Ticket do estacionamento*/

/*conferindo os valores inseridos*/
select * from estacionamento
