//adiciona mascara de cnpj

function MascaraCNPJ(cnpj) {
    if (mascaraInteiro(cnpj) == false) {
        event.returnValue = false;
    }
    return formataCampo(cnpj, '00.000.000/0000-00', event);
}

//adiciona mascara de IE
function MascaraIE(iest) {
    if (mascaraInteiro(iest) == false) {
        event.returnValue = false;
    }
    return formataCampo(iest, '000.000.000.000', event);
}

//adiciona mascara de cep
function MascaraCep(cep) {
    if (mascaraInteiro(cep) == false) {
        event.returnValue = false;
    }
    return formataCampo(cep, '00.000-000', event);
}

//adiciona mascara de data
function MascaraData(data) {
    if (mascaraInteiro(data) == false) {
        event.returnValue = false;
    }
    return formataCampo(data, '00/00/0000', event);
}

//adiciona mascara ao telefone
function MascaraTelefone(tel) {
    if (mascaraInteiro(tel) == false) {
        event.returnValue = false;
    }
    return formataCampo(tel, '(00) 0000-0000', event);
}

//adiciona mascara ao CPF
function MascaraCPF(cpf) {
    if (mascaraInteiro(cpf) == false) {
        event.returnValue = false;
    }
    return formataCampo(cpf, '000.000.000-00', event);
}

//valida telefone
function ValidaTelefone(tel) {
    exp = /\(\d{2}\)\ \d{4}\-\d{4}/
    if (!exp.test(tel.value))
        alert('Numero de Telefone Invalido!');
}

//valida CEP
function ValidaCep(cep) {
    exp = /\d{2}\.\d{3}\-\d{3}/
    if (!exp.test(cep.value))
        alert('Numero de Cep Invalido!');
}

//valida data
function ValidaData(data) {
    exp = /\d{2}\/\d{2}\/\d{4}/
    if (!exp.test(data.value))
        alert('Data Invalida!');
}

//valida email
function ValidaEmail(email) {
    exp = /^.+@.+\..{2,}$/
    if (!exp.test(email.value))
        alert('Email Invalido !');
}

//valida o CPF digitado
//valida numero inteiro com mascara
function mascaraInteiro() {
    if (event.keyCode < 48 || event.keyCode > 57) {
        event.returnValue = false;
        return false;
    }
    return true;
}

//valida o CNPJ digitado
function ValidarCNPJ(ObjCnpj) {
    var cnpj = ObjCnpj.value;
    var valida = new Array(6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
    var dig1 = new Number;
    var dig2 = new Number;

    exp = /\.|\-|\//g
    cnpj = cnpj.toString().replace(exp, "");
    if (cnpj != "Digite aqui apenas se você for pessoa jurídica") {
        if (cnpj != "") {
            var digito = new Number(eval(cnpj.charAt(12) + cnpj.charAt(13)));

            for (i = 0; i < valida.length; i++) {
                dig1 += (i > 0 ? (cnpj.charAt(i - 1) * valida[i]) : 0);
                dig2 += cnpj.charAt(i) * valida[i];
            }
            dig1 = (((dig1 % 11) < 2) ? 0 : (11 - (dig1 % 11)));
            dig2 = (((dig2 % 11) < 2) ? 0 : (11 - (dig2 % 11)));

            if (((dig1 * 10) + dig2) != digito) {
                alert('CNPJ Invalido!');
                ObjCnpj.value = "";
                ObjCnpj.select();
            }
        }
    }
}

//formata de forma generica os campos
function formataCampo(campo, Mascara, evento) {
    var boleanoMascara;

    var Digitato = evento.keyCode;
    exp = /\-|\.|\/|\(|\)| /g
    campoSoNumeros = campo.value.toString().replace(exp, "");

    var posicaoCampo = 0;
    var NovoValorCampo = "";
    var TamanhoMascara = campoSoNumeros.length;;

    if (Digitato != 8) { // backspace 
        for (i = 0; i <= TamanhoMascara; i++) {
            boleanoMascara = ((Mascara.charAt(i) == "-") || (Mascara.charAt(i) == ".")
                        || (Mascara.charAt(i) == "/"))
            boleanoMascara = boleanoMascara || ((Mascara.charAt(i) == "(")
                        || (Mascara.charAt(i) == ")") || (Mascara.charAt(i) == " "))
            if (boleanoMascara) {
                NovoValorCampo += Mascara.charAt(i);
                TamanhoMascara++;
            } else {
                NovoValorCampo += campoSoNumeros.charAt(posicaoCampo);
                posicaoCampo++;
            }
        }
        campo.value = NovoValorCampo;
        return true;
    } else {
        return true;
    }
}

function valida_cpf(cpfvalue) {
    var numeros, digitos, soma, i, resultado, digitos_iguais;
    var cpf = cpfvalue.value;
    exp = /\.|\-/g;
    cpf = cpf.toString().replace(exp, "");
    digitos_iguais = 1;

    if (cpfvalue.value != "Digite aqui apenas se você for pessoa física") {
        if (cpf.length > 0) {

            if (cpf.length < 11) {
                alert('C.P.F. Invalido!');
                cpfvalue.value = "";
                cpfvalue.select();
            }
            else {
                for (i = 0; i < cpf.length - 1; i++)
                    if (cpf.charAt(i) != cpf.charAt(i + 1)) {
                        digitos_iguais = 0;
                        break;
                    }
                if (!digitos_iguais) {
                    numeros = cpf.substring(0, 9);
                    digitos = cpf.substring(9);
                    soma = 0;
                    for (i = 10; i > 1; i--)
                        soma += numeros.charAt(10 - i) * i;
                    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
                    if (resultado != digitos.charAt(0)) {
                        alert('C.P.F. Invalido!');
                        cpfvalue.value = "";
                        cpfvalue.select();
                    }
                    else {
                        numeros = cpf.substring(0, 10);
                        soma = 0;
                        for (i = 11; i > 1; i--)
                            soma += numeros.charAt(11 - i) * i;
                        resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
                        if (resultado != digitos.charAt(1)) {
                            alert('C.P.F. Invalido!');
                            cpfvalue.value = "";
                            cpfvalue.select();
                        }
                        return true;
                    }
                }
                else {
                    alert('C.P.F. Invalido!');
                    cpfvalue.value = "";
                    cpfvalue.select();
                }
            }
        }
    }
}


function PerdeFoco_CNPJ(idObjeto) {
    if (document.getElementById(idObjeto).value == "") {
        document.getElementById(idObjeto).value = "Digite aqui apenas se você for pessoa jurídica";
    }
}
function PerdeFoco_CPF(idObjeto) {
    if (document.getElementById(idObjeto).value == "") {
        document.getElementById(idObjeto).value = "Digite aqui apenas se você for pessoa física";
    }
}
function PerdeFoco_Senha(idObjeto) {

}
function RecebeFoco_CNPJ(idObjeto) {
    document.getElementById(idObjeto).value = "";
    document.getElementById('<%=txt_CPF.ClientID%>').value = "Digite aqui apenas se você for pessoa física";
}
function RecebeFoco_CPF(idObjeto) {
    document.getElementById(idObjeto).value = "";
    document.getElementById('<%=txt_CNPJ.ClientID%>').value = "Digite aqui apenas se você for pessoa jurídica";
}
function RecebeFoco_Senha(idObjeto) {
    document.getElementById(idObjeto).value = "";
}

function OnlyNumber() {
    k = event.keyCode
    //alert(k)

    //backspace - tab - shift - . alfa - . num
    if (k == 8 || k == 9 || k == 16) {
        event.returnValue = true
        return
    }
    //0-9 alfa
    if (k >= 48 && k <= 57) {
        event.returnValue = true
        return
    }

    //a
    if (k = 97) {
        event.returnValue = false
        return
    }

    //0-9 num
    if (k >= 96 && k <= 105) {
        event.returnValue = true
        return
    }
    //setas
    if (k >= 37 && k <= 40) {
        event.returnValue = true
        return
    }
    //delete
    if (k == 46) {
        event.returnValue = true
        return
    }

    event.returnValue = false
}

function formatar(conteudo, mascara) {
    var cont = conteudo.value.length;
    var saida = mascara.substring(0, 1);
    var entrada = mascara.substring(cont)

    if (entrada.substring(0, 1) != saida) {
        conteudo.value += entrada.substring(0, 1);
    }
}

function clickButton(e, buttonid) {

    var evt = e ? e : window.event;

    var bt = document.getElementById(buttonid);

    if (bt) {

        if (evt.keyCode == 13) {

            bt.click();

            return false;

        }

    }

}


function addClass(){

    var prevItem = document.getElementById('categoria');
    var nextButton = document.getElementById('Tabs_TabPanel_0_Imgbtn_Continuar_0');

    function exibirMensagem(){
        console.log('seu buceta');
        prevItem.classList.add("complete");
    }

    nextButton.addEventListener("click", exibirMensagem);

}


window.onload = function(){
    abrir_menu();
}

function abrir_menu() {
    document.getElementById("sidebar").style.display = "initial";
    document.getElementById("sidebar").style.maxWidth = "250px";
    document.getElementById("sidebar").style.left = "0";
    document.getElementById("botao_abrir").style.display = "none";
    document.getElementById("botao_fechar").style.display = "initial";
    document.getElementById("botao_fechar").style.marginLeft = "250px";
    document.getElementById("content").style.marginLeft = "250px";
    document.getElementById("content2").style.marginLeft = "250px";
    // document.getElementById("content3").style.marginLeft = "250px";
    // document.getElementById("content4").style.marginLeft = "250px";
    // document.getElementById("content5").style.marginLeft = "250px";
    // document.getElementById("content6").style.marginLeft = "250px";
}

function fechar_menu() {
    document.getElementById('sidebar').style.left = "-250px";
    document.getElementById("sidebar").style.maxWidth = "0";
    document.getElementById("botao_fechar").style.display = "none";
    document.getElementById("botao_abrir").style.display = "initial";
    document.getElementById("botao_abrir").style.marginLeft = "0";
    document.getElementById("content").style.marginLeft = "0";
    document.getElementById("content2").style.marginLeft = "0";
    // document.getElementById("content3").style.marginLeft = "0";
    // document.getElementById("content4").style.marginLeft = "0";
    // document.getElementById("content5").style.marginLeft = "0";
    // document.getElementById("content6").style.marginLeft = "0";
}


//ReCaptcha

var your_site_key = '6Lf26n0UAAAAAGrX52ppYaF5BdsEHsPUIr_2f6yJ';

var renderRecaptcha = function () {
    grecaptcha.render('ReCaptchContainer', {
        'sitekey': your_site_key,
        'callback': reCaptchaCallback,
        theme: 'light', //light or dark    
        type: 'image',// image or audio    
        size: 'normal'//normal or compact    
    });
};

var reCaptchaCallback = function (response) {
    document.getElementById('txtCaptcha').value = "F";
    if (response !== '') {
        jQuery('#lblMessage').css('color', 'green').html('V');
        document.getElementById('<%=txtCaptcha.ClientID%>').value = "V";
    }
};

jQuery('button[type="button"]').click(function (e) {
    var message = 'Please checck the checkbox';
    if (typeof (grecaptcha) != 'undefined') {
        var response = grecaptcha.getResponse();
        (response.length === 0) ? (message = 'Captcha verification failed') : (message = 'Success!');
    }
    jQuery('#lblMessage').html(message);
    jQuery('#lblMessage').css('color', (message.toLowerCase() == 'success!') ? "green" : "red");
});

