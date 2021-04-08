--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 08 - Transações, Erros: Geração, Captura e Tratamento de erros; Debug.
--=X=-- 	Logs e rastreamento de erros.
--=X=-- 	Debug de processos.
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- ERROS - Exercícios
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Gere uma mensagem de erro customizada para indicar quando a capacidade do estabelecimento para aquele tipo de veículo foi superada ( sp_addmessage )
A inserção de novos veículos na tabela estacionamento deve estar dentro de uma transação explícita. ( BEGIN TRAN → COMMIT / ROLLBACK)
Inclua o código de inserção na tabela estacionamento em um bloco de captura ( TRY CATCH )
Faça a verificação da capacidade atual vs máxima dentro do bloco de captura, com as seguintes condições:
Se o veículo puder ser estacionado → insira-o e capture o ID inserido.
Se o veículo não puder ser estacionado → gere a mensagem de erro customizada acima, o registro não deve ser inserido.
No bloco de captura, trate o erro, armazenando-o em uma variável ( para ser utilizada mais tarde ), encerrando a transação ( ROLLBACK ).
Fora do bloco de captura,  verifique se a transação realmente foi concluída, senão, encerre-a corretamente (COMMIT) ou dê uma mensagem de erro.
Finalmente: Exiba ( PRINT ou SELECT ) o ID recém inserido ou apresente uma mensagem do por que ele não foi inserido.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

-- Gere uma mensagem de erro customizada para indicar 
-- quando a capacidade do estabelecimento para aquele 
-- tipo de veículo foi superada ( sp_addmessage )
USE master;  
GO  
EXEC sp_addmessage @msgnum = 60000, @severity = 16,   
   @msgtext = N'Error: maximum capacity reached'
   ,@lang = 'us_english'
   --,@replace = 'replace'
EXEC sp_addmessage @msgnum = 60000, @severity = 16,   
   @msgtext = N'Erro: capacidade máxima atingida'   
   ,@lang = 'Português (Brasil)'
   --,@replace = 'replace';
GO  
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

/*A inserção de novos veículos na tabela estacionamento deve 
estar dentro de uma transação explícita. ( BEGIN TRAN → COMMIT / ROLLBACK)
*/
BEGIN TRAN
	/*Demais queries de conferência ...*/

	/*Finalmente, basta inserir a entrada de um veículo em uma localidade*/
	INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
	VALUES ( @idLocalidade, @idVeiculo, @idPlano )
COMMIT
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

--Inclua o código de inserção na tabela estacionamento em um 
--bloco de captura ( TRY CATCH )
BEGIN TRAN
	BEGIN TRY
		/*Queries de coleta de valores ...*/
		/*Demais queries de conferência ...*/
		/*Finalmente, basta inserir a entrada de um veículo em uma localidade*/
		INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
		VALUES ( @idLocalidade, @idVeiculo, @idPlano )
	END TRY
	BEGIN CATCH
		/*cláusulas de tratamento de erro*/
	END CATCH
COMMIT
/*Conclusão do processo*/

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

--Faça a verificação da capacidade atual vs máxima dentro do bloco de captura
BEGIN TRAN
	BEGIN TRY
		/*Queries de coleta de valores*/
		SELECT @lotacaoAtual = COUNT(*) FROM estacionamento --...	
		SELECT @capacidadeMaxima 
			= IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
		FROM localidade 
		WHERE identificacao = 'Faculdade Impacta - Paulista'	
		/*Queries de conferência ...*/
		IF @lotacaoAtual > @capacidadeMaxima
			RAISERROR(60000,16,1)
		/*Finalmente, basta inserir a entrada de um veículo em uma localidade*/
		INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
		VALUES ( @idLocalidade, @idVeiculo, @idPlano )
	END TRY
	BEGIN CATCH
		/*cláusulas de tratamento de erro*/
	END CATCH
COMMIT
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

--	Se o veículo puder ser estacionado 
--	→	 insira-o e capture o ID inserido.
-- Se o veículo não puder ser estacionado 
--	→ gere a mensagem de erro customizada acima
-- , o registro não deve ser inserido.
BEGIN TRAN
	BEGIN TRY
		/*Queries de coleta de valores*/
		SELECT @lotacaoAtual = COUNT(*) FROM estacionamento --...	
		SELECT @capacidadeMaxima 
			= IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
		FROM localidade 
		WHERE identificacao = 'Faculdade Impacta - Paulista'	
		/*Queries de conferência ...*/
		IF @lotacaoAtual > @capacidadeMaxima
			RAISERROR(60000,16,1)
		/*Finalmente, basta inserir a entrada de um veículo em uma localidade*/
		INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
		VALUES ( @idLocalidade, @idVeiculo, @idPlano )
		/*descubro o último ID utilizado para devolve-lo.*/
		select @idEstacionamento = @@identity
	END TRY
	BEGIN CATCH
		/*cláusulas de tratamento de erro*/
	END CATCH
COMMIT
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 


--No bloco de captura, trate o erro, armazenando-o em uma variável
-- ( para ser utilizada mais tarde ), encerrando a transação ( ROLLBACK ).
DECLARE @errorMsg VARCHAR(MAX) = ''
BEGIN TRAN
	BEGIN TRY
		/*Queries de coleta de valores*/
		SELECT @lotacaoAtual = COUNT(*) FROM estacionamento --...	
		SELECT @capacidadeMaxima 
			= IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
		FROM localidade 
		WHERE identificacao = 'Faculdade Impacta - Paulista'	
		/*Queries de conferência ...*/
		IF @lotacaoAtual > @capacidadeMaxima
			RAISERROR(60000,16,1)
		/*Finalmente, basta inserir a entrada de um veículo em uma localidade*/
		INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
		VALUES ( @idLocalidade, @idVeiculo, @idPlano )
		/*descubro o último ID utilizado para devolve-lo.*/
		select @idEstacionamento = @@identity
	END TRY
	BEGIN CATCH
		SET @errorMsg = CONVERT(varchar,ERROR_NUMBER()) + ' - ' + ERROR_MESSAGE()
		/*cláusulas de tratamento de erro*/
		ROLLBACK
		--THROW; --opcional, não foi solicitado, mas é uma prática comum.
	END CATCH
COMMIT

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

-- Fora do bloco de captura,  verifique se a transação realmente foi concluída
-- , senão, encerre-a corretamente (COMMIT) ou dê uma mensagem de erro.
DECLARE @errorMsg VARCHAR(MAX) = ''
BEGIN TRAN
	BEGIN TRY
		/*Queries de coleta de valores*/
		SELECT @lotacaoAtual = COUNT(*) FROM estacionamento --...	
		SELECT @capacidadeMaxima 
			= IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
		FROM localidade 
		WHERE identificacao = 'Faculdade Impacta - Paulista'	
		/*Queries de conferência ...*/
		IF @lotacaoAtual > @capacidadeMaxima
			RAISERROR(60000,16,1)
		/*Finalmente, basta inserir a entrada de um veículo em uma localidade*/
		INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
		VALUES ( @idLocalidade, @idVeiculo, @idPlano )
		/*descubro o último ID utilizado para devolve-lo.*/
		select @idEstacionamento = @@identity
	END TRY
	BEGIN CATCH
		SET @errorMsg = CONVERT(varchar,ERROR_NUMBER()) + ' - ' + ERROR_MESSAGE()
		/*cláusulas de tratamento de erro*/
		ROLLBACK
		--THROW; --opcional, não foi solicitado, mas é uma prática comum.
	END CATCH
-- Só comita se a transação ainda estiver ativa, ou seja, não existiu ROLLBACK
IF @@TRANCOUNT > 0
	COMMIT

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

-- Finalmente: Exiba ( PRINT ou SELECT ) o ID recém inserido ou apresente 
-- uma mensagem do por que ele não foi inserido.
DECLARE @errorMsg VARCHAR(MAX) = ''
BEGIN TRAN
	BEGIN TRY
		/*Queries de coleta de valores*/
		SELECT @lotacaoAtual = COUNT(*) FROM estacionamento --...	
		SELECT @capacidadeMaxima 
			= IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
		FROM localidade 
		WHERE identificacao = 'Faculdade Impacta - Paulista'	
		/*Queries de conferência ...*/
		IF @lotacaoAtual > @capacidadeMaxima
			RAISERROR(60000,16,1)
		/*Finalmente, basta inserir a entrada de um veículo em uma localidade*/
		INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
		VALUES ( @idLocalidade, @idVeiculo, @idPlano )
		/*descubro o último ID utilizado para devolve-lo.*/
		select @idEstacionamento = @@identity
	END TRY
	BEGIN CATCH
		SET @errorMsg = CONVERT(varchar,ERROR_NUMBER()) + ' - ' + ERROR_MESSAGE()
		/*cláusulas de tratamento de erro*/
		ROLLBACK
		--THROW; --opcional, não foi solicitado, mas é uma prática comum.
	END CATCH
-- Só comita se a transação ainda estiver ativa, ou seja, não existiu ROLLBACK
-- Imprimindo o ID ou a msg de erro ( se ela existir )
IF ( @@TRANCOUNT > 0 AND @errorMsg = '' )
BEGIN
	PRINT 'Inserção realizada com sucesso, ID: ' + convert(varchar,@idEstacionamento)
	COMMIT
END
ELSE
	PRINT 'Inserção não realizada: ' + @errorMsg

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
FIM

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Processo completo do estacionamento até o momento...
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Entrada:
Dado um tipo de veículo (ex: 'moto'), uma placa, ex:'GHY6543'
um tipo de plano para cobrança( ex: 'Avulso Horista' )
e um local para estacionamento(ex: 'Faculdade Impacta - Paulista')
- verificar a capacidade do estacionamento neste momento.
- verificar se o período do plano escolhido é aceito pela localidade.
- verificar se a hora atual está condizente com o plano de cobrança.
- registrar o início do estacionamento.
- Devolver o "ID" ( que será impresso no ticket ) daquele estacionamento.
Saída:
Dado um ID ( que está presente no ticket impresso ) 
e um horário de saída ( 3 horas depois da entrada )
- Calcular valor a ser pago.
- Registrar a saída do estacionamento.

/* Declaro variáveis para indicar os dados que serão recebidos pelo processo
*/
DECLARE		@nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista'
		,	@categoriaPlano VARCHAR(50) = 'Avulso Horista'
		,	@placaVeiculo VARCHAR(50) = 'GHY6543'
		,	@tipoVeiculo VARCHAR(50) = 'moto'

/* Declaro todas as variáveis que serão utilizadas para coleta de dados
*/
DECLARE		@idLocalidade INT
		,	@idVeiculo INT
		,	@idCategoriaPlano INT
		,	@idPlano INT
		,	@idEstacionamento INT
/*Declaro variáveis de controle internas */
DECLARE		@lotacaoAtual INT
			, @capacidadeMaxima INT

/*coleto o id do estacionamento
Posso utilizá-lo para simpleficar as demas consultas*/
select @idLocalidade= id from localidade where identificacao = @nomeEstacionamento

/*Coleto o id da categoria do plano de cobrança - 'Avulso Horista'*/
select @idCategoriaPlano = id from categoriaPlano where nome = @categoriaPlano

/*coleto o id do veículo*/
/*
SE o veículo já está cadastrado, ou seja, não é a primeira vez que ele estaciona.
Basca buscar o id do veículo pela placa.
*/
IF EXISTS (SELECT id FROM   veiculo WHERE  placa = @placaVeiculo)
  BEGIN	/* SE o veículo já está cadastrado, ou seja, não é a primeira vez que ele estaciona.
      Basca buscar o id do veículo pela placa.*/
      	SELECT @idVeiculo = id FROM   veiculo WHERE  placa = @placaVeiculo
  END
ELSE
  BEGIN /* SENÃO, caso seja a primeira vez que ele estaciona, é necessário estacionar o veículo
      	Como é um cliente horista, não preciso cadastrar um cliente ( para mensalistas )*/
      	INSERT veiculo (tipo, placa, idcliente) VALUES ( @tipoVeiculo, @placaVeiculo, NULL )
        SELECT @idVeiculo = Scope_identity()
  END

/*Verificar se aquela localidade aceita aquele plano, 
Devolver o ID do plano atual naquele horário de atuação.
ou seja, o plano que será utilizado para a cobrança;
O plano pertence à uma categoria que determina o horário de atuação
Apenas um plano pode estar ativo por vez por categoria.
*/
SELECT	@idPlano = plano.id
FROM	plano 
		INNER JOIN categoriaPlano ON plano.idcategoria = categoriaPlano.id
		/*Não preciso do join com localidade pois já tenho o id da localidade dado seu nome*/
		--INNER JOIN localidade ON plano.idlocalidade = localidade.id
WHERE	plano.idlocalidade = @idLocalidade
		--localidade.identificacao = @nomeEstacionamento
		AND plano.idCategoria = @idCategoriaPlano
		--AND categoriaPlano.nome = 'Avulso Horista'	
		AND CONVERT(TIME,GETDATE()) between categoriaPlano.horarioInicio AND categoriaPlano.horarioTermino
		AND plano.ativo = 1

DECLARE @errorMsg VARCHAR(MAX) = ''
BEGIN TRAN
	BEGIN TRY
		/*Queries de coleta de valores para conferência futura*/
			/*Para verificar a capacidade de uma localidade/estacionamento
			De um certo tipo de veículo em um certo momento
			Estão estacionados agora quaisquer veículos sem data de saída)*/
			SELECT @lotacaoAtual = COUNT(*) 
			FROM	estacionamento
					INNER JOIN veiculo ON idVeiculo = veiculo.id
					/*Não preciso do join com localidade pois já tenho o id da localidade dado seu nome*/
					--INNER JOIN localidade ON plano.idlocalidade = localidade.id
			WHERE	estacionamento.idLocalidade = @idLocalidade
					--localidade.identificacao = 'Faculdade Impacta - Paulista'	
					AND tipo = @tipoVeiculo
					AND dataHoraSaida IS NULL
			/*Para verificar a capacidade máxima do estacionamento para aquele tipo de veículo*/
			SELECT @capacidadeMaxima = IIF(@tipoVeiculo = 'moto',capacidade_moto, capacidade_carro)
			FROM localidade 
			WHERE identificacao = @nomeEstacionamento	
		/*Queries de conferência ...*/
		IF @lotacaoAtual > @capacidadeMaxima
			RAISERROR(60000,16,1)
		/*Finalmente, basta inserir a entrada de um veículo em uma localidade*/
		INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
		VALUES ( @idLocalidade, @idVeiculo, @idPlano )
		/*descubro o último ID utilizado para devolve-lo.*/
		select @idEstacionamento = @@identity
	END TRY
	BEGIN CATCH
		ROLLBACK;
		SET @errorMsg = CONVERT(varchar,ERROR_NUMBER()) + ' - ' + ERROR_MESSAGE()
		/*cláusulas de tratamento de erro*/
		--THROW; --opcional, não foi solicitado, mas é uma prática comum.
	END CATCH
-- Só comita se a transação ainda estiver ativa, ou seja, não existiu ROLLBACK
-- Imprimindo o ID ou a msg de erro ( se ela existir )
IF ( @@TRANCOUNT > 0 AND @errorMsg = '' )
BEGIN
	PRINT 'Inserção realizada com sucesso, ID: ' + convert(varchar,@idEstacionamento)
	COMMIT
END
ELSE
	PRINT 'Inserção não realizada: ' + @errorMsg
--Conferência
select	* from estacionamento --where id = @idEstacionamento 
GO -- Quebra de sessão, variáveis acima não valem daqui para frente.


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Saida: Dado um ID ( que está presente no ticket impresso ) 
e um horário de saída ( 3 horas depois da entrada )
- Calcular valor a ser pago.
- Registrar a saída do estacionamento.

/*De posso do ticket, que contém o ID, é simples localidar o veículo estacionado
Porém, eu preciso acessar o plano contratado para descobrir o valor a cobrar
Poderia supor 3 horas exatas para simplificar o valor, 
porém, o correto é calcular a diferença em minutos e cobrar devidamente.
*/

Declare @idEstacionamento INT = 14 /*suposto Ticket do estacionamento*/

/*
Dado o Id do estacionamento, declarado na variável, 
basta calcular o valor a ser cobrado = valor do plano * número de horas

Para nossa sorte, o número de horas já é automaticamente calculado 
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


