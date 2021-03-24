------------------------------------------------------
-- Guia de estudo - Developing Databases - GUIA DE ESTUDO
-- Aula 02 - Tipos, Convers�es, Vari�veis
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
-- Aula 02 - Tipos, Convers�es, Vari�veis
------------------------------------------------------
Esta aula abordou:
	Tipos e convers�es, Vari�veis, lotes, operadores, colunas computadas
	Utiliza��o de vari�veis para relat�rios mais complexos
	Utiliza��o de fun��es para tratamento e organiza��o das informa��es.
	Utiliza��o de fun��es de convers�o e transforma��es de informa��es.

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 02 - Tipos, Convers�es, Vari�veis
-- Vari�veis
------------------------------------------------------

Vari�veis, em especial escalares ( nome dado �s vari�veis
que n�o do tipo tabela ), guardam 1 valor do tipo que elas foram
declaradas.
	/*Exemplo de uso de vari�veis do usu�rio*/
	declare @X int	-- declarei a vari�vel
	SET @x = 10		-- ajustei o valor para 10
	print @x		-- imprimi o valor 10

Existem vari�veis chadas de globais, que apenas o sistema 
pode 'colocar' valores, n�s podemos apenas consultar:
	/*Exemplo de uso de vari�veis globais*/
	select @@version
	select @@SPID

Vari�veis s�o muito �teis para evitar repeti��o de um mesmo 
valor, por exemplo:
- Dado um email, devolver apenas o dom�nio ( a parte 
que vem depois do @ ).

N�o usando vari�veis, o c�digo ficaria algo como:
#1 - procuramos pelo @ no meio da string
	A fun��o de busca chama-se charindex
		lembra-se dela ? se n�o, de uma pesquisada.
	Ent�o:
		select CHARINDEX('@', 'email@faculdadeimpacta.com.br',0 )
	devolve a posi��o do char '@' dentro do texto 'email@faculdadeimpacta.com.br'
#2 - determinamos o tamanho da string
	Ser� �til para calcular a quantidade de chars no passo #3.
	A fun��o de busca chama-se len
		lembra-se dela ? se n�o, de uma pesquisada.
	Ent�o:
		select LEN('email@faculdadeimpacta.com.br')
#3 - devolvemos tudo o que est� ap�s o @ naquela string.
	mais de uma fun��o servem para devolver parte de uma string
	mas, neste caso, usaremos substring
		lembra-se dela ? se n�o, de uma pesquisada.
	Ent�o:	
		select SUBSTRING(
				'email@faculdadeimpacta.com.br' --string original
				,7		--posi��o do @ +1, pois n�o quero devolver o @.
				,23		--n�mero de chars at� o final da string.
			)

Agora, tente unir os 3 em uma formula s�...
substitua o 7 pelo CHARINDEX e o 23 pelo LEN.
Por�m, lembre-se de fazer as devidas adapta��es e corre��es.
R:


.
N�o continue lendo at� ter resolvido o problema acima....
.
.
.
.
.
.

Corre��o: se voc� est� lendo isso sem ter feito nem tentado
a parte acima... que pena...

select SUBSTRING(
		--string original
		'email@faculdadeimpacta.com.br' 

		--posi��o do @ +1, pois n�o quero devolver o @.
		,CHARINDEX('@', 'email@faculdadeimpacta.com.br',0 )
			+1

		--n�mero de chars at� o final da string.
		,LEN('email@faculdadeimpacta.com.br') 
			- CHARINDEX('@', 'email@faculdadeimpacta.com.br',0 )
	)

Agora usando uma vari�vel para armazenar o email :
DECLARE @email VARCHAR(50) = 'email@faculdadeimpacta.com.br'
select SUBSTRING(
		--string original
		@email
		--posi��o do @ +1, pois n�o quero devolver o @.
		,CHARINDEX('@', @email,0 ) + 1
		--n�mero de chars at� o final da string.
		,LEN(@email) - CHARINDEX('@', @email,0 )
	)
Muito mais enxuto, al�m da facilidade de que, ao trocar o email
, s� preciso alterar o valor em um �nico local ( e n�o em 3 ).


- Sua vez, agora, dado um email devolva apenas a parte
antes do '@', ou seja, o nome da conta.
ex: dado 'jose@google.com' devolver 'jose'
R:

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 02 - Tipos, Convers�es, Vari�veis
-- Vari�veis
------------------------------------------------------

/*Exemplo de utilide de vari�veis do usu�rio*/
/*Como calcular o percentual de cada tipo de ve�culo no seu estacionamento
Ex: Atualmente 60% dos ve�culos s�o carros e 40% s�o motos.
*/

/*seja o seguinte select para devolver o total de ve�culos 
estacionados atualmente, por tipo (carro/moto) */
SELECT	tipo, COUNT(*) as total
FROM	estacionamento
		INNER JOIN veiculo ON idVeiculo = veiculo.id
		INNER JOIN localidade ON idLocalidade = localidade.id
WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
		AND dataHoraSaida IS NULL
group by tipo

- Entendeu por que esta consulta foi feita desta forma ?
	Reveja a aula 01 para entender o modelo
	veja as Fks entre estacionamento, veiculo e localidade
	veja como filtrar o estacionamento
	Reveja como o group by funciona, neste caso
		queremos grupos por tipo, ou seja, uma linha para
		cada tipo existente, ent�o, para cada tipo, 
		contar o n�mero de ve�culo ainda estacionados.
	Lembre-se, pela nossa defini��o, est�o estacionados
		os ve�culos com data de saida nula.

/*
Para transformar os totais de cada tipo num percentual eu preciso:
1� calcular o total 
2� salvar numa vari�vel @total			
3� calcular os percentuais baseado no total
	dividindo o total por ve�culo pelo total geral ( salvo na vari�vel ).
*/
--Declara��o da vari�vel
DECLARE @total INT 

--Salvando o total geral na vari�vel.
SELECT	@total = COUNT(*) 
FROM	estacionamento
		INNER JOIN veiculo ON idVeiculo = veiculo.id
		INNER JOIN localidade ON idLocalidade = localidade.id
WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
		AND dataHoraSaida IS NULL

- Ao inv�s de devolver o valor para a 'tela'
	o valor do count � armazenado na vari�vel.
	Isso permite que ele possa ser utilizado mais pra frente
	no c�digo.

--Dividindo o valor de cada tipo pelo total para obter o percentual
/*	Para conseguir um valor de 0 a 100 ( e n�o s� de 0 a 1 )
		multiplicamos o total por 100.
	Para conseguir o valor em um decimal, com ponto flutuante e n�o s� um 
		inteiro, multiplico por 100.00 e n�o s� 100 ( que � um inteiro ).
		Isso evita que precisemos de um convert(decimal(3,2), ... )
*/
SELECT	tipo
		, COUNT(*) as total
		, (100.00 * COUNT(*)) / @total as perc
FROM	estacionamento
		INNER JOIN veiculo ON idVeiculo = veiculo.id
		INNER JOIN localidade ON idLocalidade = localidade.id
WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
		AND dataHoraSaida IS NULL
group by tipo

- Lembre-se que em
			, (100.00 * COUNT(*)) / @total as perc
	foi usado um truque para evitar precisar converter
	o count(*) em decimal antes da divis�o, pois, sendo 
	naturalmente um n�mero inteiro, se dividido por outro inteiro
	ele jogaria fora a parte decimal ( arredondando-o ).

- Como voc� escreveria o mesmo select sem este truque ?
	ou seja, agora convertendo valor do count em um decimal ( 3,2 )
R:




