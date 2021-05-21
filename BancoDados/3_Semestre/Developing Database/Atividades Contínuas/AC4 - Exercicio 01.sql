
	USE ImpactaEstacionamento
	GO 

	CREATE OR ALTER PROCEDURE sp_cadastraContratoMensalidade
	( @localidade VARCHAR(50)	= NULL
	, @cliente VARCHAR(50)		= NULL
	, @categoria VARCHAR(50)	= NULL
	, @diaUtil int				= NULL
	, @duracaoContrato int		= NULL
	)AS BEGIN
		--DECLARA AS VARIAVEIS QUE SERAO UTILIZADAS
		declare @idCategoria int
		, @idPlano int
		, @idLocalidade int
		, @idCliente int
		, @dataContratacao datetime 
		, @dataEncerramento datetime 
		, @dataVencimento datetime
		, @diaVencimento tinyint
		, @valor decimal(10,2)
		, @idContrato int
		, @mes tinyint
		, @recebido bit
		, @dataPagamento datetime
		, @multa decimal(10,2)


		-- DEFINE AS DATAS
		set @dataContratacao = getdate()
		set @dataEncerramento = dateadd(month, @duracaoContrato, getdate())

		-- IDENTIFICA ID DO PLANO E O VALOR
		select @idPlano = pl.id,
			   @valor	= pl.valor
		from categoriaPlano ca
			  inner join  plano pl 	on pl.idCategoria = ca.id
		where ca.nome = @categoria
		
		-- IDENTIFICA O ID DO CLIENTE
		select @idCliente = id from cliente where nome = @cliente

		-- DEFINE O DIA ÚTIL DE VENCIMENTO
		EXEC sp_vencimentoemDiasUteis_v2 @dataContratacao, @diaUtil, @dataVencimento OUTPUT
		SELECT @diaVencimento = DATEPART(day, @dataVencimento)  
		
		-- INSERE OS DADOS NA TABELA CONTRATO
		INSERT INTO contrato (idPlano, idCliente, diaVencimento, dataContratacao, dateEncerramento)
			VALUES (@idPlano, @idCliente, @diaVencimento, @dataContratacao, @dataEncerramento)
		
		-- IDENTIFICA QUAL É O ID DO CONTRATO NOVO
		select @idContrato = @@IDENTITY
		

		-- CALCULA OS PRÓXIMOS VENCIMENTOS E INSERE EM UMA TABELA TEMPORÁRIA
		CREATE TABLE #DatasVencimento (dia DATE)
		INSERT INTO #DatasVencimento
		EXEC sp_calculaDatasVencimento @diaUtil, @duracaoContrato
		

		-- INSERE OS PRÓXIMOS VENCIMENTOS COM O VALOR, MULTA SE EXISTIR, NA TABELA MENSALIDADE
		INSERT INTO mensalidade
		SELECT @idContrato as idContrato, 
				month(@dataVencimento) as mes , 
				1 as recebido, 
				@dataVencimento as dataVencimento, 
				dia as dataPagamento, 
				@valor as valorRecebido, 
				0.00 as multa 
		from #DatasVencimento

		-- EXIBE OS PRÓXIMOS VENCIMENTOS
		select dia, @valor as valor from #DatasVencimento

		-- APAGA A TABELA TEMPORARIA 
		DROP TABLE #DatasVencimento 
	END	

	
	-- TESTE EXECUTANDO A PROCEDURE
	Exec sp_cadastraContratoMensalidade 'Faculdade Impacta - Paulista','Almir dos Santos','Mensalista Professor',5,6
	
	-- EXIBE OS CADASTROS
	select * from contrato
	select * from mensalidade