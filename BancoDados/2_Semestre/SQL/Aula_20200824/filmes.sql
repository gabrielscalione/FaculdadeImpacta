
USE ATIVIDADE_04
GO
 
/****** Object:  Table [dbo].[filmes]    Script Date: 22/08/2020 13:10:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[filmes](
    [Id_filme] int identity (100,100) PRIMARY KEY,
	[Ranking] [smallint]  NOT NULL UNIQUE,
	[Ano] [smallint] NOT NULL,
	[Filme] [varchar](200)  NOT NULL,
	[Distribuidor] [varchar](200)   NULL,
	[Bilheteria_dolar] [decimal](28, 2) NOT NULL
) ON [PRIMARY]
 
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (1, 2019, N'Avengers: Endgame', N'Walt Disney Studios Motion Pictures', CAST(2797800564 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (2, 2009, N'Avatar', N'20th Century Fox', CAST(2789679794 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (3, 1997, N'Titanic', N'Paramount Pictures / 20th Century Fox', CAST(2187463944 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (4, 2015, N'Star Wars: The Force Awakens', N'Walt Disney Studios Motion Pictures', CAST(2068223624 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (5, 2018, N'Avengers: Infinity War', N'Walt Disney Studios Motion Pictures', CAST(2048359754 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (6, 2015, N'Jurassic World', N'Universal Pictures', CAST(1671713208 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (7, 2019, N'The Lion King', N'Walt Disney Studios Motion Pictures', CAST(1656943394 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (8, 2012, N'Marvel''s The Avengers', N'Walt Disney Studios Motion Pictures', CAST(1518812988 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (9, 2015, N'Furious 7', N'Universal Pictures', CAST(1516045911 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (10, 2019, N'Frozen II', N'Walt Disney Studios Motion Pictures', CAST(1450022173 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (11, 2015, N'Avengers: Age of Ultron', N'Walt Disney Studios Motion Pictures', CAST(1405403694 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (12, 2018, N'Black Panther', N'Walt Disney Studios Motion Pictures', CAST(1346913161 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (13, 2011, N'Harry Potter and the Deathly Hallows – Part 2', null, CAST(1341693157 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (14, 2017, N'Star Wars: The Last Jedi', N'Walt Disney Studios Motion Pictures', CAST(1332539889 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (15, 2018, N'Jurassic World: Fallen Kingdom', N'Universal Pictures', CAST(1308497944 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (16, 2013, N'Frozen', N'Walt Disney Studios Motion Pictures', CAST(1276480335 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (17, 2017, N'Beauty and the Beast', N'Walt Disney Studios Motion Pictures', CAST(1263521126 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (18, 2018, N'Incredibles 2', N'Walt Disney Studios Motion Pictures', CAST(1242803968 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (19, 2017, N'The Fate of the Furious', N'Universal Pictures', CAST(1236005118 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (20, 2013, N'Iron Man 3', null, CAST(1214811252 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (21, 2015, N'Minions', N'Universal Pictures', CAST(1159398397 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (22, 2016, N'Captain America: Civil War', N'Walt Disney Studios Motion Pictures', CAST(1153304495 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (23, 2018, N'Aquaman', N'Warner Bros. Pictures', CAST(1148161807 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (24, 2019, N'Spider-Man: Far From Home', N'Sony Pictures Releasing', CAST(1131927996 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (25, 2019, N'Captain Marvel', N'Walt Disney Studios Motion Pictures', CAST(1128274794 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (26, 2011, N'Transformers: Dark of the Moon', N'Paramount Pictures', CAST(1123794079 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (27, 2003, N'The Lord of the Rings: The Return of the King', N'New Line Cinema', CAST(1119929521 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (28, 2012, N'Skyfall', N'Sony Pictures Releasing', CAST(1108561013 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (29, 2014, N'Transformers: Age of Extinction', N'Paramount Pictures', CAST(1104054072 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (30, 2012, N'The Dark Knight Rises', N'Warner Bros. Pictures', CAST(1084939099 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (31, 2019, N'Joker', N'Warner Bros. Pictures', CAST(1074251311 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (32, 2019, N'Star Wars: The Rise of Skywalker', N'Walt Disney Studios Motion Pictures', CAST(1074144248 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (33, 2019, N'Toy Story 4', N'Walt Disney Studios Motion Pictures', CAST(1073394593 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (34, 2010, N'Toy Story 3', N'Walt Disney Studios Motion Pictures', CAST(1066969703 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (35, 2006, N'Pirates of the Caribbean: Dead Man''s Chest', N'Walt Disney Studios Motion Pictures', CAST(1066179725 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (36, 2016, N'Rogue One: A Star Wars Story', N'Walt Disney Studios Motion Pictures', CAST(1056057273 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (37, 2019, N'Aladdin', N'Walt Disney Studios Motion Pictures', CAST(1050693953 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (38, 2011, N'Pirates of the Caribbean: On Stranger Tides', N'Walt Disney Studios Motion Pictures', CAST(1045713802 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (39, 2017, N'Despicable Me 3', N'Universal Pictures', CAST(1034799409 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (40, 1993, N'Jurassic Park', N'Universal Studios', CAST(1029153882 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (41, 2016, N'Finding Dory', N'Walt Disney Studios Motion Pictures', CAST(1028570889 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (42, 1999, N'Star Wars: Episode I – The Phantom Menace', N'20th Century Fox', CAST(1027044677 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (43, 2010, N'Alice in Wonderland', N'Walt Disney Studios Motion Pictures', CAST(1025467110 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (44, 2016, N'Zootopia', N'Walt Disney Studios Motion Pictures', CAST(1023784195 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (45, 2012, N'The Hobbit: An Unexpected Journey', N'Warner Bros. Pictures', CAST(1017003568 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (46, 2008, N'The Dark Knight', N'Warner Bros. Pictures', CAST(1004934033 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (47, 2001, N'Harry Potter and the Philosopher''s Stone', N'Warner Bros. Pictures', CAST(975051288 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (48, 2013, N'Despicable Me 2', N'Universal Pictures', CAST(970761885 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (49, 1994, N'The Lion King', N'Walt Disney Studios Motion Pictures', CAST(968483777 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (50, 2016, N'The Jungle Book', N'Walt Disney Studios Motion Pictures', CAST(965550600 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (51, 2007, N'Pirates of the Caribbean: At World''s End', N'Walt Disney Studios Motion Pictures', CAST(963420425 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (52, 2017, N'Jumanji: Welcome to the Jungle', N'Sony Pictures Releasing', CAST(962077546 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (53, 2010, N'Harry Potter and the Deathly Hallows – Part 1', N'Warner Bros. Pictures', CAST(960431568 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (54, 2013, N'The Hobbit: The Desolation of Smaug', N'Warner Bros. Pictures', CAST(958366855 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (55, 2014, N'The Hobbit: The Battle of the Five Armies', N'Warner Bros. Pictures', CAST(956019788 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (56, 2003, N'Finding Nemo', N'Walt Disney Studios Motion Pictures', CAST(940335536 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (57, 2007, N'Harry Potter and the Order of the Phoenix', N'Warner Bros. Pictures', CAST(940018451 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (58, 2009, N'Harry Potter and the Half-Blood Prince', N'Warner Bros. Pictures', CAST(934546568 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (59, 2002, N'The Lord of the Rings: The Two Towers', N'New Line Cinema', CAST(926047111 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (60, 2004, N'Shrek 2', N'DreamWorks', CAST(928760770 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (61, 2018, N'Bohemian Rhapsody', N'20th Century Fox', CAST(903655259 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (62, 2005, N'Harry Potter and the Goblet of Fire', N'Warner Bros. Pictures', CAST(897099794 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (63, 2007, N'Spider-Man 3', N'Columbia Pictures', CAST(890871626 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (64, 2009, N'Ice Age: Dawn of the Dinosaurs', N'20th Century Fox', CAST(886686817 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (65, 2015, N'Spectre', N'Sony Pictures Releasing', CAST(880674609 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (66, 2017, N'Spider-Man: Homecoming', N'Sony Pictures Releasing', CAST(880166924 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (67, 2002, N'Harry Potter and the Chamber of Secrets', N'Warner Bros. Pictures', CAST(879225135 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (68, 2012, N'Ice Age: Continental Drift', N'20th Century Fox', CAST(877244782 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (69, 2016, N'The Secret Life of Pets', N'Universal Pictures', CAST(875457937 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (70, 2016, N'Batman v Superman: Dawn of Justice', N'Warner Bros. Pictures', CAST(873634919 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (71, 2001, N'The Lord of the Rings: The Fellowship of the Ring', N'New Line Cinema', CAST(871530324 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (72, 2017, N'Wolf Warrior 2', N'Beijing Jingxi Culture & Tourism Company', CAST(870325439 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (73, 2013, N'The Hunger Games: Catching Fire', N'Lionsgate Films', CAST(865011746 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (74, 2017, N'Guardians of the Galaxy Vol. 2', N'Walt Disney Studios Motion Pictures', CAST(863756051 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (75, 2015, N'Inside Out', N'Walt Disney Studios Motion Pictures', CAST(857611174 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (76, 2018, N'Venom', N'Columbia Pictures', CAST(856085151 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (77, 2017, N'Thor: Ragnarok', N'Walt Disney Studios Motion Pictures', CAST(853977126 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (78, 2005, N'Star Wars: Episode III – Revenge of the Sith', N'20th Century Fox', CAST(848754768 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (79, 2009, N'Transformers: Revenge of the Fallen', N'Paramount Pictures', CAST(836303693 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (80, 2012, N'The Twilight Saga: Breaking Dawn – Part 2', N'Summit Entertainment', CAST(829746820 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (81, 2010, N'Inception', N'Warner Bros. Pictures', CAST(828322032 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (82, 2017, N'Wonder Woman', N'Warner Bros. Pictures', CAST(821847012 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (83, 2002, N'Spider-Man', N'Columbia Pictures', CAST(821708551 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (84, 1996, N'Independence Day', N'20th Century Fox', CAST(817400891 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (85, 2016, N'Fantastic Beasts and Where to Find Them', N'Warner Bros. Pictures', CAST(814037575 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (86, 2017, N'Coco', N'Walt Disney Studios Motion Pictures', CAST(807082196 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (87, 2007, N'Shrek the Third', N'Paramount Pictures', CAST(798958162 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (88, 2004, N'Harry Potter and the Prisoner of Azkaban', N'Warner Bros. Pictures', CAST(796907323 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (89, 2019, N'Jumanji: The Next Level', N'Sony Pictures Releasing', CAST(795985511 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (90, 2017, N'Pirates of the Caribbean: Dead Men Tell No Tales', N'Walt Disney Studios Motion Pictures', CAST(794861794 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (91, 1982, N'E.T. the Extra-Terrestrial', N'Universal Pictures', CAST(792910554 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (92, 2018, N'Mission: Impossible – Fallout', N'Paramount Pictures', CAST(791115104 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (93, 2013, N'Fast & Furious 6', N'Universal Pictures', CAST(788679850 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (94, 2009, N'2012', N'Sony Pictures Releasing', CAST(788550900 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (95, 2008, N'Indiana Jones and the Kingdom of the Crystal Skull', N'Paramount Pictures', CAST(786636033 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (96, 2018, N'Deadpool 2', N'20th Century Fox', CAST(785046920 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (97, 2004, N'Spider-Man 2', N'Sony Pictures Releasing', CAST(783766341 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (98, 2016, N'Deadpool', N'20th Century Fox', CAST(783112979 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (99, 1977, N'Star Wars', N'20th Century Fox', CAST(775512064 AS Decimal(28, 0)))
GO
INSERT [dbo].[filmes] ([Ranking], [Ano], [Filme], [Distribuidor], [Bilheteria_dolar]) VALUES (100, 2014, N'Guardians of the Galaxy', N'Walt Disney Studios Motion Pictures', CAST(772776600 AS Decimal(28, 0)))
GO
