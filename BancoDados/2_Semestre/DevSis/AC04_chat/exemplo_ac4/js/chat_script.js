 // Javascript nativo                         -> Javacript com Jquery
// document.getElementById("id")             -> $('#id')
// document.getElementsByClassName("classe") -> $('.classe')
// document.getElementsByTagName("tag")      -> $('tag')

// Javascript nativo                                          -> Javacript com Jquery
// document.getElementById("id").value                        -> $('#id').val()
// document.getElementById("id").style.backgroudColor = "red" -> $('#id').css('backgroud-color','red')
// document.getElementById("id").value = "valor"              -> $('#id').val("valor")

// Javascript nativo
// function criar(){
//     let paragrafo_novo = document.createElement("p");
//     paragrafo_novo.innerText = "dssdds";
//     document.getElementById("paragrafos").appendChild(paragrafo_novo);
// };
//Javacript com Jquery
// function criar_com_jquery(){
//     $('#paragrafos').append('<p> dssdds </p>');
// };

var total_msg = 0; 
var total_msg_copia = 0; 
$('.botao_pessoa').on('click',function(){
    let valor_botao = $(this).val();
    let tipo = valor_botao.split('-')[0];
    let num_pessoa = valor_botao.split('-')[1];
    if (tipo == 'enviar'){
        let msg = $('#mensagem'+num_pessoa).val();
        if (msg != ""){
            // Principal
            $('.msg'+num_pessoa).append(`
                <div id="${total_msg+1}_div" style="display:inline-block;float:right;background-color:#25D366;" class ="div_msg">
                    <span id='${total_msg+1}' class='texto_msg' onclick="deletar('${total_msg+1}');"> <b> ${$('#legend'+num_pessoa).text()}: </b>${msg}</span>
                    <div class='op_deletar' id='${total_msg+1}-deletar'>
                    </div>
                </div>
                <br id="&{total_msg+1}_br">
            `);

            // Copia para a outra pessoa
            if (num_pessoa == 1){
                $('.msg2').append(`
                    <div id="${total_msg_copia+1}_copia_div" style="display:inline-block;float:left;background-color:#EEEEEE;" class ="div_msg">
                        <span id='${total_msg_copia+1}_copia' class='texto_msg_copia' onclick="deletar_copia('${total_msg_copia+1}_copia');">${$('#legend1').text()}: ${msg}</span>
                        <div class='op_deletar' id='${total_msg_copia+1}_copia-deletar'>
                        </div>
                    </div>
                    <br id="&{total_msg_copia+1}_copia_br">
                `);

            }else if (num_pessoa == 2){
                $('.msg1').append(`
                <div id="${total_msg_copia+1}_copia_div" style="display:inline-block;float:left;background-color:#EEEEEE;" class ="div_msg">
                        <span  id='${total_msg_copia+1}_copia' class='texto_msg_copia' onclick="deletar_copia('${total_msg_copia+1}_copia');">${$('#legend2').text()}: ${msg}</span>
                        <div class='op_deletar' id='${total_msg_copia+1}_copia-deletar'>
                        </div>
                    </div>
                    <br id="&{total_msg_copia+1}_copia_br">
                `);
            }
            $('#mensagem'+num_pessoa).val('');
            total_msg ++; // total_msg = total_msg + 1;
            total_msg_copia ++; // total_msg_copia = total_msg_copia + 1;
            
        }
    }else if (tipo == 'limpar'){
        $('#mensagem'+num_pessoa).val('');
    }
});

function deletar(id){
    $(`#${id}-deletar`).append(`
        <span id='um' onclick="deletar_um('${id}');">Deletar</span> | <span id='todos' onclick="deletar_todos('${id}');"> Deletar para todos</span>
    `);
};

function deletar_copia(id){
    $(`#${id}-deletar`).append(`
        <span id='um' onclick="deletar_um('${id}');">Deletar</span>
    `);
};

function deletar_um(id){
    $(`#${id}-deletar`).remove();
    $(`#${id}`).remove();
};

function deletar_todos(id){
    $(`#${id}-deletar`).remove();
    $(`#${id}`).remove();
    $(`#${id}_copia`).remove();
};

$('#atualizar').on('click',function(){
    let nome1 = $('#nome1').val();
    let nome2 = $('#nome2').val();
    $('#legend1').text(nome1);
    $('#legend2').text(nome2);
});