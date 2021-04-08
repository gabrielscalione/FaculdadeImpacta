

Dado um tipo de ve�culo (ex: 'moto'), uma placa, ex:'GHY6543'
um tipo de plano para cobran�a( ex: 'Avulso Horista' )
e um local para estacionamento(ex: 'Faculdade Impacta - Paulista')
- verificar a capacidade do estacionamento neste momento.
- verificar se o per�odo do plano escolhido � aceito pela localidade.
- verificar se a hora atual est� condizente com o plano de cobran�a.
- registrar o in�cio do estacionamento.
- Devolver o "ID" ( que ser� impresso no ticket ) daquele estacionamento.

/*coleto o id do estacionamento
Posso utiliz�-lo para simpleficar as demas consultas*/
select id from localidade where identificacao = 'Faculdade Impacta - Paulista'

/*coleto o id do ve�culo
Posso utiliz�-lo para simpleficar as demas consultas*/
select id from veiculo where placa = 'GHY6543'

/*coleto o id do ve�culo*/
SE o ve�culo j� est� cadastrado, ou seja, n�o � a primeira vez que ele estaciona.
Basca buscar o id do ve�culo pela placa.
	select id from veiculo where placa = 'GHY6543'
SEN�O, caso seja a primeira vez que ele estaciona, � necess�rio estacionar o ve�culo
Como � um cliente horista, n�o preciso cadastrar um cliente ( apenas para mensalistas )
	Insert veiculo( tipo, placa, idCliente)
	VALUES ( 'moto', 'GHY6543', NULL )

/*Verificar se aquela localidade aceita aquele plano, 
Devolver o ID do plano atual naquele hor�rio de atua��o.
ou seja, o plano que ser� utilizado para a cobran�a;
O plano pertence � uma categoria que determina o hor�rio de atua��o
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
De um certo tipo de ve�culo em um certo momento
Est�o estacionados agora quaisquer ve�culos sem data de sa�da)*/
SELECT	COUNT(*) as total
FROM	estacionamento
		INNER JOIN veiculo ON idVeiculo = veiculo.id
		INNER JOIN localidade ON idLocalidade = localidade.id
WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
		AND tipo = 'moto'
		AND dataHoraSaida IS NULL

/*Finalmente, basta inserir a entrada de um ve�culo em uma localidade*/
INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
VALUES ( 1, 4, 6 )

/*descubro o �ltimo ID utilizado para devolve-lo.*/
select @@identity
--select max(id) from estacionamento where ... /*arriscado sem o devido WHERE*/
--OUTPUT seria �tima solu��o, vamos aprender sobre ele mais tarde.


Dado um ID ( que est� presente no ticket impresso ) 
e um hor�rio de sa�da ( 3 horas depois da entrada )
- Calcular valor a ser pago.
- Registrar a sa�da do estacionamento.

/*De posso do ticket, que cont�m o ID, � simples localidar o ve�culo estacionado
Por�m, eu preciso acessar o plano contratado para descobrir o valor a cobrar
Poderia supor 3 horas exatas para simplificar o valor, 
por�m, o correto � calcular a diferen�a em minutos e cobrar devidamente.
*/
update estacionamento
	SET dataHoraSaida = GETDATE()--dateadd(hour,3,datahoraEntrada)
	, valorCobrado = plano.valor * 3 /*Suporto N�mero de horas*/
FROM	estacionamento
		INNER JOIN Plano on estacionamento.idPlano = plano.id
WHERE	estacionamento.id = 3 /*suposto Ticket do estacionamento*/

/*conferindo os valores inseridos*/
select * from estacionamento
