
--Rode isso apenas uma vez
create database ac2;
GO
use ac2;


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 07 - AC2 - Revisão até a aula 06
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
/*
Aula 01 - Revisão
	Preparação do ambiente de estudo ( SQL Server )
	Skills esperadas: reconhecer e 'entender' o banco de dados
	Realizar relatórios utilizando o conhecimento de linguagem SQL
Aula 02 - Tipos e conversões, Variáveis, lotes, operadores, colunas computadas
	Utilizar variáveis para relatórios mais complexos ( percentual vendas )
	Utilizar funções para tratamento e organização das informações.
	Utilizar funções conversão e transformações de informações.
Aula 03 - Tratamento de dados e nulos( iif, isnull, nullif, choose ), condicionais ( IF, CASE )
	Utilizar funções para melhorar a apresentação dos dados
	Correções e tratamento de dados inválidos.
	Exercícios com agenda e calendário.
Aula 04 - AC1 - Revisão aulas 01 a 03
Aula 05 - tabelas temporárias (# e ##), variáveis do tipo tabela (@), variáveis do sistema (@@), redirecionador de conteúdo (INTO)
	Transporte de dados, redirecionamento de conteúdo.
	Armazenamento temporário para processamento.
Aula 06 - Controle de fluxo (goto, continue, break, waitfor), Loop ( while ), cursores.
	Relatórios elaborados
	Processos inteligentes.
	Discussão: 'Em lote' ou 'para cada'
Aula 07 - AC2 - Revisão aulas 05 a 06
*/

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 1: Entendimento dos dados
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Acessem: http://archive.ics.uci.edu/ml/datasets/in-vehicle+coupon+recommendation

Objetivo é derterminar sob quais condições específicas
um cupom de desconto tem mais chances de serem 'bem aceitos'
quando oferecidos aos motoristas por seus próprios 
dispositivos internos do carro.

Ex:	Se	O cliente vai à uma cafeteria mais de uma vez por mês
		E seu destino não é algo específico nem urgente
		(indo para casa talvez )
		E não há crianças como passageiro 
	OU
		O cliente vai à uma cafeteria mais de uma vez por mês
		O tempo de expiração do cupon é de 1 dia 		
	ENTÃO
		Predizer se o cliente irá aceitar o cupon para a cafeteria.

Aos curiosos, para mais detalhes, leiam:
https://jmlr.org/papers/volume18/16-003/16-003.pdf

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 2: Aquisição dos dados
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Em Data Folder > de download do arquivo: in-vehicle-coupon-recommendation.csv
( http://archive.ics.uci.edu/ml/machine-learning-databases/00603/in-vehicle-coupon-recommendation.csv )

NO SSSM ( SQL Server Management Studio )
Expandir aba Databases, clicar com o botão direito sobre o banco AC2
selecionar Tarefas > Importar dados.

Cliquem em NEXT > Flat File Source > Aponte para o nome do arquivo > NEXT > NEXT
OLE DB PROVIDER ou NATIVE CLIENT > Se autentique no seu servidor > banco AC2
NEXT > NEXT > FINISH > CLOSE


--Testes:
USE AC2
GO

1) Quantas linhas foram importadas ?

select COUNT(*) from [in-vehicle-coupon-recommendation]



--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 3: Entendimento dos dados
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Seu empregador deseja a contrução de testes apenas para
bares, e apenas com alguns variáveis, então só algumas 
colunas da base serão usadas, são elas:
-- Destino do veículo
	destination:	No Urgent Place, Home, Work
-- Quem são os passageiros neste momento com o motorista
	passanger:		Alone, Friend(s), Kid(s), Partner 
--	Tempo de expiração do cupom ( 1 dia ou 2 horas )
	expiration:		1d, 2h 
--	Hora da oferta do cupom
	time: 2PM, 10AM, 6PM, 7AM, 10PM

--	Faixa da Renda do motorista
	income:		$37500 - $49999, $62500 - $74999
				, $12500 - $24999, $75000 - $87499
				, $50000 - $62499, $25000 - $37499
				, $100000 or More, $87500 - $99999
				, Less than $12500
--	faixa de idade do motorista
	age: 21, 46, 26, 31, 41, 50plus, 36, below21
--	Temperatura atual
	temperature:55, 80, 30
--	Frequencia mensal que o motorista vai à bares
	Bar: never, less1, 1~3, gt8, nan4~8 
--	Se ele aceitou o cupom ou não.
	Y: 1, 0 (whether the coupon is accepted)
/*Para detalhes de todos os atributos possíveis, ler o artigo original.*/

--Testes
	select	destination
			, passanger
			, expiration
			, time
			, income
			, age
			, temperature
			, bar
			, y
	from	[in-vehicle-coupon-recommendation]
	where	coupon = 'bar'

2) Quantas linhas ficaram ?

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 4: Preparação dos dados
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
/*	Antes de jogar os dados necessários em um data lake seu empregador solicitou 
	( ou melhor, exigiu ) uma série de tratamento de dados.
*/

Destination deve ser traduzido
	Destination		->	Destino
	---------------		---------------------
	No Urgent Place		Sem destino urgente
	Home				Casa
	Work				Trabalho

Passenger deve ser traduzido
	Passanger	->	Passageiro
	-----------		-----------
	Alone			= 'Sozinho'
	Friend(s)		= 'Amigos'
	Kid(s)			= 'Crianças'
	Partner			= 'Companheiro(a)'

Expiração só terá o nome da coluna ajustado.
	Expiration	->	Expiracao
	------------	-----------
		1d			1d
		2h			2h

Time deve ser transformado em formato 24hrs
	Time	->	Hora
	------		-------
	2PM			14:00
	10AM		10:00
	6PM			18:00
	7AM			07:00
	10PM		22:00

Income deve ser dividido em duas colunas
	Income				-> 	RendaMin	RendaMax
	---------------			---------	---------
	$62500 - $74999			62500		74999
	Less than $12500		0			12500
	$100000 or More			100000		250000

Idade só terá o nome da coluna ajustado.
	Age		->	Idade
	----------	------------
	21			21
	46			46
	46			46

Temperature deve ser apresentada também em °C
	--usar formula para ºC, não incluir valores fixos.
	Temperture	->	Temperatura_F	Temperatura_C
	-----------		--------------	---------------
	80				80				??

Frequencia deve ser reformulado e agrupado.
	Bar			->	Frequencia
	------------	------------
	never			nunca
	less1			até 1
	1~3				de 1 a 3
	gt8				mais que 8
	nan4~8 			de 4 a 8

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 4: Preparação dos dados ( tabela destino )
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

3) Precisamos de uma tabela para guardar os valores finais
Defina os tipos de cada coluna sugerida após especificação
--lembrem-se, usem os tipos mais econômicos possíveis :
	Destino
	, Passageiro
	, Expiracao
	, Hora
	, rendaMin
	, rendaMax
	, idade
	, temperatura_F
	--Temperatura_C será um campo calculado
	, frequencia
	, Y

*A) VARCHAR(50), VARCHAR(50), CHAR(2), TIME, DECIMAL(9,2), DECIMAL(9,2), TINYINT, TINYINT, VARCHAR(50), BIT
	
B) VARCHAR(50), VARCHAR(50), VARCHAR(50), DATETIME, DECIMAL(9,0), DECIMAL(9,0), TINYINT, TINYINT, VARCHAR(50), BIT

C) VARCHAR(50), VARCHAR(50), CHAR(2), TIME, DECIMAL(9,2), DECIMAL(9,2), TINYINT, TINYINT, TINYINT, VARCHAR(50), BIT

D) VARCHAR(50), VARCHAR(50), CHAR(2), TIME, DECIMAL(9,0), DECIMAL(9,0), INT, INT, VARCHAR(50), BIT

E) N.D.A.


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 5: Tratamento dos dados ( Testes pré-carga da tabela final )
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

--Relembrando ou aprendendo :
4. Nas aulas anteriores, aprendemos métodos de criação de tabelas
[ não só ] temporárias, são exemplos :
--1
SELECT income INTO #aux1 FROM [in-vehicle-coupon-recommendation]
--2
CREATE TABLE #aux2 ( income varchar(255) )
INSERT INTO #aux2 (income) 
SELECT income FROM [in-vehicle-coupon-recommendation]

Responda, qual a diferença entre os métodos:
*lembre-se, você deve ser capaz de 'testar' as alternativas.

A)	Não há diferença alguma entre os métodos
B)	O primeiro não me permite especificar múltiplas colunas. O segundo sim.
C)	O primeiro é mais rápido e performático que o segundo.
*D)	O segundo me permite tipar melhor os dados ou adicionar regras ( constraints ), enquanto que no primeiro eu não tenho essa opção.
E)	N.D.A.

---------------------------------------------------------
Para as demais questões, seu objetivo é determinar
a melhor forma de transformar os dados retirando-os
da tabela base, tratando-os ou transformando-os antes
deles serem [futuramente] inseridos na tabela final.
---------------------------------------------------------

5. Para as etapas de transformação, como:
	Expiration	->	Expiracao
	------------	-----------
		1d			1d
		2h			2h

Qual a maneira mais simples:

*A)	nenhuma transformação nos dados é necessária a única mudança é no nome da coluna
B)	basta aplicar um CAST(expiration as INTEGER) as Expiracao
C)	basta ajustar o tipo CONVERT(BINARY,expiration) as expiracao
D)	basta jogar os valores em variáveis @expiration e depois de volta na tabela com o novo nome @expiração
E)	N.D.A.

---------------------------------------------------------

6. Para as etapas de tradução de dados
foi lhe pedido que use um CASE para a tradução
	Destination		->	Destino
	---------------		---------------------
	No Urgent Place		Sem destino urgente
	Home				Casa
	Work				Trabalho

O seguinte select foi elaborado por outro funcionário.
1- SELECT CASE destination 
2- 	WHEN destination = 'No Urgent Place' THEN 'Sem destino urgente'
3- 	WHEN destination = 'Home' THEN 'Casa'
4- 	WHEN destination = 'Work' THEN 'Trabalho'
5- 	END as Destino		
6- FROM [in-vehicle-coupon-recommendation]

Mas aparentemente o select está errado, onde está o erro:

*A)	erro na linha 1, correto = SELECT CASE
B)	erro na linha 5, correto = END as Destination
*C)	erro na linha 2,3 e 4 correto = CASE 'VALOR' THEN 'TRADUÇÃO'
D)	erro na linha 5, correto = Adicionar linha ELSE 'Unknown'	
E)	N.D.A.

---------------------------------------------------------

7. A solução acima, obviamente com nomes diferentes 
para as colunas e valores diferentes para as traduções
funcionaria para as colunas: Frequencia e passageiro ? 

A)	Obviamente que não, cada coluna com sua solução unica e inovadora.
*B)	Sim, a solução de CASE funcionaria para todas.
C)	Sim, e digo mais, com MUITO pouco esforço, funciona para todas as colunas, não importando o número de consições e comparações
D)	Não, O número de elementos de comparação inviabilisa a solução pois a deixaria muito grande e/ou complexa.
E)	N.D.A.

---------------------------------------------------------

--Relembrando ou aprendendo :
O comando SUBSTRING tem a seguinte sintaxe:
Dado uma string, uma posição inicial e a qtde de chars
ele devolver um pedaço da string começando naquela posição.
Então:
	SELECT SUBSTRING('primeiro segundo',10,7)
	--Devolvido				   ^^^^^^^ 
Devole os 7 chars a partir da posição 10.

--Relembrando ou aprendendo :
O Comando IIF (Diferentemente do IF )
é usado dentro do select e apresenta uma solução
mais simples do que um CASE para apenas 2 condições
Então:
	SELECT IIF( 2 + 2 = 4, 'verdadeiro', 'falso' )
Devolve verdadeiro pois realmente  2+2 = 4

--Relembrando ou aprendendo :
O Comando DATEADD adiciona uma fração de tempo à outra data.
Então:
	SELECT DATEADD(hour,2,getdate())
Devolve a hora atual acrescida de 2 horas

8. Para as etapas de transformação e tradução de dados ( Hora )
	Time	->	Hora
	------		-------
	2PM			14:00
	10AM		10:00

Foi lhe pedido que analise a solução proposta 
por outro funcionário para a tradução da hora:
	SELECT	CONVERT(TIME, IIF( LEN([TIME]) = 4
		, CASE WHEN SUBSTRING([time],2,2) = 'PM' 
		THEN DATEADD(hour,CAST(SUBSTRING([time],1,2) AS INT)+12,'00:00:00')
		ELSE DATEADD(hour,CAST(SUBSTRING([time],1,2) AS INT),'00:00:00')
		END
		, CASE WHEN RIGHT([time],2) = 'PM' 
		THEN DATEADD(hour,CAST(SUBSTRING([time],1,1) AS INT)+12,'00:00:00')
		ELSE DATEADD(hour,CAST(SUBSTRING([time],1,1) AS INT),'00:00:00')
		END
		))
	FROM	[in-vehicle-coupon-recommendation]

Responsa à essas duas questões:
	Esta é uma solução válida ? ( à prova de falhas )
	Você consegue enxergar uma forma mais imples de implementá-la ?
*A) Sim é valida, porém um simples convert(time,[time]) bastaria.
B)	Não é valida, o mais simples seriam 24 opções de case when para as 24 horas do dia.
C)	Sim, é válida, porém, não há maneira mais simples de transformar '2PM' em '14:00'
D)	Não é válida, porém, não há como resolver essa transformação o campo obrigatoriamente deve ser deixado como está.
E)	N.D.A.

---------------------------------------------------------

9. Para transformações como as da coluna income ( renda ).
E sua divisão em duas colunas, como sugerido:
	Income				-> 	RendaMin	RendaMax
	---------------			---------	---------
	$62500 - $74999			62500		74999
	Less than $12500		0			12500
	$100000 or More			100000		250000
A primeira parte do trabalho é identificar quais os diferentes 
valores que essa coluna pode ter, como você faria isso :

*A)	SELECT distinct income FROM [in-vehicle-coupon-recommendation]
*B)	SELECT income FROM [in-vehicle-coupon-recommendation] GROUP BY income
C)	SELECT * FROM [in-vehicle-coupon-recommendation] ORDER BY INCOME
D)	SELECT TOP 10 INCOME FROM [in-vehicle-coupon-recommendation]
E)	N.D.A.

---------------------------------------------------------
Você dever identificado que os valores em vêm 3 tipos diferentes:
Vamos tratar cada um deles separadamente:
	Income				-> 	RendaMin	RendaMax
	---------------			---------	---------
1-	$62500 - $74999			62500		74999
2-	Less than $12500		0			12500
3-	$100000 or More			100000		250000

Os tipos 2 e 3 podem ser abordados com a seguinte solução:
-	tire todo o texto conhecido, o que sobrar é o número
	no caso 2, o que sobrar é o rendaMax, e rendaMin = 0
	no caso 3, o que sobrar é o rendaMin, e rendaMax = 25000
O tipo 1, excluindo o que não é número, busque a posição do '-'
	, tudo o que está à esquerda do '-' é RendaMin
	, tudo o que está à direita do '-' é RendaMax

Como tudo é muito complexo, lhe foi solicitado 
testar os códigos utilizando variáveis, como:
DECLARE @income_caso1 VARCHAR(50) = '$62500 - $74999'
	,	@income_caso2 VARCHAR(50) = 'Less than $12500'
	,	@income_caso3 VARCHAR(50) = '$100000 or More'

---------------------------------------------------------------

--Relembrando ou aprendendo :
O comando REPLACE é usado para substituir chars
Então:
	SELECT REPLACE ( '123X56', 'X', 4 )
Posso substituir algo por nada '' para remover aquele char.
	SELECT REPLACE ( '123X56', 'X', '' )
Ambos fazem substituições mas devolvem um dado do tipo texto.

--Relembrando ou aprendendo :
Para converter o tipo para outro utilizamos o comando cast ou convert.
Então:
	SELECT CONVERT(INT,  REPLACE ( '123X56', 'X', 4 ) )
Converte o resultado o REPLACE em um inteiro
	SELECT CAST( REPLACE ( '123X56', 'X', 4 ) AS DECIMAL(9,2) )


10. Para resolver o caso número 2:

Dado uma variável com o conteúdo 'Less than $12500'
qual a linha correta para remover o 'Less than $'
e devolver o resultado como um número: 

Assinale a alternativa correta (com o tipo de dados mais adequado):
DECLARE @income_caso2 VARCHAR(50) = 'Less than $12500'

A) SELECT REPLACE( @income_caso2, 'Less than $', '' )
*B) SELECT CONVERT(DECIMAL(9,2),REPLACE(@income_caso2,'Less than $',''))
C) SELECT CAST( REPLACE( @income_caso2, 'Less than $', '' ) as INT)
D) SELECT CONVERT(DECIMAL(10,2),REPLACE( '12500', '', '' ))
E) N.D.A.

-------------------------------------------------------------

--Relembrando ou aprendendo :
Posso alinhar o REPLACE para remover um padrão de cada vez.
Ex: 
--removendo só o X
	SELECT REPLACE('123X45Y67','X','')
--removendo só o Y
	SELECT REPLACE('123X45Y67','Y','')
--removendo ambos (a saída do primeiro replace é entrada do segundo)
	SELECT REPLACE(  REPLACE('123X45Y67','X','')  ,'Y','')

11. Para resolver o caso número 3:
	
Então, dado uma variável com o conteúdo '$100000 or More'
qual a linha correta para remover o '$' e o ' or More'
e devolver o resultado como um número: 

Assinale a alternativa correta:
DECLARE @income_caso3 VARCHAR(50) = '$100000 or More'

A) SELECT REPLACE( @income_caso3, ' or More', '' )
B) SELECT REPLACE( @income_caso3, '$', '' )
C) SELECT REPLACE( REPLACE( @income_caso3, ' or More', '' ) , '$', '' )
*D) SELECT CONVERT(DECIMAL(9,2),REPLACE( REPLACE( @income_caso3, ' or More', '' ) , '$', '' ))
E) N.D.A.

-----------------------------------------------------

--Relembrando ou aprendendo :
O Comando para devolver a posição de um texto procurado é o 
CHARINDEX, por exemplo, para devolver a posição do @:
	SELECT CHARINDEX('@','jose@gmail.com',0) 
Ele devolveu 5 pois o '@' está na quinta posição em 'jose@gmail.com'

Então, podemos dizer que:
	do começo ao '@'-1 é o nome do usuário (1..4)
	do '@'+1 até o final da string é o dominiio ( 6..14 )
O char '@' da posição 5 não foi incluído nem no nome nem no domínio.

12. Para resolver o caso número 1:

Então, dado uma variável com o conteúdo '$62500 - $74999'
removendo chars inválidos como '$'
quais as linhas corretas para devolver os valores 62500 e 74999

DECLARE @income_caso1 VARCHAR(50) = '$62500 - $74999'
SELECT @income_caso1 = REPLACE( @income_caso1, '$', '' )

1. SELECT CONVERT( decimal(9,2), SUBSTRING ( @income_caso1
2. 			, 0
3.			...
4.		) ) as RendaMin
5.		, CONVERT( decimal(9,2), SUBSTRING ( @income_caso1
6.			...
7.			, LEN(@income_caso1)
8.		) ) as RendaMin

Quais os valores respectivos das linhas 3 e 6 ?
Respectivamente devolvendo a posição do inicio do bloco procurado
e a posição imediatamente posterior ao bloco procurado.
*A)	, CHARINDEX(' - ', @income_caso1,0)		e , CHARINDEX(' - ', @income_caso1,0)+3
B)	, CHARINDEX(' - ', @income_caso1,0) -1	e , CHARINDEX(' - ', @income_caso1,0)+1
C)	, CHARINDEX(' - ', @income_caso1,0)	-1	e , CHARINDEX(' - ', @income_caso1,0)
D)	, CHARINDEX(' - ', @income_caso1,0)		e , CHARINDEX(' - ', @income_caso1,0)
E)	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 6: Percorrendo os dados ( WHILE )
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

-- Relembrando ou aprendendo :
Todo while tem que ter:
	- condição inicial ( de onde o loop começa )
	- condição de parada ( quando ele termina )
	- condição de avanço ( o que muda passo a passo )
	- Script a ser executado. ( bloco de código interno ).
A união destes elementos geram o que chamamos de propósito.
*	Cuidado que a palavra while quer dizer "enquanto"
	e o que chamamos de condição de parada quer dizer
	"quando", então os conceitos tem que ser ajustados.

13. Sobre a utilização do while

Identifique esses 4 elementos no while a seguir:
	-- Loop limitado a 100 execuções
	DECLARE @qtd tinyint = 1
	WHILE @qtd <= 100
	BEGIN
		PRINT 'QTD = ' + CAST(@Qtd AS VARCHAR)
		SET @qtd = @qtd + 1
	END
Agora assinale a alternativa que representa a 
ordem correta e a conclusão ou propósito deste bloco.

A)	condição inicial: @qtd = 1
	condição de parada: @qtd <= 100
	condição de avanço: @qtd + 1
	Script a ser executado: PRINT... 
	Propósito: Imprimir o valor de @qtd 99 vezes (100-1= 99)

*B)	condição inicial: @qtd =1
	condição de parada: @qtd > 100
	condição de avanço: @qtd + 1
	Script a ser executado: PRINT... 
	Propósito: Imprimir o valor de @qtd 100 vezes.

C)	condição inicial: @qtd =1
	condição de parada: @qtd + 1
	condição de avanço: @qtd >= 100
	Script a ser executado: PRINT... 
	Propósito: Imprimir o valor de @qtd 100 vezes.

D)	condição inicial: @qtd = 0
	condição de parada: @qtd > 101
	condição de avanço: @qtd + 1
	Script a ser executado: CONCATENAR DADOS... 
	Propósito: Concatenar o valor de @qtd 101 vezes.

E)	N.D.A.

-----------------------------------------------------

--Relembrando ou aprendendo:
Aprendemos na aula 06 a percorrer os dados linha a linha
com um exemplo do seguinte código:
	DECLARE @ID INT = 0, @msg VARCHAR(200)
	-- Percorrendo todas as tabelas
	WHILE EXISTS ( SELECT * FROM estacionamento WHERE id > @ID)
	BEGIN
		--Pego o primeiro ID acima do valor atual
		SELECT @ID = MIN(id) FROM estacionamento WHERE id > @ID
		--Gero a string a ser impressa e armazeno em uma variável
		SELECT @msg = 'PLACA: ' + placa
		FROM	estacionamento
				INNER JOIN veiculo ON estacionamento.idVeiculo = veiculo.id
		WHERE	estacionamento.id = @ID
		--Imprimo os valores
		PRINT @msg
	END

14. Sobre a utilização de WHILE no estilo para cada linha...

Pergunta: É possível realizar a solução de while para percorrer a tabela
recentemente importada [in-vehicle-coupon-recommendation] linha a linha ? 

A)	Não pois ela não tem uma chave primária
B)	Não pois ela não tem um campo numérico
*C)	Não pois ela não tem nenhuma coluna que funcione, como identificador único para cada linha, são soluções: unique, primary key, identity, numerar manualmente.
D)	Sim, é possível aplicar a mesma técnica na tabela, sem precisar de alterações
E)	N.D.A.

-----------------------------------------------------

15. Agora observe o código que outro profissional escreveu para tentar resolver
o problema do while linha a linha, utilizando uma tabela temporária.
	select	ROW_NUMBER() OVER(ORDER BY rand()) as ID
			, destination
			--Demais colunas...
	INTO	#teste_while
	FROM	[in-vehicle-coupon-recommendation]
	WHERE	coupon = 'bar'
-- ROW_NUMBER()  é um comando novo, que numera ou conta as linhas

Agora, usando #teste_while e não [in-vehicle-coupon-recommendation]
É possível usar o WHILE para percorrer a tabela ?
imprimindo, por exmplo, o valor de uma das colunas ( como teste )

A)	Não pois não é possível rodar o while sobre uma tabela temporária.
*B)	Sim, basta percorrer esta nova coluna sequencialmente
C)	Não, mas um ALTER TABLE #teste_while ADD PRIMARY KEY ( ID ) Resolveria
D)	Sim, mas não seria um loop do tipo 'para cada' e precisaríamos de um contador de linhas fixas.
E)	N.D.A.

-----------------------------------------------------

16. Em continuação à questão anterior, um outro funcionário
disse quase ter encontrado a resposta ao utilizar a nova tabela temporária, 
ele só não sabe qual erro cometeu.

Ajude-o analisando o código abaixo e apontando as correções.
1.	DECLARE @ID INT = 0
2.	WHILE EXISTS ( SELECT * FROM #teste_while WHERE id = @ID)
3.	BEGIN
4.		SELECT @ID = MIN(id) FROM #teste_while WHERE id = @ID
5.		SELECT	'Destination: ' + Destination
6.			FROM	#teste_while
7.			WHERE	id = @ID
8.	END

Assinale a alternativa que corrige os erros do script acima:

*A)	Nas linhas 2 e 4. -> WHERE id > @ID
B)	Nas linhas 2 e 4. -> WHERE id >= @ID
C)	Na linhas 2 -> WHERE id >= @ID
D)	Nas linhas 4 -> SELECT MAX(ID)
E)	N.D.A.

--Relembrando ou aprendendo:
Aprendemos na aula 06 a percorrer os dados linha a linha
com um exemplo do seguinte código:
	--Variáveis para receber os valores do tabela, uma linha por vez.
	DECLARE @id int, @placa char(7)
	--Declareção do cursor
	DECLARE Veiculos CURSOR FOR (
		select id, placa from veiculo
	)
	OPEN Veiculos -- Abertura do mesmo, posição inicial do cursor é fora da tabela, antes do primeiro registro.
	-- movendo o cursor para o primeiro registro
	FETCH NEXT FROM Veiculos INTO @id, @placa 
	--repete enquanto o cursor está sob um registro válido
	WHILE (@@FETCH_STATUS = 0) 
	BEGIN
		--Tudo o que eu quero que seja repetido, deve ser incluído entre o BEGIN e o FETCH NEXT
		select @id, @placa
		-- movendo o cursor para o próximo registro
		FETCH NEXT FROM Veiculos INTO @id, @placa 
	END
	CLOSE Veiculos --Fecho o cursor
	DEALLOCATE Veiculos --Desaloco o cursor da memória


17. Sobre a utilização de CURSORES ...

Com cursores, é possível realizar a listagem linha a linha com a tabela
recentemente importada [in-vehicle-coupon-recommendation] sem precisar da inclusão 
do contador de linhas ROW_NUMBER ou da criação da tabela temporária ? 

A)	Não pois ela não tem uma chave primária
B)	Não pois ela não tem um campo numérico
C)	Não pois ela não tem nenhuma coluna que funcione como identificador único para cada linha, são soluções:	unique, primary key, identity, numerar manualmente.
*D)	Sim, é possível aplicar a mesma técnica na tabela sem precisar de alterações
E)	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 7: Carga final dos dados ( tabela destino )
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Em sala... na próxima aula.....
Mas se quiserem brincar e tentar concluir a carga, é uma ótima atividade....




select	destination
		, passanger
		, expiration
		, time
		, income
		, age
		, temperature
		, bar
		, y
from	[in-vehicle-coupon-recommendation]
where	coupon = 'bar'






