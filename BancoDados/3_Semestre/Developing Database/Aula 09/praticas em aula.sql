CREATE OR ALTER FUNCTION fn_capacidadeMaxima  ( @nomeEstacionamento VARCHAR(255), @tipoVeiculo VARCHAR(50))
RETURNS INT
as BEGIN
	DECLARE @capacidadeMaxima INT
		SELECT @capacidadeMaxima = Iif(@tipoVeiculo = 'moto', capacidade_moto,capacidade_carro)
		FROM localidade
		WHERE identificacao = @nomeEstacionamento
	RETURN @capacidadeMaxima
END
GO


DECLARE @tipoVeiculo VARCHAR(50) = 'moto'
, @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista'
, @capacidadeMaxima INT
/*Para verificar a capacidade m�xima do estacionamento para aquele tipo de ve�culo*/
SELECT @capacidadeMaxima = dbo.fn_capacidadeMaxima (@nomeEstacionamento, @tipoVeiculo )


--confer�ncia
select @capacidadeMaxima as capacidadeMaxima



/*Cria��o*/
CREATE OR ALTER PROCEDURE sp_capacidademaxima (@tipoVeiculo VARCHAR(50), @nomeEstacionamento VARCHAR(255), @capacidadeMaxima   INT output)
AS
begin
		SELECT @capacidadeMaxima = Iif(@tipoVeiculo = 'moto', capacidade_moto,capacidade_carro)
			FROM localidade
			WHERE identificacao = @nomeEstacionamento
		RETURN @capacidadeMaxima
end
go


--Seu c�digo deu certo se isso rodar:
DECLARE @tipoVeiculo        VARCHAR(50) = 'moto',
        @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista',
        @capacidadeMaxima   INT

/*Para verificar a capacidade m�xima do estacionamento para aquele tipo de ve�culo*/
EXEC sp_capacidademaxima @nomeEstacionamento, @tipoVeiculo, @capacidadeMaxima OUTPUT

--confer�ncia
SELECT @capacidadeMaxima AS LocataoAtual 