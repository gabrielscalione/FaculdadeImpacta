/*coleto o id do veículo*/
/* SE o veículo já está cadastrado, ou seja, não é a primeira vez que ele
estaciona.
Basca buscar o id do veículo pela placa.
*/

IF EXISTS(SELECT 1 FROM veiculo WHERE placa = 'GHY6543')
BEGIN
	SELECT @idVeiculo = id FROM veiculo WHERE placa = 'GHY6543'
END

/*SENÃO, caso seja a primeira vez que ele estaciona, é necessário
estacionar o veículo
Como é um cliente horista, não preciso cadastrar um cliente ( apenas para
mensalistas )
*/
ELSE
BEGIN
	INSERT veiculo (tipo, placa, idcliente)
	VALUES ( 'moto', 'GHY6543', NULL )
END



--COM VARIAVEL

DECLARE @idVeiculo INT

SET @idVeiculo = (SELECT id FROM veiculo WHERE placa = 'GHY6543')

IF @idVeiculo IS NOT NULL
BEGIN
	SELECT @idVeiculo
END
ELSE
BEGIN
	INSERT veiculo (tipo, placa, idcliente)
	VALUES ( 'moto', 'GHY6543', NULL )
END