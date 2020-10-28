/*
BD_ADS_SI - 2S - LSQL - A03 - Tipos de Dados - Aula 17/08/2020
Exercício 2
	A partir da execução do script fornecido pelo professor, retorne os seguintes resultados da tabela Funcionario:
	1 - Retorne Nome e Email dos 5 primeiros registros
	2 - Traga o nome e sobrenome, concatenados em uma única coluna com o apelido Nome Completo
	3 - Traga a matricula, nome, sobrenome, salario, bonus e campo calculado salario + Bonus com o apelido Salário Total
*/


-- 1 --

SELECT TOP 5
	NOME,
	EMAIL
FROM funcionarios


-- 2 --

SELECT
	NOME + ' ' + SOBRENOME AS NOME_COMPLETO
FROM funcionarios

-- 3 --
SELECT
	MATRICULA, 
	NOME,
	SOBRENOME,
	SALARIO, 
	BONUS,
	SALARIO_TOTAL = SALARIO + BONUS
FROM funcionarios
