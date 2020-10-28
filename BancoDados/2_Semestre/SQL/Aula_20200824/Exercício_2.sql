/*
Exercício - 2.DQL – Clausula SELECT utilizando a tabela FILMES
*/
USE ATIVIDADE_04
GO

--1. Liste todas as colunas da tabela.
select * from filmes

--2. Liste apenas a coluna DISTRIBUIDOR, com os valores distintos.
select distinct DISTRIBUIDOR from filmes

--3. Crie uma coluna chamada “Bilheteria_real” com o valor da “Bilheteria_dolar” x 5.
select *, Bilheteria_real = Bilheteria_dolar*5 from filmes

--4. Liste apenas as colunas “Ano” e “Filme”.
select Ano, Filme from filmes

--5. Selecione apenas 5 registros da tabela.
select top 5 * from filmes

--6. Crie uma coluna calculada chamada “Custo_Filme” com o valor de 30% da “bilheteria_dolar”.
select *, Custo_Filme = Bilheteria_dolar*0.30 from filmes

--7. Crie uma coluna calculada chamada “Lucro” = “Custo_Filme” – “bilheteria_dolar”.
select *, Lucro =  Bilheteria_dolar*0.30 - Bilheteria_dolar from filmes

/*8. Liste apenas uma coluna chamada “filme_distribuidor” essa coluna deverá ser uma
	cadeia de caracteres contendo a concatenação da coluna Filme + “ foi distribuído pela
	empresa: “ + coluna Distribuidor.
*/
select filme_distribuidor = Filme + ' foi distribuído pela empresa: ' + Distribuidor from filmes






