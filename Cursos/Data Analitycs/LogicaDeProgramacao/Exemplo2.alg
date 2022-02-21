algoritmo "Exemplo Inicial"
// Função : Soma de 2 Números
// Autor : Tio Jorge
// Data : 12/02/2022
// Seção de Declarações 
var
PrimeiroValor, SegundoValor, Resultado : REAL // A variável Real Aceita Casas Decimais
ValorInteiro1, ValorInteiro2, Idade : INTEIRO // Esse tipo de variável não aceita Casas Decimais
Nome : CARACTERE
EhVelho : LOGICO // Só aceita VERDADEIRO ou FALSO como entrada

inicio
// Seção de Comandos 
    ESCREVA("Digite Seu Nome: ")
    LEIA(Nome)
    
    ESCREVA ("Digite Sua Idade: ")
    LEIA(Idade)
    
    SE Idade > 99 ENTAO
       EhVelho = Verdadeiro
    SENAO
       EhVelho := Falso
    FIMSE
    
    ESCREVA("Digite o Valor do Primeiro Número: ")

    LEIA(ValorInteiro1)

    ESCREVA("Digite o Valor do Segundo Número: ")
    LEIA(ValorInteiro2)
    
    Resultado := ValorInteiro1 + ValorInteiro2
    ESCREVAL("=================================================================================")
    ESCREVA(Nome, ", ", EhVelho, " O Resultado da Soma de ", ValorInteiro1," e ", ValorInteiro2, " é: ", Resultado)
fimalgoritmo
