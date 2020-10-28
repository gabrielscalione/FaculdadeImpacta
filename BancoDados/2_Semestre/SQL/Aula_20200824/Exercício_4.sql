
/*
	4.DDL � Crie as tabelas abaixo com os tipos e constraint definidos pelo professor
*/

CREATE TABLE EMPRESA(
	  ID_EMPRESA INT NOT NULL IDENTITY
	, NOME_EMPRESA VARCHAR(200) NOT NULL UNIQUE
	, DATA_FUNDACAO DATE
	, PAIS VARCHAR(200) �
	, VALOR_MERCADO DECIMAL(18,2)
	, CONSTRAINT pkEMPRESA PRIMARY KEY(ID_EMPRESA)
)

CREATE TABLE VIDEO_GAME(
     ID_VIDEO_GAME INT NOT NULL IDENTITY 
   , NOME VARCHAR(300) NOT NULL
   , DATA_LANCAMENTO DATE
   , ANO_LANCAMENTO INT
   , VALOR_VENDA DECIMAL(10,2)
   , ID_EMPRESA INT NOT NULL 
   , CONSTRAINT pkVIDEO_GAME PRIMARY KEY (ID_VIDEO_GAME)
   , CONSTRAINT fkEmpresa FOREIGN KEY (ID_EMPRESA) REFERENCES  EMPRESA (ID_EMPRESA)
 )



