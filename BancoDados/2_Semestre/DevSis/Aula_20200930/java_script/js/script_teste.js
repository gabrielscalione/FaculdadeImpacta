// OBS: Javascript -> Python

// alert("Olá, mundo!");
// console.log("Olá, mundo!"); // print("Olá, mundo!")

// -----------------------------------------------------------------
// ---------------------- Tipos Basicos ----------------------------
// -----------------------------------------------------------------

// console.log(typeof(1.1)); //  number -> float ou double
// console.log(typeof(1)); // number ->int
// console.log(typeof("olá mundo!")); // string -> string
// console.log(typeof(true)); // boolean -> boolean
// console.log(typeof(false)); // boolean -> boolean
// console.log(typeof(null)); // null -> null
// console.log(typeof(undefined)); // undefined -> undefined

// -----------------------------------------------------------------
// ---------------------- Definir variáveis ------------------------
// -----------------------------------------------------------------

// let a = 2; // number
// console.log(typeof(a));
// a = a + 10;
// console.log(a);
// a = a - 100;
// console.log(a);
// a = a / 100;
// console.log(a);
// a = a * 100;
// console.log(a);

// let b = "2"; // string
// console.log(typeof(b));
// b = b + 10 + " olá mundo!";
// console.log(b);

// let c = "2020.999" 
// console.log(c);
// console.log(typeof(c)); // string

// let d = parseFloat(c);
// console.log(typeof(d)); // number -> float
// console.log(d);

// let e = parseInt(c);
// console.log(typeof(d)); // number -> int
// console.log(e);

// let c = "2020"
// console.log(c);
// console.log(typeof(c));

// let d = parseFloat(c);
// console.log(typeof(d));
// console.log(d);

// let e = parseInt(c);
// console.log(typeof(d));
// console.log(e);

// let c = 10.10;
// console.log(c + ' => ' + typeof(c));
// let d = c.toString(c);
// console.log(d + ' => ' + typeof(d));

// toString(); | parseInt(); | parseFloat();

// let c = true;
// console.log(c + ' => ' + typeof(c));
// let d = c.toString(c);
// console.log(d + ' => ' + typeof(d));

// let c = null;
// console.log(c + ' => ' + typeof(c));

// let d = undefined;
// console.log(d + ' => ' + typeof(d));

// -----------------------------------------------------------------
// ---------------------- Escopo de variáveis ----------------------
// -----------------------------------------------------------------

// tipos de definir uma variável: let var const

// 1. const
// const PI = 3.14159265359;
// let area_circulo = 2 * PI * 10 ** 2 // 2*PI*R²
// console.log(area_circulo);

// 2. let ("mínimo escopo possível") vs var ("variável global")
// let texto1 = "ola mundo 1";
// if (texto1 == "ola mundo 1"){
//     console.log(texto1); 
//     let a = 1;
//     a = a + 1;
// }
// console.log(a);  

// let texto1 = "ola mundo 1";
// if (texto1 == "ola mundo 1"){
//     console.log(texto1); 
//     var a = 1;
//     a = a + 1;
// }
// console.log(a);  

// let a = 10;
// let b = 20;
// // let c;
// // let d;
// if (a == 10){
//     console.log(`Valor a: ${a} e Valor b: ${b}`);
//     let c = 30; // var c = 30; 

//     if (c == 30){ 
//         let d = 40; // var d = 40; 
//         console.log(`Valor a: ${a} e Valor b: ${b}`);
//         console.log(`Valor c: ${c}`);

//     }else{
//         console.log(`Valor a: ${a} e Valor b: ${b}`);
//         console.log(`Valor c: ${c}`);
//     }

//     console.log(`Valor c: ${d}`);

// }else{
//     console.log(`Valor a: ${a} e Valor b: ${b}`);
// }

// console.log(`Valor a: ${a} e Valor b: ${b}`);
// console.log(`Valor c: ${c}`);

// -----------------------------------------------------------------
// ---------------------- Condicionais -----------------------------
// -----------------------------------------------------------------

// Python
// a = 10
// b = 50
// if a == 10:
//     print('ok1')
// elif a == 20:
//     print('ok2')
// elif a == 30:
//     print('ok3')
// elif a == 40:
//     print('ok4')
// elif ((a == 50) | (b == 60)):
//     print('ok5')
// elif ((a == 70) & (b == 80)):
//     print('ok6')
// elif ((a == 90) & (not (b == 100))):
//     print('ok6')
// elif ((a == 90) & (b != 100)):
//     print('ok6')
// else:
//     print('erro')

// python  ------> javascript
// &       ------> && (logica E)
// |       ------> || (logica OU)
// not     ------> ! (Negação)
// ==      ------> == (igual)
// !=      ------> != (diferente)
// <= , < , >=, > ------> <= , < , >=, >

// Javascript
// let a = 100;
// let b = 50;
// if (a == 10){
//     console.log("ok1");
// }else if (a == 20){
//     console.log("ok2");
// }else if (a == 30){
//     console.log("ok3");
// }else if (a == 40){
//     console.log("ok4");
// }else if ((a == 50) && (b == 60)){
//     console.log("ok5");
// }else if ((a == 70) || (b == 80)){
//     console.log("ok5");
// }else if ((a == 90) && !(b == 100)){
//     console.log("ok5");
// }else if ((a == 90) && (b != 100)){
//     console.log("ok5");
// }else{
//     console.log("erro");
// }

// -----------------------------------------------------------------
// ---------------------- Estruturas de repetição ------------------
// -----------------------------------------------------------------

// Python
// for i in range(0,10,1):
//     b = 10
//     print(f'Valor de i: {i} e valor de b: {b}')
//     # print('Valor de i: ' + str(i) + ' e valor de b: ' + str(b))
// Javascript
// for(let i = 0; i < 10; i++ ){
//     // let b = 10;
//     var b = 10; // usar var se queremos acessar essa variável fora do laço de repetição
//     console.log(`Valor de i: ${i} e valor de b: ${b}`);
//     // console.log('Valor de i: ' + i + ' e valor de b: ' + b);
// }
// console.log(b);

// Python
// for i in range(10,0,-1):
//     print(i)
// Javascript
// for(let i = 10; i > 0; i-- ){
//     console.log(`Valor de i: ${i}`);
// }

// Python
// i = 0
// while i < 10:
//     print(f'Valor de i: {i}')
//     i += 1 # i = i + 1  
// Javascript
// let i = 0;
// while (i < 10){
//     console.log(`Valor de i: ${i}`);
//     i ++; // i = i + 1;
// }

// Python
// i = 10
// while i > 0:
//     print(f'Valor de i: {i}')
//     i -= 1 # i = i - 1  
// Javascript
// let i = 10;
// while (i > 0){
//     console.log(`Valor de i: ${i}`);
//     i --; // i = i - 1;
// }

// Faça enquanto a < 10
// let a = 100;
// console.log(a);
// console.log(a*10);
// console.log(a*100);
// console.log(a*100);
// console.log(a*100);
// while(a < 10){
//     console.log(a);
//     console.log(a*10);
//     console.log(a*100);
//     console.log(a*100);
//     console.log(a*100);
//     a ++;
// }
// Faça até que b >= 10. 
// O "do while" sempre executa 1 vex antes de passar na condicional
// "do while" não tem equivalente no Python
// let b = 100;
// do {
//     console.log(b);
//     console.log(b*10);
//     console.log(b*100);
//     console.log(b*100);
//     console.log(b*100);
//     b ++;
// }while(b < 10);

// -----------------------------------------------------------------
// ---------------------- Funções ----------------------------------
// -----------------------------------------------------------------

// Python
// def funcao_soma(a,b):
//     return a + b
// res = funcao_soma(1,2)
// print(f'Resultado = {res}')
// Javascript
// function funcao_soma(a,b){
//     return a + b;
// }
// let res = funcao_soma(1,2);
// console.log(`Resultado = ${res}`);

// Python
// def teste(a,b):
//     print(f'Olá mundo, o valor de a é {a}')
//     return a + b;
// a = 10
// b = 20
// res = teste(a,b)
// print(f'Resultado = {res}')
// Javascript
// function teste(a,b){
//     console.log(`Olá mundo, o valor de a é ${a}`);
//     return a + b;
// }
// let a = 10;
// let b = 20;
// let res = teste(a,b);
// console.log(`Resultado = ${res}`);

// -----------------------------------------------------------------
// ---------------------- Arrays -----------------------------------
// -----------------------------------------------------------------

// Python
// a = ["olá","oi",1,4,"teste","olá mundo"] # Lista
// print(a)
// print(len(lista))
// print(lista[0])
// for i in a:
//     print(i)
// for i in a:
//     print(i)

// Javascript  
// let a = ["olá","oi",1,4,"teste","olá mundo"]; // array
// console.log(a); 
// console.log(a.length); 
// console.log(a[0]); 
// for(let i = 0; i < a.length;i++){
//     console.log(i); 
// }
// a.forEach((i) => {
//     console.log(i);
// });

// -----------------------------------------------------------------
// ---------------------- JSON -------------------------------------
// -----------------------------------------------------------------

// Python -> Dicionário
// a = {'nome':'kevin',
//     'idade':100,
//     'cidade':'SP'}
// print(a)
// print(a['nome'])
// print(a['idade'])
// print(a['cidade'])
// for chave in a.keys():
//     print(f'Chave: {chave} e valor: ${a[chave]}')

// Javascript -> JSON (JavaScript Object Notation)
// let a = {'nome':'kevin',
//         'idade':100,
//         'cidade':'SP'};
// console.log(a);
// console.log(a['nome']);
// console.log(a['idade']);
// console.log(a['cidade']);
// for(let chave in a){
//     console.log(`Chave: ${chave} e valor: ${a[chave]}`);
// }













