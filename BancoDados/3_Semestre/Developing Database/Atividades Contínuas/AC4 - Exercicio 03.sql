USE ImpactaEstacionamento
	GO 

	CREATE OR ALTER PROCEDURE sp_cadastraCliente 
	( @nomeCliente VARCHAR(50)		= NULL
	, @cpf VARCHAR(50)				= NULL
	, @telefone  VARCHAR(20)		= NULL
	, @ehProfessor bit				= 0
	)AS BEGIN

		-- LIMPA CPF
		SET @cpf = REPLACE(REPLACE(REPLACE(@cpf,' ', '' ),'.',''),'-','')
		
		-- VERIFICA SE O CLIENTE JÁ EXISTE
		IF EXISTS( SELECT 1 FROM cliente3 WHERE cpf = @cpf)
		BEGIN

			-- SENDO VERDADEIRA INFORMA A MENSAGEM COM O ID
			select 'CPF já esteja cadastrado, id: ' + cast(id as char) from cliente3 WHERE cpf = @cpf
		END
		ELSE
		BEGIN
			-- SENDO FALSO INSERE O NOVO CLIENTE 
			insert into cliente3 (nome, cpf, telefone, professor)
			VALUES (@nomeCliente, @cpf, @telefone, @ehProfessor)

			-- E INFORMA A MENSAGEM COM O ID DO NOVO CLIENTE
			select 'Cadastrado do cliente realizado, id: ' + cast(id as char) from cliente3 WHERE cpf = @cpf

		END -- FIM DO IF

	END -- FIM DA PROCEDURE

	-- TESTES
	EXEc sp_cadastraCliente 'Luzia Emily da Silva','891.197.860-42','(86) 3953-8373',1
	EXEc sp_cadastraCliente 'Levi Jorge Ian dos Santos','335.763.580-13','(83) 99193-5152',1
	EXEc sp_cadastraCliente 'Marlene Sueli Rocha','167.075.828-10','(27) 99909-0357',0