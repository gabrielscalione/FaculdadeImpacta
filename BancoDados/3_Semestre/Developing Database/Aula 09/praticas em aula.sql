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
/*Para verificar a capacidade máxima do estacionamento para aquele tipo de veículo*/
SELECT @capacidadeMaxima = dbo.fn_capacidadeMaxima (@nomeEstacionamento, @tipoVeiculo )


--conferência
select @capacidadeMaxima as capacidadeMaxima



/*Criação*/
CREATE OR ALTER PROCEDURE sp_capacidademaxima (@tipoVeiculo VARCHAR(50), @nomeEstacionamento VARCHAR(255), @capacidadeMaxima   INT output)
AS
begin
		SELECT @capacidadeMaxima = Iif(@tipoVeiculo = 'moto', capacidade_moto,capacidade_carro)
			FROM localidade
			WHERE identificacao = @nomeEstacionamento
		RETURN @capacidadeMaxima
end
go


--Seu código deu certo se isso rodar:
DECLARE @tipoVeiculo        VARCHAR(50) = 'moto',
        @nomeEstacionamento VARCHAR(255) = 'Faculdade Impacta - Paulista',
        @capacidadeMaxima   INT

/*Para verificar a capacidade máxima do estacionamento para aquele tipo de veículo*/
EXEC sp_capacidademaxima @nomeEstacionamento, @tipoVeiculo, @capacidadeMaxima OUTPUT

--conferência
SELECT @capacidadeMaxima AS LocataoAtual 