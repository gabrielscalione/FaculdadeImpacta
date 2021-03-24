------------------------------------------------------
-- Guia de estudo - Developing Databases - GUIA DE ESTUDO
-- Aula 01 - Entendimento de um banco de dados
------------------------------------------------------

Este guia visa apresentar um conjunto de passos ou exerc�cios
( muitas vezes desenvolvido pelo pr�prio aluno) como forma 
de estudo, pr�tica ou para fixa��o de conte�do.

Tente responder � todas as perguntas e fa�a todos os passos
propostos.

Mas, antes de come�ar a falar de SQL...

------------------------------------------------------
-- Prepara��o do ambiente
------------------------------------------------------

� altamente recomendado que voc�s tenham um ambiente de trabalho.
Para ver detalhes de como instalar o MSSQL e o cliente SSMS, 
veja aula 01.
Quem n�o puder instalar o MSSQL, Instale apenas o cliente SSMS
e tente usar o servidor da impacta ou solicite acesso � um 
servidor criado pelo professor na AWS.
Quem n�o puder nem instalar o MSSQL, nem o cliente SSMS,
tente acompanhar via http://www.sqlfiddle.com/

Pause este guia e prepare seu ambiente de estudo.

------------------------------------------------------
-- Tenha uma metodologia de estudo
------------------------------------------------------

Mantenha-se organizado, salve todo o conte�do passado pelo
professor em pastas organizadas por aula, por conte�do,
por tipo de arquivo, o que voc� achar melhor.

� essencial que cada arquivo, cada v�deo, cada exerc�cios,
seja refeito, revisto, pelo menos uma vez fora da aula.

Crie um bloco de notas no inicio de cada aula, v� anotando
cada d�vida, cada ponto n�o entendido, e n�o saia da aula
sem ter respondido ou pelo menos postado as perguntas ao 
professor. 

Lembre-se, o professor tem o dever de ensinar, mas voc�
tem o dever de aprender, e os dois s� cumprir�o seus pap�is
se ambos trabalharem juntos.

N�o tenha vergonha nem pregui�a de dar um passo para tr�s 
antes de dar dois para frente. Para a constru��o de uma
pir�mide de conhecimento, se sua base n�o for forte o 
sufiente, � seu papel refor�a-la, rever conceitos, procurar
novos materiais e superar os desafios ( lembre-se
o professor � sempre uma �tima fonte de orienta��o ).

------------------------------------------------------
-- Saiba onde encontrar a informa��o
------------------------------------------------------

O material do professor � a refer�ncia b�sica e primeiro 
local de consulta. Os exerc�cios, as aulas gravadas, 
seus coment�rios, suas notas coletadas durante as aulas.

Tamb�m existem n�o s� v�deos gravadados por todos os 
professores que j� ministraram esta disciplina no passado,
basta pesquisar no smartclass ( sistema da faculdade
em www.impacta.com.br > area do aluno > Aulas de gradua��o )

Existe muito material dispon�vel na internet.
N�o h� problema se, ao estudar, voc�s precisarem 
acessar o google para descobrir o que este ou aquele comando
faz. Cada novo link, documento, ou v�deo com conte�do
interessante, deve ser arquivado em sua biblioteca pessoal
de estudo.

Seus colegas tamb�m s�o uma �tima refer�ncia,
muitos tem ou j� tiveram as mesmas d�vidas que voc�.

Por�m, ceda � tenta��o de procurar por respostas prontas
elas representam atalhos falsos para o conhecimento, e
muitas vezes apenas v�o lhe tornar cada mais dependentes 
dos outros e menos de si pr�prios.

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
------------------------------------------------------
Esta aula abordou:
	Tipos e convers�es, Vari�veis, lotes, operadores, colunas computadas
	Utiliza��o de vari�veis para relat�rios mais complexos
	Utiliza��o de fun��es para tratamento e organiza��o das informa��es.
	Utiliza��o de fun��es de convers�o e transforma��es de informa��es.

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
-- Processos
------------------------------------------------------

Lhe foram apresentados o que � um processo:
� um conjunto de instru��es com um objetivo bem definido
Muitas vezes uma linguagem cl�ssica de desenvolvimento
n�o � r�pida nem eficaz o suficiente para testar 
um conjunto de opera��es que outrora seria MUITO mais 
simples de ser realizado via SQL.

Em outras ocasi�es, os processos se tratam de uma opera��o
muito curta, uma manuten��o, uma importa��o de dados,
um relat�rio, e de forma alguma justifica-se utilizar
programas diferente do pr�prio SGBD para realiz�-los.

Outros processos s�o controlados de forma �nit�ria
(como se fosse apenas uma a��o ), mas no banco tratam-se 
de m�ltiplas a��es necess�rias para concluir aquela 
solicita��o. 
Exemplo: UPSERT, processo de 
	SE o dado n�o existir, Insira-o
	SE o dado j� existir, Atualize-o 

O processo apresentado foi o de um banco de dados 
que gerencia estacionamentos, para mais detalhes
ver "Aula 01 - Revisao SQL e entendimento de um banco de dados.sql"
ou "Aula 01 - Developing Databases - Apresenta��o e revis�o.pptx.pdf"

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
-- Entendendo um enunciado de um processo
------------------------------------------------------
Enunciado:
	Dado um tipo de ve�culo (ex: 'moto'), uma placa, ex:'GHY6543'
	um tipo de plano para cobran�a( ex: 'Avulso Horista' )
	e um local para estacionamento(ex: 'Faculdade Impacta - Paulista')
	- verificar a capacidade do estacionamento neste momento.
	- verificar se o per�odo do plano escolhido � aceito pela localidade.
	- verificar se a hora atual est� condizente com o plano de cobran�a.
	- registrar o in�cio do estacionamento.
	- Devolver o "ID" ( que ser� impresso no ticket ) daquele estacionamento.

Existem muitos tipos de inc�gnitas e de IDs que precisam ser
coletados, verificados e testados para garantir a devida 
inser��o de um �nico estacionamento.

Entenda que o objetivo final � a inser��o de um estacionamento
Ent�o, come�e olhando a tabela conforme declara��o.
	/*a��o de estacionar um ve�culo em uma localidade, principal entidade do modelo*/
	CREATE TABLE estacionamento (
		id INT NOT NULL IDENTITY(1,1)
		, idLocalidade INT NOT NULL
		, dataHoraEntrada DATETIME NOT NULL CONSTRAINT DF_dataHoraEntrada DEFAULT(GETDATE())
		, dataHoraSaida DATETIME NULL
		, idVeiculo INT NOT NULL
		, idPlano INT NOT NULL
		, valorCobrado DECIMAL(10,2) NOT NULL CONSTRAINT CK_valorCobrado DEFAULT(0.00)
		, CONSTRAINT PK_estacionamento PRIMARY KEY ( id )
		, CONSTRAINT FK_estacionamentoVeiculo FOREIGN KEY (idVeiculo) REFERENCES veiculo(id)
		, CONSTRAINT FK_estacionamentoPlano FOREIGN KEY (idPlano) REFERENCES plano(id)
		, CONSTRAINT FK_estacionamentoLocalidade FOREIGN KEY (idLocalidade) REFERENCES localidade(id)
	)
	GO
- Quais as regras de preenchimento desta tabela ?
	Qual a PK ?
	Quais as FKs ? 
		essas FKs est�o relacionadas com quais tabelas ?
	H� colunas auto-incrementais ?
	H� colunas com valores padr�o ?
	H� campos UNIQUE ou com valida��o CHECK ?
- O que � preciso coletar para inserir 1 estacionamento ?
	Para cada coluna obrigat�ria ( NOT NULL sem DEFAULT )
	busque um dado fornecido ou uma traget�ria para descobrir
	tal dado, volte ao enunciado para descobrir.
Resumo:
	id INT NOT NULL IDENTITY(1,1)
		--Auto incremental, n�o precisa ser preenchido
	, idLocalidade INT NOT NULL
		-- Existe uma FK_estacionamentoLocalidade
		-- que � capaz de me fornecer o ID da localidade
	, dataHoraEntrada DATETIME NOT NULL CONSTRAINT DF_dataHoraEntrada DEFAULT(GETDATE())
		-- N�o preciso inserir, possui DEFAULT
	, dataHoraSaida DATETIME NULL
		-- N�o � obrigat�rio
		-- s� ser� preenchido na sa�da do ve�culo
	, idVeiculo INT NOT NULL
		-- Existe uma FK_estacionamentoVeiculo
		-- que � capaz de me fornecer o ID da ve�culo
	, idPlano INT NOT NULL
		-- Existe uma FK_estacionamentoPlano
		-- que � capaz de me fornecer o ID da ve�culo
	, valorCobrado DECIMAL(10,2) NOT NULL CONSTRAINT CK_valorCobrado DEFAULT(0.00)
		-- N�o � obrigat�rio
		-- s� ser� preenchido na sa�da do ve�culo
Ou seja, agora sei onde buscar cada informa��o
necess�ria para inserir um estacionamento.

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
-- Coleta de dados para atender ao enunciado do processo
------------------------------------------------------

-- #1 -- localidade
Pela FK eu sei onde procurar o id da localidade
		, CONSTRAINT FK_estacionamentoLocalidade FOREIGN KEY (idLocalidade) REFERENCES localidade(id)
Pelo enunciado eu seu qual valor procurar na tabela
	e um local para estacionamento(ex: 'Faculdade Impacta - Paulista')
Ent�o:
	/*coleto o id do estacionamento
	Posso utiliz�-lo para simpleficar as demas consultas*/
	select id from localidade where identificacao = 'Faculdade Impacta - Paulista'
N�o se cadastra localidades com frequencia, ent�o,
seu ID � apenas consultado, nenhuma a��o � necess�ria
para inserir tal localidade caso ela n�o exista.

-- #2 -- ve�culo
Pela FK eu sei onde procurar o id do ve�culo
		, CONSTRAINT FK_estacionamentoVeiculo FOREIGN KEY (idVeiculo) REFERENCES veiculo(id)
Pelo enunciado eu seu qual valor procurar na tabela
	Dado um tipo de ve�culo (ex: 'moto'), uma placa, ex:'GHY6543'
Ent�o:
	/*coleto o id do ve�culo
	Posso utiliz�-lo para simpleficar as demas consultas*/
	select id from veiculo where placa = 'GHY6543'
Por�m:
Se o ve�culo n�o existir, ele deve ser inserido.
Pois n�o h� como recuperar o ID de um ve�culo que n�o 
est� no banco de dados.
Desta forma:
	/*coleto o id do ve�culo*/
	Caso seja a primeira vez que ele estaciona, � necess�rio estacionar o ve�culo
	Como � um cliente horista, n�o preciso cadastrar um cliente ( apenas para mensalistas )
		Insert veiculo( tipo, placa, idCliente)
		VALUES ( 'moto', 'GHY6543', NULL )
Se o ve�culo acabou de ser inserido
eu preciso recuperar o ID que ele acabou de ganhar.
observando o modelo desta tabela:
		/*Veiculo � o objeto controlado durante o estacionamento*/
		CREATE TABLE veiculo (
			id INT NOT NULL IDENTITY(1,1)
			, tipo CHAR(5) NOT NULL
			, placa CHAR(7) NOT NULL
			, idCliente INT NULL /*Ve�culo avulso n�o registra o cliente*/
			, CONSTRAINT CK_tipoVeiculo CHECK ( tipo in ( 'carro', 'moto' ) )
			, CONSTRAINT CK_placaVeiculo CHECK ( placa like '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9]'
											OR	placa like '[A-Z][A-Z][A-Z][0-9][A-Z][0-9][0-9]') 
			, CONSTRAINT PK_veiculo PRIMARY KEY ( id )
			, CONSTRAINT UQ_veiculoPlaca UNIQUE ( placa )
			, CONSTRAINT FK_VeiculoCliente FOREIGN KEY ( idCliente ) REFERENCES cliente(id)
		)
Observa-se que ela possui uma PK com valor auto-incremental,
ent�o, basta recuperar o ID pelos processos:
	SELECT @@identity
	OU 
	SELECT SCOPE_IDENTITY
- J� conhecia estes comandos ? 
	se n�o, de uma pausa dos estudos e pesquise-os.

-- #3 -- plano
Pela FK eu sei onde procurar o id da planio
		, CONSTRAINT FK_estacionamentoPlano FOREIGN KEY (idPlano) REFERENCES plano(id)
Pelo enunciado eu seu qual valor procurar na tabela
	um tipo de plano para cobran�a( ex: 'Avulso Horista' )

Por�m, ao analisar o c�digo da tabela PLANO:
		/*Plano s�o os modelos de contrata��o e cobran�a que um ve�culo tem que se encaixar*/
		/* Os planos s�o espec�ficos por localidade e tem validade
		*/
		CREATE TABLE Plano (
			id INT NOT NULL IDENTITY(1,1)
			, idCategoria INT NOT NULL
			, ativo BIT NOT NULL
			, dataInicioVigencia DATE
			, dataFimVigencia DATE
			, valor DECIMAL(10,2) NOT NULL CONSTRAINT DF_valor DEFAULT (0.00)
			, idLocalidade INT NOT NULL 
			, CONSTRAINT PK_plano PRIMARY KEY ( id )
			, CONSTRAINT FK_PlanoTipo FOREIGN KEY ( idCategoria ) REFERENCES categoriaPlano(id)
			, CONSTRAINT FK_PlanoLocalidade FOREIGN KEY ( idLocalidade ) REFERENCES localidade(id)
		)
		GO
� poss�vel observar que o nome do plano de cobran�a n�o fica ali.
Desta forma, tenho que procurar em seus relacionamentos
por uma forma de chegar at� onde eu possa localizar tal nome

Ao listar os planos previamente inseridos:
- select * from plano
	id	idCategoria	ativo	dataInicioVigencia	dataFimVigencia	valor	idLocalidade
	1	1			1		2021-01-01			NULL			120.00	1
	2	2			1		2021-01-01			NULL			160.00	1
	3	3			1		2021-01-01			NULL			100.00	1
	4	4			1		2021-01-01			NULL			20.00	1
	5	5			1		2021-01-01			NULL			25.00	1
	6	6			1		2021-01-01			NULL			10.00	1
Observa-se que os planos tem categorias.
E ao olhar na defini��o da tabela:
		, CONSTRAINT FK_PlanoTipo FOREIGN KEY ( idCategoria ) REFERENCES categoriaPlano(id)
Agora sabemos como chegar at� ela.

Ent�o, dado uma localidade e um nome para a categoria do plano
preciso descobrir o id do plano.
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
- Lembra-se de como realizar os JOINs ?
	eles s�o sempre feitos pela compara��o de dados
	Ent�o, sempre confira os dados antes de realizar uma jun��o.
- Lembre-se que na GRANDE MAIORIA dos casos,
	toda jun��o � sempre realizara baseada na integridade
	referencial criada pela dupla PK-FK
	Ent�o, conhecendo as regras, conhece-se os caminhos entre as tabelas

- Outro ponto de d�vida � a restri��o:
	AND CONVERT(TIME,GETDATE()) between categoriaPlano.horarioInicio AND categoriaPlano.horarioTermino
Observe na tabela da categoriaPlano que eles tem 
uma hora de vig�ncia, ou seja, come�am a valer em uma
hora e terminam em outra.
Ex:SELECT * FROM CATEGORIAPLANO;
	id	nome					unidadeCobranca	horarioInicio		horarioTermino
	1	Mensalista Diurno		mes				06:00:00.0000000	18:00:00.0000000
	2	Mensalista Noturno		mes				18:00:00.0000000	23:00:00.0000000
	3	Mensalista Professor	mes				06:00:00.0000000	23:00:00.0000000
	4	Avulso Diurno			periodo			06:00:00.0000000	18:00:00.0000000
	5	Avulso Noturno			periodo			18:00:00.0000000	23:00:00.0000000
	6	Avulso Horista			hora			06:00:00.0000000	23:00:00.0000000
Ent�o, se para descobrir qual plano posso usar AGORA
posso usar a fun��o GETDATE() que retorna a data + hora atuais.
como s� me interesso pela hora, posso descartar a data.
SELECT CONVERT(TIME,GETDATE()) -- s� me devolve a hora

Lembram-se do comando BETWEEN ?
	se n�o, de uma pausa neste guia e pesquise-o.

Finalmente, ao filtrar:
	AND CONVERT(TIME,GETDATE()) between categoriaPlano.horarioInicio AND categoriaPlano.horarioTermino
S� v�o ficar os registros cuja hora atual
	estiver entre as horas de inicio e fim daquela categoria.


------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
-- Regras e valida��es adiocionais solicitadas
------------------------------------------------------

- Foi solicitado que um registro de estacionamento
s� possa ser realizado se, e somente se, houve espa�o 
f�sico naquela localidade, isso � controlado 
pelo funcion�rio no local, por�m, tamb�m deve ser
controlado no banco de dados, para evitar fraudes.

- Para descobrir se h� espa�o, voc� precisa de duas
informa��es:
#1 - n�mero de ve�culos, por tipo, estacionados atualmente.
#2 - capacidade m�xima da localidade.
Apenas se #1 for inferior � #2 um ve�culo pode estacionar.

#1	/*Para verificar a capacidade de uma localidade/estacionamento
	De um certo tipo de ve�culo em um certo momento
	Est�o estacionados agora quaisquer ve�culos sem data de sa�da)*/
	SELECT	COUNT(*) as total
	FROM	estacionamento
			INNER JOIN veiculo ON idVeiculo = veiculo.id
			INNER JOIN localidade ON idLocalidade = localidade.id
	WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
			AND tipo = 'moto'
			AND dataHoraSaida IS NULL

- Foi definido e explicado que um ve�culo est� atualmente
estacionado se sua dataHoraSaida for NULA, 
por isso a seguinte cl�usula foi inclu�da :
		AND dataHoraSaida IS NULL
- Ainda com d�vidas e dificuldades com os JOINs
	de um pausa neste estudo e procure por mais material
	procure outras defini��es em outras fontes,
	procure exerc�cios ou fa�a os exerc�cios extras propostos.

#2	/* Se o total de ve�culos for inferior � capacidade, registrar o estacionamento*/
	select capacidade_moto from localidade where identificacao = 'Faculdade Impacta - Paulista'	
- Este � simples, j� que a capacidade do estacionamento
por tipo de ve�culo � um dado fornecido e j� salvo na tabela

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
-- Inser��o de um estacionamento
------------------------------------------------------

- Com todos os IDs j� coletados, por�m ainda guardados
em nossa cabe�a, pois ainda n�o estamos guardando 
nenhum dos dados coletados em vari�veis.
mesmo assim, ainda podemos realizar a inser��o:

/*Se a capacidade atual for inferior � capacidade total pode inserir*/
/*Finalmente, basta inserir a entrada de um ve�culo em uma localidade*/
INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
VALUES ( 1, 11, 6 )

/*descubro o �ltimo ID utilizado para devolve-lo.*/
select @@identity
--select max(id) from estacionamento where ... /*arriscado sem o devido WHERE*/
--OUTPUT seria �tima solu��o, vamos aprender sobre ele mais tarde.

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
-- Novo processo, sa�da de um ve�culo do um estacionamento
------------------------------------------------------

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
	SET dataHoraSaida = dateadd(hour,3,datahoraEntrada)
	, valorCobrado = plano.valor * 3 /*Suporto N�mero de horas*/
FROM	estacionamento
		INNER JOIN Plano on estacionamento.idPlano = plano.id
WHERE	estacionamento.id = 13 /*suposto Ticket do estacionamento*/

- Pontos de d�vida deste update incluem:
		SET dataHoraSaida = dateadd(hour,3,datahoraEntrada)
	Aqui, simplesmente foi-lhe solicitado supor
	que o ve�culo ficou 3 horas ali.
- Entende o que a fun��o dateadd faz ?
	Se n�o, de uma pausa no guia e pesquise, fa�a um exemplo.

- Pontos de d�vida deste update incluem:
		, valorCobrado = plano.valor * 3 /*Suporto N�mero de horas*/
	Conforme explicado, o plano escolhido tem um valor POR HORA
	ent�o, se ele ficou parado 3 horas, eu multiplico 
	o valor da hora por 3. 
Isso ser� calculado automaticamente em um exerc�cio futuro.

- Pontos de d�vida deste update incluem:
		update estacionamento
		...
		FROM	estacionamento
				INNER JOIN Plano on estacionamento.idPlano = plano.id
	� poss�vel consultar multiplas tabelas,
	mas apenas uma poder� ter seu valor atualizado.
	ou seja, mesmo que a jun��o entre estacionamento e plano
	seja realizada, eu preciso estabelecer quem ter�
	um dado alterado, no caso, estacionamento.

/*conferindo os valores inseridos*/
select * from estacionamento



