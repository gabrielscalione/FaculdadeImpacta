/*coleto o id do ve�culo*/
/* SE o ve�culo j� est� cadastrado, ou seja, n�o � a primeira vez que ele
estaciona.
Basca buscar o id do ve�culo pela placa.
*/

IF EXISTS(SELECT 1 FROM veiculo WHERE placa = 'GHY6543')
BEGIN
	SELECT @idVeiculo = id FROM veiculo WHERE placa = 'GHY6543'
END

/*SEN�O, caso seja a primeira vez que ele estaciona, � necess�rio
estacionar o ve�culo
Como � um cliente horista, n�o preciso cadastrar um cliente ( apenas para
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