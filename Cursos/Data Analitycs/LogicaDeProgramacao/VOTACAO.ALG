Algoritmo "VOTACAO"
// 
//  
// Descrição   : Aqui você descreve o que o programa faz! (função)
// Autor(a)    : Nome do(a) aluno(a)
// Data atual  : 26/02/2022
Var
// Seção de Declarações das variáveis 
Voto : INTEIRO
TotalChapa1, TotalChapa2,TotalChapa3, TotalBrancos, TotalNulos, TotalVotos : REAL
PercentualChapa1,PercentualChapa2,PercentualChapa3,PercentualNulos,PercentualBrancos: REAL
Espera: CARACTER
inicio
// Seção de Comandos

REPITA
   ESCREVAL("STJE - Sistema Tio Jorge Eleitoral")
   ESCREVAL("==================================")
   ESCREVAL("1 - Chapa 1")
   ESCREVAL("2 - Chapa 2")
   ESCREVAL("3 - Chapa 3")
   ESCREVAL("4 - Brancos")
   ESCREVAL("5 - Nulos")
   ESCREVAL("0 - Encerrar Votacao")
   ESCREVAL("==================================")
   //Entrada de Votos
   LEIA (Voto)
   //Processamento de Votos
   ESCOLHA (Voto)
      CASO 1
      TotalChapa1 := TotalChapa1 + 1
      CASO 2
      TotalChapa2 := TotalChapa2 + 1
      CASO 3
      TotalChapa3 := TotalChapa3 + 1
      CASO 4
      TotalBrancos := TotalBrancos + 1
      CASO 5
      TotalNulos := TotalNulos + 1
   FIMESCOLHA
   TotalVotos := TotalVotos + 1
   LIMPATELA
ATE Voto = 0
//Cálculo da Votação

PercentualChapa1 := TotalChapa1 / TotalVotos
PercentualChapa2 := TotalChapa2 / TotalVotos
PercentualChapa3 := TotalChapa3 / TotalVotos
PercentualNulos := TotalNulos / TotalVotos
PercentualBrancos:= TotalBrancos / TotalVotos

 //Resultado da Apuração
LIMPATELA

ESCREVAL("Resultado da Apuração: Votos Registrados: ", TotalVotos)
ESCREVAL("==========================================================")
ESCREVAL("Chapa1 : ", TotalChapa1, " votos, ", PercentualChapa1, "% do Total de Votos")
ESCREVAL("Chapa2 : ", TotalChapa2, " votos, ", PercentualChapa2, "% do Total de Votos")
ESCREVAL("Chapa3 : ", TotalChapa3, " votos, ", PercentualChapa3, "% do Total de Votos")
ESCREVAL("Nulos : ", TotalNulos , " votos, ", PercentualNulos , "% do Total de Votos")
ESCREVAL("Brancos: ", TotalBrancos," votos, ", PercentualBrancos,"% do Total de Votos")
ESCREVAL("==========================================================")
ESCREVA("Pressione qualquer Tecla para Continuar...")
LEIA(Espera)

Fimalgoritmo