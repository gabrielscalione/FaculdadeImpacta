/*
	3.DQL – Clausula SELECT com WHERE utilizando a tabela FILMES
*/
use ATIVIDADE_04
go

--	1. Liste todas as colunas da tabela onde o filme seja o seu favorito.
select * from filmes where Filme = 'Avengers: Endgame'

--  2. Liste todas as colunas que o ano é menor que 2000.
select * from filmes where Ano < 2000

--	3. Liste todas as colunas que o ano é maior ou igual 2010 e menor que 2015.
select * from filmes where Ano >= 2000 and Ano < 2015

--	4. Liste todas as colunas que a bilheteria_dolar é maior que 1.000.000.000 (1 bilhão).
select * from filmes where Bilheteria_dolar > 1000000000.00

--	5. Liste as colunas filme e ano, onde a bilheteria_dolar é menor que 1.000.000.000 e que o Ano seja maior que 2000.
select Filme, Ano from filmes where Bilheteria_dolar < 1000000000.00 and Ano > 2000

--	6. Liste as colunas filme, ano e bilheteria onde o distribuidor é igual Warner Bros. Pictures.
select Filme, Ano, Bilheteria_dolar from filmes where Distribuidor = 'Warner Bros. Pictures'

--	7. Liste todas as colunas da tabela onde o distribuidor é diferente de New Line Cinema.
select * from filmes where Distribuidor != 'New Line Cinema'

--	8. Liste todas as colunas da tabela onde o ano do filme é maior que o ano do seu nascimento.
select * from filmes where Ano > 1982

--	9. Liste todas as colunas da tabela onde os valores do distribuidor são NULOS.
select * from filmes where Distribuidor is NULL

--	10. Liste todos os filmes que o ranking seja maior que 50 e menor que 80 ou que o ano seja igual 2007.
select * from filmes where Ranking > 50 and Ranking < 80 or Ano = 2007

--  11. Liste as colunas filme, ano, distribuidor onde o Ano seja 1977 e o Distribuidor seja “20th Century Fox” ou Que o ano seja 1982 e que o distribuidor seja “Universal Pictures”.
select Filme, Ano, Distribuidor from filmes where Ano = 1977 and Distribuidor = '20th Century Fox' or Ano = 1982 and Distribuidor = 'Universal Pictures'