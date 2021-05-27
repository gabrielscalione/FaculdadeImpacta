use  ImpactaEstacionamento
go

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

1. Descubra o erro da seguinte instrução:
	INSERT INTO localidade (id, identificacao, localizacao, capacidade_carro, capacidade_moto )
	values ( 10, 'Faculdade Impacta - Av. Rudge', 'Av.Rudge', 30, 10 )

Qual a correção e a explicação correta melhor aplicáveis para este cenário:
( tanto a correção quanto a explicação do erro devem estar corretos ).

A	Não fornecer o ID pois não se pode fornecer valores às chaves primárias.
	INSERT INTO localidade (identificacao, localizacao, capacidade_carro, capacidade_moto )
	values ( 'Faculdade Impacta - Av. Rudge', 'Av.Rudge', 30, 10 )
	
--B	Só se deve passar colunas que na definição da tabela sejam NOT NULL, e não as NULL
--	INSERT INTO localidade (identificacao, localizacao, capacidade_carro, capacidade_moto )
--	values ( 'Faculdade Impacta - Av. Rudge', 'Av.Rudge', 30, 10 )

--C	A ordem das colunas está incorreta
--	INSERT INTO localidade (identificacao, localizacao, capacidade_carro, capacidade_moto )
--	values ( 'Faculdade Impacta - Av. Rudge', 'Av.Rudge', 30, 10 )

--D	Não se deve fornecer valores à colunas auto-incrementais
--	INSERT INTO localidade (identificacao, localizacao, capacidade_carro, capacidade_moto )
--	values ( 'Faculdade Impacta - Av. Rudge', 'Av.Rudge', 30, 10 )

--E	N.D.A. OU Não há erro na query original, ela pode ser executada normalmente.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

2. Para devolver o total de veículos estacionados atualmente de um tipo específico (ie. moto)
lhe foi fornecida a seguinte consulta
		SELECT	tipo, COUNT(*) as total
		FROM	estacionamento
				INNER JOIN veiculo ON idVeiculo = veiculo.id
				INNER JOIN localidade ON idLocalidade = localidade.id
		WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
				
				AND dataHoraSaida IS NULL
			group by tipo
		...

Para alterar a consulta, fazendo-a devolver, em uma única instrução,
o total de veículos estacionados para todos os tipos de veículos (it. motos, carros, etc )
Quais linhas e quais alteraçãoes na query são sugeridas ?
Ex:		tipo	total
		------- ------
		Carro	4
		Moto	2

--A	Linha #3 transformar o INNER JOIN em LEFT JOIN 
--	Linha #4 transformar o INNER JOIN em LEFT JOIN 

B	Linha #1 incluir o tipo junto da contagem: SELECT tipo, COUNT(*) as total
	Linha #6 remover o filtro AND tipo = 'moto'
	Linha #8 incluir um agrupament por tipo: GROUP BY tipo

--C	Linha #6 remover o filtro AND tipo = 'moto'	 

--D	Linha #1 incluir o tipo junto da contagem: SELECT tipo, COUNT(*) as total
--	Linha #8 incluir um agrupament por tipo: GROUP BY tipo

--E	N.D.A. OU Não é necessária nenhuma mudança na query original.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

3.	Ao desejar armazenar um valor em uma variável, como no exemplo abaixo:
		DECLARE @idLocalidade INT
		select @idLocalidade=id from localidade where identificacao='Faculdade Impacta - Paulista'
		select @idLocalidade as IdCapturado

 Qual o tipo de dados mais recomendado e por que ?
 Qual o código que deve ser incluído na linha #1 ?
( tanto o cóidigo quanto a explicação devem estar corretos ).

--A	O recomendado é que a variável seja do mesmo tipo da coluna.
--	ex: SET @idLocalidade INT 

--B	O recomendado é que a variável SEMPRE seja dos tipos básicos ( INT, DATETIME ou VARCHAR)
--	ex: SELECT @idLocalidade VARCHAR(10)

--C	O tipo depende de como ela for utilizada, se for para contas: INT, para exibição: VARCHAR
--	ex: INSERT @idLocalidade VARCHAR

D	Independente da situação, toda variável deve ser um INTEIRO.
	ex: DECLARE @variável INT

--E	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

4. Lhe foi solicitado armazenar o resultado do select abaixo em variáveis :
		select id, capacidade_Moto 
		from localidade 
		where identificacao = 'Faculdade Impacta - Paulista'

Explique qual a maneira recomendável de se proceder ?
Quais alterações nos codigos seriam necessárias ?
( tanto o cóidigo quanto a explicação devem estar corretos ).

--A	Declarar duas variáveis, para o ID e capacidadeMoto
--	Dividir a query em duas, cada uma coleta uma variável de cada vez
--	É impossível capturar as duas variáveis de uma só vez.
--	SELECT @idLocalidade = id FROM...
--	SELECT @capacidade_Moto = capacidade_Moto FROM...

--B	Declarar uma variável composta que recebe id concatenado com a localidade
--	É impossível capturar as duas variáveis de uma só vez.
--	SELECT @ID+capacidade_Moto = ID + capacidade_Moto FROM...

C	Declarar duas variáveis, para o ID e capacidadeMoto	
	Capturar as duas variáveis na mesma query
	SELECT @idLocalidade = id, 
	       @capacidade_Moto = capacidade_Moto 
	FROM...
	
--D	Declarar uma variável do tipo tabela
--	Salvar os dois valores em uma única linha, mas cada uma em sua respectiva coluna.
--	INSERT @tabelaVariavel ( id, capacidade_Moto)
--	SELECT id, capacidade_Moto FROM...

--E	N.D.A OU não há uma maneira de armazenar o resultado de uma query em variáveis.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

5. Lhe foi fornecido o seguinte processo para devolver o ID de um veículo passado a placa e o tipo
caso ele não esteja na base, ele deve ser inserido e depois ter seu ID devolvido.

	DECLARE @idVeiculo int
			, @placa char(15) = 'GHY9546'
			, @tipo char(5) = 'moto'
	SELECT @idVeiculo = id from veiculo where placa = @placa
	
	IF ( @idVeiculo IS NULL )
	BEGIN
		Insert veiculo( tipo, placa, idCliente)
		VALUES ( @tipo, @placa, NULL )
		select @idVeiculo = SCOPE_IDENTITY()
	END

Que código deve ser inserido na linha #6 para que este processo funcione como esperado ?

A	IF ( @idVeiculo IS NULL )

--B	IF ISNULL(@idVeiculo,-1) = 0

--C	WHILE ( @idVeiculo IS NULL )

--D	EXISTS (select id from veiculo where placa = @placa)

--E	N.D.A Ou nada precisa ser inserido, o processo já está correto.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

6. Lhe foi fornecido duas variáveis, já com valores coletados de processos anteriores
	DECLARE @capacidadeAtual INT = 0
	DECLARE @capacidadeMaxima INT = 10
E a seguinte condição de desvio de fluxo condicional:
	IF @capacidadeAtual < @capacidadeMaxima
		print 'Permite a inserção do veículo'
	ELSE
		print 'Não Permite a inserção do veículo'
	
Porém, em testes, foi detectado que a variável @capacidadeAtual pode vir NULA
o que deveria permitir estacionamentos pois o NULO deve ser entendido como 0 ( zero )

Como ficaria o novo código da instrução IF para tratar tratar como zero os 
casos onde @capacidadeAtual assume valores nulos ?

--A	IF ( CASE	WHEN @capacidadeAtual IS NULL then 0 
--				WHEN @capacidadeAtual < @capacidadeMaxima THEN 0 
--				ELSE NULL 
--		END 
--		) = 1
--B	IF ( @capacidadeMaxima IS NOT NULL AND @capacidadeAtual IS NOT NULL)
C	IF ISNULL(@capacidadeAtual,0) < @capacidadeMaxima
--D	IF (@capacidadeAtual < @capacidadeMaxima) OR @capacidadeMaxima IS NULL
--E	N.D.A ou nada precisa ser feito.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

7. A variável @capacidadeMaxima deve receber a capacidade maxima daquele tipo de veículo
estacionado, ou seja, os valores mudam dependendo do tipo, segundo o seguinte código.
	DECLARE @capacidadeMaxima INT
			, @tipo VARCHAR(50) = 'moto' -- ou Carro
	-- SELECT @capacidadeMaxima = IIF(@tipo = 'moto',capacidade_Carro,capacidade_Moto)  FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'
	SELECT @capacidadeMaxima = CASE WHEN @tipo = 'moto' then capacidade_Moto else capacidade_Carro END FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'
	SELECT @capacidadeMaxima 
	select * from localidade

	IF @tipo = 'moto'
		SELECT @capacidadeMaxima = capacidade_Moto 
		FROM localidade 
		WHERE identificacao = 'Faculdade Impacta - Paulista'
	ELSE
		SELECT @capacidadeMaxima = capacidade_Carro 
		FROM localidade 
		WHERE identificacao = 'Faculdade Impacta - Paulista'
	SELECT @capacidadeMaxima

Como simplificar essa consulta realizando apenas UM SELECT à tabela localidade mas abastecendo
a variável @capacidadeMaxima com o valor da coluna correta dependendo do tipo de veículo.

--A	SELECT @capacidadeMaxima = IIF(@tipo = 'moto',capacidade_Carro,capacidade_Moto)  FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'
		
B	SELECT @capacidadeMaxima = CASE WHEN @tipo = 'moto' then capacidade_Moto else capacidade_Carro END FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'

--C	IF @tipo = 'moto'
--		SELECT @capacidadeMaxima = capacidade_Carro FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'

--D	SELECT @capacidadeMaxima = capacidade_Carro + capacidade_Carro FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'

--E	N.D.A OU não há como simplificar a consulta

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

8. Lhe foi solicitado um apoio na construção de um código para percorrer as linhas
da tabela veículo uma a uma ( ou seja, em uma instrução de repetição ou laço ).
O seguinte bloco de código foi escrito mas parece que apresenta erros:
	DECLARE @linhaAtual INT = 0
			, @totalLinhas INT
	SELECT @totalLinhas = COUNT(*) FROM veiculo 
	WHILE ( @linhaAtual < @totalLinhas )
	BEGIN
		SELECT * from veiculo where id = @linhaAtual
		SET @linhaAtual+= 1
	END

Este é a maneira mais recomendada para percorrer todas as linhas de uma tabela ?
se não, qual a lógica recomendada para implementação ?

--A	Sim, esta é a melhor e única maneira de percorrer todos os registros de uma tabela.
--	Se o ID é autoincremental, percorrê-lo N vezes ( COUNT ) SEMPRE trará o resultado esperado.
--B	Sim, esta é a melhor, porém não a única.
--	Também poderia subistituir o COUNT pelo MAX(ID), pois percorrer do 1 ao MAX é equivalente.
C	Não, esta solução não contempla ID excluídos, nem cenários em que eu possa ter, por exemplo
	15 registros mas que não estão numerados do 1 ao 15.
	O recomendado é buscar o menor ID ( dentre os válidos ) e a cada laço, buscar o próximo
	menor id ( maior que o anterior ) até que não existam mais registros.
--D	Não, esta solução deveria ter começado a contar a partir do 1, já que um ID autoincremental
--	não começa do zero, e deveria parar em MAX(ID) e não COUNT(*). 
--	Fora isso, o restante da lógica está correta.
--E	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

9. Em mais de um processo implementado no estacionamento é necessário que ele seja transacionado
Lhe foi sugerido o seguinte código.
	BEGIN TRANSACTION
			<bloco do processo>
	COMMIT

Há algum erro neste bloco de código
Só isso é o suficiente para incluir uma transação explícita no <bloco do processo> ?

A	Não há erros neste bloco de código, ele faz o que se espera.
	Só com o BEGIN TRANSACTION e o COMMIT são o suficientes para criar uma transação explícita.
--B	Não há erros neste bloco de código, ele faz o que se espera.
--	Porém, não só o BEGIN TRANSACTION ou o COMMIT são suficientes para criar uma transação.
--	É necessário também a execução da instrução ROLLBACK.
--C	Há erros neste bloco de código, ele não faz o que se espera.
--	Transações são controladas pelos comandos BEGIN TRANSACTION, COMMIT E ROLLBACK
--	E este bloco de código não utilizou o ROLLBACK.
--D	Há erros neste bloco de código, ele não faz o que se espera.
--	Faltou indicar o final do bloco iniciado pelo BEGIN TRANSACTION
--	Logo abaixo do COMMIT deve ser incluído um comando END TRANSACTION
--E	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

10. Ao executar um comando como este:
		UPDATE localidade SET capacidade_carro = 30 
		OUTPUT inserted.capacidade_carro as novo, deleted.capacidade_carro as antigo
		where id = 1

Um desenvolvedor sugeriu incluir na linha #2 a cláusula OUTPUT, para devolver 
não só o valor antigo ( que estava na tabela antes do update ), mas também o valor
atual ( que está sendo inserido ), para depois serem inseridos, por exemplo
em uma tabela de logs.

Como ficaria esta linha #2 ?

--A	OUTPUT inserted.capacidade_carro as antigo, deleted.capacidade_carro as novo
B	OUTPUT inserted.capacidade_carro as novo, deleted.capacidade_carro as antigo
--C	OUTPUT capacidade_carro as novo
--D	OUTPUT novo.capacidade_carro as inserted, antigo.capacidade_carro as deleted
--E	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

11. Lhe foi solicitado uma função que devolvesse o total de veículos estacionados
dado o tipo de veículo, ou seja, ao se passar o valor 'moto' ele devolve o total de motos 
estacionadas, ao se passar 'carro' o total de carros.
Lhe foi apresentado o seguinte código :
		CREATE FUNCTION dbo.fn_TotalVeiculos ( @tipo VARCHAR(50) )
		RETURNS INT
		AS BEGIN
			DECLARE @total INT
			SELECT	@total = COUNT(*) 
			FROM	estacionamento
					INNER JOIN veiculo ON idVeiculo = veiculo.id
					INNER JOIN localidade ON idLocalidade = localidade.id
			WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
					AND tipo = 'moto'
					AND dataHoraSaida IS NULL
			RETURN @total
		END
	
Ele está correto ? Se não, qual o erro mais óbvio que ele apresenta ?

--A	Sim, ele está completamente correto.
--B	Sim, ele está praticamente correto, só faltou receber duas variáveis de entrada
--	@tipo_carro e @tipo_moto, e trabalhar os totais individualmente.
C	Não, ele não está correto, pois não utilizou a variável recebida @tipo
	para filtrar qual o tipo desejado na linha #10, seno o correto:
	#10			AND tipo = @tipo
--D	Não, ele não está correto, a query interna precisa utilizar-se de GROUP BY pelo tipo
--	devolvendo tanto valores para moto ou carro para a função.
--E	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

12. A seguinte instrução poderia ser utilizada para alterar a placa de um veículo
	UPDATE veiculo SET placa = 'ABC1235' WHERE id = 1
	
Porém, existe uma limitação de que ninguém, nem mesmo administadores, possam alterar 
a placa de um veículo.

Lhe foi sugerido o seguinte código para tornar impossível realizar a instrução UPDATE 
para alteração de qualquer dado da tabela veículo.
	CREATE TRIGGER TRG_AU_veiculo ON veiculo
	AFTER UPDATE
	AS BEGIN
		PRINT 'UPDATES SÃO PROIBIDOS'
		ROLLBACK
	END
	GO

Ele atende ao que foi solicitado ?
Se não, o que deveria ser alterado ?

A	Sim, ela atende ao esperado, pois mesmo uma trigger AFTER ainda mantem a transação aberta
	e o ROLLBACK no final desfaz tudo o que foi alterado anteriormente.
--B	Sim, ela atende ao esperado, porém apenas, unica e somente para updates da PLACA do veículo
--	ou seja, updates em outras colunas ela não bloqueia.
--C	Não, ela não atende ao esperado, pois além de permitir o UPDATE ela ainda gera um erro
--	que confunde o usuário final.
--D	Não, ela não atende ao esperado, tudo que essa trigger faz é dar um PRINT que não afeta
--	o fluxo de execução do comando.
--E	N.D.A.






