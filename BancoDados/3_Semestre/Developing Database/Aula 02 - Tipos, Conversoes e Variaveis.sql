/*Exemplo de uso de variáveis globais*/
select @@version
select @@SPID

/*Exemplo de uso de variáveis do usuário*/
declare @X int
SET @x = 10
print @x


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

--Dividindo o valor de cada tipo pelo total para obter o percentual
/*	Para conseguir um valor de 0 a 100 ( e não só de 0 a 1 )
		multiplicamos o total por 100.
	Para conseguir o valor em um decimal, com ponto flutuante e não só um 
		inteiro, multiplico por 100.00 e não só 100 ( que é um inteiro ).
		Isso evita que precisemos de um convert(decimal(3,2), ... )
*/
SELECT	tipo, COUNT(*) as total, (100.00 * COUNT(*)) / @total as perc
FROM	estacionamento
		INNER JOIN veiculo ON idVeiculo = veiculo.id
		INNER JOIN localidade ON idLocalidade = localidade.id
WHERE	localidade.identificacao = 'Faculdade Impacta - Paulista'	
		AND dataHoraSaida IS NULL
group by tipo
--Resultado da minha base de testes.
tipo	total	perc
carro	7		58.3333333333333
moto 	5		41.6666666666666
 
/*Mais exemplos de variáveis, usando set e select para alterar os valores.*/
 declare @x int = 10
 set  @x += 1; 
 select @x = @x + 1 
 select @x

/*Primeiro exercício feito em sala*/ 
 Exercícios para fixação:
Declare duas variáveis para 	que recebam duas datas, respectivamente 
a hora de entrada e a hora atual ( podem usar função getdate() ).

Calcular a quantidade de horas ( valor cheio, arredondado para cima ) 
que deverá ser cobrado de quem estacionou seu veículo naquela período ?
Ex: ‘20210210 20:00’ e ‘20210210 22:01’

Deverá pagar por 3 horas ( mesmo tendo ficado apenas 121 minutos )

/*Observe que as variáveis apenas contém as duas datas usadas na formula
	Seja a segunda, @datafinal, uma data fixa ou uma formula para obter
	a data e hora atual.
*/
DECLARE		@dataInicial datetime	= '20210210 20:00'
		,	@datafinal datetime		= GETDATE() --'20210210 22:01' --121
SELECT CEILING ( DATEDIFF(minute,@dataInicial,@datafinal) / 60.00 )
/*Esta formula tem 3 partes:
	1º DATEDIFF(minute,@dataInicial,@datafinal)
		Não posso simplesmente pegar a diferença em horas, pois 
		um DATEDIFF(hour,@dataInicial,@datafinal) não iria me trazer as
		horas quebradas ou parciais, e passou 1 min eu tenho que cobrar a hora cheia.
	2º / 60.00
		Eu ainda divido por 60 para pegar o valor por hora
		porém, uso 60.00 para conseguir um valor quebrado, 
		já que 60 é inteiro dividir por ele, ainda dá um número inteiro.
		Já 60.00 é um decimal e dividir por ele, dá um decimal, que contém ponto flutuante.
	3º CEILING ( ...)
		Observe que quem ficar 2horas e 1min, ou seja, 121 mins
		ao ser dividido por 60 dá 2.016666, eu preciso arredondar isso para o 
		inteiro mais alto, ou seja, o teto deste número. 2(chão) < 2.016666 < 3(teto)
		Do inglês, teto = ceiling.
*/

GO

/*Exemplo de coluna calculada ou coluna computada
Suponha a tabela veiculo com 4 colunas: id, tipo, placa e idCliente*/
select * from veiculo
id			int
tipo		char
placa		char		= 'ABC1234'
idCliente	int
/*eu gostaria de adicionar uma quinta, cujo valor pode ser automaticamente
obtido pela introdução de um 'traço' na quarta posição da placa*/
placaFormatada char(8)	= 'ABC-1234' = LEFT(placa,3) + '-' + RIGHT(placa,4)
/*Então, esta coluna calculada, que é por definição uma formula e não
armazenará valores por si, porém, nos selects devolverá como se tivesse.
ou seja, ela calcula e devolve os valores quando necessário
Ela pode ser adicionada como outra coluna, apenas atenção com sua sintaxe*/
alter table veiculo
	ADD  placaFormatada as (LEFT(placa,3) + '-' + RIGHT(placa,4))

/*Conferência da placa e placaFormatada na tabela veículo*/
select * from veiculo
placa: ABC1234 
placaFormatada ABC-1234

/* Colunas calculadas podem ser já criadas no CREATE TABLE
Porém, como nosso modelo já tem dados, e executar um DROP TABLE + CREATE TABLE
limpa os dados da tabela, esta solução não é recomendada.
*/
CREATE TABLE veiculo (
	id INT NOT NULL IDENTITY(1,1)
	, tipo CHAR(5) NOT NULL
	, placa CHAR(7) NOT NULL
	, idCliente INT NULL /*Veículo avulso não registra o cliente*/
	-->>> , placaFormatada as (LEFT(placa,3) + '-' + RIGHT(placa,4)) <----
	, CONSTRAINT CK_tipoVeiculo CHECK ( tipo in ( 'carro', 'moto' ) )
	, CONSTRAINT CK_placaVeiculo CHECK ( placa like '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9]'
									OR	placa like '[A-Z][A-Z][A-Z][0-9][A-Z][0-9][0-9]') 
	, CONSTRAINT PK_veiculo PRIMARY KEY ( id )
	, CONSTRAINT UQ_veiculoPlaca UNIQUE ( placa )
	, CONSTRAINT FK_VeiculoCliente FOREIGN KEY ( idCliente ) REFERENCES cliente(id)
)
GO

/*Exemplo de tratamento de dados nulos
o valor da coluna cliente.nome, quando vier nulo 
será substituido pela string 'Horista'*/
SELECT estacionamento.id               AS ticket, 
       estacionamento.datahoraentrada, 
       estacionamento.datahorasaida, 
       veiculo.placa, 
       Isnull(cliente.nome, 'Horista') AS Cliente 
FROM   estacionamento 
       INNER JOIN veiculo 
               ON estacionamento.idveiculo = veiculo.id 
       LEFT JOIN cliente 
              ON veiculo.idcliente = cliente.id 

/*Segundo exercício*/
Exercícios para fixação:
Adicione uma coluna calculada na tabela estacionamento, 
com o nome: horasEstacionado que estime a quantidade de horas 
(arredondado para cima ) em que o veículo ficou no estabelecimento.
Porém, se a data de saída for nula ( ou seja, o veículo ainda está 
no estabelecimento ), ele deve utilizar a data/hora atual como base de cálculo.
Ex: Se dataHoraEntrada = ‘20:00’ mas o veículo ainda está no estacionamento
, porém agora são ‘22:01’, a coluna calculada deve apresenta o valor 3.

/*Assim como no exercício anterior, a diferença pode ser calculada pela formula:
SELECT CEILING ( DATEDIFF(minute,@dataInicial,@datafinal) / 60.00 )
--> utilizar variáveis para testes de funções é muito útil.

Na hora de incluí-la na tabela como uma coluna calculada eu devo fazer
a substituição pelas colunas da tabela, porém a dataHoraSaida tem que ser
tratada, pois não pode ser NULA.

dataHoraEntrada	--> OK
dataHoraSaida	--> case when dataHoraSaida IS NULL then GETDATE() else dataHoraSaida end
				--> ISNULL(dataHoraSaida, GETDATE() )
*/

/*Comando final para adicionar a coluna calculada que devolve
a quantidade de horas que o veículo já ficou 
( tento ele saído, quando dataHoraSaida não é nula
ou ainda no pátio, quando dataHoraSaida é nula, ou seja, neste caso ele usa a 
dataHora atual para o cálculo*/
alter table estacionamento
	ADD  horasEstacionado 
	as ( 
		CEILING ( DATEDIFF(minute,dataHoraEntrada,ISNULL(dataHoraSaida, GETDATE() )) / 60.00 )
	)

/*Testando os valores retornados*/
select * from estacionamento




