algoritmo "FUNCAO SOMA NUMERO"
// Função :  1) Escreva um algoritmo e crie, nele, uma função que receba um número
//              e retorne a soma dos números inteiros positivos e menores que o
//              número digitado. Se o número digitado for negativo ou nulo,
//              não chama a função e mostra uma mensagem de erro.
// Autor :
// Data : 05/03/2022
// Seção de Declarações
var
//Decalração das Variáveis Globais
Numero : INTEIRO
//Declaração das Funções
FUNCAO SomaNumero(NumeroInteiro: INTEIRO) : INTEIRO
      VAR
      //Declaração das variáveis Locais
      Contador, Soma : INTEIRO
      INICIO
         PARA Contador De 1 ATE NumeroInteiro FACA
            Soma := Soma + Contador
         FIMPARA
      RETORNE Soma
FIMFUNCAO
inicio
// Seção de Comandos
ESCREVA("Digite um Número Inteiro: ")
LEIA(Numero)

SE Numero <= 0 ENTAO
ESCREVAL("Número Inválido")
SENAO
ESCREVAL(SomaNumero(Numero))
FIMSE
fimalgoritmo
