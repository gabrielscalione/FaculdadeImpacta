Algoritmo "KW POR IMOVEL"
// 
//  
// Descrição   : Programa usando LAÇO DE REPETICAO ENQUANTO
// Autor(a)    : Nome do(a) aluno(a)
// Data atual  : 26/02/2022
Var
// Seção de Declarações das variáveis 
Kw: REAL
ValorIndustria, ValorComercio, ValorResidencia: REAL
TipoImovel, Espera: CARACTER

Inicio
// Seção de Comandos, procedimento, funções, operadores, etc... 

ValorIndustria := 2.03
ValorComercio  := 0.62
ValorResidencia := 0.62


TipoImovel := "R"
ENQUANTO TipoImovel <> "S" FACA
   ESCREVAL("CTJFL")
   ESCREVAL("=======================================")
   ESCREVAL("R - Residencia")
   ESCREVAL("C - Comercio")
   ESCREVAL("I - Industria")
   ESCREVAL("S - Sair")
   ESCREVAL("=======================================")
   
   ESCREVA("Digite o tipo de Imovel: ")
   LEIA(TipoImovel)
   
   ESCOLHA(TipoImovel)
      CASO "R"
           ESCREVA("Digite a quantidade utilizada: ")
           LEIA(Kw)
           ESCREVAL("Valor à pagar: ", Kw * ValorResidencia)
      CASO "C"
           ESCREVA("Digite a quantidade utilizada: ")
           LEIA(Kw)
           ESCREVAL("Valor à pagar: ", Kw * ValorComercio)
      CASO "I"
           ESCREVA("Digite a quantidade utilizada: ")
           LEIA(Kw)
           ESCREVAL("Valor à pagar: ", Kw * ValorIndustria)
      CASO "S"
           ESCREVAL("Encerrando...")
      OUTROCASO
           ESCREVAL("Opcao Invalida!!!")
   FIMESCOLHA
   
   ESCREVA("Pressione qualquer tecla para continuar....")
   LEIA(Espera)
LIMPATELA
FIMENQUANTO

Fimalgoritmo