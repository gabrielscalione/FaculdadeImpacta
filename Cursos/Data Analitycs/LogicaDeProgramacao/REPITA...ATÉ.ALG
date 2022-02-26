Algoritmo "REPITA...ATÉ"
// 
//  
// Descrição   : LAÇO DE REPETICAO REPITA...ATÉ
// Autor(a)    : Nome do(a) aluno(a)
// Data atual  : 26/02/2022
Var
// Seção de Declarações das variáveis 
TipoImovel, Espera : CARACTERE
Kw: REAL
ValorIndustria, ValorComercio, ValorResidencia : REAL

inicio
// Seção de Comandos

ValorIndustria := 2.03
ValorComercio := 0.62
ValorResidencia := 0.62
//Inicialização da Variável que será usada como padrão para a repetição
TipoImovel := "S"
REPITA
ESCREVAL("CTJFL")
ESCREVAL("====================================================")
ESCREVAL("R - Residencial")
ESCREVAL("C - Comercial")
ESCREVAL("I - Industrial")
ESCREVAL("S - Sair")
ESCREVAL("====================================================")

 ESCREVA ("Digite o Tipo de Imóvel: ")
LEIA (TipoImovel)

 //ESCREVA("Digite a Quantidade Utilizada: ")
//LEIA(Kw)

 ESCOLHA (TipoImovel)
CASO "R"
ESCREVA("Digite a Quantidade Utilizada: ")
LEIA(Kw)
ESCREVAL("Valor à pagar: ", Kw * ValorResidencia)

 CASO "C"
ESCREVA("Digite a Quantidade Utilizada: ")
LEIA(Kw)
ESCREVAL("Valor à pagar: ", Kw * ValorComercio)
CASO "I"
ESCREVA("Digite a Quantidade Utilizada: ")
LEIA(Kw)
ESCREVAL("Valor à pagar: ", Kw * ValorIndustria)
OUTROCASO
ESCREVAL("opção Inválida!!!")
FIMESCOLHA


ESCREVA("Pressione Qualquer Tecla para Continuar")
LEIA(Espera)
LIMPATELA
ATE TipoImovel <> "S"

Fimalgoritmo