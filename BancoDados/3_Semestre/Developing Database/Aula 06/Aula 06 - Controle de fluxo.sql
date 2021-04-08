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
--Declarando Variável e ajustando valor inicial
Declare @qtd smallint
Set @qtd = 200

--Verificação do Valor da quantidade
IF @qtd >= 200 --Se Maior ou Igual a 200
	Set @qtd += 50 --Somar 50 unidades
ELSE
	Set @qtd -= 20 --Reduzir 20 unidades

Select @qtd --Independente do caminho tomado no fluxo, retorna o valor @qtd

-- Outro exemplo:
	-- Declarando Variáveis e Ajustando valores Iniciais
	declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

	-- Aplicação das taxas
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
	-- Declarando Variáveis e Ajustando valores Iniciais
	declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

	-- Aplicação das taxas
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
-- Declarando Variáveis e Ajustando valores Iniciais
	declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

	goto MarcacaoDeUmRotulo -- Salta diretamente para este rótulo

	set @qtd = @qtd + 100
	set @taxa = @taxa + 1

	MarcacaoDeUmRotulo: -- Definição do Rótulo
		select @qtd as 'Valor da Quantidade'
			, @taxa as 'Valor da Taxa'

--Outro exemplo:
	if (select count(*) from sys.objects) > 50
		goto Objetos_Maior_50 -- Forçar desvio de Fluxo
	else
		select 'Quantidade de OBJETOS menor que 50 !'

	Return

	Objetos_Maior_50: -- Desvio para o número de sys.objects
		select 	count(*) as 'Quantidade de Objetos encontrados !' 
		from 	sys.objects

-- Outro exemplo:
	-- Variável já com valor inicial de objetos de sistema e usuários
	declare @qtd int = (select count(*) from sys.objects)

	-- Verificando o número de objetos na base de dados atual
	if @qtd > 50
		goto Objetos_Maior_50 -- Forçar desvio de Fluxo
	return -- Forçar a saída imediata do script

	/*
	Como o número de objetos é maior que 50, só chegará a este ponto do BATCH se houver algum outro desvio de fluxo
	*/
	Desvio_Nao_Estruturado: -- Pegar o número de tabelas de usuários
		select @qtd = count(*) from sys.tables 
		select 'Quantidade de TABELAS =  ' + cast(@qtd as varchar) + ' ! '
			as 'Select no Desvio_Nao_Estruturado:'
		return -- Forçar a saída imediata do script

	Objetos_Maior_50: -- Só chega neste ponto do BATCH por desvio de fluxo
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
	SELECT 'ESSA ROTINA EXECUTARÁ O SELECT ETERNAMENTE !'
END

-- Loop limitado a 100 execuções
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
	SELECT @qtd += 1, @msg = 'O número ' + CAST(@qtd as VARCHAR)

	--verificando se é PAR ou ÍMPAR
	IF @qtd %2 = 0
	BEGIN
			select @msg = @msg + ' é PAR !'
	END
	ELSE
	BEGIN
			select @msg = @msg + ' é ÍMPAR !'
	END

	PRINT @msg
END

--LOOP do tipo 'para cada' ( dado uma lista, percorrer cada elemento )
use ImpactaEstacionamento

--Cada tabela internamente também recebe um ID do sistema chamado Object ID ou OID
--Usaremos esta variável para percorrer estes IDs.
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
-- Aula 06 - Controle de fluxo - Exercícios WHILE
--------------------------------------------------------------------------------------------------------------------------------

/*Escreva um bloco de código para percorrer a tabela estacionamentos (WHILE), imprimindo ( comando PRINT )
a placa, a data do estacionamento e o valor recebido daquele evento.

Formato obrigatório do PRINT ( 1 linha impressa para cada linha na tabela estacionamento ) :
	PLACA: YJB8742, DIA: 19/02/2021, VALOR RECEBIDO: 0.00
	PLACA: GHY6543, DIA: 17/02/2021, VALOR RECEBIDO: 30.00
	PLACA: GHY6543, DIA: 17/02/2021, VALOR RECEBIDO: 10.00
	...

Dicas:
	- Use um while para percorrer cada linha, gerencie os estacionamentos pelo ID do mesmo
	- Gere uma variável com tudo o que tiver que ser impresso numa única grande string
	- converta tudo para varchar antes de concatenar e gerar a string
	- formato ou estilo da data pode ser 103 - convert(varchar,data,103)
*/


--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - Return
--------------------------------------------------------------------------------------------------------------------------------
--Interrupção de fluxo: Return
	-- Declarando Variáveis e Ajustando valores Iniciais
	declare @qtd smallint = 200, @taxa decimal(3,2) = 0.05

	-- Verificando valores
	if @qtd * @taxa >= 10
	begin
		select 'Valor da Quantidade x Taxa = ' 
        		+ cast(@qtd * @taxa as varchar) + ' !'
		return
	end

	--Ele não vai rodar este select, pois o fluxo foi interrompido no RETURN
	select @qtd as 'Valor da Quantidade', @taxa as 'Valor da Taxa'

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - Break
--------------------------------------------------------------------------------------------------------------------------------
--Interrupção de while: Break

-- Loop limitado a 100 execuções
DECLARE @qtd tinyint = 1

WHILE @qtd <= 100
BEGIN
	PRINT 'QTD = ' + CAST(@Qtd AS VARCHAR)

	IF @qtd = 50
		BREAK -- força a saída do loop

	SET @qtd = @qtd + 1
END

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - Continue
--------------------------------------------------------------------------------------------------------------------------------
--Força o retorno ao WHILE: Continue

-- Loop limitado a 100 execuções
DECLARE @qtd tinyint = 1

WHILE @qtd <= 100
BEGIN
	PRINT 'QTD = ' + CAST(@Qtd AS VARCHAR)

	IF @qtd = 8
		CONTINUE -- força o retorno ao WHILE

	SET @qtd = @qtd + 1
END

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - WAITFOR
--------------------------------------------------------------------------------------------------------------------------------
--Tempo de espera / Interrupção : WAITFOR

--Utilizando WAITFOR e controle de tempo
DECLARE @qtd tinyint = 0, @msg VARCHAR(100), @dt1 datetime, @dt2 datetime
		, @timeLimit datetime = DATEADD(minute,1,GETDATE())

WHILE ( @qtd <= 100 AND GETDATE() < @timeLimit )
BEGIN
	SET @qtd += 1
	SET @msg = 'O Número ' + CAST(@qtd AS VARCHAR)
	SET @dt1 = GETDATE()

	--verificando se é PAR ou ÍMPAR
	IF @qtd %2 = 0
	BEGIN
			select @msg = @msg + ' é PAR !'
			WAITFOR DELAY '00:00:00.500'
	END
	ELSE
	BEGIN
			select @msg = @msg + ' é ÍMPAR !'
			WAITFOR DELAY '00:00:01'
	END

	SET @dt2 = GETDATE()
	SET @msg = @msg 
				+ 'Diferença em milisegundos '
				+ CAST(DATEDIFF(millisecond,@dt1,@dt2) as VARCHAR)
	PRINT @msg				
END

--Quando sair do loop, rotina continua
SET @msg = 'O numero ' + CAST(@qtd as VARCHAR)
			+ ' foi o limite que tornou a condição FALSE, '
			+ ' forçando a saída do WHILE'
PRINT @msg

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - GO
--------------------------------------------------------------------------------------------------------------------------------
--Repetição de blocos

print 'Hello world'
GO 10

select aqui tem um erro de syntaxe
go 2

-- crio uma tabela temporária
create table #teste ( valor int )
GO
--gero e insiro um valor aleatório entre 0 e 100
insert #teste(valor) values ( round(rand()*100.00,0) )
--repito 10 vezes
GO 10
select * from #teste
drop table #teste

--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - CURSORES
--------------------------------------------------------------------------------------------------------------------------------
--Repetição de blocos: Cursores

--Variáveis para receber os valores do tabela, uma linha por vez.
DECLARE @id int, @placa char(7)
--Declareção do cursor
DECLARE Veiculos CURSOR FOR (
	select id, placa from veiculo
)
OPEN Veiculos -- Abertura do mesmo, posição inicial do cursor é fora da tabela, antes do primeiro registro.
FETCH NEXT FROM Veiculos INTO @id, @placa -- movendo o cursor para o primeiro registro
WHILE (@@FETCH_STATUS = 0) --repete enquanto o cursor está sob um registro válido
BEGIN
	--Tudo o que eu quero que seja repetido, deve ser incluído entre o BEGIN e o FETCH NEXT
	select @id, @placa

	FETCH NEXT FROM Veiculos INTO @id, @placa -- movendo o cursor para o próximo registro
END
CLOSE Veiculos --Fecho o cursor
DEALLOCATE Veiculos --Desaloco o cursor da memória



--------------------------------------------------------------------------------------------------------------------------------
-- Aula 06 - Controle de fluxo - Exercícios CURSORES
--------------------------------------------------------------------------------------------------------------------------------
--Exercícios CURSORES

/*Faça o mesmo PRINT do exercício anterior, porém, agora usando cursores, ou seja:

Escreva um bloco de código para percorrer a tabela estacionamentos (CURSOR), imprimindo ( comando PRINT )
a placa, a data do estacionamento e o valor recebido daquele evento.

Formato obrigatório do PRINT ( 1 linha impressa para cada linha na tabela estacionamento ) :
	PLACA: YJB8742, DIA: 19/02/2021, VALOR RECEBIDO: 0.00
	PLACA: GHY6543, DIA: 17/02/2021, VALOR RECEBIDO: 30.00
	PLACA: GHY6543, DIA: 17/02/2021, VALOR RECEBIDO: 10.00
	...

Dicas:
	- Gere um único select que já devolva não só o ID do estacionamento
		, mas também os valores que devem ser impressos, ou seja: placa, data da entrada e valor recebido.
	- Use um CURSOR para percorrer cada linha do select gerado ( e não só um select * from estacionamento )
	- Gere uma variável com tudo o que tiver que ser impresso numa única grande string
	- converta tudo para varchar antes de concatenar e gerar a string
	- formato ou estilo da data pode ser 103 - convert(varchar,data,103)

EXTRA:
  Agora acrescente ao seu código duas condições extras:
  - Não imprima as placas 'ABC1234','AOE7432', 'HGG1A12'
    	, elas pertencem aos filhos do dono e não podem aparecer em nenhum relatório.
	, na sua ocorrência, continue o loop
  - Se a placa 'YJB8742' aparecer, interrompa o loop imediatamente.
    , ou seja, o relatório deve sempre imprimir por último a placa 'YJB8742'

*/






