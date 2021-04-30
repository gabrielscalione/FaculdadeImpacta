--Rode isso apenas uma vez
create database ac3;
GO
use ac3;


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 10 - AC3 - Revisão até a aula 09
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
/*
Aula 08 - Transações, Erros: Geração, Captura e Tratamento de erros; Debug.
	Logs e rastreamento de erros.
	Debug de processos.
Aula 09 - Funções e procedimentos - parte 1
	Utilização de procedures para controle de processos.
	Utilização de funções para automatização de processos de validação.
	Criação de funções para manipulação de processos.
	Criação de procedimentos para manipulação de processos.
Aula 10 - AC3 - Revisão aulas 08 e 09
*/


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 1: Revisão Teórica
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Objetivo: colocar em prática últimos conceitos aprendidos
para facilitar o uso nas atividades a seguir

01) Sejam as seguintes afirmações sobre transações:
	I		Transações Explícitas são aquelas que o usuário 
			determina o início ( BEGIN TRANSACTION ) 
			e termino ( COMMIT OU ROLLBACK TRANSACTION )
	II		Transações Implícitas são aquelas que o sistema abre
			automaticamente quando alguns comandos ( CREATE, INSERT, etc )
			são executados, mas ainda precisam que o usuário as conclua 
	III		Transações automáticas são aquelas gerenciadas automaticamente
			pelo sistema ao redor de comandos transacionados, como o INSERT.
			Ou seja, não cabe ao usuário rodar nem o inicio nem o término.
	IV		Transações são a maneira que SGBDs utilizam 
			para garantir o ACID, ou seja, é a garantia de que as operações 
			devem ser Atômicas, Consistentes, Isoladas e Duráveis.
	V		Além do BEGIN, COMMIT e ROLLBACK outros comandos utilizados
			são o STOP( pausa em uma transação) e o RETURN (para retomar a transação)
	VI		Ao alinhar múltiplas transações ( NESTED TRANSACTIONS ) tenho que tomar
			cuidado pois qualquer ROLLBACK desfaz todas as transações em cascata.
Assinale a alternativa correta:

A) Apenas I, II e III são verdadeiras
B) Todas as alternativas são verdadeiras	
C) Apenas I, II, III, IV e VI são verdadeiras
D) Apenas I e IV são verdadeiras
E) N.D.A.( se nenhuma alternativa corresponder ao conjunto de afirmações corretas ).

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
02) Sejam as seguintes afirmações sobre Isolamento entre Processos.
		I		Quando dentro de uma transação, tudo que é utilizado é reservado
				( LOCK ) para indicar aos outros processos que você já o está usando
				e evitar que outros processos o utilizem.
		II		Quando dentro de uma transação você desejar utilizar um recurso
				já reservado por outro processo, você recebe o que chamamos de BLOCK
				e fica na espera até que aquele recurso fique liberado novamente.
		III		Para evitar problemas de concorrência, o mais recomendado é manter
				as transações o mais curtas ou breve possíveis, além de tentar 
				sempre afetar a menor quantidade de linhas possíveis.
		IV		Uma transação pode conter inúmeras intruções, porém, os únicos 
				estados aceitáveis, considerados consistentes, são aqueles em que
				ou todas as intruções rodaram, ou nenhuma intrução rodou.
		V		Um dos objetivos de garantir o isolamento entre os processos é 
				dar a impressão ou ilusão aos usuários de que eles são os únicos
				usuários a trabalhar simultâneamente no sistema.
Assinale a alternativa correta:

A) Apenas I e II são verdadeiras
B) Todas as afirmações são verdadeiras
C) Apenas III e IV são verdadeiras
D) Apenas V é falsa.
E) N.D.A.( se nenhuma alternativa corresponder ao conjunto de afirmações corretas ).

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
03) Sejam as seguintes afirmações sobre Erros e tratamento de erros.
		I		Erro é a forma que o sistema utiliza para indicar que algo
				indevido aconteceu, orientando o usuário sobre as formas de 
				identificá-lo, reproduzí-lo ou corrigí-lo.
		II		Erros no MSSQL são categorizados em severidades, que vão das 
				mais baixas, que englobam erros que podem ser corrigidos pelo 
				usuário às mais altas, que são erros do sistema que só podem 
				ser corrigidos por um administrador.
		III		Erros customizados ou personalisados podem ser criados para
				detalhar inconsistências em processos ou sistemas utilizados 
				pelo usuário.
		IV		Erros podem ser capturados ( instrução TRY ) 
				e tratados ( instrução CATCH ) mesmo utilizando instruções em SQL.
		V		Um dos maiores benefícios do tratamento de erros é, além da devida 
				identificação dos erros, a capacidade de gerar logs e relatórios 
				sobre processos de importação, que muitas vezes trazem excessões
				ou erros no meio dos dados recebidos.
Assinale a alternativa correta:
				
A) Todas as afirmações estão corretas.
B) Apenas I e V estão corretas.
C) Apenas II e III estão corretas.
D) Nenhuma afirmação está correta.
E) N.D.A.( se nenhuma alternativa corresponder ao conjunto de afirmações corretas ).

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
04) Sejam as seguintes afirmações sobre funções em MSSQL.
		I		Funções são códigos SQL encapsulados sob um nome, que pode ser 
				chamados múltiplas vezes, evitando ter que repetir grandes blocos
				de código SQL múltiplas vezes.
		II		Existem vários tipos de funções, um destes é chamado função escalar
				pois esta devolve apenas um único valor, e o tipo deste valor
				retornado tem que ser declarado no cabeçalho da função.
		III		Funções podem receber parâmetros de entrada, cada um deles
				deve ser declarado no cabeçalho da função no formato de uma variável
				com o respectivo tipo do dado que será recebido.
		IV		Uma vez criadas, as funções escalares podem ser chamadas como qualquer
				outra função do sistema, podendo ser, inclusive, chamadas umas
				dentro de outras ( ou seja, uma função chamando outra função ).
		V		O nome das variáveis dentro de uma função não precisa ser o mesmo 
				do nome das variáveis de quando ela é chamada, ou seja, o que 
				importa são os 'valores' passados para dentro e para fora.
Assinale a alternativa correta:

A) Apenas I, II, III e V são verdadeiras.
B) Apenas II é falsa.
C) Nenhuma afirmação é falsa.
D) Todas as afirmações são verdadeiras.
E) N.D.A.( se nenhuma alternativa corresponder ao conjunto de afirmações corretas ).

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
05) Sejam as seguintes afirmações sobre procedimentos armazenados em MSSQL.
		I		Exatamente igual às funções, os procedimentos que devolvem 
				apenas um valor único são chamados de escalares e o tipo 
				deve ser declarado usando a instrução RETURNS do cabeçalho.
		II		Assim como na intrução INSERT, onde a cláusula OUTPUT serve para 
				devolver o que foi inserido, a cláusula OUTPUT na declaração 
				de procedimentos é utilizada para devolver o que foi inserido
				nas tabelas por ela afetadas.
		III		Procedimentos obrigatoriamente existem a troca de parâmetros 
				de entrada e saída, ou seja, não é possível declarar uma procedure
				que não receba E nem devolva valores.
		IV		Da mesma forma que as funções, os procedimentos são chamados (usados)
				como quaisquer outras funções do sistema, podem ser usados dentro de 
				instruções como SELECT ou mesmo um chamando o outro.
		V		Em procedimentos, diferente das funções, eu posso ter múltiplos 
				parâmetros de saída, desde que cada um deles seja devidamente declarado
				no cabeçalho com a cláusula OUTPUT.
Assinale a alternativa correta:
				
A) Nenhuma afirmação está correta.
B) Apenas V está correta.
C) Apenas I, II e IV estão corretas.
D) Todas as afirmações estão corretas.
E) N.D.A.( se nenhuma alternativa corresponder ao conjunto de afirmações corretas ).

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 2: Revisão de código - alternativa
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Objetivo: 
dividir uma programação complexa, em blocos menores,
cada parte deve ser simples o suficiente para ser incluída em uma
função ou procedimento interno e facilitar o uso.

Proposta: Validação de CPF
https://dicasdeprogramacao.com.br/algoritmo-para-validar-cpf/

Alguns algoritmos prontos, caso queiram brincar ou testar outras fontes:
https://www.dirceuresende.com/blog/validando-cpf-cnpj-e-mail-telefone-e-cep-no-sql-server/
https://dba-pro.com/como-validar-cpfs-e-cnpjs-no-sql-server/

Vamos usar como exemplo, um CPF fictício "529.982.247-25".
Validação formato:
	XXX.XXX.XXX-XX (14 chars ) -> XXXXXXXXXXX ( 11 números )
Validação excessões:
	Casos conhecidos '111.111.111-11' 
	CPFs de dígitos únicos são inválidos.
Validação do primeiro dígito
	5 * 10 + 2 * 9 + 9 * 8 + 9 * 7 + 8 * 6 + 2 * 5 + 2 * 4 + 4 * 3 + 7 * 2
	= 295 * 10 / 11 
	*resto = 2 -- OK
Validação do segundo dígito
	5 * 11 + 2 * 10 + 9 * 9 + 9 * 8 + 8 * 7 + 2 * 6 + 2 * 5 + 4 * 4 + 7 * 3 + 2 * 2
	= 347 * 10 / 11
	*resto = 5 --OK

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
Retirando chars não utilizados na validação
Validação formato:
	XXX.XXX.XXX-XX (14 chars ) -> XXXXXXXXXXX ( 11 números )

06) Seja a seguinte função que, receba um CPF e tenha o seguinte comportamento.
- Parâmetros de de entrada 
	deve ser de 14 chars XXX.XXX.XXX-XX
	ou 9 dígitos XXXXXXXXXXX
- Parâmetros de saida
	9 digitos XXXXXXXXXXX ( CPF sem os pontos e traços )

1	CREATE OR ALTER FUNCTION dbo.fn_limpaCPF ( @CPF CHAR(14) )
2	RETURNS CHAR(11)
3	AS BEGIN
4		SELECT @CPF = REPLACE(@CPF,'.','')
5		SELECT @CPF = REPLACE(@CPF,'-','')
6		RETURN @CPF
7	END
8	GO
9	DECLARE @CPF CHAR(11) = '529.982.247-25'
10	SELECT dbo.fn_limpaCPF(@CPF)

O que há de errado com a DECLARAÇÃO desta função ?
A)	Não há nada de errado com a função.
B)	A função declarou um tipo muito pequeno para receber o valor do CPF
C)	A função deveria ter removido primeiro o traço depois os pontos
D)	A função declarou um tipo muito pequeno para a devolução 
E)	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
07) Sejam as seguintes linhas, adicionadas para capturar os erros
de formato inválido, se o número de chars retornado pela função for diferente de 11 
OU de Dígitos inválidos, se ela não for composto por números.
DECLARE @CPF CHAR(255) = '529.982.247-25'
	IF ( len(dbo.fn_limpaCPF(@CPF)) <> 11 ) 
		THROW 50000, 'Formato inválido',1
	IF ( ISNUMERIC(dbo.fn_limpaCPF(@CPF)) <> 1 ) 
		THROW 50001,'Dígitos inválidos',1

Este tratamento de erro faz o que se propõe a fazer ?
A)	Sim, as o retorno for uma string com mais ou menos de 11 chars, teremos erro de Formato Inválido e se ela não for composta de números de Dígitos inválidos.
B)	Parcialmente, a função LEN não funciona para casos em que que o CPF é maior do que 11 chars. 
C)	Parcialmente, a função ISNUMERIC deveria ser substituida por um CONVERT(INT,...)
D)	Não, nenhuma das verificações de erro entrega o que promete.
E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
Validação excessões:
	Casos conhecidos '111.111.111-11' 
	CPFs de dígitos únicos são inválidos.

08) Como seria o cabeçalho de uma função que receberia um único char( Ex: '1' )
além de um CPF, e devolver, 1( true ) se todos os dígitos forem compostos 
por aquele número ou 0 ( false ) se nem todos os dígitos forem compostos 
por aquele número ? De forma que:
select dbo.fn_validaExcessoes('1','111.111.111-11' ) --devolva 1
select dbo.fn_validaExcessoes('2','111.111.111-11' ) --devolva 0

A) CREATE FUNCTION fn_validaExcessoes ( @char VARCHAR(11) ) AS
B) CREATE OR ALTER FUNCTION fn_validaExcessoes ( @CPF CHAR(11) ) RETURNS CHAR(14) AS
C) CREATE FUNCTION fn_validaExcessoes ( @char(1) ) RETURNS BINARY AS
D) CREATE FUNCTION fn_validaExcessoes ( @char CHAR(1) ) RETURNS BIT AS
E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
Validação do primeiro dígito
	5 * 10 + 2 * 9 + 9 * 8 + 9 * 7 + 8 * 6 + 2 * 5 + 2 * 4 + 4 * 3 + 7 * 2
	= 295 * 10 / 11 
	*resto = 2 -- OK

09) Preciso de uma função que, dado um CPF, calcule o primeiro dígito 
verificador, temos em mãos o seguinte código:
CREATE FUNCTION fn_calculaPrimeiroDigito ( @CPF CHAR(11) )
RETURNS INT AS
BEGIN
	DECLARE @retorno INT
	SELECT @retorno = 
		  CONVERT(INT,SUBSTRING(@CPF,1,1)) * 10 
		+ CONVERT(INT,SUBSTRING(@CPF,2,1)) * 9 
		+ CONVERT(INT,SUBSTRING(@CPF,3,1)) * 8 
		+ CONVERT(INT,SUBSTRING(@CPF,4,1)) * 7 
		+ CONVERT(INT,SUBSTRING(@CPF,5,1)) * 6 
		+ CONVERT(INT,SUBSTRING(@CPF,6,1)) * 5 
		+ CONVERT(INT,SUBSTRING(@CPF,7,1)) * 4 
		+ CONVERT(INT,SUBSTRING(@CPF,8,1)) * 3 
		+ CONVERT(INT,SUBSTRING(@CPF,9,1)) * 2
	return (@retorno * 10) % 11
END
GO
DECLARE @CPF CHAR(14) = dbo.fn_limpaCPF('529.982.247-25')
select dbo.fn_calculaPrimeiroDigito(@CPF)

O que há de errado com essa função ?
A) Não há nada de errado com esta função, ela devolve o que é esperado.
B) Ela apresentou o erro: Já existe um objeto com nome 'fn_calculaPrimeiroDigito' no banco de dados. 	Portanto, deveria receber outro nome.
C) Ela não funciona para alguns exemplos de CPFs.
D) No cabeçalho, ela deveria receber um CHAR(14) pois a variável foi declarada como char(14), ou seja, a função está jogando fora 3 dígitos.
E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
Validação do segundo dígito
	5 * 11 + 2 * 10 + 9 * 9 + 9 * 8 + 8 * 7 + 2 * 6 + 2 * 5 + 4 * 4 + 7 * 3 + 2 * 2
	= 347 * 10 / 11
	*resto = 5 --OK

10) Preciso de uma função que, dado um CPF, calcule o segundo dígito 
verificador, temos em mãos o seguinte código:

CREATE OR ALTER FUNCTION fn_calculaSegundoDigito ( @CPF CHAR(11) )
RETURNS INT AS
BEGIN
	DECLARE @i TINYINT = 1, @retorno INT = 0
	WHILE (@i < 10)
	BEGIN
		SET @retorno += CONVERT(INT,SUBSTRING(@CPF,@i,1)) * (12-@i)
		SET @i+=1
	END
	return (@retorno * 10) % 11
END
GO
DECLARE @CPF CHAR(14) = dbo.fn_limpaCPF('529.982.247-25')
select dbo.fn_calculaSegundoDigito(@CPF)

O que há de errado com essa função ?
A) Não há nada de errado com esta função, ela devolve o que é esperado.
B) O WHILE parou 1 volta antes, deveria ser < 11 ( ou <= 10 ), este foi o único erro.
C) A multiplicação do segundo dígito é diferente do primeiro, pois uma começa no fator 11  (5 * 11 + 2 * 10)e a outra no 10 ( 5 * 10 + 2 * 9 ) Este foi o único erro.
D) O incremento do WHILE ( SET @i+=1 ) tem que ser adicionado antes da operação	Este foi o único erro.
E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
11) Unindo as funções de primeiro e segundo dígitos.

Como você usaria as duas funções criadas anteriormente,
DECLARE @CPF CHAR(14) = dbo.fn_limpaCPF('529.982.247-25')
IF....
PRINT 'VÁLIDO'
ELSE 
PRINT 'INVALIDO'

Complete a linha do IF com a alternativa correta:
A)	IF	SUBSTRING(@CPF,10,1) = dbo.fn_calculaPrimeiroDigito(@CPF)		OR SUBSTRING(@CPF,11,1) = dbo.fn_calculaSegundoDigito(@CPF)
B)	IF	SUBSTRING(@CPF,10,1) = dbo.fn_calculaPrimeiroDigito(@CPF)		AND SUBSTRING(@CPF,10,1) = dbo.fn_calculaPrimeiroDigito(@CPF)
C)	IF	SUBSTRING(@CPF,2,1) = dbo.fn_calculaPrimeiroDigito(@CPF)		AND SUBSTRING(@CPF,1,1) = dbo.fn_calculaSegundoDigito(@CPF)
D)	IF	SUBSTRING(@CPF,10,1) = dbo.fn_calculaPrimeiroDigito(@CPF)		AND SUBSTRING(@CPF,11,1) = dbo.fn_calculaSegundoDigito(@CPF)
E)	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
Agora preciso criar um procedimento que:
- receba um texto ( VARCHAR(255) )
- de erro se ele não passar nas validações de formato e dígitos
- seja tratado para perder os pontos e traços.
- calcule o primeiro e segundos dígitos.
- valide o CPF baseado nos cálculos gerados.
- devolva o texto 'válido' ou 'inválido' em um parâmetro de saída.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
12) Como ficaria o cabeçalho desta procedure ?

A) CREATE PROCEDURE pr_validaCPF ( @CPF VARCHAR(255), @retorno VARCHAR(255) OUTPUT )
B) CREATE PROCEDURE pr_validaCPF ( @CPF VARCHAR(255) ) RETURNS VARCHAR(255)
C) CREATE PROCEDURE pr_validaCPF ( @CPF VARCHAR(255), OUTPUT @retorno VARCHAR(255) )
D) CREATE FUNCTION pr_validaCPF ( @CPF VARCHAR(255), @retorno VARCHAR(255) OUTPUT )
E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--

13) Como seria a execução ( ou uso desta suposta procedure ) 
Assinale a alternativa correta;

A)	DECLARE @CPF VARCHAR(255) = '529.982.247-25'
	SELECT 'O CPF : '+ @CPF + ' é ' + dbo.pr_validaCPF( @CPF ) 

B)	DECLARE @CPF VARCHAR(255) = '529.982.247-25', @retorno VARCHAR(255) 
	EXEC pr_validaCPF @CPF, @retorno 
	SELECT 'O CPF : '+ @CPF + ' é ' + @retorno

C)	DECLARE @CPF VARCHAR(255) = '529.982.247-25', @retorno VARCHAR(255)
	EXEC pr_validaCPF @CPF, @retorno OUTPUT
	SELECT 'O CPF : '+ @CPF + ' é ' + @retorno

D)	DECLARE @CPF VARCHAR(255) = '529.982.247-25', @retorno VARCHAR(255) 
	EXEC pr_validaCPF @CPF OUTPUT, @retorno
	SELECT 'O CPF : '+ @CPF + ' é ' + @retorno

E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 3: Revisão de código - mão na massa
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Objetivo: 
Receber um conjunto de instruções menores e ser capaz de 
criar algo maior, mais complexo, porém completamente funcional.

/*
Esta não é uma questão alternativa, ou seja, exige a criação e 
apresentação do código, portanto, vale MUITO mais pontos que
as demais.
*/
14) Agora é sua vez de colocar a mão no código e concluir a procedure 
pr_validaCPF, crie-a usando como base nossas funções ( podem ignorar o 
código da questão 8, fn_validaExcessoes, que é apenas didático e não 
muito prático ), mas todos os demais podem ser usados....
Poste o código do create, assim como alguns exemplos de uso aqui.
OBRIGATÓRIO: testar e entregar o código com testes do seu próprio CPF....

