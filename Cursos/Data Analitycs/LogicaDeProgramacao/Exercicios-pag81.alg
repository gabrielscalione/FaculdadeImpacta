algoritmo "EXERCICIOS"
// Função :
// Autor :
// Data : 19/02/2022
// Seção de Declarações 
var
  X, N, Quadrado, Soma, A, B, Area, Raio, Resultado : REAL
   Ano, Mes, Dia, Numero : INTEIRO

inicio
// Seção de Comandos 
// 1) Escreva um programa que leia dois valores A e B,
// calcule a soma entre eles e exiba o resultado para o usuário.

ESCREVA("=================================")
ESCREVAL
ESCREVAL("Exercicio 1")

ESCREVAL

ESCREVA("DIGITE O PRIMEIRO VALOR: ")
LEIA(A)
ESCREVA("DIGITE O SEGUNDO VALOR: ")
LEIA(B)

Soma := A + B

ESCREVAL("A Soma de",A," mais",B," é:", Soma)

// 2) Faça um programa que leia um número inteiro informado pelo usuário,
// calcule o seu quadrado e exiba o resultado para o usuário.
ESCREVAL
ESCREVA("=================================")
ESCREVAL
ESCREVAL("Exercicio 2")

ESCREVAL

ESCREVA("Digite um Numero: ")
LEIA(Numero)

Quadrado := Numero^2

ESCREVAL("O quadrado de",Numero," é:", Quadrado)

// 3) Sabendo que a fórmula para calcular a área de uma circunferência é A = pir^2
// , elabore um programa que leia o valor do raio da circunferência,
// calcule a área e exiba o resultado para o usuário.
ESCREVAL
ESCREVAL("=================================")
ESCREVAL("Exercicio 3")


ESCREVA("Digite o raio: ")
LEIA(Raio)

Area := (3.14* Raio)^2

ESCREVAL("A área do raio",Raio," é:", Area)

// 4) Faça um algoritmo que leia um valor X e um valor N,
// e calcule o produto de X por 2 elevado a N.
ESCREVAL
ESCREVAL("=================================")
ESCREVAL("Exercicio 4")


ESCREVA("Digite o valor de X: ")
LEIA(X)
ESCREVA("Digite o valor de N: ")
LEIA(N)

Resultado := (X*2)^N

ESCREVAL("o produto de",X," por 2 elevado a",N," é:", Resultado)

// 5) Faça um algoritmo que leia a idade de uma pessoa expressa em
// anos, meses e dias e exiba apenas em dias.
ESCREVAL
ESCREVA("=================================")
ESCREVAL
ESCREVAL("Exercicio 5")

ESCREVAL

ESCREVA("Digite o AnoMesDia que nasceu: ")
LEIA(Ano)
ESCREVA("Digite o Mês que nasceu: ")
LEIA(Mes)
ESCREVA("Digite o Dia que nasceu: ")
LEIA(Dia)



fimalgoritmo
