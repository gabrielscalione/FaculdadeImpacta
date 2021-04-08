/*Exemplo de uso de vari�veis globais*/
select @@version
select @@SPID

/*Exemplo de uso de vari�veis do usu�rio*/
declare @X int
SET @x = 10
print @x


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

--Dividindo o valor de cada tipo pelo total para obter o percentual
/*	Para conseguir um valor de 0 a 100 ( e n�o s� de 0 a 1 )
		multiplicamos o total por 100.
	Para conseguir o valor em um decimal, com ponto flutuante e n�o s� um 
		inteiro, multiplico por 100.00 e n�o s� 100 ( que � um inteiro ).
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
 
/*Mais exemplos de vari�veis, usando set e select para alterar os valores.*/
 declare @x int = 10
 set  @x += 1; 
 select @x = @x + 1 
 select @x

/*Primeiro exerc�cio feito em sala*/ 
 Exerc�cios para fixa��o:
Declare duas vari�veis para 	que recebam duas datas, respectivamente 
a hora de entrada e a hora atual ( podem usar fun��o getdate() ).

Calcular a quantidade de horas ( valor cheio, arredondado para cima ) 
que dever� ser cobrado de quem estacionou seu ve�culo naquela per�odo ?
Ex: �20210210 20:00� e �20210210 22:01�

Dever� pagar por 3 horas ( mesmo tendo ficado apenas 121 minutos )

/*Observe que as vari�veis apenas cont�m as duas datas usadas na formula
	Seja a segunda, @datafinal, uma data fixa ou uma formula para obter
	a data e hora atual.
*/
DECLARE		@dataInicial datetime	= '20210210 20:00'
		,	@datafinal datetime		= GETDATE() --'20210210 22:01' --121
SELECT CEILING ( DATEDIFF(minute,@dataInicial,@datafinal) / 60.00 )
/*Esta formula tem 3 partes:
	1� DATEDIFF(minute,@dataInicial,@datafinal)
		N�o posso simplesmente pegar a diferen�a em horas, pois 
		um DATEDIFF(hour,@dataInicial,@datafinal) n�o iria me trazer as
		horas quebradas ou parciais, e passou 1 min eu tenho que cobrar a hora cheia.
	2� / 60.00
		Eu ainda divido por 60 para pegar o valor por hora
		por�m, uso 60.00 para conseguir um valor quebrado, 
		j� que 60 � inteiro dividir por ele, ainda d� um n�mero inteiro.
		J� 60.00 � um decimal e dividir por ele, d� um decimal, que cont�m ponto flutuante.
	3� CEILING ( ...)
		Observe que quem ficar 2horas e 1min, ou seja, 121 mins
		ao ser dividido por 60 d� 2.016666, eu preciso arredondar isso para o 
		inteiro mais alto, ou seja, o teto deste n�mero. 2(ch�o) < 2.016666 < 3(teto)
		Do ingl�s, teto = ceiling.
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
obtido pela introdu��o de um 'tra�o' na quarta posi��o da placa*/
placaFormatada char(8)	= 'ABC-1234' = LEFT(placa,3) + '-' + RIGHT(placa,4)
/*Ent�o, esta coluna calculada, que � por defini��o uma formula e n�o
armazenar� valores por si, por�m, nos selects devolver� como se tivesse.
ou seja, ela calcula e devolve os valores quando necess�rio
Ela pode ser adicionada como outra coluna, apenas aten��o com sua sintaxe*/
alter table veiculo
	ADD  placaFormatada as (LEFT(placa,3) + '-' + RIGHT(placa,4))

/*Confer�ncia da placa e placaFormatada na tabela ve�culo*/
select * from veiculo
placa: ABC1234 
placaFormatada ABC-1234

/* Colunas calculadas podem ser j� criadas no CREATE TABLE
Por�m, como nosso modelo j� tem dados, e executar um DROP TABLE + CREATE TABLE
limpa os dados da tabela, esta solu��o n�o � recomendada.
*/
CREATE TABLE veiculo (
	id INT NOT NULL IDENTITY(1,1)
	, tipo CHAR(5) NOT NULL
	, placa CHAR(7) NOT NULL
	, idCliente INT NULL /*Ve�culo avulso n�o registra o cliente*/
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
ser� substituido pela string 'Horista'*/
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

/*Segundo exerc�cio*/
Exerc�cios para fixa��o:
Adicione uma coluna calculada na tabela estacionamento, 
com o nome: horasEstacionado que estime a quantidade de horas 
(arredondado para cima ) em que o ve�culo ficou no estabelecimento.
Por�m, se a data de sa�da for nula ( ou seja, o ve�culo ainda est� 
no estabelecimento ), ele deve utilizar a data/hora atual como base de c�lculo.
Ex: Se dataHoraEntrada = �20:00� mas o ve�culo ainda est� no estacionamento
, por�m agora s�o �22:01�, a coluna calculada deve apresenta o valor 3.

/*Assim como no exerc�cio anterior, a diferen�a pode ser calculada pela formula:
SELECT CEILING ( DATEDIFF(minute,@dataInicial,@datafinal) / 60.00 )
--> utilizar vari�veis para testes de fun��es � muito �til.

Na hora de inclu�-la na tabela como uma coluna calculada eu devo fazer
a substitui��o pelas colunas da tabela, por�m a dataHoraSaida tem que ser
tratada, pois n�o pode ser NULA.

dataHoraEntrada	--> OK
dataHoraSaida	--> case when dataHoraSaida IS NULL then GETDATE() else dataHoraSaida end
				--> ISNULL(dataHoraSaida, GETDATE() )
*/

/*Comando final para adicionar a coluna calculada que devolve
a quantidade de horas que o ve�culo j� ficou 
( tento ele sa�do, quando dataHoraSaida n�o � nula
ou ainda no p�tio, quando dataHoraSaida � nula, ou seja, neste caso ele usa a 
dataHora atual para o c�lculo*/
alter table estacionamento
	ADD  horasEstacionado 
	as ( 
		CEILING ( DATEDIFF(minute,dataHoraEntrada,ISNULL(dataHoraSaida, GETDATE() )) / 60.00 )
	)

/*Testando os valores retornados*/
select * from estacionamento




