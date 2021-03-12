--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - IF
--------------------------------------------------------------------------------------------------------------------------------
--Condicionais: IF
	IF 1 = 1
		PRINT 'VERDADEIRO'
	ELSE
		PRINT 'FALSO ou DESCONHECIDO'

	IF 1 <> 1
		PRINT 'VERDADEIRO'
	ELSE
		PRINT 'FALSO ou DESCONHECIDO'

	IF 1 = NULL
		PRINT 'VERDADEIRO'
	ELSE
		PRINT 'FALSO ou DESCONHECIDO'
/*
Rotina Teste para Contole de Fluxo IF ... ELSE
*/
--Declarando Vari�vel e ajustando valor inicial
Declare @qtd smallint
Set @qtd = 200

--Verifica��o do Valor da quantidade
IF @qtd >= 200 --Se Maior ou Igual a 200
	Set @qtd += 50 --Somar 50 unidades
ELSE
	Set @qtd -= 20 --Reduzir 20 unidades

Select @qtd --Independente do caminho tomado no fluxo, retorna o valor @qtd

-- Outro exemplo:
	-- Declarando Vari�veis e Ajustando valores Iniciais
	declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

	-- Aplica��o das taxas
	if @qtd * @taxa > 20
	begin
		set @qtd += @qtd * 0.1 -- Aumentar em 10 %
		set @taxa *= 2 -- Duplicar a taxa
	end
	else
	begin
		set @qtd -= @qtd * 0.15 -- Reduzir em 15 %
		set @taxa *= 2 -- Duplicar a taxa
	end

	select @qtd as 'Valor da Quantidade', @taxa as 'Valor da Taxa'

-- Outro exemplo:
	-- Declarando Vari�veis e Ajustando valores Iniciais
	declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

	-- Aplica��o das taxas
	if @qtd * @taxa > 20
	begin
		set @qtd += @qtd * 0.1 -- Aumentar em 10 %
		set @taxa *= 2 -- Duplicar a taxa
	end
	else  -- Reduzir em 15 % e Duplicar a taxa
		select @qtd -= @qtd * 0.15, @taxa *= 2 

	select @qtd as 'Valor da Quantidade', @taxa as 'Valor da Taxa'

--IF vs CASE
	/*#errado:*/ 
	SELECT IF idade < 18 
			THEN	'menor de idade'
			ELSE	'maior de idade'	 AS [idade] 
	FROM alunos 
	/*#correto:*/ 
	SELECT CASE 
			WHEN idade < 18 THEN 'menor de idade' 
			ELSE 'maior de idade' END AS [idade]
	FROM  alunos

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - GOTO
--------------------------------------------------------------------------------------------------------------------------------
-- Desvio de fluxo - GOTO
-- Declarando Vari�veis e Ajustando valores Iniciais
	declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

	goto MarcacaoDeUmRotulo -- Salta diretamente para este r�tulo

	set @qtd = @qtd + 100
	set @taxa = @taxa + 1

	MarcacaoDeUmRotulo: -- Defini��o do R�tulo
		select @qtd as 'Valor da Quantidade'
			, @taxa as 'Valor da Taxa'

--Outro exemplo:
	if (select count(*) from sys.objects) > 50
		goto Objetos_Maior_50 -- For�ar desvio de Fluxo
	else
		select 'Quantidade de OBJETOS menor que 50 !'

	Return

	Objetos_Maior_50: -- Desvio para o n�mero de sys.objects
		select 	count(*) as 'Quantidade de Objetos encontrados !' 
		from 	sys.objects

-- Outro exemplo:
	-- Vari�vel j� com valor inicial de objetos de sistema e usu�rios
	declare @qtd int = (select count(*) from sys.objects)

	-- Verificando o n�mero de objetos na base de dados atual
	if @qtd > 50
		goto Objetos_Maior_50 -- For�ar desvio de Fluxo
	return -- For�ar a sa�da imediata do script

	/*
	Como o n�mero de objetos � maior que 50, s� chegar� a este ponto do BATCH se houver algum outro desvio de fluxo
	*/
	Desvio_Nao_Estruturado: -- Pegar o n�mero de tabelas de usu�rios
		select @qtd = count(*) from sys.tables 
		select 'Quantidade de TABELAS =  ' + cast(@qtd as varchar) + ' ! '
			as 'Select no Desvio_Nao_Estruturado:'
		return -- For�ar a sa�da imediata do script

	Objetos_Maior_50: -- S� chega neste ponto do BATCH por desvio de fluxo
		select concat('Quantidade de OBJETOS = ', cast(@qtd as varchar)
				 , ' ! ') as 'Select no Objetos_Maior_50:'
		goto Desvio_Nao_Estruturado -- Desvio pode ser para qualquer ponto do BATCH

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - WHILE
--------------------------------------------------------------------------------------------------------------------------------
--Loop : WHILE

--LOOP INFINITO
WHILE 1=1
BEGIN
	SELECT 'ESSA ROTINA EXECUTAR� O SELECT ETERNAMENTE !'
END

-- Loop limitado a 100 execu��es
DECLARE @qtd tinyint = 1
WHILE @qtd <= 100
BEGIN
	PRINT 'QTD = ' + CAST(@Qtd AS VARCHAR)
	SET @qtd = @qtd + 1
END

--Combinando WHILE e IF
DECLARE @qtd tinyint = 0, @msg varchar(100)

WHILE @qtd <= 100
BEGIN
	SELECT @qtd += 1, @msg = 'O n�mero ' + CAST(@qtd as VARCHAR)

	--verificando se � PAR ou �MPAR
	IF @qtd %2 = 0
	BEGIN
			select @msg = @msg + ' � PAR !'
	END
	ELSE
	BEGIN
			select @msg = @msg + ' � �MPAR !'
	END

	PRINT @msg
END

--LOOP do tipo 'para cada' ( dado uma lista, percorrer cada elemento )
use ImpactaEstacionamento

--Cada tabela internamente tamb�m recebe um ID do sistema chamado Object ID ou OID
--Usaremos esta vari�vel para percorrer estes IDs.
DECLARE @OID INT = 0

-- Percorrendo todas as tabelas
WHILE EXISTS ( SELECT * FROM sys.tables WHERE object_id > @OID)
BEGIN
	--Pego o primeiro ID acima do valor atual
	SELECT @OID = MIN(object_id) FROM sys.tables WHERE object_id > @OID
	--Devolvo o ID e o nome da tabela
	SELECT @OID, 'Tabela ' + object_name(@OID)
END


--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - Exerc�cios WHILE
--------------------------------------------------------------------------------------------------------------------------------

/*Escreva um bloco de c�digo para percorrer a tabela estacionamentos (WHILE), imprimindo ( comando PRINT )
a placa, a data do estacionamento e o valor recebido daquele evento.

Formato obrigat�rio do PRINT ( 1 linha impressa para cada linha na tabela estacionamento ) :
	PLACA: YJB8742, DIA: 19/02/2021, VALOR RECEBIDO: 0.00
	PLACA: GHY6543, DIA: 17/02/2021, VALOR RECEBIDO: 30.00
	PLACA: GHY6543, DIA: 17/02/2021, VALOR RECEBIDO: 10.00
	...

Dicas:
	- Use um while para percorrer cada linha, gerencie os estacionamentos pelo ID do mesmo
	- Gere uma vari�vel com tudo o que tiver que ser impresso numa �nica grande string
	- converta tudo para varchar antes de concatenar e gerar a string
	- formato ou estilo da data pode ser 103 - convert(varchar,data,103)
*/


--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - Return
--------------------------------------------------------------------------------------------------------------------------------
--Interrup��o de fluxo: Return
	-- Declarando Vari�veis e Ajustando valores Iniciais
	declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

	-- Verificando valores
	if @qtd * @taxa >= 10
	begin
		select 'Valor da Quantidade x Taxa = ' 
        		+ cast(@qtd * @taxa as varchar) + ' !'
		return
	end

	--Ele n�o vai rodar este select, pois o fluxo foi interrompido no RETURN
	select @qtd as 'Valor da Quantidade', @taxa as 'Valor da Taxa'

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - Break
--------------------------------------------------------------------------------------------------------------------------------
--Interrup��o de while: Break

-- Loop limitado a 100 execu��es
DECLARE @qtd tinyint = 1

WHILE @qtd <= 100
BEGIN
	PRINT 'QTD = ' + CAST(@Qtd AS VARCHAR)

	IF @qtd = 50
		BREAK -- for�a a sa�da do loop

	SET @qtd = @qtd + 1
END

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - Continue
--------------------------------------------------------------------------------------------------------------------------------
--For�a o retorno ao WHILE: Continue

-- Loop limitado a 100 execu��es
DECLARE @qtd tinyint = 1

WHILE @qtd <= 100
BEGIN
	PRINT 'QTD = ' + CAST(@Qtd AS VARCHAR)

	IF @qtd = 8
		CONTINUE -- for�a o retorno ao WHILE

	SET @qtd = @qtd + 1
END

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - WAITFOR
--------------------------------------------------------------------------------------------------------------------------------
--Tempo de espera / Interrup��o : WAITFOR

--Utilizando WAITFOR e controle de tempo
DECLARE @qtd tinyint = 0, @msg VARCHAR(100), @dt1 datetime, @dt2 datetime
		, @timeLimit datetime = DATEADD(minute,1,GETDATE())

WHILE ( @qtd <= 100 AND GETDATE() < @timeLimit )
BEGIN
	SET @qtd += 1
	SET @msg = 'O N�mero ' + CAST(@qtd AS VARCHAR)
	SET @dt1 = GETDATE()

	--verificando se � PAR ou �MPAR
	IF @qtd %2 = 0
	BEGIN
			select @msg = @msg + ' � PAR !'
			WAITFOR DELAY '00:00:00.500'
	END
	ELSE
	BEGIN
			select @msg = @msg + ' � �MPAR !'
			WAITFOR DELAY '00:00:01'
	END

	SET @dt2 = GETDATE()
	SET @msg = @msg 
				+ 'Diferen�a em milisegundos '
				+ CAST(DATEDIFF(millisecond,@dt1,@dt2) as VARCHAR)
	PRINT @msg				
END

--Quando sair do loop, rotina continua
SET @msg = 'O numero ' + CAST(@qtd as VARCHAR)
			+ ' foi o limite que tornou a condi��o FALSE, '
			+ ' for�ando a sa�da do WHILE'
PRINT @msg

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - GO
--------------------------------------------------------------------------------------------------------------------------------
--Repeti��o de blocos

print 'Hello world'
GO 10

select aqui tem um erro de syntaxe
go 2

-- crio uma tabela tempor�ria
create table #teste ( valor int )
GO
--gero e insiro um valor aleat�rio entre 0 e 100
insert #teste(valor) values ( round(rand()*100.00,0) )
--repito 10 vezes
GO 10
select * from #teste
drop table #teste

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - CURSORES
--------------------------------------------------------------------------------------------------------------------------------
--Repeti��o de blocos: Cursores

--Vari�veis para receber os valores do tabela, uma linha por vez.
DECLARE @id int, @placa char(7)
--Declare��o do cursor
DECLARE Veiculos CURSOR FOR (
	select id, placa from veiculo
)
OPEN Veiculos -- Abertura do mesmo, posi��o inicial do cursor � fora da tabela, antes do primeiro registro.
FETCH NEXT FROM Veiculos INTO @id, @placa -- movendo o cursor para o primeiro registro
WHILE (@@FETCH_STATUS = 0) --repete enquanto o cursor est� sob um registro v�lido
BEGIN
	--Tudo o que eu quero que seja repetido, deve ser inclu�do entre o BEGIN e o FETCH NEXT
	select @id, @placa

	FETCH NEXT FROM Veiculos INTO @id, @placa -- movendo o cursor para o pr�ximo registro
END
CLOSE Veiculos --Fecho o cursor
DEALLOCATE Veiculos --Desaloco o cursor da mem�ria



--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - Exerc�cios CURSORES
--------------------------------------------------------------------------------------------------------------------------------
--Exerc�cios CURSORES

/*Fa�a o mesmo PRINT do exerc�cio anterior, por�m, agora usando cursores, ou seja:

Escreva um bloco de c�digo para percorrer a tabela estacionamentos (CURSOR), imprimindo ( comando PRINT )
a placa, a data do estacionamento e o valor recebido daquele evento.

Formato obrigat�rio do PRINT ( 1 linha impressa para cada linha na tabela estacionamento ) :
	PLACA: YJB8742, DIA: 19/02/2021, VALOR RECEBIDO: 0.00
	PLACA: GHY6543, DIA: 17/02/2021, VALOR RECEBIDO: 30.00
	PLACA: GHY6543, DIA: 17/02/2021, VALOR RECEBIDO: 10.00
	...

Dicas:
	- Gere um �nico select que j� devolva n�o s� o ID do estacionamento
		, mas tamb�m os valores que devem ser impressos, ou seja: placa, data da entrada e valor recebido.
	- Use um CURSOR para percorrer cada linha do select gerado ( e n�o s� um select * from estacionamento )
	- Gere uma vari�vel com tudo o que tiver que ser impresso numa �nica grande string
	- converta tudo para varchar antes de concatenar e gerar a string
	- formato ou estilo da data pode ser 103 - convert(varchar,data,103)

EXTRA:
  Agora acrescente ao seu c�digo duas condi��es extras:
  - N�o imprima as placas 'ABC1234','AOE7432', 'HGG1A12'
    	, elas pertencem aos filhos do dono e n�o podem aparecer em nenhum relat�rio.
	, na sua ocorr�ncia, continue o loop
  - Se a placa 'YJB8742' aparecer, interrompa o loop imediatamente.
    , ou seja, o relat�rio deve sempre imprimir por �ltimo a placa 'YJB8742'

*/






