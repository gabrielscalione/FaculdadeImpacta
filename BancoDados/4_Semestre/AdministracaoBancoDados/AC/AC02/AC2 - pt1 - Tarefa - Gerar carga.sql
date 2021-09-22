INSERT INTO Consulta (ID_Paciente, ID_Medico, Numero_Sala, DataHora, Duracao )
SELECT	(select top 1 paciente.id from paciente order by newid())
	,	(select top 1 medico.id from medico order by newid())
	,	(select top 1 sala.numero from sala order by newid())
	,	(dateadd(minute,(convert(int,rand()*2553)%4)*15,
			dateadd(hour, (convert(int,rand()*2553)%8)+8,
				convert(datetime
					,dateadd(day,-1*convert(int,rand()*1000),convert(date,getdate()) )
				)
			)
		 )
		) 
	, ((convert(int,rand()*2553)%2)+1)*15
GO 1000000000
		


