algoritmo "Exemplo Inicial"
// Função : Soma de 2 Números
// Autor : Tio Jorge
// Data : 12/02/2022
// Seção de Declarações 
var
PrimeiroValor, SegundoValor, Resultado : REAL // A variável Real Aceita Casas Decimais
ValorInteiro1, ValorInteiro2 : INTEIRO // Esse tipo de variável não aceita Casas Decimais

inicio
// Seção de Comandos
    ESCREVA("Digite o Valor do Primeiro Número: ")
    LEIA(PrimeiroValor)

    ESCREVA("Digite o Valor do Segundo Número: ")
    LEIA(SegundoValor)
    
    Resultado := PrimeiroValor + SegundoValor
    ESCREVAL("=================================================================================")
    ESCREVA("O Resultado da Soma de ", PrimeiroValor," e ", SegundoValor, " é: ", Resultado)
fimalgoritmo
