
/*
BD_ADS_SI - 2S - LSQL - A04 - Create Table - Aula 17/08/2020
Exerc�cio 5
Um psic�logo infantil solicitou uma solu��o para ajudar as suas consultas. 
As tabelas abaixo, fazem parte da implementa��o.
Crie as tabelas no banco de dados
*/


CREATE TABLE CRIANCA
( 
	Matricula int IDENTITY (1, 1)
	, Nome VARCHAR(100)
	, Data datetime
	, Nome_mae varchar(100)
	, CONSTRAINT pkMatricula PRIMARY KEY (Matricula)
);


CREATE TABLE PET
( 
	Nome VARCHAR(100)
	, Crianca int not null
	, CONSTRAINT fkCrianca FOREIGN KEY (Crianca) REFERENCES CRIANCA(Matricula)
);


