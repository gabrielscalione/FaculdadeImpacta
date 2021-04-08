
--Rode isso apenas uma vez
create database ac2;
GO
use ac2;


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 07 - AC2 - Revis�o at� a aula 06
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
/*
Aula 01 - Revis�o
	Prepara��o do ambiente de estudo ( SQL Server )
	Skills esperadas: reconhecer e 'entender' o banco de dados
	Realizar relat�rios utilizando o conhecimento de linguagem SQL
Aula 02 - Tipos e convers�es, Vari�veis, lotes, operadores, colunas computadas
	Utilizar vari�veis para relat�rios mais complexos ( percentual vendas )
	Utilizar fun��es para tratamento e organiza��o das informa��es.
	Utilizar fun��es convers�o e transforma��es de informa��es.
Aula 03 - Tratamento de dados e nulos( iif, isnull, nullif, choose ), condicionais ( IF, CASE )
	Utilizar fun��es para melhorar a apresenta��o dos dados
	Corre��es e tratamento de dados inv�lidos.
	Exerc�cios com agenda e calend�rio.
Aula 04 - AC1 - Revis�o aulas 01 a 03
Aula 05 - tabelas tempor�rias (# e ##), vari�veis do tipo tabela (@), vari�veis do sistema (@@), redirecionador de conte�do (INTO)
	Transporte de dados, redirecionamento de conte�do.
	Armazenamento tempor�rio para processamento.
Aula 06 - Controle de fluxo (goto, continue, break, waitfor), Loop ( while ), cursores.
	Relat�rios elaborados
	Processos inteligentes.
	Discuss�o: 'Em lote' ou 'para cada'
Aula 07 - AC2 - Revis�o aulas 05 a 06
*/

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 1: Entendimento dos dados
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Acessem: http://archive.ics.uci.edu/ml/datasets/in-vehicle+coupon+recommendation

Objetivo � derterminar sob quais condi��es espec�ficas
um cupom de desconto tem mais chances de serem 'bem aceitos'
quando oferecidos aos motoristas por seus pr�prios 
dispositivos internos do carro.

Ex:	Se	O cliente vai � uma cafeteria mais de uma vez por m�s
		E seu destino n�o � algo espec�fico nem urgente
		(indo para casa talvez )
		E n�o h� crian�as como passageiro 
	OU
		O cliente vai � uma cafeteria mais de uma vez por m�s
		O tempo de expira��o do cupon � de 1 dia 		
	ENT�O
		Predizer se o cliente ir� aceitar o cupon para a cafeteria.

Aos curiosos, para mais detalhes, leiam:
https://jmlr.org/papers/volume18/16-003/16-003.pdf

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 2: Aquisi��o dos dados
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Em Data Folder > de download do arquivo: in-vehicle-coupon-recommendation.csv
( http://archive.ics.uci.edu/ml/machine-learning-databases/00603/in-vehicle-coupon-recommendation.csv )

NO SSSM ( SQL Server Management Studio )
Expandir aba Databases, clicar com o bot�o direito sobre o banco AC2
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

Seu empregador deseja a contru��o de testes apenas para
bares, e apenas com alguns vari�veis, ent�o s� algumas 
colunas da base ser�o usadas, s�o elas:
-- Destino do ve�culo
	destination:	No Urgent Place, Home, Work
-- Quem s�o os passageiros neste momento com o motorista
	passanger:		Alone, Friend(s), Kid(s), Partner 
--	Tempo de expira��o do cupom ( 1 dia ou 2 horas )
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
--	Frequencia mensal que o motorista vai � bares
	Bar: never, less1, 1~3, gt8, nan4~8 
--	Se ele aceitou o cupom ou n�o.
	Y: 1, 0 (whether the coupon is accepted)
/*Para detalhes de todos os atributos poss�veis, ler o artigo original.*/

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
--=X=-- Parte 4: Prepara��o dos dados
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
/*	Antes de jogar os dados necess�rios em um data lake seu empregador solicitou 
	( ou melhor, exigiu ) uma s�rie de tratamento de dados.
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
	Kid(s)			= 'Crian�as'
	Partner			= 'Companheiro(a)'

Expira��o s� ter� o nome da coluna ajustado.
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

Idade s� ter� o nome da coluna ajustado.
	Age		->	Idade
	----------	------------
	21			21
	46			46
	46			46

Temperature deve ser apresentada tamb�m em �C
	--usar formula para �C, n�o incluir valores fixos.
	Temperture	->	Temperatura_F	Temperatura_C
	-----------		--------------	---------------
	80				80				??

Frequencia deve ser reformulado e agrupado.
	Bar			->	Frequencia
	------------	------------
	never			nunca
	less1			at� 1
	1~3				de 1 a 3
	gt8				mais que 8
	nan4~8 			de 4 a 8

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 4: Prepara��o dos dados ( tabela destino )
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

3) Precisamos de uma tabela para guardar os valores finais
Defina os tipos de cada coluna sugerida ap�s especifica��o
--lembrem-se, usem os tipos mais econ�micos poss�veis :
	Destino
	, Passageiro
	, Expiracao
	, Hora
	, rendaMin
	, rendaMax
	, idade
	, temperatura_F
	--Temperatura_C ser� um campo calculado
	, frequencia
	, Y

*A) VARCHAR(50), VARCHAR(50), CHAR(2), TIME, DECIMAL(9,2), DECIMAL(9,2), TINYINT, TINYINT, VARCHAR(50), BIT
	
B) VARCHAR(50), VARCHAR(50), VARCHAR(50), DATETIME, DECIMAL(9,0), DECIMAL(9,0), TINYINT, TINYINT, VARCHAR(50), BIT

C) VARCHAR(50), VARCHAR(50), CHAR(2), TIME, DECIMAL(9,2), DECIMAL(9,2), TINYINT, TINYINT, TINYINT, VARCHAR(50), BIT

D) VARCHAR(50), VARCHAR(50), CHAR(2), TIME, DECIMAL(9,0), DECIMAL(9,0), INT, INT, VARCHAR(50), BIT

E) N.D.A.


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 5: Tratamento dos dados ( Testes pr�-carga da tabela final )
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

--Relembrando ou aprendendo :
4. Nas aulas anteriores, aprendemos m�todos de cria��o de tabelas
[ n�o s� ] tempor�rias, s�o exemplos :
--1
SELECT income INTO #aux1 FROM [in-vehicle-coupon-recommendation]
--2
CREATE TABLE #aux2 ( income varchar(255) )
INSERT INTO #aux2 (income) 
SELECT income FROM [in-vehicle-coupon-recommendation]

Responda, qual a diferen�a entre os m�todos:
*lembre-se, voc� deve ser capaz de 'testar' as alternativas.

A)	N�o h� diferen�a alguma entre os m�todos
B)	O primeiro n�o me permite especificar m�ltiplas colunas. O segundo sim.
C)	O primeiro � mais r�pido e perform�tico que o segundo.
*D)	O segundo me permite tipar melhor os dados ou adicionar regras ( constraints ), enquanto que no primeiro eu n�o tenho essa op��o.
E)	N.D.A.

---------------------------------------------------------
Para as demais quest�es, seu objetivo � determinar
a melhor forma de transformar os dados retirando-os
da tabela base, tratando-os ou transformando-os antes
deles serem [futuramente] inseridos na tabela final.
---------------------------------------------------------

5. Para as etapas de transforma��o, como:
	Expiration	->	Expiracao
	------------	-----------
		1d			1d
		2h			2h

Qual a maneira mais simples:

*A)	nenhuma transforma��o nos dados � necess�ria a �nica mudan�a � no nome da coluna
B)	basta aplicar um CAST(expiration as INTEGER) as Expiracao
C)	basta ajustar o tipo CONVERT(BINARY,expiration) as expiracao
D)	basta jogar os valores em vari�veis @expiration e depois de volta na tabela com o novo nome @expira��o
E)	N.D.A.

---------------------------------------------------------

6. Para as etapas de tradu��o de dados
foi lhe pedido que use um CASE para a tradu��o
	Destination		->	Destino
	---------------		---------------------
	No Urgent Place		Sem destino urgente
	Home				Casa
	Work				Trabalho

O seguinte select foi elaborado por outro funcion�rio.
1- SELECT CASE destination 
2- 	WHEN destination = 'No Urgent Place' THEN 'Sem destino urgente'
3- 	WHEN destination = 'Home' THEN 'Casa'
4- 	WHEN destination = 'Work' THEN 'Trabalho'
5- 	END as Destino		
6- FROM [in-vehicle-coupon-recommendation]

Mas aparentemente o select est� errado, onde est� o erro:

*A)	erro na linha 1, correto = SELECT CASE
B)	erro na linha 5, correto = END as Destination
*C)	erro na linha 2,3 e 4 correto = CASE 'VALOR' THEN 'TRADU��O'
D)	erro na linha 5, correto = Adicionar linha ELSE 'Unknown'	
E)	N.D.A.

---------------------------------------------------------

7. A solu��o acima, obviamente com nomes diferentes 
para as colunas e valores diferentes para as tradu��es
funcionaria para as colunas: Frequencia e passageiro ? 

A)	Obviamente que n�o, cada coluna com sua solu��o unica e inovadora.
*B)	Sim, a solu��o de CASE funcionaria para todas.
C)	Sim, e digo mais, com MUITO pouco esfor�o, funciona para todas as colunas, n�o importando o n�mero de consi��es e compara��es
D)	N�o, O n�mero de elementos de compara��o inviabilisa a solu��o pois a deixaria muito grande e/ou complexa.
E)	N.D.A.

---------------------------------------------------------

--Relembrando ou aprendendo :
O comando SUBSTRING tem a seguinte sintaxe:
Dado uma string, uma posi��o inicial e a qtde de chars
ele devolver um peda�o da string come�ando naquela posi��o.
Ent�o:
	SELECT SUBSTRING('primeiro segundo',10,7)
	--Devolvido				   ^^^^^^^ 
Devole os 7 chars a partir da posi��o 10.

--Relembrando ou aprendendo :
O Comando IIF (Diferentemente do IF )
� usado dentro do select e apresenta uma solu��o
mais simples do que um CASE para apenas 2 condi��es
Ent�o:
	SELECT IIF( 2 + 2 = 4, 'verdadeiro', 'falso' )
Devolve verdadeiro pois realmente  2+2 = 4

--Relembrando ou aprendendo :
O Comando DATEADD adiciona uma fra��o de tempo � outra data.
Ent�o:
	SELECT DATEADD(hour,2,getdate())
Devolve a hora atual acrescida de 2 horas

8. Para as etapas de transforma��o e tradu��o de dados ( Hora )
	Time	->	Hora
	------		-------
	2PM			14:00
	10AM		10:00

Foi lhe pedido que analise a solu��o proposta 
por outro funcion�rio para a tradu��o da hora:
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

Responsa � essas duas quest�es:
	Esta � uma solu��o v�lida ? ( � prova de falhas )
	Voc� consegue enxergar uma forma mais imples de implement�-la ?
*A) Sim � valida, por�m um simples convert(time,[time]) bastaria.
B)	N�o � valida, o mais simples seriam 24 op��es de case when para as 24 horas do dia.
C)	Sim, � v�lida, por�m, n�o h� maneira mais simples de transformar '2PM' em '14:00'
D)	N�o � v�lida, por�m, n�o h� como resolver essa transforma��o o campo obrigatoriamente deve ser deixado como est�.
E)	N.D.A.

---------------------------------------------------------

9. Para transforma��es como as da coluna income ( renda ).
E sua divis�o em duas colunas, como sugerido:
	Income				-> 	RendaMin	RendaMax
	---------------			---------	---------
	$62500 - $74999			62500		74999
	Less than $12500		0			12500
	$100000 or More			100000		250000
A primeira parte do trabalho � identificar quais os diferentes 
valores que essa coluna pode ter, como voc� faria isso :

*A)	SELECT distinct income FROM [in-vehicle-coupon-recommendation]
*B)	SELECT income FROM [in-vehicle-coupon-recommendation] GROUP BY income
C)	SELECT * FROM [in-vehicle-coupon-recommendation] ORDER BY INCOME
D)	SELECT TOP 10 INCOME FROM [in-vehicle-coupon-recommendation]
E)	N.D.A.

---------------------------------------------------------
Voc� dever identificado que os valores em v�m 3 tipos diferentes:
Vamos tratar cada um deles separadamente:
	Income				-> 	RendaMin	RendaMax
	---------------			---------	---------
1-	$62500 - $74999			62500		74999
2-	Less than $12500		0			12500
3-	$100000 or More			100000		250000

Os tipos 2 e 3 podem ser abordados com a seguinte solu��o:
-	tire todo o texto conhecido, o que sobrar � o n�mero
	no caso 2, o que sobrar � o rendaMax, e rendaMin = 0
	no caso 3, o que sobrar � o rendaMin, e rendaMax = 25000
O tipo 1, excluindo o que n�o � n�mero, busque a posi��o do '-'
	, tudo o que est� � esquerda do '-' � RendaMin
	, tudo o que est� � direita do '-' � RendaMax

Como tudo � muito complexo, lhe foi solicitado 
testar os c�digos utilizando vari�veis, como:
DECLARE @income_caso1 VARCHAR(50) = '$62500 - $74999'
	,	@income_caso2 VARCHAR(50) = 'Less than $12500'
	,	@income_caso3 VARCHAR(50) = '$100000 or More'

---------------------------------------------------------------

--Relembrando ou aprendendo :
O comando REPLACE � usado para substituir chars
Ent�o:
	SELECT REPLACE ( '123X56', 'X', 4 )
Posso substituir algo por nada '' para remover aquele char.
	SELECT REPLACE ( '123X56', 'X', '' )
Ambos fazem substitui��es mas devolvem um dado do tipo texto.

--Relembrando ou aprendendo :
Para converter o tipo para outro utilizamos o comando cast ou convert.
Ent�o:
	SELECT CONVERT(INT,  REPLACE ( '123X56', 'X', 4 ) )
Converte o resultado o REPLACE em um inteiro
	SELECT CAST( REPLACE ( '123X56', 'X', 4 ) AS DECIMAL(9,2) )


10. Para resolver o caso n�mero 2:

Dado uma vari�vel com o conte�do 'Less than $12500'
qual a linha correta para remover o 'Less than $'
e devolver o resultado como um n�mero: 

Assinale a alternativa correta (com o tipo de dados mais adequado):
DECLARE @income_caso2 VARCHAR(50) = 'Less than $12500'

A) SELECT REPLACE( @income_caso2, 'Less than $', '' )
*B) SELECT CONVERT(DECIMAL(9,2),REPLACE(@income_caso2,'Less than $',''))
C) SELECT CAST( REPLACE( @income_caso2, 'Less than $', '' ) as INT)
D) SELECT CONVERT(DECIMAL(10,2),REPLACE( '12500', '', '' ))
E) N.D.A.

-------------------------------------------------------------

--Relembrando ou aprendendo :
Posso alinhar o REPLACE para remover um padr�o de cada vez.
Ex: 
--removendo s� o X
	SELECT REPLACE('123X45Y67','X','')
--removendo s� o Y
	SELECT REPLACE('123X45Y67','Y','')
--removendo ambos (a sa�da do primeiro replace � entrada do segundo)
	SELECT REPLACE(  REPLACE('123X45Y67','X','')  ,'Y','')

11. Para resolver o caso n�mero 3:
	
Ent�o, dado uma vari�vel com o conte�do '$100000 or More'
qual a linha correta para remover o '$' e o ' or More'
e devolver o resultado como um n�mero: 

Assinale a alternativa correta:
DECLARE @income_caso3 VARCHAR(50) = '$100000 or More'

A) SELECT REPLACE( @income_caso3, ' or More', '' )
B) SELECT REPLACE( @income_caso3, '$', '' )
C) SELECT REPLACE( REPLACE( @income_caso3, ' or More', '' ) , '$', '' )
*D) SELECT CONVERT(DECIMAL(9,2),REPLACE( REPLACE( @income_caso3, ' or More', '' ) , '$', '' ))
E) N.D.A.

-----------------------------------------------------

--Relembrando ou aprendendo :
O Comando para devolver a posi��o de um texto procurado � o 
CHARINDEX, por exemplo, para devolver a posi��o do @:
	SELECT CHARINDEX('@','jose@gmail.com',0) 
Ele devolveu 5 pois o '@' est� na quinta posi��o em 'jose@gmail.com'

Ent�o, podemos dizer que:
	do come�o ao '@'-1 � o nome do usu�rio (1..4)
	do '@'+1 at� o final da string � o dominiio ( 6..14 )
O char '@' da posi��o 5 n�o foi inclu�do nem no nome nem no dom�nio.

12. Para resolver o caso n�mero 1:

Ent�o, dado uma vari�vel com o conte�do '$62500 - $74999'
removendo chars inv�lidos como '$'
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
Respectivamente devolvendo a posi��o do inicio do bloco procurado
e a posi��o imediatamente posterior ao bloco procurado.
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
	- condi��o inicial ( de onde o loop come�a )
	- condi��o de parada ( quando ele termina )
	- condi��o de avan�o ( o que muda passo a passo )
	- Script a ser executado. ( bloco de c�digo interno ).
A uni�o destes elementos geram o que chamamos de prop�sito.
*	Cuidado que a palavra while quer dizer "enquanto"
	e o que chamamos de condi��o de parada quer dizer
	"quando", ent�o os conceitos tem que ser ajustados.

13. Sobre a utiliza��o do while

Identifique esses 4 elementos no while a seguir:
	-- Loop limitado a 100 execu��es
	DECLARE @qtd tinyint = 1
	WHILE @qtd <= 100
	BEGIN
		PRINT 'QTD = ' + CAST(@Qtd AS VARCHAR)
		SET @qtd = @qtd + 1
	END
Agora assinale a alternativa que representa a 
ordem correta e a conclus�o ou prop�sito deste bloco.

A)	condi��o inicial: @qtd = 1
	condi��o de parada: @qtd <= 100
	condi��o de avan�o: @qtd + 1
	Script a ser executado: PRINT... 
	Prop�sito: Imprimir o valor de @qtd 99 vezes (100-1= 99)

*B)	condi��o inicial: @qtd =1
	condi��o de parada: @qtd > 100
	condi��o de avan�o: @qtd + 1
	Script a ser executado: PRINT... 
	Prop�sito: Imprimir o valor de @qtd 100 vezes.

C)	condi��o inicial: @qtd =1
	condi��o de parada: @qtd + 1
	condi��o de avan�o: @qtd >= 100
	Script a ser executado: PRINT... 
	Prop�sito: Imprimir o valor de @qtd 100 vezes.

D)	condi��o inicial: @qtd = 0
	condi��o de parada: @qtd > 101
	condi��o de avan�o: @qtd + 1
	Script a ser executado: CONCATENAR DADOS... 
	Prop�sito: Concatenar o valor de @qtd 101 vezes.

E)	N.D.A.

-----------------------------------------------------

--Relembrando ou aprendendo:
Aprendemos na aula 06 a percorrer os dados linha a linha
com um exemplo do seguinte c�digo:
	DECLARE @ID INT = 0, @msg VARCHAR(200)
	-- Percorrendo todas as tabelas
	WHILE EXISTS ( SELECT * FROM estacionamento WHERE id > @ID)
	BEGIN
		--Pego o primeiro ID acima do valor atual
		SELECT @ID = MIN(id) FROM estacionamento WHERE id > @ID
		--Gero a string a ser impressa e armazeno em uma vari�vel
		SELECT @msg = 'PLACA: ' + placa
		FROM	estacionamento
				INNER JOIN veiculo ON estacionamento.idVeiculo = veiculo.id
		WHERE	estacionamento.id = @ID
		--Imprimo os valores
		PRINT @msg
	END

14. Sobre a utiliza��o de WHILE no estilo para cada linha...

Pergunta: � poss�vel realizar a solu��o de while para percorrer a tabela
recentemente importada [in-vehicle-coupon-recommendation] linha a linha ? 

A)	N�o pois ela n�o tem uma chave prim�ria
B)	N�o pois ela n�o tem um campo num�rico
*C)	N�o pois ela n�o tem nenhuma coluna que funcione, como identificador �nico para cada linha, s�o solu��es: unique, primary key, identity, numerar manualmente.
D)	Sim, � poss�vel aplicar a mesma t�cnica na tabela, sem precisar de altera��es
E)	N.D.A.

-----------------------------------------------------

15. Agora observe o c�digo que outro profissional escreveu para tentar resolver
o problema do while linha a linha, utilizando uma tabela tempor�ria.
	select	ROW_NUMBER() OVER(ORDER BY rand()) as ID
			, destination
			--Demais colunas...
	INTO	#teste_while
	FROM	[in-vehicle-coupon-recommendation]
	WHERE	coupon = 'bar'
-- ROW_NUMBER()  � um comando novo, que numera ou conta as linhas

Agora, usando #teste_while e n�o [in-vehicle-coupon-recommendation]
� poss�vel usar o WHILE para percorrer a tabela ?
imprimindo, por exmplo, o valor de uma das colunas ( como teste )

A)	N�o pois n�o � poss�vel rodar o while sobre uma tabela tempor�ria.
*B)	Sim, basta percorrer esta nova coluna sequencialmente
C)	N�o, mas um ALTER TABLE #teste_while ADD PRIMARY KEY ( ID ) Resolveria
D)	Sim, mas n�o seria um loop do tipo 'para cada' e precisar�amos de um contador de linhas fixas.
E)	N.D.A.

-----------------------------------------------------

16. Em continua��o � quest�o anterior, um outro funcion�rio
disse quase ter encontrado a resposta ao utilizar a nova tabela tempor�ria, 
ele s� n�o sabe qual erro cometeu.

Ajude-o analisando o c�digo abaixo e apontando as corre��es.
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
com um exemplo do seguinte c�digo:
	--Vari�veis para receber os valores do tabela, uma linha por vez.
	DECLARE @id int, @placa char(7)
	--Declare��o do cursor
	DECLARE Veiculos CURSOR FOR (
		select id, placa from veiculo
	)
	OPEN Veiculos -- Abertura do mesmo, posi��o inicial do cursor � fora da tabela, antes do primeiro registro.
	-- movendo o cursor para o primeiro registro
	FETCH NEXT FROM Veiculos INTO @id, @placa 
	--repete enquanto o cursor est� sob um registro v�lido
	WHILE (@@FETCH_STATUS = 0) 
	BEGIN
		--Tudo o que eu quero que seja repetido, deve ser inclu�do entre o BEGIN e o FETCH NEXT
		select @id, @placa
		-- movendo o cursor para o pr�ximo registro
		FETCH NEXT FROM Veiculos INTO @id, @placa 
	END
	CLOSE Veiculos --Fecho o cursor
	DEALLOCATE Veiculos --Desaloco o cursor da mem�ria


17. Sobre a utiliza��o de CURSORES ...

Com cursores, � poss�vel realizar a listagem linha a linha com a tabela
recentemente importada [in-vehicle-coupon-recommendation] sem precisar da inclus�o 
do contador de linhas ROW_NUMBER ou da cria��o da tabela tempor�ria ? 

A)	N�o pois ela n�o tem uma chave prim�ria
B)	N�o pois ela n�o tem um campo num�rico
C)	N�o pois ela n�o tem nenhuma coluna que funcione como identificador �nico para cada linha, s�o solu��es:	unique, primary key, identity, numerar manualmente.
*D)	Sim, � poss�vel aplicar a mesma t�cnica na tabela sem precisar de altera��es
E)	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 7: Carga final dos dados ( tabela destino )
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

Em sala... na pr�xima aula.....
Mas se quiserem brincar e tentar concluir a carga, � uma �tima atividade....




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






