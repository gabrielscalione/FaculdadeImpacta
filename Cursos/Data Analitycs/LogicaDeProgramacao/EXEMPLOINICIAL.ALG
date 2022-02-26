Algoritmo "ExemploInicial"
// Descrição   :  Soma de 2 numeros
// Autor(a)    : Gabriel S. Scalione
// Data atual  : 12/02/2022
Var
// Seção de Declarações das variáveis 
primeiroValor, segundoValor, resultado : REAL // Variavel real aceita casas decimais
valorInteiro1, valorInteiro2 : INTEIRO // Esse tipo não aceita casas decimais

Inicio
// Seção de Comandos, procedimento, funções, operadores, etc... 
   ESCREVA("Digite o valor do primeiro numero: ")
   LEIA(primeiroValor)

   ESCREVA("Digite o valor do primeiro numero: ")
   LEIA(segundoValor)
   
   resultado := primeiroValor + segundoValor
   
   ESCREVAL("=============================================")
   ESCREVAL("Resultado da Soma de ", primeiroValor," e ",segundoValor," é: ", resultado)

Fimalgoritmo