Algoritmo "COMBUSTIVEL"
// 
//  
// Descrição   : Aqui você descreve o que o programa faz! (função)
// Autor(a)    : Nome do(a) aluno(a)
// Data atual  : 26/02/2022
Var
// Seção de Declarações das variáveis 
Combustivel : CARACTERE
Litros, ValorGasolina, ValorAlcool,ValorDiesel : REAL

inicio
// Seção de Comandos

ValorGasolina := 10.06
ValorAlcool := 5.21
ValorDiesel := 3.87

ESCREVA("Posto de Gasolina do Tio Jorge ")
ESCREVAL("====================================================")
ESCREVAL("G - Gasolina -", ValorGasolina)
ESCREVAL("A - Álcool -", ValorAlcool)
ESCREVAL("D - Diesel -", ValorDiesel)
ESCREVAL("====================================================")
ESCREVA ("Digite o Tipo de Combustivel: ")
LEIA (Combustivel)

ESCREVA("Digite a Quantidade Abastecida: ")
LEIA(Litros)

ESCOLHA (combustivel)
CASO "G"
ESCREVAL("Valor à pagar: ", Litros * ValorGasolina)
CASO "A"
ESCREVAL("Valor à pagar: ", Litros * ValorAlcool)
CASO "D"
ESCREVAL("Valor à pagar: ", Litros * ValorDisel)
FIMESCOLHA
fimalgoritmo