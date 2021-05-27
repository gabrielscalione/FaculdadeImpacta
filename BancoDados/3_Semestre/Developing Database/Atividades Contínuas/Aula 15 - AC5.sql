use  ImpactaEstacionamento
go

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

1. Descubra o erro da seguinte instru��o:
	INSERT INTO localidade (id, identificacao, localizacao, capacidade_carro, capacidade_moto )
	values ( 10, 'Faculdade Impacta - Av. Rudge', 'Av.Rudge', 30, 10 )

Qual a corre��o e a explica��o correta melhor aplic�veis para este cen�rio:
( tanto a corre��o quanto a explica��o do erro devem estar corretos ).

A	N�o fornecer o ID pois n�o se pode fornecer valores �s chaves prim�rias.
	INSERT INTO localidade (identificacao, localizacao, capacidade_carro, capacidade_moto )
	values ( 'Faculdade Impacta - Av. Rudge', 'Av.Rudge', 30, 10 )
	
--B	S� se deve passar colunas que na defini��o da tabela sejam NOT NULL, e n�o as NULL
--	INSERT INTO localidade (identificacao, localizacao, capacidade_carro, capacidade_moto )
--	values ( 'Faculdade Impacta - Av. Rudge', 'Av.Rudge', 30, 10 )

--C	A ordem das colunas est� incorreta
--	INSERT INTO localidade (identificacao, localizacao, capacidade_carro, capacidade_moto )
--	values ( 'Faculdade Impacta - Av. Rudge', 'Av.Rudge', 30, 10 )

--D	N�o se deve fornecer valores � colunas auto-incrementais
--	INSERT INTO localidade (identificacao, localizacao, capacidade_carro, capacidade_moto )
--	values ( 'Faculdade Impacta - Av. Rudge', 'Av.Rudge', 30, 10 )

--E	N.D.A. OU N�o h� erro na query original, ela pode ser executada normalmente.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

2. Para devolver o total de ve�culos estacionados atualmente de um tipo espec�fico (ie. moto)
lhe foi fornecida a seguinte consulta
		SELECT	tipo, COUNT(*) as total
		FROM	estacionamento
				INNER JOIN veiculo ON idVeiculo = veiculo.id
				INNER JOIN localidade ON idLocalidade = localidade.id
		WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
				
				AND dataHoraSaida IS NULL
			group by tipo
		...

Para alterar a consulta, fazendo-a devolver, em uma �nica instru��o,
o total de ve�culos estacionados para todos os tipos de ve�culos (it. motos, carros, etc )
Quais linhas e quais altera��oes na query s�o sugeridas ?
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

--E	N.D.A. OU N�o � necess�ria nenhuma mudan�a na query original.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

3.	Ao desejar armazenar um valor em uma vari�vel, como no exemplo abaixo:
		DECLARE @idLocalidade INT
		select @idLocalidade=id from localidade where identificacao='Faculdade Impacta - Paulista'
		select @idLocalidade as IdCapturado

 Qual o tipo de dados mais recomendado e por que ?
 Qual o c�digo que deve ser inclu�do na linha #1 ?
( tanto o c�idigo quanto a explica��o devem estar corretos ).

--A	O recomendado � que a vari�vel seja do mesmo tipo da coluna.
--	ex: SET @idLocalidade INT 

--B	O recomendado � que a vari�vel SEMPRE seja dos tipos b�sicos ( INT, DATETIME ou VARCHAR)
--	ex: SELECT @idLocalidade VARCHAR(10)

--C	O tipo depende de como ela for utilizada, se for para contas: INT, para exibi��o: VARCHAR
--	ex: INSERT @idLocalidade VARCHAR

D	Independente da situa��o, toda vari�vel deve ser um INTEIRO.
	ex: DECLARE @vari�vel INT

--E	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

4. Lhe foi solicitado armazenar o resultado do select abaixo em vari�veis :
		select id, capacidade_Moto 
		from localidade 
		where identificacao = 'Faculdade Impacta - Paulista'

Explique qual a maneira recomend�vel de se proceder ?
Quais altera��es nos codigos seriam necess�rias ?
( tanto o c�idigo quanto a explica��o devem estar corretos ).

--A	Declarar duas vari�veis, para o ID e capacidadeMoto
--	Dividir a query em duas, cada uma coleta uma vari�vel de cada vez
--	� imposs�vel capturar as duas vari�veis de uma s� vez.
--	SELECT @idLocalidade = id FROM...
--	SELECT @capacidade_Moto = capacidade_Moto FROM...

--B	Declarar uma vari�vel composta que recebe id concatenado com a localidade
--	� imposs�vel capturar as duas vari�veis de uma s� vez.
--	SELECT @ID+capacidade_Moto = ID + capacidade_Moto FROM...

C	Declarar duas vari�veis, para o ID e capacidadeMoto	
	Capturar as duas vari�veis na mesma query
	SELECT @idLocalidade = id, 
	       @capacidade_Moto = capacidade_Moto 
	FROM...
	
--D	Declarar uma vari�vel do tipo tabela
--	Salvar os dois valores em uma �nica linha, mas cada uma em sua respectiva coluna.
--	INSERT @tabelaVariavel ( id, capacidade_Moto)
--	SELECT id, capacidade_Moto FROM...

--E	N.D.A OU n�o h� uma maneira de armazenar o resultado de uma query em vari�veis.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

5. Lhe foi fornecido o seguinte processo para devolver o ID de um ve�culo passado a placa e o tipo
caso ele n�o esteja na base, ele deve ser inserido e depois ter seu ID devolvido.

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

Que c�digo deve ser inserido na linha #6 para que este processo funcione como esperado ?

A	IF ( @idVeiculo IS NULL )

--B	IF ISNULL(@idVeiculo,-1) = 0

--C	WHILE ( @idVeiculo IS NULL )

--D	EXISTS (select id from veiculo where placa = @placa)

--E	N.D.A Ou nada precisa ser inserido, o processo j� est� correto.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

6. Lhe foi fornecido duas vari�veis, j� com valores coletados de processos anteriores
	DECLARE @capacidadeAtual INT = 0
	DECLARE @capacidadeMaxima INT = 10
E a seguinte condi��o de desvio de fluxo condicional:
	IF @capacidadeAtual < @capacidadeMaxima
		print 'Permite a inser��o do ve�culo'
	ELSE
		print 'N�o Permite a inser��o do ve�culo'
	
Por�m, em testes, foi detectado que a vari�vel @capacidadeAtual pode vir NULA
o que deveria permitir estacionamentos pois o NULO deve ser entendido como 0 ( zero )

Como ficaria o novo c�digo da instru��o IF para tratar tratar como zero os 
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

7. A vari�vel @capacidadeMaxima deve receber a capacidade maxima daquele tipo de ve�culo
estacionado, ou seja, os valores mudam dependendo do tipo, segundo o seguinte c�digo.
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

Como simplificar essa consulta realizando apenas UM SELECT � tabela localidade mas abastecendo
a vari�vel @capacidadeMaxima com o valor da coluna correta dependendo do tipo de ve�culo.

--A	SELECT @capacidadeMaxima = IIF(@tipo = 'moto',capacidade_Carro,capacidade_Moto)  FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'
		
B	SELECT @capacidadeMaxima = CASE WHEN @tipo = 'moto' then capacidade_Moto else capacidade_Carro END FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'

--C	IF @tipo = 'moto'
--		SELECT @capacidadeMaxima = capacidade_Carro FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'

--D	SELECT @capacidadeMaxima = capacidade_Carro + capacidade_Carro FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'

--E	N.D.A OU n�o h� como simplificar a consulta

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

8. Lhe foi solicitado um apoio na constru��o de um c�digo para percorrer as linhas
da tabela ve�culo uma a uma ( ou seja, em uma instru��o de repeti��o ou la�o ).
O seguinte bloco de c�digo foi escrito mas parece que apresenta erros:
	DECLARE @linhaAtual INT = 0
			, @totalLinhas INT
	SELECT @totalLinhas = COUNT(*) FROM veiculo 
	WHILE ( @linhaAtual < @totalLinhas )
	BEGIN
		SELECT * from veiculo where id = @linhaAtual
		SET @linhaAtual+= 1
	END

Este � a maneira mais recomendada para percorrer todas as linhas de uma tabela ?
se n�o, qual a l�gica recomendada para implementa��o ?

--A	Sim, esta � a melhor e �nica maneira de percorrer todos os registros de uma tabela.
--	Se o ID � autoincremental, percorr�-lo N vezes ( COUNT ) SEMPRE trar� o resultado esperado.
--B	Sim, esta � a melhor, por�m n�o a �nica.
--	Tamb�m poderia subistituir o COUNT pelo MAX(ID), pois percorrer do 1 ao MAX � equivalente.
C	N�o, esta solu��o n�o contempla ID exclu�dos, nem cen�rios em que eu possa ter, por exemplo
	15 registros mas que n�o est�o numerados do 1 ao 15.
	O recomendado � buscar o menor ID ( dentre os v�lidos ) e a cada la�o, buscar o pr�ximo
	menor id ( maior que o anterior ) at� que n�o existam mais registros.
--D	N�o, esta solu��o deveria ter come�ado a contar a partir do 1, j� que um ID autoincremental
--	n�o come�a do zero, e deveria parar em MAX(ID) e n�o COUNT(*). 
--	Fora isso, o restante da l�gica est� correta.
--E	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

9. Em mais de um processo implementado no estacionamento � necess�rio que ele seja transacionado
Lhe foi sugerido o seguinte c�digo.
	BEGIN TRANSACTION
			<bloco do processo>
	COMMIT

H� algum erro neste bloco de c�digo
S� isso � o suficiente para incluir uma transa��o expl�cita no <bloco do processo> ?

A	N�o h� erros neste bloco de c�digo, ele faz o que se espera.
	S� com o BEGIN TRANSACTION e o COMMIT s�o o suficientes para criar uma transa��o expl�cita.
--B	N�o h� erros neste bloco de c�digo, ele faz o que se espera.
--	Por�m, n�o s� o BEGIN TRANSACTION ou o COMMIT s�o suficientes para criar uma transa��o.
--	� necess�rio tamb�m a execu��o da instru��o ROLLBACK.
--C	H� erros neste bloco de c�digo, ele n�o faz o que se espera.
--	Transa��es s�o controladas pelos comandos BEGIN TRANSACTION, COMMIT E ROLLBACK
--	E este bloco de c�digo n�o utilizou o ROLLBACK.
--D	H� erros neste bloco de c�digo, ele n�o faz o que se espera.
--	Faltou indicar o final do bloco iniciado pelo BEGIN TRANSACTION
--	Logo abaixo do COMMIT deve ser inclu�do um comando END TRANSACTION
--E	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

10. Ao executar um comando como este:
		UPDATE localidade SET capacidade_carro = 30 
		OUTPUT inserted.capacidade_carro as novo, deleted.capacidade_carro as antigo
		where id = 1

Um desenvolvedor sugeriu incluir na linha #2 a cl�usula OUTPUT, para devolver 
n�o s� o valor antigo ( que estava na tabela antes do update ), mas tamb�m o valor
atual ( que est� sendo inserido ), para depois serem inseridos, por exemplo
em uma tabela de logs.

Como ficaria esta linha #2 ?

--A	OUTPUT inserted.capacidade_carro as antigo, deleted.capacidade_carro as novo
B	OUTPUT inserted.capacidade_carro as novo, deleted.capacidade_carro as antigo
--C	OUTPUT capacidade_carro as novo
--D	OUTPUT novo.capacidade_carro as inserted, antigo.capacidade_carro as deleted
--E	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

11. Lhe foi solicitado uma fun��o que devolvesse o total de ve�culos estacionados
dado o tipo de ve�culo, ou seja, ao se passar o valor 'moto' ele devolve o total de motos 
estacionadas, ao se passar 'carro' o total de carros.
Lhe foi apresentado o seguinte c�digo :
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
	
Ele est� correto ? Se n�o, qual o erro mais �bvio que ele apresenta ?

--A	Sim, ele est� completamente correto.
--B	Sim, ele est� praticamente correto, s� faltou receber duas vari�veis de entrada
--	@tipo_carro e @tipo_moto, e trabalhar os totais individualmente.
C	N�o, ele n�o est� correto, pois n�o utilizou a vari�vel recebida @tipo
	para filtrar qual o tipo desejado na linha #10, seno o correto:
	#10			AND tipo = @tipo
--D	N�o, ele n�o est� correto, a query interna precisa utilizar-se de GROUP BY pelo tipo
--	devolvendo tanto valores para moto ou carro para a fun��o.
--E	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

12. A seguinte instru��o poderia ser utilizada para alterar a placa de um ve�culo
	UPDATE veiculo SET placa = 'ABC1235' WHERE id = 1
	
Por�m, existe uma limita��o de que ningu�m, nem mesmo administadores, possam alterar 
a placa de um ve�culo.

Lhe foi sugerido o seguinte c�digo para tornar imposs�vel realizar a instru��o UPDATE 
para altera��o de qualquer dado da tabela ve�culo.
	CREATE TRIGGER TRG_AU_veiculo ON veiculo
	AFTER UPDATE
	AS BEGIN
		PRINT 'UPDATES S�O PROIBIDOS'
		ROLLBACK
	END
	GO

Ele atende ao que foi solicitado ?
Se n�o, o que deveria ser alterado ?

A	Sim, ela atende ao esperado, pois mesmo uma trigger AFTER ainda mantem a transa��o aberta
	e o ROLLBACK no final desfaz tudo o que foi alterado anteriormente.
--B	Sim, ela atende ao esperado, por�m apenas, unica e somente para updates da PLACA do ve�culo
--	ou seja, updates em outras colunas ela n�o bloqueia.
--C	N�o, ela n�o atende ao esperado, pois al�m de permitir o UPDATE ela ainda gera um erro
--	que confunde o usu�rio final.
--D	N�o, ela n�o atende ao esperado, tudo que essa trigger faz � dar um PRINT que n�o afeta
--	o fluxo de execu��o do comando.
--E	N.D.A.






