

CREATE VIEW VW_TABELAO_POP_TEMPO_MODAL
AS
	SELECT distinct
		pm.UF,
		pm.Pop_2010,
		dm.DIVISAO_MODAL,
		cast(dm.PERC_2010 as float) as PERC_UTILIZACAO,
		cast(tm.TEMPO_2010 as float) as TEMPO_MEDIO
	FROM 
		populacao_municipios pm
		inner join divisao_modal_municipios dm
			on dm.CD_UF = pm.COD_UF
		inner join tempo_medio_municipios tm
			on tm.CD_UF = pm.COD_UF