/*
Aula 01 - Revisão
	Preparação do ambiente de estudo ( SQL Server )
	Skills esperadas: reconhecer e 'entender' o banco de dados
	Realizar relatórios utilizando o conhecimento de linguagem SQL
*/
USE MASTER
GO
DROP DATABASE ImpactaEstacionamento;
GO
CREATE DATABASE ImpactaEstacionamento;
GO
USE ImpactaEstacionamento;
GO
/*Cliente é o mensalista, pode estacionar se estiver em dia com as mensalidades*/
CREATE TABLE cliente (
	id INT NOT NULL IDENTITY(1,1)
	, nome VARCHAR(60) NOT NULL
	, cpf CHAR(11) NOT NULL
	, telefone VARCHAR(20) NOT NULL
	, professor BIT NULL CONSTRAINT DF_professorCliente DEFAULT (0)
	, CONSTRAINT CK_CPFCliente CHECK ( cpf LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' )
	, CONSTRAINT PK_cliente PRIMARY KEY ( id )
	, CONSTRAINT UQ_ClienteCPF UNIQUE (cpf)
)
GO
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
GO
/*Localidade é o nome da garagem ou do local físico do estacionamento*/
CREATE TABLE localidade (
	id INT NOT NULL IDENTITY(1,1)
	, identificacao VARCHAR(60) NOT NULL
	, localizacao VARCHAR(255) NOT NULL
	, capacidade_carro TINYINT NOT NULL 
	, capacidade_moto TINYINT NOT NULL 
	, CONSTRAINT PK_localidade PRIMARY KEY ( id )
)
GO
/*CategoriaPlano é o modelo de contratação que os planos tem que se basear*/
/*Define os horários de funcionamento, 
ex: Avulso diurno só pode ser utilizado para estacionamentos durante o dia*/
CREATE TABLE categoriaPlano (
	id INT NOT NULL IDENTITY(1,1)
	, nome VARCHAR(255) NOT NULL
	, unidadeCobranca VARCHAR(10) NOT NULL
	, horarioInicio TIME NULL
	, horarioTermino TIME NULL
	, CONSTRAINT PK_categoriaPlano PRIMARY KEY ( id )
	, CONSTRAINT CK_unidadeCobrancha CHECK ( unidadeCobranca IN ( 'hora', 'periodo', 'dia', 'mes' ) )
)
GO
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
/*contrato é o que é realizado por clientes mensalistas*/
CREATE TABLE contrato (
	id INT NOT NULL IDENTITY(1,1)
	, idPlano INT NOT NULL
	, idCliente INT NOT NULL
	, diaVencimento TINYINT NOT NULL
	, dataContratacao DATETIME NOT NULL CONSTRAINT DF_dataContratacao DEFAULT ( GETDATE() )
	, dateEncerramento DATETIME NULL 
	, CONSTRAINT CK_diaVencimento CHECK ( diaVencimento IN ( 5,10,15,20,25 ) )
	, CONSTRAINT PK_contrato PRIMARY KEY ( id )
	, CONSTRAINT FK_contratoPlano FOREIGN KEY (idPlano) REFERENCES plano(id)
	, CONSTRAINT FK_contratoCliente FOREIGN KEY (idCliente) REFERENCES cliente(id)
)
GO
/*mensalidade é gerada mês a mês para clientes mensalistas durante o contrato*/
CREATE TABLE mensalidade (
	id INT NOT NULL IDENTITY(1,1)
	, idContrato INT NOT NULL
	, mes TINYINT NOT NULL
	, recebido BIT NOT NULL CONSTRAINT DF_recebido DEFAULT(0)
	, dataVencimento DATETIME NOT NULL
	, dataPagamento DATETIME NULL
	, valorRecebido DECIMAL(10,2) NULL
	, multa DECIMAL(10,2) NULL
	, CONSTRAINT PK_mensalidade PRIMARY KEY ( id )
	, CONSTRAINT CK_mensalidade CHECK ( mes BETWEEN 1 and 12 ) 
	, CONSTRAINT FK_mensalidadeContrato FOREIGN KEY (idContrato) REFERENCES contrato(id)
)
GO
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
/*dados iniciais para testes*/
INSERT INTO Cliente(nome, cpf, telefone) VALUES (
	'Almir dos Santos', '78654552421', '(11)91234-5678' 
)
GO
Insert into veiculo(tipo, placa) values ( 'carro', 'ABC1234' )
, ( 'carro', 'AOE7432' ), ( 'moto', 'HGG1A12' ), ( 'moto', 'YJB8742' )
, ( 'carro', 'JKL9864' ), ( 'carro', 'OIU9800' ), ( 'carro', 'FDE4545' )
, ( 'moto', 'DAP9989' ), ( 'carro', 'TER4533' ), ( 'carro', 'MNJ9878' )
GO
Insert veiculo( tipo, placa, idCliente)
			select 'moto', 'GHY6543', NULL
union all	select 'carro', 'JHH9G12', (select id from cliente where cpf = '78654552421')
GO
INSERT INTO localidade ( identificacao, localizacao, capacidade_carro, capacidade_moto )
VALUES	('Faculdade Impacta - Paulista', 'Av. Paulista', 10, 2 )
GO
INSERT INTO categoriaPlano (nome, unidadeCobranca, horarioInicio, horarioTermino)
values ('Mensalista Diurno', 'mes', '06:00', '18:00')
	,  ('Mensalista Noturno', 'mes', '18:00', '23:00')
	,  ('Mensalista Professor', 'mes', '06:00', '23:00')
	,  ('Avulso Diurno', 'periodo', '06:00', '18:00')
	,  ('Avulso Noturno', 'periodo', '18:00', '23:00')
	,  ('Avulso Horista', 'hora', '06:00', '23:00')
GO
INSERT INTO plano(idCategoria, ativo, dataInicioVigencia, dataFimVigencia, valor, idLocalidade)
VALUES ((select id from categoriaPlano where nome = 'Mensalista Diurno'), 1, '20210101', NULL, 120.00, (SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'))
	,  ((select id from categoriaPlano where nome = 'Mensalista Noturno'), 1, '20210101', NULL, 160.00, (SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'))
	,  ((select id from categoriaPlano where nome = 'Mensalista Professor'), 1, '20210101', NULL, 100.00, (SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'))
	,  ((select id from categoriaPlano where nome = 'Avulso Diurno'), 1, '20210101', NULL, 20.00, (SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'))
	,  ((select id from categoriaPlano where nome = 'Avulso Noturno'), 1, '20210101', NULL, 25.00, (SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'))
	,  ((select id from categoriaPlano where nome = 'Avulso Horista'), 1, '20210101', NULL, 10.00, (SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'))
GO
INSERT INTO estacionamento ( idLocalidade, idVeiculo, idPlano )
VALUES 
((SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'), (SELECT id FROM veiculo WHERE placa = 'JKL9864'), (SELECT plano.id FROM plano INNER JOIN categoriaPlano on idCategoria= categoriaPlano.id WHERE	categoriaPlano.nome = 'Avulso Horista' and plano.ativo = 1)),
((SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'), (SELECT id FROM veiculo WHERE placa = 'JHH9G12'), (SELECT plano.id FROM plano INNER JOIN categoriaPlano on idCategoria= categoriaPlano.id WHERE	categoriaPlano.nome = 'Avulso Horista' and plano.ativo = 1)),
((SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'), (SELECT id FROM veiculo WHERE placa = 'TER4533'), (SELECT plano.id FROM plano INNER JOIN categoriaPlano on idCategoria= categoriaPlano.id WHERE	categoriaPlano.nome = 'Avulso Horista' and plano.ativo = 1)),
((SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'), (SELECT id FROM veiculo WHERE placa = 'DAP9989'), (SELECT plano.id FROM plano INNER JOIN categoriaPlano on idCategoria= categoriaPlano.id WHERE	categoriaPlano.nome = 'Avulso Horista' and plano.ativo = 1)),
((SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'), (SELECT id FROM veiculo WHERE placa = 'OIU9800'), (SELECT plano.id FROM plano INNER JOIN categoriaPlano on idCategoria= categoriaPlano.id WHERE	categoriaPlano.nome = 'Avulso Horista' and plano.ativo = 1)),
((SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'), (SELECT id FROM veiculo WHERE placa = 'GHY6543'), (SELECT plano.id FROM plano INNER JOIN categoriaPlano on idCategoria= categoriaPlano.id WHERE	categoriaPlano.nome = 'Avulso Horista' and plano.ativo = 1)),
((SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'), (SELECT id FROM veiculo WHERE placa = 'FDE4545'), (SELECT plano.id FROM plano INNER JOIN categoriaPlano on idCategoria= categoriaPlano.id WHERE	categoriaPlano.nome = 'Avulso Horista' and plano.ativo = 1)),
((SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'), (SELECT id FROM veiculo WHERE placa = 'MNJ9878'), (SELECT plano.id FROM plano INNER JOIN categoriaPlano on idCategoria= categoriaPlano.id WHERE	categoriaPlano.nome = 'Avulso Horista' and plano.ativo = 1)),
((SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'), (SELECT id FROM veiculo WHERE placa = 'AOE7432'), (SELECT plano.id FROM plano INNER JOIN categoriaPlano on idCategoria= categoriaPlano.id WHERE	categoriaPlano.nome = 'Avulso Horista' and plano.ativo = 1)),
((SELECT id FROM localidade WHERE identificacao = 'Faculdade Impacta - Paulista'), (SELECT id FROM veiculo WHERE placa = 'YJB8742'), (SELECT plano.id FROM plano INNER JOIN categoriaPlano on idCategoria= categoriaPlano.id WHERE	categoriaPlano.nome = 'Avulso Horista' and plano.ativo = 1))
GO
