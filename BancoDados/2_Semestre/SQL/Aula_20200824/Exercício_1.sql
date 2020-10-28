/*
1.Criação de Base de dados e execução de scripts no SQL SERVER
	1. Crie uma nova base de dados chamada ATIVIDADE_04
	2. Através do comando USE, altere a base de dados para a base ATIVIDADE_04
	3. Crie uma variável chamada “filme_favorito” do tipo Varchar, com no máximo 200
	caracteres. Atribua o nome do seu filme favorito a essa variável.
	4. Crie uma variável chamada “Ano_Filme” do tipo Int, com o ano de lançamento do seu
	filme favorito.
	5. Crie uma variável chamada “Idade_Filme” do tipo int, atribua a essa variável a
	diferença entre o Ano atual e o Ano_filme.
	6. Exiba o valor das variáveis através do comando PRINT.
	7. Execute o script filmes.sql na base de dados ATIVIDADE_04
	8. Na aba “Pesquisador de objetos” se certifique que a tabela “filmes” foi criada

	CREATE DATABASE ATIVIDADE_04
	GO

*/


USE ATIVIDADE_04
GO

DECLARE	@filme_favorito varchar(200) = 'Pulp Fiction: Tempo de Violência'
DECLARE @Ano_Filme int = 1994 
DECLARE @Idade_Filme int = YEAR(GETDATE()) - @Ano_Filme

print(@Filme_Favorito)
print(@Ano_Filme)
print(@Idade_Filme)

