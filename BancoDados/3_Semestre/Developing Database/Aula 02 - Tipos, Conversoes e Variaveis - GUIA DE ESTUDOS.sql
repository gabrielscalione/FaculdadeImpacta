------------------------------------------------------
-- Guia de estudo - Developing Databases - GUIA DE ESTUDO
-- Aula 02 - Tipos, Conversões, Variáveis
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
-- Aula 02 - Tipos, Conversões, Variáveis
------------------------------------------------------
Esta aula abordou:
	Tipos e conversões, Variáveis, lotes, operadores, colunas computadas
	Utilização de variáveis para relatórios mais complexos
	Utilização de funções para tratamento e organização das informações.
	Utilização de funções de conversão e transformações de informações.

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 02 - Tipos, Conversões, Variáveis
-- Variáveis
------------------------------------------------------

Variáveis, em especial escalares ( nome dado às variáveis
que não do tipo tabela ), guardam 1 valor do tipo que elas foram
declaradas.
	/*Exemplo de uso de variáveis do usuário*/
	declare @X int	-- declarei a variável
	SET @x = 10		-- ajustei o valor para 10
	print @x		-- imprimi o valor 10

Existem variáveis chadas de globais, que apenas o sistema 
pode 'colocar' valores, nós podemos apenas consultar:
	/*Exemplo de uso de variáveis globais*/
	select @@version
	select @@SPID

Variáveis são muito úteis para evitar repetição de um mesmo 
valor, por exemplo:
- Dado um email, devolver apenas o domínio ( a parte 
que vem depois do @ ).

Não usando variáveis, o código ficaria algo como:
#1 - procuramos pelo @ no meio da string
	A função de busca chama-se charindex
		lembra-se dela ? se não, de uma pesquisada.
	Então:
		select CHARINDEX('@', 'email@faculdadeimpacta.com.br',0 )
	devolve a posição do char '@' dentro do texto 'email@faculdadeimpacta.com.br'
#2 - determinamos o tamanho da string
	Será útil para calcular a quantidade de chars no passo #3.
	A função de busca chama-se len
		lembra-se dela ? se não, de uma pesquisada.
	Então:
		select LEN('email@faculdadeimpacta.com.br')
#3 - devolvemos tudo o que está após o @ naquela string.
	mais de uma função servem para devolver parte de uma string
	mas, neste caso, usaremos substring
		lembra-se dela ? se não, de uma pesquisada.
	Então:	
		select SUBSTRING(
				'email@faculdadeimpacta.com.br' --string original
				,7		--posição do @ +1, pois não quero devolver o @.
				,23		--número de chars até o final da string.
			)

Agora, tente unir os 3 em uma formula só...
substitua o 7 pelo CHARINDEX e o 23 pelo LEN.
Porém, lembre-se de fazer as devidas adaptações e correções.
R:


.
Não continue lendo até ter resolvido o problema acima....
.
.
.
.
.
.

Correção: se você está lendo isso sem ter feito nem tentado
a parte acima... que pena...

select SUBSTRING(
		--string original
		'email@faculdadeimpacta.com.br' 

		--posição do @ +1, pois não quero devolver o @.
		,CHARINDEX('@', 'email@faculdadeimpacta.com.br',0 )
			+1

		--número de chars até o final da string.
		,LEN('email@faculdadeimpacta.com.br') 
			- CHARINDEX('@', 'email@faculdadeimpacta.com.br',0 )
	)

Agora usando uma variável para armazenar o email :
DECLARE @email VARCHAR(50) = 'email@faculdadeimpacta.com.br'
select SUBSTRING(
		--string original
		@email
		--posição do @ +1, pois não quero devolver o @.
		,CHARINDEX('@', @email,0 ) + 1
		--número de chars até o final da string.
		,LEN(@email) - CHARINDEX('@', @email,0 )
	)
Muito mais enxuto, além da facilidade de que, ao trocar o email
, só preciso alterar o valor em um único local ( e não em 3 ).


- Sua vez, agora, dado um email devolva apenas a parte
antes do '@', ou seja, o nome da conta.
ex: dado 'jose@google.com' devolver 'jose'
R:

------------------------------------------------------
-- Guia de estudo - Developing Databases 
-- Aula 02 - Tipos, Conversões, Variáveis
-- Variáveis
------------------------------------------------------

/*Exemplo de utilide de variáveis do usuário*/
/*Como calcular o percentual de cada tipo de veículo no seu estacionamento
Ex: Atualmente 60% dos veículos são carros e 40% são motos.
*/

/*seja o seguinte select para devolver o total de veículos 
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
		cada tipo existente, então, para cada tipo, 
		contar o número de veículo ainda estacionados.
	Lembre-se, pela nossa definição, estão estacionados
		os veículos com data de saida nula.

/*
Para transformar os totais de cada tipo num percentual eu preciso:
1º calcular o total 
2º salvar numa variável @total			
3º calcular os percentuais baseado no total
	dividindo o total por veículo pelo total geral ( salvo na variável ).
*/
--Declaração da variável
DECLARE @total INT 

--Salvando o total geral na variável.
SELECT	@total = COUNT(*) 
FROM	estacionamento
		INNER JOIN veiculo ON idVeiculo = veiculo.id
		INNER JOIN localidade ON idLocalidade = localidade.id
WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
		AND dataHoraSaida IS NULL

- Ao invés de devolver o valor para a 'tela'
	o valor do count é armazenado na variável.
	Isso permite que ele possa ser utilizado mais pra frente
	no código.

--Dividindo o valor de cada tipo pelo total para obter o percentual
/*	Para conseguir um valor de 0 a 100 ( e não só de 0 a 1 )
		multiplicamos o total por 100.
	Para conseguir o valor em um decimal, com ponto flutuante e não só um 
		inteiro, multiplico por 100.00 e não só 100 ( que é um inteiro ).
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
	o count(*) em decimal antes da divisão, pois, sendo 
	naturalmente um número inteiro, se dividido por outro inteiro
	ele jogaria fora a parte decimal ( arredondando-o ).

- Como você escreveria o mesmo select sem este truque ?
	ou seja, agora convertendo valor do count em um decimal ( 3,2 )
R:




