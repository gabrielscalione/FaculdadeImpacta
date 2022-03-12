Algoritmo "Exercícios Vetores e Matrizes"
// 
//  
// Descrição   : Aqui você descreve o que o programa faz! (função)
// Autor(a)    : Nome do(a) aluno(a)
// Data atual  : 05/03/2022
Var
// Seção de Declarações das variáveis 
VetorFunc : VETOR[1..15] de CARACTER
VetorSalario : VETOR [1..15] de REAL
MatrizNumero : VETOR[1..5, 1..5] de INTEIRO

VetorJogadores : VETOR[1..11] de CARACTER

Contador, Linha, Coluna : INTEIRO

Inicio
// Seção de Comandos, procedimento, funções, operadores, etc... 



//1) Escreva um algoritmo que leia os nomes de 15 funcionários de uma fábrica e
//os seus respectivos salários e os armazene em dois vetores diferentes.
//Em seguida, exiba uma lista com o nome e o salário de cada um.

PARA Contador DE 1 ATE 15 FACA

  ESCREVA ("Digite o nome do ",Contador, "º: ")
  LEIA(VetorFunc[Contador])
   
  ESCREVA ("Digite o seu salário: ")
  LEIA(VetorSalario[Contador])
   
FIMPARA

PARA Contador DE 1 ATE 15 FACA

  ESCREVAL (VetorFunc[Contador], " Salario: ", VetorSalario[Contador])

FIMPARA

//2) Escreva um algoritmo que leia os elementos (números inteiros) de uma
//matriz de 5 linhas e 5 colunas e os exiba.

PARA Linha DE 1 ATE 5 FACA

     PARA Coluna DE 1 ATE 5 FACA

         ESCREVA("Digite o valor na posição ",Linha," -", Coluna, ": ")
         LEIA(MatrizNumero[Linha,Coluna])

     FIMPARA
     
FIMPARA

ESCREVAL("==========================================")

ESCREVAL ("Valores da Matriz")
PARA Linha DE 1 ATE 5 FACA
      
     PARA Coluna DE 1 ATE 5 FACA

         ESCREVA ( MatrizNumero[Linha,Coluna])

     FIMPARA

     ESCREVAL

FIMPARA


//3) Multiplique os elementos da matriz que você construiu no exercício anterior
// por 10 e os exiba.

PARA Linha DE 1 ATE 5 FACA

     PARA Coluna DE 1 ATE 5 FACA

         ESCREVA("Digite o valor na posição ",Linha," -", Coluna, ": ")
         LEIA(MatrizNumero[Linha,Coluna])

     FIMPARA

FIMPARA

ESCREVAL("==========================================")

ESCREVAL ("Valores da Matriz")
PARA Linha DE 1 ATE 5 FACA

     PARA Coluna DE 1 ATE 5 FACA

         ESCREVA ( MatrizNumero[Linha,Coluna])

     FIMPARA

     ESCREVAL

FIMPARA


//4) Escreva um algoritmo que armazene e mostre os nomes dos 11 jogadores titulares
//de 5 times de futebol.

PARA Linha DE 1 ATE 5 FACA

     PARA Coluna DE 1 ATE 5 FACA

         ESCREVA("Digite o valor na posição ",Linha," -", Coluna, ": ")
         LEIA(MatrizNumero[Linha,Coluna])

     FIMPARA

FIMPARA


//5) Escreva um algoritmo que armazene valores inteiros em uma matriz 3 x 4 e
//calcule e mostre a média aritmética dos valores digitados.




Fimalgoritmo