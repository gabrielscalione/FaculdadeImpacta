--Rode isso apenas uma vez
create database ac3;
GO
use ac3;


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Aula 10 - AC3 - Revis�o at� a aula 09
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
/*
Aula 08 - Transa��es, Erros: Gera��o, Captura e Tratamento de erros; Debug.
	Logs e rastreamento de erros.
	Debug de processos.
Aula 09 - Fun��es e procedimentos - parte 1
	Utiliza��o de procedures para controle de processos.
	Utiliza��o de fun��es para automatiza��o de processos de valida��o.
	Cria��o de fun��es para manipula��o de processos.
	Cria��o de procedimentos para manipula��o de processos.
Aula 10 - AC3 - Revis�o aulas 08 e 09
*/


--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 1: Revis�o Te�rica
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Objetivo: colocar em pr�tica �ltimos conceitos aprendidos
para facilitar o uso nas atividades a seguir

01) Sejam as seguintes afirma��es sobre transa��es:
	I		Transa��es Expl�citas s�o aquelas que o usu�rio 
			determina o in�cio ( BEGIN TRANSACTION ) 
			e termino ( COMMIT OU ROLLBACK TRANSACTION )
	II		Transa��es Impl�citas s�o aquelas que o sistema abre
			automaticamente quando alguns comandos ( CREATE, INSERT, etc )
			s�o executados, mas ainda precisam que o usu�rio as conclua 
	III		Transa��es autom�ticas s�o aquelas gerenciadas automaticamente
			pelo sistema ao redor de comandos transacionados, como o INSERT.
			Ou seja, n�o cabe ao usu�rio rodar nem o inicio nem o t�rmino.
	IV		Transa��es s�o a maneira que SGBDs utilizam 
			para garantir o ACID, ou seja, � a garantia de que as opera��es 
			devem ser At�micas, Consistentes, Isoladas e Dur�veis.
	V		Al�m do BEGIN, COMMIT e ROLLBACK outros comandos utilizados
			s�o o STOP( pausa em uma transa��o) e o RETURN (para retomar a transa��o)
	VI		Ao alinhar m�ltiplas transa��es ( NESTED TRANSACTIONS ) tenho que tomar
			cuidado pois qualquer ROLLBACK desfaz todas as transa��es em cascata.
Assinale a alternativa correta:

A) Apenas I, II e III s�o verdadeiras
B) Todas as alternativas s�o verdadeiras	
C) Apenas I, II, III, IV e VI s�o verdadeiras
D) Apenas I e IV s�o verdadeiras
E) N.D.A.( se nenhuma alternativa corresponder ao conjunto de afirma��es corretas ).

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
02) Sejam as seguintes afirma��es sobre Isolamento entre Processos.
		I		Quando dentro de uma transa��o, tudo que � utilizado � reservado
				( LOCK ) para indicar aos outros processos que voc� j� o est� usando
				e evitar que outros processos o utilizem.
		II		Quando dentro de uma transa��o voc� desejar utilizar um recurso
				j� reservado por outro processo, voc� recebe o que chamamos de BLOCK
				e fica na espera at� que aquele recurso fique liberado novamente.
		III		Para evitar problemas de concorr�ncia, o mais recomendado � manter
				as transa��es o mais curtas ou breve poss�veis, al�m de tentar 
				sempre afetar a menor quantidade de linhas poss�veis.
		IV		Uma transa��o pode conter in�meras intru��es, por�m, os �nicos 
				estados aceit�veis, considerados consistentes, s�o aqueles em que
				ou todas as intru��es rodaram, ou nenhuma intru��o rodou.
		V		Um dos objetivos de garantir o isolamento entre os processos � 
				dar a impress�o ou ilus�o aos usu�rios de que eles s�o os �nicos
				usu�rios a trabalhar simult�neamente no sistema.
Assinale a alternativa correta:

A) Apenas I e II s�o verdadeiras
B) Todas as afirma��es s�o verdadeiras
C) Apenas III e IV s�o verdadeiras
D) Apenas V � falsa.
E) N.D.A.( se nenhuma alternativa corresponder ao conjunto de afirma��es corretas ).

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
03) Sejam as seguintes afirma��es sobre Erros e tratamento de erros.
		I		Erro � a forma que o sistema utiliza para indicar que algo
				indevido aconteceu, orientando o usu�rio sobre as formas de 
				identific�-lo, reproduz�-lo ou corrig�-lo.
		II		Erros no MSSQL s�o categorizados em severidades, que v�o das 
				mais baixas, que englobam erros que podem ser corrigidos pelo 
				usu�rio �s mais altas, que s�o erros do sistema que s� podem 
				ser corrigidos por um administrador.
		III		Erros customizados ou personalisados podem ser criados para
				detalhar inconsist�ncias em processos ou sistemas utilizados 
				pelo usu�rio.
		IV		Erros podem ser capturados ( instru��o TRY ) 
				e tratados ( instru��o CATCH ) mesmo utilizando instru��es em SQL.
		V		Um dos maiores benef�cios do tratamento de erros �, al�m da devida 
				identifica��o dos erros, a capacidade de gerar logs e relat�rios 
				sobre processos de importa��o, que muitas vezes trazem excess�es
				ou erros no meio dos dados recebidos.
Assinale a alternativa correta:
				
A) Todas as afirma��es est�o corretas.
B) Apenas I e V est�o corretas.
C) Apenas II e III est�o corretas.
D) Nenhuma afirma��o est� correta.
E) N.D.A.( se nenhuma alternativa corresponder ao conjunto de afirma��es corretas ).

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
04) Sejam as seguintes afirma��es sobre fun��es em MSSQL.
		I		Fun��es s�o c�digos SQL encapsulados sob um nome, que pode ser 
				chamados m�ltiplas vezes, evitando ter que repetir grandes blocos
				de c�digo SQL m�ltiplas vezes.
		II		Existem v�rios tipos de fun��es, um destes � chamado fun��o escalar
				pois esta devolve apenas um �nico valor, e o tipo deste valor
				retornado tem que ser declarado no cabe�alho da fun��o.
		III		Fun��es podem receber par�metros de entrada, cada um deles
				deve ser declarado no cabe�alho da fun��o no formato de uma vari�vel
				com o respectivo tipo do dado que ser� recebido.
		IV		Uma vez criadas, as fun��es escalares podem ser chamadas como qualquer
				outra fun��o do sistema, podendo ser, inclusive, chamadas umas
				dentro de outras ( ou seja, uma fun��o chamando outra fun��o ).
		V		O nome das vari�veis dentro de uma fun��o n�o precisa ser o mesmo 
				do nome das vari�veis de quando ela � chamada, ou seja, o que 
				importa s�o os 'valores' passados para dentro e para fora.
Assinale a alternativa correta:

A) Apenas I, II, III e V s�o verdadeiras.
B) Apenas II � falsa.
C) Nenhuma afirma��o � falsa.
D) Todas as afirma��es s�o verdadeiras.
E) N.D.A.( se nenhuma alternativa corresponder ao conjunto de afirma��es corretas ).

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
05) Sejam as seguintes afirma��es sobre procedimentos armazenados em MSSQL.
		I		Exatamente igual �s fun��es, os procedimentos que devolvem 
				apenas um valor �nico s�o chamados de escalares e o tipo 
				deve ser declarado usando a instru��o RETURNS do cabe�alho.
		II		Assim como na intru��o INSERT, onde a cl�usula OUTPUT serve para 
				devolver o que foi inserido, a cl�usula OUTPUT na declara��o 
				de procedimentos � utilizada para devolver o que foi inserido
				nas tabelas por ela afetadas.
		III		Procedimentos obrigatoriamente existem a troca de par�metros 
				de entrada e sa�da, ou seja, n�o � poss�vel declarar uma procedure
				que n�o receba E nem devolva valores.
		IV		Da mesma forma que as fun��es, os procedimentos s�o chamados (usados)
				como quaisquer outras fun��es do sistema, podem ser usados dentro de 
				instru��es como SELECT ou mesmo um chamando o outro.
		V		Em procedimentos, diferente das fun��es, eu posso ter m�ltiplos 
				par�metros de sa�da, desde que cada um deles seja devidamente declarado
				no cabe�alho com a cl�usula OUTPUT.
Assinale a alternativa correta:
				
A) Nenhuma afirma��o est� correta.
B) Apenas V est� correta.
C) Apenas I, II e IV est�o corretas.
D) Todas as afirma��es est�o corretas.
E) N.D.A.( se nenhuma alternativa corresponder ao conjunto de afirma��es corretas ).

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 2: Revis�o de c�digo - alternativa
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Objetivo: 
dividir uma programa��o complexa, em blocos menores,
cada parte deve ser simples o suficiente para ser inclu�da em uma
fun��o ou procedimento interno e facilitar o uso.

Proposta: Valida��o de CPF
https://dicasdeprogramacao.com.br/algoritmo-para-validar-cpf/

Alguns algoritmos prontos, caso queiram brincar ou testar outras fontes:
https://www.dirceuresende.com/blog/validando-cpf-cnpj-e-mail-telefone-e-cep-no-sql-server/
https://dba-pro.com/como-validar-cpfs-e-cnpjs-no-sql-server/

Vamos usar como exemplo, um CPF fict�cio "529.982.247-25".
Valida��o formato:
	XXX.XXX.XXX-XX (14 chars ) -> XXXXXXXXXXX ( 11 n�meros )
Valida��o excess�es:
	Casos conhecidos '111.111.111-11' 
	CPFs de d�gitos �nicos s�o inv�lidos.
Valida��o do primeiro d�gito
	5 * 10 + 2 * 9 + 9 * 8 + 9 * 7 + 8 * 6 + 2 * 5 + 2 * 4 + 4 * 3 + 7 * 2
	= 295 * 10 / 11 
	*resto = 2 -- OK
Valida��o do segundo d�gito
	5 * 11 + 2 * 10 + 9 * 9 + 9 * 8 + 8 * 7 + 2 * 6 + 2 * 5 + 4 * 4 + 7 * 3 + 2 * 2
	= 347 * 10 / 11
	*resto = 5 --OK

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
Retirando chars n�o utilizados na valida��o
Valida��o formato:
	XXX.XXX.XXX-XX (14 chars ) -> XXXXXXXXXXX ( 11 n�meros )

06) Seja a seguinte fun��o que, receba um CPF e tenha o seguinte comportamento.
- Par�metros de de entrada 
	deve ser de 14 chars XXX.XXX.XXX-XX
	ou 9 d�gitos XXXXXXXXXXX
- Par�metros de saida
	9 digitos XXXXXXXXXXX ( CPF sem os pontos e tra�os )

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

O que h� de errado com a DECLARA��O desta fun��o ?
A)	N�o h� nada de errado com a fun��o.
B)	A fun��o declarou um tipo muito pequeno para receber o valor do CPF
C)	A fun��o deveria ter removido primeiro o tra�o depois os pontos
D)	A fun��o declarou um tipo muito pequeno para a devolu��o 
E)	N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
07) Sejam as seguintes linhas, adicionadas para capturar os erros
de formato inv�lido, se o n�mero de chars retornado pela fun��o for diferente de 11 
OU de D�gitos inv�lidos, se ela n�o for composto por n�meros.
DECLARE @CPF CHAR(255) = '529.982.247-25'
	IF ( len(dbo.fn_limpaCPF(@CPF)) <> 11 ) 
		THROW 50000, 'Formato inv�lido',1
	IF ( ISNUMERIC(dbo.fn_limpaCPF(@CPF)) <> 1 ) 
		THROW 50001,'D�gitos inv�lidos',1

Este tratamento de erro faz o que se prop�e a fazer ?
A)	Sim, as o retorno for uma string com mais ou menos de 11 chars, teremos erro de Formato Inv�lido e se ela n�o for composta de n�meros de D�gitos inv�lidos.
B)	Parcialmente, a fun��o LEN n�o funciona para casos em que que o CPF � maior do que 11 chars. 
C)	Parcialmente, a fun��o ISNUMERIC deveria ser substituida por um CONVERT(INT,...)
D)	N�o, nenhuma das verifica��es de erro entrega o que promete.
E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
Valida��o excess�es:
	Casos conhecidos '111.111.111-11' 
	CPFs de d�gitos �nicos s�o inv�lidos.

08) Como seria o cabe�alho de uma fun��o que receberia um �nico char( Ex: '1' )
al�m de um CPF, e devolver, 1( true ) se todos os d�gitos forem compostos 
por aquele n�mero ou 0 ( false ) se nem todos os d�gitos forem compostos 
por aquele n�mero ? De forma que:
select dbo.fn_validaExcessoes('1','111.111.111-11' ) --devolva 1
select dbo.fn_validaExcessoes('2','111.111.111-11' ) --devolva 0

A) CREATE FUNCTION fn_validaExcessoes ( @char VARCHAR(11) ) AS
B) CREATE OR ALTER FUNCTION fn_validaExcessoes ( @CPF CHAR(11) ) RETURNS CHAR(14) AS
C) CREATE FUNCTION fn_validaExcessoes ( @char(1) ) RETURNS BINARY AS
D) CREATE FUNCTION fn_validaExcessoes ( @char CHAR(1) ) RETURNS BIT AS
E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
Valida��o do primeiro d�gito
	5 * 10 + 2 * 9 + 9 * 8 + 9 * 7 + 8 * 6 + 2 * 5 + 2 * 4 + 4 * 3 + 7 * 2
	= 295 * 10 / 11 
	*resto = 2 -- OK

09) Preciso de uma fun��o que, dado um CPF, calcule o primeiro d�gito 
verificador, temos em m�os o seguinte c�digo:
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

O que h� de errado com essa fun��o ?
A) N�o h� nada de errado com esta fun��o, ela devolve o que � esperado.
B) Ela apresentou o erro: J� existe um objeto com nome 'fn_calculaPrimeiroDigito' no banco de dados. 	Portanto, deveria receber outro nome.
C) Ela n�o funciona para alguns exemplos de CPFs.
D) No cabe�alho, ela deveria receber um CHAR(14) pois a vari�vel foi declarada como char(14), ou seja, a fun��o est� jogando fora 3 d�gitos.
E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
Valida��o do segundo d�gito
	5 * 11 + 2 * 10 + 9 * 9 + 9 * 8 + 8 * 7 + 2 * 6 + 2 * 5 + 4 * 4 + 7 * 3 + 2 * 2
	= 347 * 10 / 11
	*resto = 5 --OK

10) Preciso de uma fun��o que, dado um CPF, calcule o segundo d�gito 
verificador, temos em m�os o seguinte c�digo:

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

O que h� de errado com essa fun��o ?
A) N�o h� nada de errado com esta fun��o, ela devolve o que � esperado.
B) O WHILE parou 1 volta antes, deveria ser < 11 ( ou <= 10 ), este foi o �nico erro.
C) A multiplica��o do segundo d�gito � diferente do primeiro, pois uma come�a no fator 11  (5 * 11 + 2 * 10)e a outra no 10 ( 5 * 10 + 2 * 9 ) Este foi o �nico erro.
D) O incremento do WHILE ( SET @i+=1 ) tem que ser adicionado antes da opera��o	Este foi o �nico erro.
E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
11) Unindo as fun��es de primeiro e segundo d�gitos.

Como voc� usaria as duas fun��es criadas anteriormente,
DECLARE @CPF CHAR(14) = dbo.fn_limpaCPF('529.982.247-25')
IF....
PRINT 'V�LIDO'
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
- de erro se ele n�o passar nas valida��es de formato e d�gitos
- seja tratado para perder os pontos e tra�os.
- calcule o primeiro e segundos d�gitos.
- valide o CPF baseado nos c�lculos gerados.
- devolva o texto 'v�lido' ou 'inv�lido' em um par�metro de sa�da.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--
12) Como ficaria o cabe�alho desta procedure ?

A) CREATE PROCEDURE pr_validaCPF ( @CPF VARCHAR(255), @retorno VARCHAR(255) OUTPUT )
B) CREATE PROCEDURE pr_validaCPF ( @CPF VARCHAR(255) ) RETURNS VARCHAR(255)
C) CREATE PROCEDURE pr_validaCPF ( @CPF VARCHAR(255), OUTPUT @retorno VARCHAR(255) )
D) CREATE FUNCTION pr_validaCPF ( @CPF VARCHAR(255), @retorno VARCHAR(255) OUTPUT )
E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=--

13) Como seria a execu��o ( ou uso desta suposta procedure ) 
Assinale a alternativa correta;

A)	DECLARE @CPF VARCHAR(255) = '529.982.247-25'
	SELECT 'O CPF : '+ @CPF + ' � ' + dbo.pr_validaCPF( @CPF ) 

B)	DECLARE @CPF VARCHAR(255) = '529.982.247-25', @retorno VARCHAR(255) 
	EXEC pr_validaCPF @CPF, @retorno 
	SELECT 'O CPF : '+ @CPF + ' � ' + @retorno

C)	DECLARE @CPF VARCHAR(255) = '529.982.247-25', @retorno VARCHAR(255)
	EXEC pr_validaCPF @CPF, @retorno OUTPUT
	SELECT 'O CPF : '+ @CPF + ' � ' + @retorno

D)	DECLARE @CPF VARCHAR(255) = '529.982.247-25', @retorno VARCHAR(255) 
	EXEC pr_validaCPF @CPF OUTPUT, @retorno
	SELECT 'O CPF : '+ @CPF + ' � ' + @retorno

E) N.D.A.

--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
--=X=-- Parte 3: Revis�o de c�digo - m�o na massa
--=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- --=X=-- 
Objetivo: 
Receber um conjunto de instru��es menores e ser capaz de 
criar algo maior, mais complexo, por�m completamente funcional.

/*
Esta n�o � uma quest�o alternativa, ou seja, exige a cria��o e 
apresenta��o do c�digo, portanto, vale MUITO mais pontos que
as demais.
*/
14) Agora � sua vez de colocar a m�o no c�digo e concluir a procedure 
pr_validaCPF, crie-a usando como base nossas fun��es ( podem ignorar o 
c�digo da quest�o 8, fn_validaExcessoes, que � apenas did�tico e n�o 
muito pr�tico ), mas todos os demais podem ser usados....
Poste o c�digo do create, assim como alguns exemplos de uso aqui.
OBRIGAT�RIO: testar e entregar o c�digo com testes do seu pr�prio CPF....

