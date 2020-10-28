 
GO
/****** Object:  Table [dbo].[funcionarios]    Script Date: 07/08/2020 19:29:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[funcionarios](
	[NOME] [varchar](7) NULL,
	[SOBRENOME] [varchar](9) NULL,
	[EMAIL] [varchar](28) NULL,
	[MATRICULA] [smallint] PRIMARY KEY,
	[SALARIO] [real] NULL,
	[BONUS] [smallint] NULL,
	[CARGO] [varchar](20) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Gilmar', N'Santos', N'GilmarSantos@grupo.com.br', 1010, 3000, 140, N'Consultor Comercial')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Felipe', N'Silva', N'FelipeSilva@grupo.com.br', 1011, 3000, 140, N'Tecnico de Xerox')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Nestor', N'Fernandes', N'NestorFernandes@grupo.com.br', 1012, 3000, 140, N'Sapateiro ')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Eduardo', N'Faustino', N'EduardoFaustino@grupo.com.br', 1013, 3000, 140, N'Sapateiro ')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Catia', N'Rocha', N'CatiaRocha@grupo.com.br', 1014, 3000, 140, N'Consultor Comercial')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Carla', N'Santos', N'CarlaSantos@grupo.com.br', 1015, 3000, 140, N'Tecnico de Xerox')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Carlos', N'Lima', N'CarlosLima@grupo.com.br', 1016, 3000, 140, N'Advogado')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Juan', N'Agostino', N'JuanAgostino@grupo.com.br', 1017, 2000, 140, N'Advogado')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Cassio', N'Ramo', N'CassioRamo@grupo.com.br', 1018, 2000, 140, N'Consultor Comercial')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Jonas', N'Bianco', N'JonasBianco@grupo.com.br', 1019, 2000, 140, N'Consultor Comercial')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Linda', N'Pereira', N'LindaPereira@grupo.com.br', 1020, 2000, 700, N'Consultor Comercial')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Emi', N'Limo', N'EmiLimo@grupo.com.br', 1021, 2000, 700, N'Consultor Comercial')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Jana', N'Russi', N'JanaRussi@grupo.com.br', 1022, 2000, 700, N'Advogado')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Carla', N'Gomes', N'CarlaGomes@grupo.com.br', 1023, 2000, 700, N'Professor ')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Lucia', N'Russo', N'LuciaRusso@grupo.com.br', 1024, 2000, 700, N'Analista de Sistemas')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Felipe', N'Rosa', N'FelipeRosa@grupo.com.br', 1025, 2000, 700, N'Analista de Sistemas')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Lorena', N'Sanches', N'LorenaSanches@grupo.com.br', 1026, 2000, 140, N'Analista de Sistemas')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Pamela', N'Gaspar', N'PamelaGaspar@grupo.com.br', 1027, 2000, 140, N'Analista de Sistemas')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Caio', N'Neto', N'CaioNeto@grupo.com.br', 1028, 1000, 700, N'Analista de Sistemas')
INSERT [dbo].[funcionarios] ([NOME], [SOBRENOME], [EMAIL], [MATRICULA], [SALARIO], [BONUS], [CARGO]) VALUES (N'Sergio', N'Castro', N'SergioCastro@grupo.com.br', 1029, 1000, 700, N'Analista de Sistemas')
GO
