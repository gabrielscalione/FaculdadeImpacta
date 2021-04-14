--CRIACAO DO MODELO DATA WAREHOUSE

USE DW_BD_202101
GO

--Dimensão
CREATE TABLE Ano (
	
	sk_Ano SMALLINT NOT NULL IDENTITY,
	Ano SMALLINT NOT NULL,
	
	CONSTRAINT	pkAno PRIMARY KEY (sk_Ano)

)
--Dimensão
CREATE TABLE Curso (
	
	sk_Curso INT NOT NULL IDENTITY,
	Modalidade VARCHAR(30) NOT NULL,
	NomeCurso VARCHAR(255) NOT NULL,
	Turno VARCHAR (35) NOT NULL,

	CONSTRAINT pkCurso PRIMARY KEY (sk_Curso)

)

--Dimensão
CREATE TABLE Bolsa(
	sk_Bolsa INT NOT NULL IDENTITY,
	Bolsa NVARCHAR(30) NOT NULL,
	Porcentagem SMALLINT NOT NULL, -- Se nulo: Valores placeholders
	
	CONSTRAINT pkBolsa PRIMARY KEY (sk_Bolsa)

)

--Dimensão
CREATE TABLE InstituicaoEnsino(
	sk_InstituicaoEnsino INT NOT NULL IDENTITY,
	CodigoInstituicaoEnsino INT NOT NULL,
	NomeInstituicaoEnsino NVARCHAR(255) NOT NULL,
	
	CONSTRAINT pkInstituicaoEnsino PRIMARY KEY (sk_InstituicaoEnsino)

)

--Dimensão
CREATE TABLE Beneficiario(
	sk_Beneficiario INT NOT NULL IDENTITY,
	CPF	NVARCHAR(13) NOT NULL,
	Sexo NVARCHAR(13) NOT NULL,
	Raca NVARCHAR(13) NOT NULL,
	DataNascimento DATE NOT NULL,
	IndicadorDeficienteFisico NVARCHAR(13) NOT NULL,
	Regiao NVARCHAR(13) NOT NULL,
	Municipio NVARCHAR(100) NOT NULL,
	
	CONSTRAINT pkBeneficiario PRIMARY KEY (sk_Beneficiario)

)

-- Fato
CREATE TABLE ConcessaoBolsas(
	sk_ConcessaoBolsas INT NOT NULL IDENTITY,
	sk_Ano SMALLINT NOT NULL,
	sk_InstituicaoEnsino INT NOT NULL,
	sk_Bolsa INT NOT NULL,
	sk_Curso INT NOT NULL,
	sk_Beneficiario INT NOT NULL,

	CONSTRAINT pkConcessaoBolsas PRIMARY KEY (sk_ConcessaoBolsas),
	CONSTRAINT fkConcessaoBolsasAno FOREIGN KEY (sk_Ano)
			REFERENCES Ano(sk_Ano),
	CONSTRAINT fkConcessaoBolsasInstituicaoEnsino FOREIGN KEY (sk_InstituicaoEnsino)
			REFERENCES InstituicaoEnsino(sk_InstituicaoEnsino),
	CONSTRAINT fkConcessaoBolsasBolsa FOREIGN KEY (sk_Bolsa)
			REFERENCES Bolsa(sk_Bolsa),
	CONSTRAINT fkConcessaoBolsasCurso FOREIGN KEY (sk_Curso)
			REFERENCES Curso(sk_Curso),
	CONSTRAINT fkConcessaoBolsasBeneficiario FOREIGN KEY (sk_Beneficiario)
			REFERENCES Beneficiario(sk_Beneficiario),
)