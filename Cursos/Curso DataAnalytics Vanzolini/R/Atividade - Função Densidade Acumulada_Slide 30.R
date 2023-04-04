## Gabriel Serrano Scalione
#
# Atividade Função Densidade Acumulada_Slide 30
# Em uma população onde as medidas tem Média 100 e Desvio Padrão 5, determine a probabilidade de se ter uma medida.

  media <- 100
  desvio_padrao <- 5
  
  #------------------------------------------------------------------------
  
  # a) Entre 100 e 115:
  
    pnorm(115, media, desvio_padrao) - pnorm(100, media, desvio_padrao)
  
    # A resposta é 0.4986501, ou seja, há uma probabilidade de 49,86% de se ter uma medida entre 100 e 115.

  #------------------------------------------------------------------------
  
  # b) Entre 100 e 90:

    pnorm(100, media, desvio_padrao) - pnorm(90, media, desvio_padrao)
  
    # A resposta é 0.4772499, ou seja, há uma probabilidade de 47,72% de se ter uma medida entre 100 e 90.

  #------------------------------------------------------------------------
  
  # c) Superior a 110:
  
    1 - pnorm(110, media, desvio_padrao)
  
    # A resposta é 0.02275013, ou seja, há uma probabilidade de 2,27% de se ter uma medida superior a 110.

  #------------------------------------------------------------------------
  
  # d) Inferior a 95:

    pnorm(95, media, desvio_padrao)
  
    # A resposta é 0.1586553, ou seja, há uma probabilidade de 15,86% de se ter uma medida inferior a 95.

  #------------------------------------------------------------------------
  
  # e) Inferior a 105:
  
    pnorm(105, media, desvio_padrao)
    
    # A resposta é 0.8413447, ou seja, há uma probabilidade de 84,13% de se ter uma medida inferior a 105.

  #------------------------------------------------------------------------
  
  # f) Superior a 97:
  
    1 - pnorm(97, media, desvio_padrao)
  
    # A resposta é 0.7257469, ou seja, há uma probabilidade de 72,57% de se ter uma medida superior a 97.

  #------------------------------------------------------------------------
  
  # g) Entre 105 e 112:
  
  pnorm(112, media, desvio_padrao) - pnorm(105, media, desvio_padrao)

  # A resposta é 0.1504577, ou seja, há uma probabilidade de 15,04% de se ter uma medida entre 105 e 112.

  #------------------------------------------------------------------------
  
  # h) Entre 89 e 93:
  
  pnorm(93, media, desvio_padrao) - pnorm(89, media, desvio_padrao)

  # A resposta é 0.06685321, ou seja, há uma probabilidade de 6,68% de se ter uma medida entre 89 e 93.

  #------------------------------------------------------------------------
  
  # i) 98:
  
  pnorm(98, media, desvio_padrao) - pnorm(98, media, desvio_padrao)
  
  # A resposta é 0, ou seja, a probabilidade de se ter uma medida exatamente igual a 98 é zero.