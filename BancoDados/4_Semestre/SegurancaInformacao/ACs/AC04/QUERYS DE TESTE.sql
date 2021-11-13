

select * from Replicante_Impacta.dbo.cliente
select * from ReplicanteImpacta2.dbo.cliente


INSERT INTO CLIENTE( nome, endereco) VALUES
('Chaves','Barril, 8'),
('Seu Madruga','Vila, 72')


/* PRINCIPAL */  SELECT * FROM   Replicante_Impacta.dbo.cliente
/* SECUNDARIO */ SELECT * FROM   [Secundario].ReplicanteImpactaSecundario.dbo.cliente 

--Insira uma linha nova no banco principal
	INSERT INTO Replicante_Impacta.dbo.cliente( nome, endereco) VALUES
	('TesteAC4','Seguranca')
	


Demonstre que os dois servidores ficaram atualizados e idênticos novamente
/* PRINCIPAL */  SELECT * FROM   Replicante_Impacta.dbo.cliente
/* SECUNDARIO */ SELECT * FROM   [Secundario].ReplicanteImpactaSecundario.dbo.cliente 


/*************************** TESTES FINALIZADOS COM SUCESSO ***************************/