algoritmo "semnome"
// Função :
// Autor :
// Data : 19/02/2022
// Seção de Declarações 
var
Bim1, Bim2, Bim3, Bim4, MediaS, MediaP, MediaM : REAL

//Declaração de Função - Trecho Automatizado de Código - Utilizado para evitar retrabalho
FUNCAO MediaSimples (Nota1, Nota2, Nota3, Nota4: REAL) : REAL
       VAR
       Resultado : REAL

       INICIO
       Resultado := (Nota1 + Nota2 + Nota3 + Nota4)/4

       //Retorno do Valor Calculado
       RETORNE Resultado
FIMFUNCAO

FUNCAO MediaPonderada (Nota1, Nota2, Nota3, Nota4: REAL) : REAL
       VAR
       Resultado : REAL

       INICIO
       Resultado := (Nota1 + Nota2 + Nota3 + Nota4)/4

       //Retorno do Valor Calculado
       RETORNE Resultado
FIMFUNCAO

FUNCAO MediaManual (Nota1, Nota2, Nota3, Nota4: REAL) : REAL
       VAR
       Resultado : REAL

       INICIO
       Resultado := (Nota1 + Nota2 + Nota3 + Nota4)/4

       //Retorno do Valor Calculado
       RETORNE Resultado
FIMFUNCAO


//Inicio do programa principal
inicio
// Seção de Comandos 

escreva("Exemplo de chamada de Procedimentos")
escrevaL("====================================================")

escreva("1 Bimestre: ")
leia(Bim1)

escreva("2 Bimestre: ")
leia(Bim2)

escreva("3 Bimestre: ")
leia(Bim3)

escreva("4 Bimestre: ")
leia(Bim4)

//Chamada de Funções
MediaS := MediaSimples(Bim1, Bim2, Bim3, Bim4)
MediaP := MediaPonderada(Bim1, Bim2, Bim3, Bim4)
MediaM := MediaManual(7.9, 8.8, 7.3, 1.0)

ESCREVAL

ESCREVAL("Media Simples: ", MediaS)
ESCREVAL("Media Ponderada: ", MediaP)
ESCREVAL("Media Manual: ", MediaM)

fimalgoritmo
