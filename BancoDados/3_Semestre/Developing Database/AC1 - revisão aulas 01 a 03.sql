--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- AC1 - revisão aulas 01 a 03
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
*/

1) Por que é importante um DBA / SQL Developer conhecer sobre procesos em SQL ? 
ou seja, uma sequência complexa de comandos SQL, que compartilha conceitos
com linguagens de programação tradicionais como: Concidionais ( IF ), 
Laços ( WHILE ), variáveis ( @ ), tratamento de nulos e erros ?

A) O DBA/SQL Developer não precisa conhecer nada disso.
Nenhum destes comandos será necessário em minha carreira.
B) Isto não é tarefa de DBA/SQL Developer, mesmo testes
de importação ou processos só devem ser feitos em programação
mesmo que tais testes precisem esperar todas as interfaces 
ficarem prontas.
C) O DBA/SQL Developer não precisa conhecer estas funções no SQL,
mas sim na respectiva linguagem de programação que irá usar o banco.
D) o DBA/SQL Developer precisa conhecer tais comandos para simular
processos, realizar testes de carga ( importação/exportação ),
auxilar os devenvolvedores na validação e simulação dos processos,
mesmo antes do sistema ou das interfaces ficarem prontas.
E) N.D.A

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

2) É sempre importante ao tipar uma coluna ou variável, utilizar o tipo
de dados mais econômico possível, seja por economia de espaço ( bytes )
ou para acelerar o processo ( menos leitura/escrita em disco = menos tempo ).
Sejam as seguintes especificações de variáveis que podem assumir qualquer 
valor dentro do intervalo e precisão solicitado:
Variável:		Valor Inicial	Valor Final		Precisão
--------------	---------------	---------------	----------------------------
Contador		1				30000			inteiro
DtNascimento	1900			2050			minuto
NumProduto		XR-457-BR		XR-856-BR		somente os números variam
Preco			0,00			9.999,00		duas casas decimais

Assinale a alternativa correta que declara a variável no tipo sugerido:
A)	
	DECLARE	@contador		INT
		,	@DtNascimento	DATETIME
		,	@NumProduto		VARCHAR(255)
		,	@preco			FLOAT
B)	
	DECLARE	@contador		TINYINT
		,	@DtNascimento	DATETIME2
		,	@NumProduto		VARCHAR(9)
		,	@preco			DECIMAL(9,2)
C)	
	DECLARE	@contador		SMALLINT
		,	@DtNascimento	SMALLDATETIME
		,	@NumProduto		CHAR(9)
		,	@preco			DECIMAL(6,2)
D)	
	DECLARE	@contador		BIGINT
		,	@DtNascimento	DATETIME
		,	@NumProduto		VARCHAR(MAX)
		,	@preco			REAL
E) N.D.A

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

3) Nas aulas de linguagem SQL, aprendemos várias funções sobre data,
além de funções de manipulação de strings e de conversão de tipos.
Usando este conhecimento:

Seja a seguinte variável declada com a data atual
	DECLARE @data DATETIME = GETDATE()
Qual a função SQL para devolver o primeiro dia do mês em formato de data 
( sem a hora ou com hora = 00:00:00.000 ) do mês daquela variável
independente de que data aquela variável tenha ?
A)
	DECLARE @data DATETIME = GETDATE()
	SELECT	CONVERT(DATE, '01/02/2020' )
B)
	DECLARE @data DATETIME = GETDATE()
	SELECT	LEFT(CONVERT(varchar,@data,112),6)
C)
	DECLARE @data DATETIME = GETDATE()
	SELECT	CAST( @data as date) - DATEDIFF(day,@data,GETDATE())
D)
	DECLARE @data DATETIME = GETDATE()
	SELECT	DATEADD(day, -1*DAY(@data), @data )
E)	
	DECLARE @data DATETIME = GETDATE()
	SELECT	CONVERT(DATE, @data - DAY(@data) + 1 )

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

4) Nas aulas de linguagem SQL, aprendemos várias funções sobre data,
além de funções de manipulação de strings e de conversão de tipos.
Usando este conhecimento:

Seja a seguinte variável declada com a data atual
	DECLARE @data DATETIME = GETDATE()
Qual a função SQL para devolver o último dia do mês em formato de data 
( sem a hora ou com hora = 00:00:00.000 ) do mês daquela variável   
independente de que data aquela variável tenha ?
A)
	DECLARE @data DATETIME = GETDATE()
	SELECT	CONVERT(DATE, '28/02/2020' )
B)
	DECLARE @data DATETIME = GETDATE()
	SELECT	LEFT(CONVERT(varchar,@data,112),6) + '31'
C)
	DECLARE @data DATETIME = GETDATE()
	SELECT	convert(date, dateadd(month,1,@data) - day(@data) )
D)
	DECLARE @data DATETIME = GETDATE()
	SELECT	DATEADD(day, 31-DAY(@data), @data )
E)	
	DECLARE @data DATETIME = GETDATE()
	SELECT	CONVERT(DATE, @data + (28-DAY(@data))  )

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

5)	Nas aulas de linguagem SQL, aprendemos várias funções sobre data,
além de funções de manipulação de strings e de conversão de tipos.
Usando este conhecimento:

Seja a seguinte variável declada com a placa de um veículo
	DECLARE @placa CHAR(7) = 'ABC1234'
No padrão mercosul das placas, o segundo número deve ser substituído
por uma letra equivalente à sua posição no alfabeto,
ou seja, 0->'A', 1->'B', 2->'C'
Então, nossa placa ficaria, no novo padrão do mercosul 'ABC1C34'

Qual a função para realizar esta substituição independente do valor
da placa recebido pela variável ?
A)	
	DECLARE @placa CHAR(7) = 'ABC1234'
	SELECT	REPLACE('ABC1234',2,'C')
B)	
	DECLARE @placa CHAR(7) = 'ABC1234'
	SELECT	CASE SUBSTRING(@placa,5,1)
				WHEN 0 then 'A'
				WHEN 1 then 'B'
				WHEN 2 then 'C'
				WHEN 3 then 'D'
				WHEN 4 then 'E'
				WHEN 5 then 'F'
				WHEN 6 then 'G'
				WHEN 7 then 'H'
				WHEN 8 then 'I'
				WHEN 9 then 'J'
			END
C)	
	DECLARE @placa CHAR(7) = 'ABC1234'
	SELECT	LEFT(@placa,4) + SUBSTRING(@placa,5,1) + RIGHT(@placa,2)
D)	
	DECLARE @placa CHAR(7) = 'ABC1234'
	SELECT	LEFT(@placa,4) 
		+ CHOOSE(SUBSTRING(@placa,5,1)+1,'A','B','C','D','E','F','G','H','I','J')
		+ RIGHT(@placa,2)
E)	
	N.D.A

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

6)	Nas aulas de linguagem SQL, aprendemos várias funções sobre data,
além de funções de manipulação de strings e de conversão de tipos.
Usando este conhecimento:

Um antigo desenvolvedor, resolveu salvar todos os emails
de uma certa pessoa numa lista separada por vírgula. Ex:
	DECLARE @ListaEmails VARCHAR(MAX) = 
	'aluno@faculdade.com, funcionario@empresa.com.br, pessoal@gmail.com'
Porém, durante a autenticação, apenas um email é verificado.
	DECLARE @email VARCHAR(255) = 'funcionario@empresa.com.br'

Qual a função para validar se o email fornecido ( @email ) 
está 'dentro' da lista de emails armazenada 
, devolvendo 'OK' se sim e nada ( nada, NULL ou zero ) se não ?
independente dos valores da lista ou do email fornecidos.
A)	
	DECLARE @ListaEmails VARCHAR(MAX) = 
	'aluno@faculdade.com, funcionario@empresa.com.br, pessoal@gmail.com'
	DECLARE @email VARCHAR(255) = 'funcionario@empresa.com.br'
	SELECT 'OK' where @email IN @ListaEmails
B)	
	DECLARE @ListaEmails VARCHAR(MAX) = 
	'aluno@faculdade.com, funcionario@empresa.com.br, pessoal@gmail.com'
	DECLARE @email VARCHAR(255) = 'funcionario@empresa.com.br'
	SELECT 'OK' where @ListaEmails like '%'+@email+'%'
C)	
	DECLARE @ListaEmails VARCHAR(MAX) = 
	'aluno@faculdade.com, funcionario@empresa.com.br, pessoal@gmail.com'
	DECLARE @email VARCHAR(255) = 'funcionario@empresa.com.br'
	SELECT	'OK' WHERE CHARINDEX(@email, @ListaEmails,0) = 0
D)	
	DECLARE @ListaEmails VARCHAR(MAX) = 
	'aluno@faculdade.com, funcionario@empresa.com.br, pessoal@gmail.com'
	DECLARE @email VARCHAR(255) = 'funcionario@empresa.com.br'
	SELECT	'OK' WHERE LEN(REPLACE(@ListaEmails, @email, '')) > 0
E)	
	N.D.A

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

7)	Nas aulas de linguagem SQL, aprendemos várias funções sobre data,
além de funções de manipulação de strings e de conversão de tipos.
Usando este conhecimento:

Um antigo desenvolvedor, resolveu salvar o documento(CPF)
de uma certa pessoa em uma string, sempre no mesmo formato, Ex:
	DECLARE @CPF VARCHAR(20) = 'CPF: 123.456.789-01'
Porém, no novo sistema, o CPF deve ser armazenado sem nada além de números.
ou seja, o correto seria '12345678901'.

Qual a função para validar tratar a string original só deixando números
independente dos valores de CPF fornecidos ?
A)	
	DECLARE @CPF VARCHAR(20) = 'CPF: 123.456.789-01'
	SELECT	REPLACE(REPLACE(REPLACE(@CPF,'CPF: ', '' ),'.',''),'-','')
B)	
	DECLARE @CPF VARCHAR(20) = 'CPF: 123.456.789-01'
	SELECT	SUBSTRING(@CPF,6,3) 
			+ SUBSTRING(@CPF,10,3) 
			+ SUBSTRING(@CPF,14,3) 
			+ SUBSTRING(@CPF,18,2)
C)	
	DECLARE @CPF VARCHAR(20) = 'CPF: 123.456.789-01'
	SELECT	STUFF(@CPF,1,5,'') 
D)	
	DECLARE @CPF VARCHAR(20) = 'CPF: 123.456.789-01'
	SELECT	'12345678901'
E)	
	N.D.A

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

8) Seja uma certa tabela hipotética que registra o preco unitário e a quantidade:
	CREATE TABLE venda (
		preco DECIMAL(6,2)
		, quantidade TINYINT
	)
Qual o comando para adicionar na mesma uma coluna calculada
que deva devolver o valor cobrado, ou seja, o preco unitário 
multiplicado pela quantidade ?
A)	
	ALTER	TABLE venda
	ADD		valorCobrado as (preco * quantidade)
B)	
	ALTER	TABLE venda ADD	valorCobrado DECIMAL(12,2)
	UPDATE venda SET valorCobrado = preco * quantidade
C)	
	CREATE VIEW View_venda as
		SELECT preco, quantidade, preco * quantidade as valorCobrado
D)	
	SELECT preco, quantidade, valorCobrado = preco * quantidade
E)	
	N.D.A

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

9) Foi criada uma tabela para gerenciar a quantidade de vezes
que um email (identificador) de aluno faz login.
	CREATE TABLE Logins (
		email varchar(255) NOT NULL
		, quantidade tinyint NOT NULL
		, CONSTRAINT PK_logins primary key (email )
		)
No primeiro login o email deve ser registrado na tabela com quantidade = 1
Nos logins subsequentes, o login deve ser identificado e apenas o contador 
de quantidade deve ser incrementado ( 2, 3, 4, etc ).
O login é fornecido em forma de variável: @email, como em;
	DECLARE @email VARCHAR(255) = 'gustavo.maia@faculdadeimpacta.com.br'
Qual a sequência de comandos que realiza este processo conforme descrito :	
A)		
	DECLARE @email VARCHAR(255) = 'gustavo.maia@faculdadeimpacta.com.br'
	IF EXISTS ( SELECT 1 FROM logins where email = @email )
		UPDATE logins set quantidade += 1 where email = @email 
	else
		INSERT logins(email,quantidade) values ( @email, 1 )
B)	
	DECLARE @email VARCHAR(255) = 'gustavo.maia@faculdadeimpacta.com.br'
			, @quantidade INT = 0
	IF NOT EXISTS ( SELECT 1 FROM logins where email = @email )
	BEGIN
		INSERT logins(email,quantidade) values ( @email, @quantidade )
	END
	else
	BEGIN
		SELECT 	@quantidade = quantidade from logins where email = @email 
		SELECT @@identity
		UPDATE logins set quantidade = @quantidade where email = @email 
	END
C)	
	DECLARE @email VARCHAR(255) = 'gustavo.maia@faculdadeimpacta.com.br'
	INSERT logins(email,quantidade) values ( @email, 0 )
	SELECT @email = email from logins
	UPDATE logins set quantidade = quantidade + 1 where email = @email 
D)	
	DECLARE @email VARCHAR(255) = 'gustavo.maia@faculdadeimpacta.com.br'
	IF @email = ( select email from logins )
		UPDATE logins set quantidade = quantidade + 1 where email = @email 
	ELSE
		INSERT logins(email,quantidade) values ( @email, 1 )
E)	
	N.D.A

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

10) Foi criada uma tabela para gerenciar a quantidade de vezes
que um email (identificador) de aluno faz login.
	CREATE TABLE Logins (
		email varchar(255) NOT NULL
		, quantidade tinyint NOT NULL
		, CONSTRAINT PK_logins primary key (email )
		)
Foi solicitado um relatório com o percentual de vezes que cada email
foi registrado no sistema, ou seja, se o email 1 vez 8 logins 
e o email 2 fez 2 logins, o primeiro realizou 80% dos logins e o segundo 20%.
(fiquem à vontade para inserir valores de teste na tabela)

Qual código é capaz de devolver este relatório:
A)	
	select	email, (10.00 * quantidade ) as percentual
	from	logins
B)	
	select	email, SUM(quantidade) as percentual
	from	logins
	group by email
C)		
	DECLARE @total INT = (select sum(quantidade) from logins)
	select	email, (100.00 *quantidade)/@total  as percentual
	from	logins
D)	
	DECLARE @total INT = (select sum(quantidade) from logins)
	select	(100.00 * @total)/quantidade, email  as percentual
	from	logins
E)	
	N.D.A

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

11) Foi a data de nascimento e a naturalidade de crianças no seguinte formato:
CREATE TABLE RegistroInfantil ( 
	, Nome VARCHAR(50) NOT NULL
	, dtNasc VARCHAR(50) NOT NULL
	, Nacionalidade VARCHAR(20)
)	
Foi solicitado um relatóri com o nome, nacionalidade e data de nascimento
das crianças registradas, porém, se a nacionalidade for Brasileira,
Porém, todas as datas foram salvos no formato de origem de sua nacionalidade.
Por exemplo:
INSERT INTO  RegistroInfantil( nome, dtNasc, Nacionalidade )
values	( 'João', '10/04/2000', 'Brasileiro' )
	,	( 'Joseph', '10/04/2000', 'Americano' )
Qual código SQL devolve um relatório com todas as datas na mesma nacionalidade.
Ex: João nasceu em 10 de abril, e deve imprimir 10/04/2000
e Joseph Nasceu em 04 de outubro, e deve imprimir 04/10/2000
(fiquem à vontade para inserir valores de teste na tabela)

A)	
	SELECT nome, CASE 
		WHEN Nacionalidade = 'Americano' 
			THEN CONVERT(VARCHAR,CONVERT(DATETIME,dtNasc),101)
		WHEN Nacionalidade = 'Brasileiro' 
			THEN CONVERT(VARCHAR,CONVERT(DATETIME,dtNasc),103)
	END as DtNasc
	FROM RegistroInfantil
B)	
	DECLARE @nacionalidade VARCHAR(20)
	SELECT @nacionalidade = nacionalidade FROM RegistroInfantil
	IF	@nacionalidade = 'Brasileiro'
		SELECT nome, dtNasc from RegistroInfantil
	IF @nacionalidade = 'Americano'
		SELECT	nome, SUBSTRING(dtNasc,4,2) 
				+ '/' +  SUBSTRING(dtNasc,1,2)
				+ '/' +  SUBSTRING(dtNasc,7,4)
		from RegistroInfantil
C)	
	SELECT	nome, SUBSTRING(dtNasc,4,2) 
			+ '/' +  SUBSTRING(dtNasc,1,2)
			+ '/' +  SUBSTRING(dtNasc,7,4) as DtNasc
	from RegistroInfantil
	WHERE nacionalidade = 'Americano'
	UNION ALL
	SELECT nome, dtNasc from RegistroInfantil
	WHERE nacionalidade = 'Brasileiro'
D)	
	SELECT nome, CASE Nacionalidade
		WHEN 'Americano' 
			THEN CONVERT(VARCHAR,CONVERT(DATETIME,dtNasc),101)
		WHEN 'Brasileiro' 
			THEN CONVERT(VARCHAR,CONVERT(DATETIME,dtNasc),103)
	END as DtNasc
	FROM RegistroInfantil
E)	
	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 

12) Sejam as seguintes tabelas para registro de funcionarios e dependentes.
CREATE TABLE Funcionario (	ID INT NOT NULL IDENTITY(1,1)
							, nome VARCHAR(60) NOT NULL
							, CONSTRAINT PK_Funcionario PRIMARY KEY ( ID )	);
CREATE TABLE Dependente (	ID INT NOT NULL IDENTITY(1,1)
							, nome VARCHAR(60) NOT NULL
							, idFuncionario INT NOT NULL
							, CONSTRAINT PK_Dependente PRIMARY KEY ( ID )
							, CONSTRAINT FK_Dependente_Funcionario FOREIGN KEY ( idFuncionario )
								REFERENCES Funcionario ( id ) );
--Sejam os seguintes valores de teste:
INSERT INTO Funcionario(nome) VALUES ('Mario') , ('Pedro');
INSERT INTO Dependente (nome, idFuncionario)
VALUES	( 'Igor', (SELECT ID FROM Funcionario WHERE nome = 'Mario') )
,		( 'Tereza', (SELECT ID FROM Funcionario WHERE nome = 'Mario') )

Seja a seguinte função STRING_AGG que, em um agrupamento, devolve 
uma lista de strings concatenadas ( equivalente à função de soma 
num group by, mas, ao invés de somar valores, ela junta os resultados ).

Qual dos seguintes comandos devolve uma lista com os nomes
concatenados dos dependentes, porém, devolve o texto 'sem dependentes'
caso ele não possua nenhum dependente cadastrado ?

A)	
	SELECT	F.nome as Funcionario, STRING_AGG(D.nome,',') as dependentes
	FROM	Funcionario as F
			LEFT JOIN Dependente as D ON F.id = D.idFuncionario
	GROUP BY F.nome
B)	
	SELECT	ISNULL(F.nome,'sem dependentes') as Funcionario
			, STRING_AGG(D.nome,',') as dependentes
	FROM	Funcionario as F
			INNER JOIN Dependente as D ON F.id = D.idFuncionario
	GROUP BY F.nome
C)	
	SELECT	ISNULL(dependente.nome,'sem dependentes') as Dependente
			, Funcionario.nome as Funcionario
	FROM	Funcionario
			LEFT JOIN Dependente ON Funcionario.id = Dependente.idFuncionario
D)	
	SELECT	F.nome as Funcionario
			, ISNULL( STRING_AGG(D.nome,','), 'sem dependentes') as dependentes
	FROM	Funcionario as F
			LEFT JOIN Dependente as D ON F.id = D.idFuncionario
	GROUP BY F.nome
E)	
	N.D.A.



