Entrada:
Dado um tipo de ve�culo (ex: 'moto'), uma placa, ex:'GHY6543'
um tipo de plano para cobran�a( ex: 'Avulso Horista' )
e um local para estacionamento(ex: 'Faculdade Impacta - Paulista')
- verificar a capacidade do estacionamento neste momento.
- verificar se o per�odo do plano escolhido � aceito pela localidade.
- verificar se a hora atual est� condizente com o plano de cobran�a.
- registrar o in�cio do estacionamento.
- Devolver o "ID" ( que ser� impresso no ticket ) daquele estacionamento.
Sa�da:
Dado um ID ( que est� presente no ticket impresso ) 
e um hor�rio de sa�da ( 3 horas depois da entrada )
- Calcular valor a ser pago.
- Registrar a sa�da do estacionamento.

DECLARE		@idLocalidade INT
		,	@idVeiculo INT
		,	@idCategoriaPlano INT
		,	@idPlano INT
		,	@idEstacionamento INT

/*coleto o id do estacionamento
Posso utiliz�-lo para simpleficar as demas consultas*/
select @idLocalidade= id from localidade where identificacao = 'Faculdade Impacta - Paulista'

/*Coleto o id da categoria do plano de cobran�a - 'Avulso Horista'*/
select @idCategoriaPlano = id from categoriaPlano where nome = 'Avulso Horista'

/*coleto o id do ve�culo*/
/*
SE o ve�culo j� est� cadastrado, ou seja, n�o � a primeira vez que ele estaciona.
Basca buscar o id do ve�culo pela placa.
*/
	select @idVeiculo = id from veiculo where placa = 'GHY6543'
/*
SEN�O, caso seja a primeira vez que ele estaciona, � necess�rio estacionar o ve�culo
Como � um cliente horista, n�o preciso cadastrar um cliente ( apenas para mensalistas )
	Insert veiculo( tipo, placa, idCliente)
	VALUES ( 'moto', 'GHY6543', NULL )
	select @idVeiculo = SCOPE_IDENTITY()
--OU  
	select @idVeiculo = @@IDENTITY
*/

/*Verificar se aquela localidade aceita aquele plano, 
Devolver o ID do plano atual naquele hor�rio de atua��o.
ou seja, o plano que ser� utilizado para a cobran�a;
O plano pertence � uma categoria que determina o hor�rio de atua��o
Apenas um plano pode estar ativo por vez por categoria.
*/
SELECT	@idPlano = plano.id
FROM	plano 
		INNER JOIN categoriaPlano ON plano.idcategoria = categoriaPlano.id
		/*N�o preciso do join com localidade pois j� tenho o id da localidade dado seu nome*/
		--INNER JOIN localidade ON plano.idlocalidade = localidade.id
WHERE	plano.idlocalidade = @idLocalidade
		--localidade.identificacao = 'Faculdade Impacta - Paulista'	
		AND plano.idCategoria = @idCategoriaPlano
		--AND categoriaPlano.nome = 'Avulso Horista'	
		AND CONVERT(TIME,GETDATE()) between categoriaPlano.horarioInicio AND categoriaPlano.horarioTermino
		AND plano.ativo = 1

/*Para verificar a capacidade de uma localidade/estacionamento
De um certo tipo de ve�culo em um certo momento
Est�o estacionados agora quaisquer ve�culos sem data de sa�da)*/
SELECT	COUNT(*) as total
FROM	estacionamento
		INNER JOIN veiculo ON idVeiculo = veiculo.id
		/*N�o preciso do join com localidade pois j� tenho o id da localidade dado seu nome*/
		--INNER JOIN localidade ON plano.idlocalidade = localidade.id
WHERE	estacionamento.idLocalidade = @idLocalidade
		--localidade.identificacao = 'Faculdade Impacta - Paulista'	
		AND tipo = 'moto'
		AND dataHoraSaida IS NULL

/* Se o total de ve�culos for inferior � capacidade, registrar o estacionamento*/
select capacidade_moto from localidade where identificacao = 'Faculdade Impacta - Paulista'	

/*Se a capacidade atual for inferior � capacidade total pode inserir*/

/*Finalmente, basta inserir a entrada de um ve�culo em uma localidade*/
INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
VALUES ( @idLocalidade, @idVeiculo, @idPlano )

/*descubro o �ltimo ID utilizado para devolve-lo.*/
select @idEstacionamento = @@identity
--select max(id) from estacionamento where ... /*arriscado sem o devido WHERE*/
--OUTPUT seria �tima solu��o, vamos aprender sobre ele mais tarde.

--Confer�ncia
select	* from estacionamento where id = @idEstacionamento 

GO -- Quebra de sess�o, vari�veis acima n�o valem daqui para frente.

Dado um ID ( que est� presente no ticket impresso ) 
e um hor�rio de sa�da ( 3 horas depois da entrada )
- Calcular valor a ser pago.
- Registrar a sa�da do estacionamento.

/*De posso do ticket, que cont�m o ID, � simples localidar o ve�culo estacionado
Por�m, eu preciso acessar o plano contratado para descobrir o valor a cobrar
Poderia supor 3 horas exatas para simplificar o valor, 
por�m, o correto � calcular a diferen�a em minutos e cobrar devidamente.
*/

Declare @idEstacionamento INT = 14 /*suposto Ticket do estacionamento*/

/*
Dado o Id do estacionamento, declarado na vari�vel, 
basta calcular o valor a ser cobrado = valor do plano * n�mero de horas

Para nossa sorte, o n�mero de horas j� � automaticamente calculado 
na coluna: horasEstacionado 
	as ( 
		CEILING ( DATEDIFF(minute,dataHoraEntrada,ISNULL(dataHoraSaida, GETDATE() )) / 60.00 )
	)
*/

update estacionamento
	SET dataHoraSaida = GETDATE()
	, valorCobrado = plano.valor * horasEstacionado
FROM	estacionamento
		INNER JOIN Plano on estacionamento.idPlano = plano.id
WHERE	estacionamento.id = @idEstacionamento

/*conferindo os valores inseridos*/
select * from estacionamento where id = @idEstacionamento


