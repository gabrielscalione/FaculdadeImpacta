------------------------------------------------------
-- Guia de estudo - Developing Databases - GUIA DE ESTUDO
-- Aula 01 - Entendimento de um banco de dados
------------------------------------------------------

Este guia visa apresentar um conjunto de passos ou exercícios
( muitas vezes desenvolvido pelo próprio aluno) como forma 
de estudo, prática ou para fixação de conteúdo.

Tente responder à todas as perguntas e faça todos os passos
propostos.

Mas, antes de começar a falar de SQL...

------------------------------------------------------
-- Preparação do ambiente
------------------------------------------------------

É altamente recomendado que vocês tenham um ambiente de trabalho.
Para ver detalhes de como instalar o MSSQL e o cliente SSMS, 
veja aula 01.
Quem não puder instalar o MSSQL, Instale apenas o cliente SSMS
e tente usar o servidor da impacta ou solicite acesso à um 
servidor criado pelo professor na AWS.
Quem não puder nem instalar o MSSQL, nem o cliente SSMS,
tente acompanhar via http://www.sqlfiddle.com/

Pause este guia e prepare seu ambiente de estudo.

------------------------------------------------------
-- Tenha uma metodologia de estudo
------------------------------------------------------

Mantenha-se organizado, salve todo o conteúdo passado pelo
professor em pastas organizadas por aula, por conteúdo,
por tipo de arquivo, o que você achar melhor.

É essencial que cada arquivo, cada vídeo, cada exercícios,
seja refeito, revisto, pelo menos uma vez fora da aula.

Crie um bloco de notas no inicio de cada aula, vá anotando
cada dúvida, cada ponto não entendido, e não saia da aula
sem ter respondido ou pelo menos postado as perguntas ao 
professor. 

Lembre-se, o professor tem o dever de ensinar, mas você
tem o dever de aprender, e os dois só cumprirão seus papéis
se ambos trabalharem juntos.

Não tenha vergonha nem preguiça de dar um passo para trás 
antes de dar dois para frente. Para a construção de uma
pirâmide de conhecimento, se sua base não for forte o 
sufiente, é seu papel reforça-la, rever conceitos, procurar
novos materiais e superar os desafios ( lembre-se
o professor é sempre uma ótima fonte de orientação ).

------------------------------------------------------
-- Saiba onde encontrar a informação
------------------------------------------------------

O material do professor é a referência básica e primeiro 
local de consulta. Os exercícios, as aulas gravadas, 
seus comentários, suas notas coletadas durante as aulas.

Também existem não só vídeos gravadados por todos os 
professores que já ministraram esta disciplina no passado,
basta pesquisar no smartclass ( sistema da faculdade
em www.impacta.com.br > area do aluno > Aulas de graduação )

Existe muito material disponível na internet.
Não há problema se, ao estudar, vocês precisarem 
acessar o google para descobrir o que este ou aquele comando
faz. Cada novo link, documento, ou vídeo com conteúdo
interessante, deve ser arquivado em sua biblioteca pessoal
de estudo.

Seus colegas também são uma ótima referência,
muitos tem ou já tiveram as mesmas dúvidas que você.

Porém, ceda à tentação de procurar por respostas prontas
elas representam atalhos falsos para o conhecimento, e
muitas vezes apenas vão lhe tornar cada mais dependentes 
dos outros e menos de si próprios.

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
------------------------------------------------------
Esta aula abordou:
	Tipos e conversões, Variáveis, lotes, operadores, colunas computadas
	Utilização de variáveis para relatórios mais complexos
	Utilização de funções para tratamento e organização das informações.
	Utilização de funções de conversão e transformações de informações.

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
-- Processos
------------------------------------------------------

Lhe foram apresentados o que é um processo:
É um conjunto de instruções com um objetivo bem definido
Muitas vezes uma linguagem clássica de desenvolvimento
não é rápida nem eficaz o suficiente para testar 
um conjunto de operações que outrora seria MUITO mais 
simples de ser realizado via SQL.

Em outras ocasiões, os processos se tratam de uma operação
muito curta, uma manutenção, uma importação de dados,
um relatório, e de forma alguma justifica-se utilizar
programas diferente do próprio SGBD para realizá-los.

Outros processos são controlados de forma únitária
(como se fosse apenas uma ação ), mas no banco tratam-se 
de múltiplas ações necessárias para concluir aquela 
solicitação. 
Exemplo: UPSERT, processo de 
	SE o dado não existir, Insira-o
	SE o dado já existir, Atualize-o 

O processo apresentado foi o de um banco de dados 
que gerencia estacionamentos, para mais detalhes
ver "Aula 01 - Revisao SQL e entendimento de um banco de dados.sql"
ou "Aula 01 - Developing Databases - Apresentação e revisão.pptx.pdf"

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
-- Entendendo um enunciado de um processo
------------------------------------------------------
Enunciado:
	Dado um tipo de veículo (ex: 'moto'), uma placa, ex:'GHY6543'
	um tipo de plano para cobrança( ex: 'Avulso Horista' )
	e um local para estacionamento(ex: 'Faculdade Impacta - Paulista')
	- verificar a capacidade do estacionamento neste momento.
	- verificar se o período do plano escolhido é aceito pela localidade.
	- verificar se a hora atual está condizente com o plano de cobrança.
	- registrar o início do estacionamento.
	- Devolver o "ID" ( que será impresso no ticket ) daquele estacionamento.

Existem muitos tipos de incógnitas e de IDs que precisam ser
coletados, verificados e testados para garantir a devida 
inserção de um único estacionamento.

Entenda que o objetivo final é a inserção de um estacionamento
Então, começe olhando a tabela conforme declaração.
	/*ação de estacionar um veículo em uma localidade, principal entidade do modelo*/
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
		essas FKs estão relacionadas com quais tabelas ?
	Há colunas auto-incrementais ?
	Há colunas com valores padrão ?
	Há campos UNIQUE ou com validação CHECK ?
- O que é preciso coletar para inserir 1 estacionamento ?
	Para cada coluna obrigatória ( NOT NULL sem DEFAULT )
	busque um dado fornecido ou uma tragetória para descobrir
	tal dado, volte ao enunciado para descobrir.
Resumo:
	id INT NOT NULL IDENTITY(1,1)
		--Auto incremental, não precisa ser preenchido
	, idLocalidade INT NOT NULL
		-- Existe uma FK_estacionamentoLocalidade
		-- que é capaz de me fornecer o ID da localidade
	, dataHoraEntrada DATETIME NOT NULL CONSTRAINT DF_dataHoraEntrada DEFAULT(GETDATE())
		-- Não preciso inserir, possui DEFAULT
	, dataHoraSaida DATETIME NULL
		-- Não é obrigatório
		-- só será preenchido na saída do veículo
	, idVeiculo INT NOT NULL
		-- Existe uma FK_estacionamentoVeiculo
		-- que é capaz de me fornecer o ID da veículo
	, idPlano INT NOT NULL
		-- Existe uma FK_estacionamentoPlano
		-- que é capaz de me fornecer o ID da veículo
	, valorCobrado DECIMAL(10,2) NOT NULL CONSTRAINT CK_valorCobrado DEFAULT(0.00)
		-- Não é obrigatório
		-- só será preenchido na saída do veículo
Ou seja, agora sei onde buscar cada informação
necessária para inserir um estacionamento.

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
Então:
	/*coleto o id do estacionamento
	Posso utilizá-lo para simpleficar as demas consultas*/
	select id from localidade where identificacao = 'Faculdade Impacta - Paulista'
Não se cadastra localidades com frequencia, então,
seu ID é apenas consultado, nenhuma ação é necessária
para inserir tal localidade caso ela não exista.

-- #2 -- veículo
Pela FK eu sei onde procurar o id do veículo
		, CONSTRAINT FK_estacionamentoVeiculo FOREIGN KEY (idVeiculo) REFERENCES veiculo(id)
Pelo enunciado eu seu qual valor procurar na tabela
	Dado um tipo de veículo (ex: 'moto'), uma placa, ex:'GHY6543'
Então:
	/*coleto o id do veículo
	Posso utilizá-lo para simpleficar as demas consultas*/
	select id from veiculo where placa = 'GHY6543'
Porém:
Se o veículo não existir, ele deve ser inserido.
Pois não há como recuperar o ID de um veículo que não 
está no banco de dados.
Desta forma:
	/*coleto o id do veículo*/
	Caso seja a primeira vez que ele estaciona, é necessário estacionar o veículo
	Como é um cliente horista, não preciso cadastrar um cliente ( apenas para mensalistas )
		Insert veiculo( tipo, placa, idCliente)
		VALUES ( 'moto', 'GHY6543', NULL )
Se o veículo acabou de ser inserido
eu preciso recuperar o ID que ele acabou de ganhar.
observando o modelo desta tabela:
		/*Veiculo é o objeto controlado durante o estacionamento*/
		CREATE TABLE veiculo (
			id INT NOT NULL IDENTITY(1,1)
			, tipo CHAR(5) NOT NULL
			, placa CHAR(7) NOT NULL
			, idCliente INT NULL /*Veículo avulso não registra o cliente*/
			, CONSTRAINT CK_tipoVeiculo CHECK ( tipo in ( 'carro', 'moto' ) )
			, CONSTRAINT CK_placaVeiculo CHECK ( placa like '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9]'
											OR	placa like '[A-Z][A-Z][A-Z][0-9][A-Z][0-9][0-9]') 
			, CONSTRAINT PK_veiculo PRIMARY KEY ( id )
			, CONSTRAINT UQ_veiculoPlaca UNIQUE ( placa )
			, CONSTRAINT FK_VeiculoCliente FOREIGN KEY ( idCliente ) REFERENCES cliente(id)
		)
Observa-se que ela possui uma PK com valor auto-incremental,
então, basta recuperar o ID pelos processos:
	SELECT @@identity
	OU 
	SELECT SCOPE_IDENTITY
- Já conhecia estes comandos ? 
	se não, de uma pausa dos estudos e pesquise-os.

-- #3 -- plano
Pela FK eu sei onde procurar o id da planio
		, CONSTRAINT FK_estacionamentoPlano FOREIGN KEY (idPlano) REFERENCES plano(id)
Pelo enunciado eu seu qual valor procurar na tabela
	um tipo de plano para cobrança( ex: 'Avulso Horista' )

Porém, ao analisar o código da tabela PLANO:
		/*Plano são os modelos de contratação e cobrança que um veículo tem que se encaixar*/
		/* Os planos são específicos por localidade e tem validade
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
É possível observar que o nome do plano de cobrança não fica ali.
Desta forma, tenho que procurar em seus relacionamentos
por uma forma de chegar até onde eu possa localizar tal nome

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
E ao olhar na definição da tabela:
		, CONSTRAINT FK_PlanoTipo FOREIGN KEY ( idCategoria ) REFERENCES categoriaPlano(id)
Agora sabemos como chegar até ela.

Então, dado uma localidade e um nome para a categoria do plano
preciso descobrir o id do plano.
		/*Verificar se aquela localidade aceita aquele plano, 
		Devolver o ID do plano atual naquele horário de atuação.
		ou seja, o plano que será utilizado para a cobrança;
		O plano pertence à uma categoria que determina o horário de atuação
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
	eles são sempre feitos pela comparação de dados
	Então, sempre confira os dados antes de realizar uma junção.
- Lembre-se que na GRANDE MAIORIA dos casos,
	toda junção é sempre realizara baseada na integridade
	referencial criada pela dupla PK-FK
	Então, conhecendo as regras, conhece-se os caminhos entre as tabelas

- Outro ponto de dúvida é a restrição:
	AND CONVERT(TIME,GETDATE()) between categoriaPlano.horarioInicio AND categoriaPlano.horarioTermino
Observe na tabela da categoriaPlano que eles tem 
uma hora de vigência, ou seja, começam a valer em uma
hora e terminam em outra.
Ex:SELECT * FROM CATEGORIAPLANO;
	id	nome					unidadeCobranca	horarioInicio		horarioTermino
	1	Mensalista Diurno		mes				06:00:00.0000000	18:00:00.0000000
	2	Mensalista Noturno		mes				18:00:00.0000000	23:00:00.0000000
	3	Mensalista Professor	mes				06:00:00.0000000	23:00:00.0000000
	4	Avulso Diurno			periodo			06:00:00.0000000	18:00:00.0000000
	5	Avulso Noturno			periodo			18:00:00.0000000	23:00:00.0000000
	6	Avulso Horista			hora			06:00:00.0000000	23:00:00.0000000
Então, se para descobrir qual plano posso usar AGORA
posso usar a função GETDATE() que retorna a data + hora atuais.
como só me interesso pela hora, posso descartar a data.
SELECT CONVERT(TIME,GETDATE()) -- só me devolve a hora

Lembram-se do comando BETWEEN ?
	se não, de uma pausa neste guia e pesquise-o.

Finalmente, ao filtrar:
	AND CONVERT(TIME,GETDATE()) between categoriaPlano.horarioInicio AND categoriaPlano.horarioTermino
Só vão ficar os registros cuja hora atual
	estiver entre as horas de inicio e fim daquela categoria.


------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
-- Regras e validações adiocionais solicitadas
------------------------------------------------------

- Foi solicitado que um registro de estacionamento
só possa ser realizado se, e somente se, houve espaço 
físico naquela localidade, isso é controlado 
pelo funcionário no local, porém, também deve ser
controlado no banco de dados, para evitar fraudes.

- Para descobrir se há espaço, você precisa de duas
informações:
#1 - número de veículos, por tipo, estacionados atualmente.
#2 - capacidade máxima da localidade.
Apenas se #1 for inferior à #2 um veículo pode estacionar.

#1	/*Para verificar a capacidade de uma localidade/estacionamento
	De um certo tipo de veículo em um certo momento
	Estão estacionados agora quaisquer veículos sem data de saída)*/
	SELECT	COUNT(*) as total
	FROM	estacionamento
			INNER JOIN veiculo ON idVeiculo = veiculo.id
			INNER JOIN localidade ON idLocalidade = localidade.id
	WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
			AND tipo = 'moto'
			AND dataHoraSaida IS NULL

- Foi definido e explicado que um veículo está atualmente
estacionado se sua dataHoraSaida for NULA, 
por isso a seguinte cláusula foi incluída :
		AND dataHoraSaida IS NULL
- Ainda com dúvidas e dificuldades com os JOINs
	de um pausa neste estudo e procure por mais material
	procure outras definições em outras fontes,
	procure exercícios ou faça os exercícios extras propostos.

#2	/* Se o total de veículos for inferior à capacidade, registrar o estacionamento*/
	select capacidade_moto from localidade where identificacao = 'Faculdade Impacta - Paulista'	
- Este é simples, já que a capacidade do estacionamento
por tipo de veículo é um dado fornecido e já salvo na tabela

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
-- Inserção de um estacionamento
------------------------------------------------------

- Com todos os IDs já coletados, porém ainda guardados
em nossa cabeça, pois ainda não estamos guardando 
nenhum dos dados coletados em variáveis.
mesmo assim, ainda podemos realizar a inserção:

/*Se a capacidade atual for inferior à capacidade total pode inserir*/
/*Finalmente, basta inserir a entrada de um veículo em uma localidade*/
INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
VALUES ( 1, 11, 6 )

/*descubro o último ID utilizado para devolve-lo.*/
select @@identity
--select max(id) from estacionamento where ... /*arriscado sem o devido WHERE*/
--OUTPUT seria ótima solução, vamos aprender sobre ele mais tarde.

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 01 - Entendimento de um banco de dados
-- Novo processo, saída de um veículo do um estacionamento
------------------------------------------------------

Dado um ID ( que está presente no ticket impresso ) 
e um horário de saída ( 3 horas depois da entrada )
- Calcular valor a ser pago.
- Registrar a saída do estacionamento.

/*De posso do ticket, que contém o ID, é simples localidar o veículo estacionado
Porém, eu preciso acessar o plano contratado para descobrir o valor a cobrar
Poderia supor 3 horas exatas para simplificar o valor, 
porém, o correto é calcular a diferença em minutos e cobrar devidamente.
*/
update estacionamento
	SET dataHoraSaida = dateadd(hour,3,datahoraEntrada)
	, valorCobrado = plano.valor * 3 /*Suporto Número de horas*/
FROM	estacionamento
		INNER JOIN Plano on estacionamento.idPlano = plano.id
WHERE	estacionamento.id = 13 /*suposto Ticket do estacionamento*/

- Pontos de dúvida deste update incluem:
		SET dataHoraSaida = dateadd(hour,3,datahoraEntrada)
	Aqui, simplesmente foi-lhe solicitado supor
	que o veículo ficou 3 horas ali.
- Entende o que a função dateadd faz ?
	Se não, de uma pausa no guia e pesquise, faça um exemplo.

- Pontos de dúvida deste update incluem:
		, valorCobrado = plano.valor * 3 /*Suporto Número de horas*/
	Conforme explicado, o plano escolhido tem um valor POR HORA
	então, se ele ficou parado 3 horas, eu multiplico 
	o valor da hora por 3. 
Isso será calculado automaticamente em um exercício futuro.

- Pontos de dúvida deste update incluem:
		update estacionamento
		...
		FROM	estacionamento
				INNER JOIN Plano on estacionamento.idPlano = plano.id
	É possível consultar multiplas tabelas,
	mas apenas uma poderá ter seu valor atualizado.
	ou seja, mesmo que a junção entre estacionamento e plano
	seja realizada, eu preciso estabelecer quem terá
	um dado alterado, no caso, estacionamento.

/*conferindo os valores inseridos*/
select * from estacionamento



