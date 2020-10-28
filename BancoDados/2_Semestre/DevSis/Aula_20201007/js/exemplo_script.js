            // let i = document.getElementById("nome");
            // console.log(i);
            // let nome = i.value;
            // console.log(nome);

            // let nome = document.getElementById("nome").value;
            // console.log(nome);

            // document.getElementById("nome").style.backgroundColor = "red";
            // document.getElementById("nome").style.border = "2px solid green";
            // document.getElementById("nome").style.color = "white";

            // let paragrafos = document.getElementsByClassName("classe_paragrafo");
            // console.log(typeof(paragrafos));
            // console.log(paragrafos.length);
            // for(let i = 0; i < paragrafos.length; i++){
            //     console.log(paragrafos[i]);
            // }
            // console.log(paragrafos[0]);
            // console.log(paragrafos[1]);
            // console.log(paragrafos[2]);

            // let paragrafos = document.getElementsByTagName("p");
            // console.log(typeof(paragrafos));
            // console.log(paragrafos.length);
            // for(let i = 0; i < paragrafos.length; i++){
            //     console.log(paragrafos[i]);
            // }
            // console.log(paragrafos[0]);
            // console.log(paragrafos[1]);
            // console.log(paragrafos[2]);

            // let paragrafos = document.getElementsByName("paragrafo");
            // console.log(typeof(paragrafos));
            // console.log(paragrafos.length);
            // for(let i = 0; i < paragrafos.length; i++){
            //     console.log(paragrafos[i]);
            //     if (i == 3){ // Paragrafo 4
            //         paragrafos[i].style.backgroundColor = "red";
            //     }
            // }
            // document.getElementById("p3").style.backgroundColor = "red";

            // console.log(paragrafos[0]);
            // console.log(paragrafos[1]);
            // console.log(paragrafos[2]);

            // document.getElementById("")
            // document.getElementsByTagName("")
            // document.getElementsByClassName("")
            // document.getElementsByName("")

            // document.getElementById("formulario1").onsubmit = function(){

            //     let cpf = document.getElementById("cpf").value;
            //     let idade = document.getElementById("idade").value;

            //     if (cpf == "" || idade == ""){
            //         alert("Campo obrigatário não preenchido!");
            //         return false
            //     }

            //     if (idade < 0 || idade > 120){
            //         alert("Campo idade inválido! Somente é permitido idades entre 0 e 120 anos");
            //         return false
            //     }

            //     if (cpf.length < 11){
            //         alert("Campo CPF inválido!");
            //         return false
            //     }
                
            //     return true
            // }

            function verificar_formulario(){

                let cpf = document.getElementById("cpf").value;
                let idade = document.getElementById("idade").value;

                if (cpf == "" || idade == ""){
                    alert("Campo obrigatário não preenchido!");
                    return false
                }

                if (idade < 0 || idade > 120){
                    alert("Campo idade inválido! Somente é permitido idades entre 0 e 120 anos");
                    return false
                }

                if (cpf.length < 11){
                    alert("Campo CPF inválido!");
                    return false
                }
                
                return true
            }

            function verificar_formulario2(){
                let formulario = document.getElementById("formulario1");
                let campos = formulario.getElementsByTagName("input");
                // let campos = document.getElementById("formulario1").childNodes;
                for(let i = 0;i < campos.length;i++){
                    if (campos[i] == ""){
                        return false
                    }
                }
                return true
            }
