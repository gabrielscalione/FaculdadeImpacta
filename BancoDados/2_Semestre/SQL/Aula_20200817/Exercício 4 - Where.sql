
/*
BD_ADS_SI - 2S - LSQL - A03 - Tipos de Dados - Aula 17/08/2020
Exerc�cio 4
	A partir da execu��o do script fornecido pelo professor, retorne os seguintes resultados da tabela Funcionario:
		1 - Liste os cargos distintos que s�o diferentes de �Consultor Comercial�
		2 - Liste o nome, cargo, salario e o campo calculado com acr�scimo de 7% do sal�rio com o apelido de Sal�rio_Diss�dio
		3 - Liste o nome, cargo, salario, Sal�rio Diss�dio quando o Sal�rio_Diss�dio for maior que 2000 e menor ou igual 3000.
		4 - Liste cargo, salario distintos que o salario seja menor que 2.000 ou que o cargo seja �Analista de Sistemas� 
*/

-- 1 --
SELECT DISTINCT	CARGO
FROM  FUNCIONARIOS
WHERE CARGO != 'CONSULTOR COMERCIAL'

-- 2 --
SELECT NOME, CARGO, SALARIO, SALARIO*1.007 SALARIO_DISSIDIO
FROM FUNCIONARIOS

-- 3 --
SELECT NOME, CARGO, SALARIO, SALARIO*1.007 SALARIO_DISSIDIO
FROM FUNCIONARIOS
WHERE 
	SALARIO*1.007 > 2000 AND SALARIO*1.007 < = 3000 
	--SALARIO*1.007 BETWEEN 2000 AND 3000

-- 4 --
SELECT DISTINCT CARGO, SALARIO
FROM FUNCIONARIOS
WHERE SALARIO < 2000
OR CARGO = 'ANALISTA DE SISTEMAS'
 