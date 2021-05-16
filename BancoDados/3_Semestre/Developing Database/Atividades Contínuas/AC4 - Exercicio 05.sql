USE ImpactaEstacionamento
GO 

	CREATE OR ALTER PROCEDURE sp_cadastraCliente_v2
	( @nomeCliente VARCHAR(50)		= NULL
	, @cpf VARCHAR(50)				= NULL
	, @telefone  VARCHAR(20)		= NULL
	, @ehProfessor bit				= 0
	)AS BEGIN
		
		-- VARIAVEL PARA VERIFICAR SITUAÇAO DO CPF
		declare @validaCPF char(10)

		-- AJUSTA O CPF PARA FICAR NO PADRÃO CORRETO
		SET @cpf = dbo.fn_limpaCPF(@cpf)

		-- EXECUTA PROC PARA VALIDAR SE O CPF É VALIDO
		EXEC pr_validaCPF @CPF, @validaCPF OUTPUT

		-- VERIFICA SE O CPF É INVALIDO
		IF(@validaCPF like 'INV%LIDO')
		BEGIN
			-- SENDO VERDADEIRO EXIBE A MENSAGEM -1
			select -1 as mensagem
		END
		ELSE
		BEGIN

			-- SENDO FALSO, VERIFICA SE O CLIENTE JÁ EXISTE
			IF EXISTS( SELECT 1 FROM cliente3 WHERE cpf = @cpf)
			BEGIN
				-- SENDO VERDADEIRO, EXIBE MENSAGEM COM O ID DO CLIENTE
				select 'CPF já esteja cadastrado, id: ' + cast(id as char) as mensagem from cliente3 WHERE cpf = @cpf
			END
			ELSE
			BEGIN
				-- SENDO FALSO, INSERE O NOVO CLIENTE
				insert into cliente3 (nome, cpf, telefone, professor)
				VALUES (@nomeCliente, @cpf, @telefone, @ehProfessor)

				-- E EXIBE MENSAGEM COM O NOVO ID DO CLIENTE
				select 'Cadastrado do cliente realizado, id: ' + cast(id as char) as mensagem from cliente3 WHERE cpf = @cpf

			END -- FIM DO IF VERIFICARCLIENTE
		END -- FIM DO FI VERIFICA CPF
	END-- FIM DA PROCEDURE


	-- TESTES

	EXEc sp_cadastraCliente_v2 'Luzia Emily da Silva','197.860-42','(86) 3953-8373',1
	EXEc sp_cadastraCliente_v2 'Levi Jorge Ian dos Santos','asd.763.580-13','(83) 99193-5152',1
	EXEc sp_cadastraCliente_v2 'Marlene Sueli Rocha','167.075.828-99','(27) 99909-0357',0
