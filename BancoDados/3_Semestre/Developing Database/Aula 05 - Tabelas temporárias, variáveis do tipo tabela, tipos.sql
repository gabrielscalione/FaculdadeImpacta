---------------------------------------------------------------------------
-- TYPE
---------------------------------------------------------------------------
/*
� poss�vel a cria��o de um tipo de dados ALIAS definido pelo usu�rio
Baseado em um tipo de dados nativo do SQL Server
Podemos criar outros tipos de dados por CLR (Common Language Runtime)
*/

-- 1. Criando TYPE
create type Moeda from decimal(9, 2) not null
go

-- Utilizando UDF TYPE
if exists(select * from sys.tables where name = 'TableTypeTeste')
	drop table TableTypeTeste
go

create table TableTypeTeste
(	
	id smallint identity(-32768, 1)
	, nome varchar (20)
	, valor Moeda
)

exec sp_help TableTypeTeste

insert TableTypeTeste (nome, valor) values ('Mouse', 35.42)

select * from TableTypeTeste


-- Dropando TYPE
drop type Moeda 
drop table TableTypeTeste; drop type Moeda; 
---------------------------------------------------------------------------


---------------------------------------------------------------------------
-- VARIABLE TABLE
---------------------------------------------------------------------------
/*
Declara��o de Vari�vel com comportamento de tabela
Permite aplica��o de constraints (PK, UQ, DF e CK) sem nomea��o
Como qualquer vari�vel, seu escopo � local ao batch
S� existe no momento RUNTIME
Localizada na mem�ria, parcim�nia na inser��o de registros 
*/


declare  @TBTeste table (id tinyint identity, UF varchar(2) not null)
insert @TBTeste values ('SP'), ('RJ'), ('MG')
select * from @TBTeste

declare  @TBTeste table (id smallint identity(-32768, 1) primary key, nota varchar(100) unique)
insert @TBTeste values ('Apenas Teste de variable table em um batch')
insert @TBTeste values ('Apenas Teste de variable table em um batch')
select * from @TBTeste
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- TYPE e VARIABLE TABLE
---------------------------------------------------------------------------
/*
Podemos criar uma TYPE mais elaborada quando baseada em Variable Table
Permite que objeto possa ser passado como par�metro de procedures
Favorece a padroniza��o de c�digos e/ou objetos do banco
*/

if exists (select * from sys.types where name = 'Moeda')
	drop type Moeda 
go
if exists (select * from sys.types where name = 'UF')
	drop type UF 
go

create type Moeda from decimal(9, 2) not null
go
create type UF from char(2) not null
go


-- Variavel Table com TYPE
declare  @TBTeste table 
(
	id smallint identity (32767, -1) primary key (id)
	, produto varchar(20) not null unique
	, estadoProdutor UF check (estadoProdutor in ('SP', 'RJ', 'MG'))
	, valor Moeda check (Valor between 10 and 1000)
	, dataCompra datetime default getdate()
)

insert @TBTeste (produto, estadoProdutor, valor) values ('Caderno', 'SP', 15.5)
select * from @TBTeste


-- TYPE como VARIABLE TABLE
if exists (select * from sys.types where name = 'PadraoProduto')
	drop type PadraoProduto 
go

create type PadraoProduto as table 
(
	id smallint identity (32767, -1) primary key (id)
	, produto varchar(20) not null unique
	, estadoProdutor UF check (estadoProdutor in ('SP', 'RJ', 'MG')) default ('SP') 
	, valor Moeda check (Valor between 10 and 1000)
	, dataCompra datetime default getdate()
)


-- Declarando Vari�vel Table do TYPE criado
declare @TB PadraoProduto
insert @TB (produto, valor) values ('Caderno', 15.5)
select * from @TB
---------------------------------------------------------------------------


---------------------------------------------------------------------------
-- OUTPUT
---------------------------------------------------------------------------
/*
- Usado para pegar um retorno de instru��es como INSERT, DELETE, UPDATE, MERGE
- D� acesso � duas tabelas internas que s� existem durante a execu��o da instru��o original:
	inserted - cont�m informa��es de entrada
	deleted - cont�m informa��es de sa�da
- Podem ser capturadas em vari�veis do tipo tabela ou simplesmente exibidas na tela.
*/

-- Criando uma tabela de teste
if exists(select * from sys.tables where name = 'TesteOutput')
	drop table TesteOutput
go

create table TesteOutput
(	id smallint identity(-32768, 1)
	, nome varchar (20)
)

INSERT INTO TesteOutput(nome) OUTPUT inserted.id, inserted.nome VALUES ( 'primeiro' )
INSERT INTO TesteOutput(nome) OUTPUT inserted.* VALUES ( 'segundo' )

DELETE FROM TesteOutput OUTPUT deleted.* 

INSERT INTO TesteOutput(nome) VALUES ( 'terceiro' )

UPDATE TesteOutput SET nome = 'quarto' 
OUTPUT	deleted.nome as nome_antigo, inserted.nome as nome_novo
FROM	TesteOutput
where	nome = 'terceiro'


-- OUTPUT COM VARIABLE TABLE
DECLARE @saida TABLE 
(	id smallint
	, nome varchar (20)
)
INSERT INTO TesteOutput(nome) 
	OUTPUT inserted.id, inserted.nome 
	INTO @saida(id,nome) VALUES ( 'quinto' )
SELECT * from @saida

DECLARE @log TABLE 
(	quem VARCHAR(255)
	, quando DATETIME
	, onde VARCHAR(255)
	, valorAntigo VARCHAR(1024)
	, valorNovo VARCHAR(1024)
)
UPDATE TesteOutput SET nome = 'sexto' 
OUTPUT	SYSTEM_USER
		, GETDATE()
		, HOST_NAME() 
		, deleted.nome
		, inserted.nome
INTO @log ( quem, quando, onde, valorAntigo, valorNovo)
FROM	TesteOutput
where	nome = 'quinto'

select * from @log

--------------------------------------------------------------------------------------------------------------------------------
-- Exerc�cios com OUTPUT e VARI�VEIS do tipo TABELA
--------------------------------------------------------------------------------------------------------------------------------
/* Seja o seguinte processo j� bem conhecido :
Um ve�culo ir� estacionar em um estacionamento em um plano pr�-selecionado.

Foi lhe solicitado testar o processo de inser��o de 'm�ltiplos' ( no caso x2 )
ve�culos numa mesma instru��o.

O Id dos ve�culos ( @idVeiculo1 e @idVeiculo2 ), o Id da localidade ( @idLocalidade )
e o ID do plano selecionado ( @idPlano ) j� s�o vari�veis com valores conhecidos
que passaram pelos processos de coleta e valida��o exercitados em aulas anteriores.
*/
/* 
Altere o seguinte bloco de c�digo para coletar em uma vari�vel do tipo tabela, os dados, em especial os IDs, dos dois estacionamentos ( ou seja, seus TICKETs ).
N�o � permitido a utiliza��o de instru��es como @@identity ou SCOPE_IDENTITY()

*/ 
USE impactaestacionamento 
go 

DECLARE @idVeiculo1		INT = 2 /*selecionado aleatoriamente*/ 
        , @idVeiculo2   INT = 3 /*selecionado aleatoriamente*/ 
        , @idLocalidade INT = 1 /*estacionamento da Faculdade Impacta - Paulista*/ 
        , @idPlano      INT = 6 /*plano Avulso Horista*/ 

DECLARE @saida TABLE 
(	id smallint)
--Entrada de ve�culos 
INSERT INTO estacionamento (idlocalidade, idveiculo, idplano) 
		OUTPUT inserted.id 
		INTO @saida(id)
VALUES      ( @idLocalidade, @idVeiculo1, @idPlano )

			,  ( @idLocalidade, @idVeiculo2, @idPlano ) 

SELECT * FROM @saida

/* 
Altere o seguinte bloco de c�digo que, dado uma vari�vel do tipo tabela 
contendo m�ltiplos IDs (ou TICKETs de estacionamento ),
de baixa em todos eles ( ou seja, realize o registro da sa�da do ve�culo
*/ 
--Sa�da de ve�culos
UPDATE	estacionamento
		SET dataHoraSaida = GETDATE()
		, valorCobrado = plano.valor * horasEstacionado
		OUTPUT inserted.*				-- retorna na tela os recentes inseridos
FROM	estacionamento
		INNER JOIN Plano on estacionamento.idPlano = plano.id
WHERE	estacionamento.id in (SELECT id FROM @saida) /*os IDs vem da tabela vari�vel*/

--caso n�o use o output, select abaixo
select * from estacionamento where dataHoraSaida is not null

--------------------------------------------------------------------------------------------------------------------------------
-- TABELAS TEMPOR�RIAS
--------------------------------------------------------------------------------------------------------------------------------
-- Local
create table #veiculo1 (idVeiculo int, valor decimal(9,2))

insert	#veiculo1 
select	idVeiculo, valor 
from	Veiculo where valor > 45000

select * from #veiculo1


-- Global
select	idVeiculo, valor 
into	##Veiculo2
from	Veiculo 
where	valor > 45000

select * from ##Veiculo2
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- Exerc�cios TABELAS TEMPOR�RIAS
--------------------------------------------------------------------------------------------------------------------------------
/*
Em um processo de auditoria, foi lhe pedido para gerar uma tabela tempor�ria (nome = #auditoria)
com os Tickets de estacionamento de ve�culos estacionados � mais do que 24 horas,
pois, como n�o s�o permitidos pernoites, todos estes registros devem ser detectados.
*/
SELECT ... INTO ....

/*
Exclua desta lista ( ou seja, da tabela tempor�ria ) as placas do dono e dos filhos do dono
pois estas, podem pernoitar no estacionamento. 
Tais placas lhe foram fornecidos em uma nova tabela tempor�ria denominada ##auditoria_isentos
*/
CREATE TABLE ##auditoria_isentos ( placa char(7) )
insert into ##auditoria_isentos VALUES ( 'ABC1234' ),( 'AOE7432' ),( 'HGG1A12' )
select * from ##auditoria_isentos
/*resultado esperado: exclua de sua tabela temporiaria (#auditoria)
os ve�culos presentes na outra tabela temporaria (##auditoria_isentos) */
DELETE ...

/*
Por fim, foi lhe solicitado que atualize o status dos demais ve�culos
ajustando a hora de sa�da para o final do dia de entrada dos mesmos,
ou seja, se ele entrou em dataHoraEntrada = '2021-02-17 19:35:03.600' ele 
deve receber dataHoraSaida = '2021-02-17 23:00:00.000'.
Salve corretamente os demais campos da tabela estacionamento.
*/
UPDATE estacionamento SET....
