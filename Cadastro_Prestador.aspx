<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Cadastro_Prestador.aspx.vb" Inherits="Cadastro_Prestador" MaintainScrollPositionOnPostback="True" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="utf-8">

    <!-- Isso é necessário para funcionar a versão mobile -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="//assets.locaweb.com.br/locastyle/2.0.6/stylesheets/locastyle.css">

    <title></title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="~/Styles/links.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
    
    
<!--
    // JavaScript Document
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

    //adiciona mascara ao celular
    function MascaraCelular(tel) {
        if (mascaraInteiro(tel) == false) {
            event.returnValue = false;
        }
        return formataCampo(tel, '(00) 00000-0000', event);
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

    //valida celular
    function ValidaCelular(tel) {
        exp = /\(\d{2}\)\ \d{4}\-\d{4}/
        if (!exp.test(tel.value))
            alert('Numero de Celular Invalido!');
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

    //valida email    exp = /^.+@.+\..{2,}$/ 
    function ValidaEmail(email) {
        exp = /^.+@.+\..{2,}$/
        if (!exp.test(email.value))
            alert('Email Invalido !');
    }

    //valida o CPF digitado
    function ValidarCPF(Objcpf) {
        var cpf = Objcpf.value;
        exp = /\.|\-/g
        cpf = cpf.toString().replace(exp, "");
        var digitoDigitado = eval(cpf.charAt(9) + cpf.charAt(10));
        var soma1 = 0, soma2 = 0;
        var vlr = 11;

        for (i = 0; i < 9; i++) {
            soma1 += eval(cpf.charAt(i) * (vlr - 1));
            soma2 += eval(cpf.charAt(i) * vlr);
            vlr--;
        }
        soma1 = (((soma1 * 10) % 11) == 10 ? 0 : ((soma1 * 10) % 11));
        soma2 = (((soma2 + (2 * soma1)) * 10) % 11);

        var digitoGerado = (soma1 * 10) + soma2;
        if (digitoGerado != digitoDigitado)
            alert('CPF Invalido!');
    }


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
    function RecebeFoco_CNPJ(idObjeto, idObjeto1) {
        document.getElementById(idObjeto).value = "";
        document.getElementById(idObjeto1).value = "Digite aqui apenas se você for pessoa física";
    }
    function RecebeFoco_CPF(idObjeto, idObjeto1) {
        document.getElementById(idObjeto).value = "";
        document.getElementById(idObjeto1).value = "Digite aqui apenas se você for pessoa jurídica";
    }

    //-->
    </script>


    <style type="text/css">
        .style1 {
            height: 0px;
            background-color: #fff;
            margin: 0px auto 0px auto;
            border: 1px solid #496077;
            margin-left: 0px;
            margin-right: 0px;
            margin-top: 0px;
            margin-bottom: 0px;
        }

        .popUpStyle {
            font: normal 11px auto "Trebuchet MS", Verdana;
            background-color: #4F4F4F;
            color: #FF9900;
            padding: 6px;
        }

        .popUpStyle1 {
            font: normal 11px auto "Trebuchet MS", Verdana;
            background-color: gray;
            color: #ff9900;
            padding: 6px;
            margin-left: 0px;
            filter: alpha(opacity=80);
            opacity: 0.8;
        }

        .drag {
            background-color: #dddddd;
            cursor: move;
            border: solid 1px gray;
        }

        .campo {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 11px;
            color: #4E6070;
            background-color: #FFFFFF;
            border: 1px solid #999999;
            height: 17px;
            margin-left: 17px;
            margin-bottom: 0px;
        }

        /*Header*/
        .Tab .ajax__tab_header {
            color: #4682b4;
            font-family: Calibri;
            font-size: 14px;
            font-weight: bold;
            background-color: #ffffff;
            margin-left: 0px;
        }
        /*Body*/
        .Tab .ajax__tab_body {
            border: 1px solid #b4cbdf;
            padding-top: 0px;
        }
        /*Tab Active*/
        .Tab .ajax__tab_active .ajax__tab_tab {
            color: #ffffff;
            background: url("../../tab_active.gif") repeat-x;
            height: 20px;
        }

        .Tab .ajax__tab_active .ajax__tab_inner {
            color: #ffffff;
            background: url("../../tab_left_active.gif") no-repeat left;
            padding-left: 10px;
        }

        .Tab .ajax__tab_active .ajax__tab_outer {
            color: #ffffff;
            background: url("../../tab_right_active.gif") no-repeat right;
            padding-right: 6px;
        }
        /*Tab Hover*/
        .Tab .ajax__tab_hover .ajax__tab_tab {
            color: #000000;
            background: url("../../tab_hover.gif") repeat-x;
            height: 20px;
        }

        .Tab .ajax__tab_hover .ajax__tab_inner {
            color: #000000;
            background: url("../../tab_left_hover.gif") no-repeat left;
            padding-left: 10px;
        }

        .Tab .ajax__tab_hover .ajax__tab_outer {
            color: #000000;
            background: url("../../tab_right_hover.gif") no-repeat right;
            padding-right: 6px;
        }
        /*Tab Inactive*/
        .Tab .ajax__tab_tab {
            color: #666666;
            background: url("../../tab_Inactive.gif") repeat-x;
            height: 20px;
        }

        .Tab .ajax__tab_inner {
            color: #666666;
            background: url("../../tab_left_inactive.gif") no-repeat left;
            padding-left: 10px;
        }

        .Tab .ajax__tab_outer {
            color: #666666;
            background: url("../../tab_right_inactive.gif") no-repeat right;
            padding-right: 6px;
            margin-right: 2px;
        }

        .MyTabStyle .ajax__tab_header {
            background: transparent;
            border: none;
            border-bottom: 1px solid #c0c0c0;
            -moz-border-radius: 0px;
            -webkit-border-radius: 0px;
            -border-radius: 0px;
            text-align: center;
        }

            .MyTabStyle .ajax__tab_header .ajax__tab_outer {
                border-color: #222;
                color: #222;
                padding-left: 10px;
                margin-right: 3px;
                border: none;
            }

            .MyTabStyle .ajax__tab_header .ajax__tab_inner {
                border-color: #666;
                color: #666;
                padding: 3px 10px 2px 0px;
                border: none;
            }

        .MyTabStyle .ajax__tab_hover .ajax__tab_outer {
            background-color: #9c3;
            border: none;
        }

        .MyTabStyle .ajax__tab_hover .ajax__tab_inner {
            color: #fff;
            border: none;
            font-weight: bolder;
            font-size: medium;
        }

        .MyTabStyle .ajax__tab_active .ajax__tab_outer {
            border-bottom-color: #ffffff;
            background: transparent;
            font-weight: bolder;
            font-size: medium;
            border: none;
            color: #459e00;
        }

        .MyTabStyle .ajax__tab_active .ajax__tab_inner {
            color: #000;
            border-color: #333;
            background: transparent url(imagens/uiTabsArrow.png) no-repeat bottom center;
            border: none;
            font-weight: bolder;
            font-size: medium;
        }

        .MyTabStyle .ajax__tab_body {
            font-family: verdana,tahoma,helvetica;
            /*font-size: 10pt;*/
            background-color: #fff;
            border-top-width: 0;
            border: none;
            /*border-top-color: #ffffff;*/
        }

        .MyTabStyle .ajax__tab_tab {
            color: #666666;
            height: 35px;
        }


        .tabs-min {
            background: transparent;
            border: none;
        }

            .tabs-min .ajax__tab_header {
                background: transparent;
                border: none;
                border-bottom: 1px solid #c0c0c0;
                -moz-border-radius: 0px;
                -webkit-border-radius: 0px;
                -border-radius: 0px;
            }

            .tabs-min .ui-tabs-nav .ui-state-default {
                background: transparent;
                border: none;
            }

            .tabs-min .ui-tabs-nav .ui-state-active {
                background: transparent url(img/uiTabsArrow.png) no-repeat bottom center;
                border: none;
            }

            .tabs-min .ui-tabs-nav .ui-state-default a {
                color: #c0c0c0;
            }

            .tabs-min .ui-tabs-nav .ui-state-active a {
                color: #459e00;
            }
    </style>
    <script language="javascript" type="text/javascript">
<!--
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

    // -->


    </script>



</head>
<body>
    <form id="Form1" name="form1" runat="server">

        <asp:ToolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager1" ScriptMode="Release" />
        <script type="text/javascript">
            function PanelClick(sender, e) {
                var Messages = $get('<%=Messages.ClientID%>');
            Highlight(Messages);
        }
        function ActiveTabChanged(sender, e) {
            var CurrentTab = $get('<%=CurrentTab.ClientID%>');
            CurrentTab.innerHTML = sender.get_activeTab().get_headerText();
            Highlight(CurrentTab);
        }

        var HighlightAnimations = {};
        function Highlight(el) {
            if (HighlightAnimations[el.uniqueID] == null) {
                HighlightAnimations[el.uniqueID] = Sys.Extended.UI.Animation.createAnimation({
                    AnimationName: "color",
                    duration: 0.5,
                    property: "style",
                    propertyKey: "backgroundColor",
                    startValue: "#FFFF90",
                    endValue: "#FFFFFF"
                }, el);
            }
            HighlightAnimations[el.uniqueID].stop();
            HighlightAnimations[el.uniqueID].play();
        }

        function ToggleHidden(value) {
            $find('<%=Tabs.ClientID%>').get_tabs()[1].set_enabled(value);
        }
        </script>

        <table class="style1" width="100%">

            <tr>
                <td width="20px">&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <asp:Label runat="server" ID="CurrentTab" />
                    <asp:Label runat="server" ID="Messages" />
                    <asp:TextBox ID="txt_CNPJ" runat="server" CssClass="campo" Enabled="False"
                        ReadOnly="True" Font-Bold="True" Visible="False" Height="23px"
                        Width="42px"></asp:TextBox>
                    <asp:Label ID="lbl_TipoEmpresa" runat="server" Font-Bold="True"
                        Font-Names="Verdana" Font-Size="Small" ForeColor="#669900" Visible="False"></asp:Label>
                    <asp:TextBox ID="txt_ID" runat="server" CssClass="campo" Enabled="False"
                        ReadOnly="True" Font-Bold="True" Visible="False" Height="16px"
                        Width="41px"></asp:TextBox>
                    <asp:TextBox ID="txt_novo" runat="server" CssClass="campo" Enabled="False"
                        ReadOnly="True" Font-Bold="True" Visible="False" Height="16px"
                        Width="41px"></asp:TextBox>
                </td>
                <td width="20px">&nbsp;</td>
            </tr>
            <tr>
                <td width="20px">&nbsp;</td>
                <td align="center" colspan="2">
                    <asp:Label ID="lbl_Identificacao" runat="server" Font-Bold="True" Font-Names="Verdana"
                        Font-Overline="False" Font-Size="Medium"
                        Font-Strikeout="False" ForeColor="#3333CC"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>

            <tr>
                <td width="20px">&nbsp;</td>
                <td align="center" colspan="2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>

            <tr>
                <td width="20px">&nbsp;</td>
                <td>&nbsp;</td>
                <td>

                    <asp:TabContainer runat="server" ScrollBars="Auto" ID="Tabs"
                        ActiveTabIndex="1" Visible="true" Enabled="true" BorderStyle="None"
                        EnableTheming="true" CssClass="MyTabStyle">

                        <asp:TabPanel ID="TabPanel_0" runat="server" HeaderText="Categoria" Enabled="true" Visible="true" Height="500px" TabIndex="0" BorderStyle="None" BorderWidth="0px">
                            <HeaderTemplate>Categoria</HeaderTemplate>
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td>&#160;</td>
                                        <td>&#160;<td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <tr>
                                                <td width="10%">&nbsp;</td>
                                                <td align="center" colspan="2" width="80%">
                                                    <asp:Panel ID="Pn_Categoria" runat="server" BorderStyle="Solid"
                                                        BorderWidth="1px" Width="600px">
                                                        <table width="600px">
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="lbl_Titulo8" runat="server" Font-Bold="True"
                                                                        Font-Names="Verdana" Font-Size="Medium" ForeColor="#0000CC">Cadastro</asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td background="Imagens/Backgrounds/LinhaS.gif" colspan="2">&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="lbl_Titulo9" runat="server" Font-Bold="True"
                                                                        Font-Names="Verdana" Font-Size="Small" ForeColor="#0000CC">Comece o cadastro 
                                                informando qual é sua categoria</asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:RadioButtonList ID="rb_pessoa" runat="server" AutoPostBack="True"
                                                                        Font-Bold="True" Font-Names="Verdana" Font-Size="Small"
                                                                        RepeatDirection="Horizontal" Width="340px">
                                                                        <asp:ListItem Value="PF">Sou Pessoa Física</asp:ListItem>
                                                                        <asp:ListItem Value="PJ">Sou Pessoa Jurídica</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td>C.N.P.J. :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_cad_CNPJ" runat="server" CssClass="form-control"
                                                                        ForeColor="Black" MaxLength="18" Width="300px">Digite aqui apenas se você for pessoa jurídica</asp:TextBox>
                                                                    <br />
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl_Titulo4" runat="server" Font-Bold="True"
                                                                        Font-Names="Verdana" Font-Size="X-Small" ForeColor="#0000CC">(digite somente 
                                                os números)</asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td>C.P.F. :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_cad_CPF" runat="server" CssClass="form-control" ForeColor="Black"
                                                                        Height="30px" MaxLength="14" Width="300px">Digite aqui apenas se você for pessoa física</asp:TextBox>
                                                                    <br />
                                                                    <br />
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="lbl_Titulo5" runat="server" Font-Bold="True"
                                                    Font-Names="Verdana" Font-Size="X-Small" ForeColor="#0000CC">(digite somente 
                                                os números)</asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td>Categoria :<asp:Label ID="Label566" runat="server" ForeColor="#FF3300"
                                                                    Text=" * "></asp:Label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:RadioButtonList ID="RB_TipoEmpresa" runat="server" AutoPostBack="True"
                                                                        Font-Bold="True" Font-Names="Verdana" Font-Size="Small" ForeColor="#0033CC"
                                                                        Width="500px">
                                                                        <asp:ListItem Value="1">Associações e Cooperativas</asp:ListItem>
                                                                        <asp:ListItem Value="2">Empresa de Pequeno Porte (EPP)</asp:ListItem>
                                                                        <asp:ListItem Value="3">Empresa Individual</asp:ListItem>
                                                                        <asp:ListItem Value="4">Empresa Ltda</asp:ListItem>
                                                                        <asp:ListItem Value="5">Empresa Individual de Responsabilidade Limitada ( 
                                                    EIRELI)</asp:ListItem>
                                                                        <asp:ListItem Value="6">Micro Empreendedor Individual ( M.E.I. )</asp:ListItem>
                                                                        <asp:ListItem Value="7">Micro Empresa ( M.E. )</asp:ListItem>
                                                                        <asp:ListItem Value="8">Sociedade Anônima (SA)</asp:ListItem>
                                                                        <asp:ListItem Value="9">Sociedade Simples (SS)</asp:ListItem>
                                                                        <asp:ListItem Value="10">Pessoa Física</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td>Participa de Licitação :<asp:Label ID="Label567" runat="server"
                                                                    ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:RadioButtonList ID="RB_Licitacao" runat="server" AutoPostBack="True"
                                                                        Font-Bold="True" Font-Names="Verdana" Font-Size="Small" ForeColor="#0033CC"
                                                                        Width="500px">
                                                                        <asp:ListItem Value="Sim">Sim</asp:ListItem>
                                                                        <asp:ListItem Value="Nao">Não</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="style2"></td>
                                                                <td class="style2"></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Trabalho oferecido :<asp:Label ID="Label579" runat="server" ForeColor="#FF3300"
                                                                    Text=" * "></asp:Label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:RadioButtonList ID="RB_Categoria" runat="server" Font-Bold="True"
                                                                        Font-Names="Verdana" Font-Size="Small" ForeColor="#0033CC">
                                                                        <asp:ListItem Value="1">Serviços Artísticos</asp:ListItem>
                                                                        <asp:ListItem Value="2">Bens e outros serviços</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Button ID="Imgbtn_Continuar_0" runat="server" BackColor="#00554F"
                                                                        CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                                                        ForeColor="White" Height="35px" Text="CONTINUAR" Width="150px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="lbl_Erro" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                        Font-Size="Large" ForeColor="#CC0000"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False"
                                                                        Font-Bold="True" Font-Names="verdana" Font-Size="Medium" ForeColor="#CC0000"
                                                                        Visible="False">Clique aqui</asp:LinkButton>
                                                                    &nbsp;&nbsp;<asp:Label ID="Label571" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                        Font-Size="Medium" ForeColor="#CC0000" Visible="False"> para retornar a tela 
                                                de Login</asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="Label19" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                        Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                                <td width="10%"></td>
                                            </tr>
                                            <tr>
                                                <td width="10%">&nbsp;</td>
                                                <td align="center" colspan="2" width="80%">&nbsp;</td>
                                                <td width="10%">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px"></td>
                                                <td></td>
                                                <td>&nbsp;</td>
                                                <td></td>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:TabPanel>


                        <asp:TabPanel runat="server" HeaderText="Identificação" ID="TabPanel_11" Enabled="False" Visible="true" Height="500px" TabIndex="0">
                            <HeaderTemplate>Identificação</HeaderTemplate>
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td width="10%">&#160;</td>
                                        <td colspan="2" width="80%" align="center">&nbsp;<td width="10%">&nbsp;</td>
                                            <tr>
                                                <td width="10%">&nbsp;</td>
                                                <td align="center" colspan="2" width="80%">
                                                    <asp:Panel ID="Panel1" runat="server" BorderStyle="Solid" BorderWidth="1px"
                                                        Width="75%">
                                                        <table width="100%">
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                        Font-Size="Medium" ForeColor="#0000CC">Identificação </asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td background="Imagens/Backgrounds/LinhaS.gif" colspan="2">&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                        Font-Size="Small" ForeColor="#0000CC">Agora precisamos de algumas 
                                            informações sobre sua empresa</asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td align="left">&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Razão Social :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_Razao_Social" runat="server" CssClass="form-control"
                                                                        MaxLength="70" onkeyup="this.value=this.value.toUpperCase();"
                                                                        ToolTip="Informe aqui sua Razão Social" Width="400px"></asp:TextBox>
                                                                    <asp:Label ID="Label43" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Nome Fantasia :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_Nome_Fantasia" runat="server" CssClass="form-control"
                                                                        MaxLength="25" onkeyup="this.value=this.value.toUpperCase();"
                                                                        ToolTip="Informe aqui seu Nome Fantasia caso tenha" Width="300px"></asp:TextBox>
                                                                    <asp:Label ID="Label44" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Inscrição Estadual :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_IEstadual" runat="server" CssClass="form-control" MaxLength="20"
                                                                        ToolTip="Informe aqui sua Inscrição Estadual, se não houver, informe ISENTO " Width="300px"></asp:TextBox>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Inscrição Municipal :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_IMunicipal" runat="server" CssClass="form-control" MaxLength="20"
                                                                        ToolTip="Informe aqui sua Incrição Municipal" Width="300px"></asp:TextBox>
                                                                    <asp:Label ID="Label45" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Cidade :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_IM_Cidade" runat="server" CssClass="form-control" MaxLength="50"
                                                                        onkeyup="this.value=this.value.toUpperCase();"
                                                                        ToolTip="Informe aqui a cidade de sua Inscrição Municipal" Width="400px"></asp:TextBox>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">UF :</td>
                                                                <td align="left">
                                                                    <asp:DropDownList ID="ddl_IM_UF" runat="server" CssClass="form-control" Height="30px"
                                                                        ToolTip="Informe aqui o Estado de sua Inscrição Municipal" Width="300px">
                                                                        <asp:ListItem Value="Selecione "> Selecione uma opção</asp:ListItem>
                                                                        <asp:ListItem Value="DF">DISTRITO FEDERAL</asp:ListItem>
                                                                        <asp:ListItem Value="AC">ACRE</asp:ListItem>
                                                                        <asp:ListItem Value="AL">ALAGOAS</asp:ListItem>
                                                                        <asp:ListItem Value="AP">AMAPÁ</asp:ListItem>
                                                                        <asp:ListItem Value="AM">AMAZONAS</asp:ListItem>
                                                                        <asp:ListItem Value="BA">BAHIA</asp:ListItem>
                                                                        <asp:ListItem Value="CE">CEARÁ</asp:ListItem>
                                                                        <asp:ListItem Value="ES">ESPÍRITO SANTO</asp:ListItem>
                                                                        <asp:ListItem Value="GO">GOIÁS</asp:ListItem>
                                                                        <asp:ListItem Value="MA">MARANHÃO</asp:ListItem>
                                                                        <asp:ListItem Value="MT">MATO GROSSO</asp:ListItem>
                                                                        <asp:ListItem Value="MS">MATO GROSSO DO SUL</asp:ListItem>
                                                                        <asp:ListItem Value="MG">MINAS GERAIS</asp:ListItem>
                                                                        <asp:ListItem Value="PR">PARANÁ</asp:ListItem>
                                                                        <asp:ListItem Value="PB">PARAÍBA</asp:ListItem>
                                                                        <asp:ListItem Value="PA">PARÁ</asp:ListItem>
                                                                        <asp:ListItem Value="PE">PERNAMBUCO</asp:ListItem>
                                                                        <asp:ListItem Value="PI">PIAUÍ</asp:ListItem>
                                                                        <asp:ListItem Value="RJ">RIO DE JANEIRO</asp:ListItem>
                                                                        <asp:ListItem Value="RN">RIO GRANDE DO NORTE</asp:ListItem>
                                                                        <asp:ListItem Value="RS">RIO GRANDE DO SUL</asp:ListItem>
                                                                        <asp:ListItem Value="RO">RONDÔNIA</asp:ListItem>
                                                                        <asp:ListItem Value="RR">RORAIMA</asp:ListItem>
                                                                        <asp:ListItem Value="SC">SANTA CATARINA</asp:ListItem>
                                                                        <asp:ListItem Value="SE">SERGIPE</asp:ListItem>
                                                                        <asp:ListItem Value="SP">SÃO PAULO</asp:ListItem>
                                                                        <asp:ListItem Value="TO">TOCANTINS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Código C.N.A.E :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_CNAE_Codigo" runat="server" CausesValidation="True"
                                                                        CssClass="form-control" MaxLength="9"
                                                                        ToolTip="Informe aqui o CPF do CNAE da Empresa" Width="300px"></asp:TextBox>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Descrição C.N.A.E :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_CNAE_Descricao" runat="server" CssClass="form-control"
                                                                        MaxLength="150" onkeyup="this.value=this.value.toUpperCase();"
                                                                        ToolTip="Informe aqui o endereço da empresa" Width="400px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">&nbsp;</td>
                                                                <td align="left">&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Representante :<br />
                                                                    <br />
                                                                </td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_Representante" runat="server" CssClass="form-control" align=" midlle"
                                                                        MaxLength="50" onkeyup="this.value=this.value.toUpperCase();"
                                                                        ToolTip="Informe aqui o nome do Requesentante Legal da Empresa" Width="400px"></asp:TextBox>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Cargo :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_Representante_Cargo" runat="server" CssClass="form-control"
                                                                        MaxLength="40" onkeyup="this.value=this.value.toUpperCase();"
                                                                        ToolTip="Informe aqui o cargo do Requesentante Legal da Empresa" Width="400px"></asp:TextBox>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">C.P.F. :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_CPF" runat="server" CausesValidation="True"
                                                                        CssClass="form-control" MaxLength="20"
                                                                        ToolTip="Informe aqui o CPF do Requesentante Legal da Empresa" Width="300px"></asp:TextBox>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">R.G. :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_RG" runat="server" CssClass="form-control" MaxLength="20"
                                                                        onkeyup="this.value=this.value.toUpperCase();"
                                                                        ToolTip="Informe aqui o RG do Requesentante Legal da Empresa" Width="300px"></asp:TextBox>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Nacionalidade :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_Nacionalidade" runat="server" CssClass="form-control"
                                                                        MaxLength="30" onkeyup="this.value=this.value.toUpperCase();"
                                                                        ToolTip="Informe aqui a nacionalidade do Requesentante Legal da Empresa"
                                                                        Width="300px"></asp:TextBox>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Estado Civil :</td>
                                                                <td align="left">
                                                                    <asp:DropDownList ID="ddl_Representante_EstadoCivil" runat="server"
                                                                        Height="40px"
                                                                        ToolTip="Informe aqui o estado civil do Requesentante Legal da Empresa"
                                                                        Width="300px" CssClass="form-control">
                                                                        <asp:ListItem Value=" Selecione "> Selecione uma opção</asp:ListItem>
                                                                        <asp:ListItem>SOLTEIRO</asp:ListItem>
                                                                        <asp:ListItem>CASADO</asp:ListItem>
                                                                        <asp:ListItem>DIVORCIADO</asp:ListItem>
                                                                        <asp:ListItem>VIÚVO</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Profissão :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_Representante_Profissao" runat="server" CssClass="form-control"
                                                                        MaxLength="50" onkeyup="this.value=this.value.toUpperCase();"
                                                                        ToolTip="Informe aqui a profissão do Requesentante Legal da Empresa"
                                                                        Width="300px"></asp:TextBox>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">E-mail :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_Representante_Email" runat="server" CssClass="form-control"
                                                                        MaxLength="50"
                                                                        ToolTip="Informe aqui o endereço de email da empresa - ATENÇÃO !!! Este será o email de contato com a Fundação Cultural "
                                                                        Width="300px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">&nbsp;</td>
                                                                <td align="left">&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Senha :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_Senha" runat="server" CssClass="form-control" MaxLength="10"
                                                                        ToolTip="Informe aqui sua senha com no mínimo 6 caracteres ( números e/ou letras)"
                                                                        Width="300px"></asp:TextBox>
                                                                    <asp:Label ID="Label562" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">Confirme a senha :</td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txt_Confirma_Senha" runat="server" CssClass="form-control"
                                                                        MaxLength="10" ToolTip="Redigite a senha para confirmá-la" Width="300px"></asp:TextBox>
                                                                    <asp:Label ID="Label563" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td align="left">&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Button ID="Imgbtn_Voltar_11" runat="server" BackColor="#00554F"
                                                                        CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                                                        ForeColor="White" Height="35px" Text="RETORNAR" Width="150px" />
                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:Button ID="Imgbtn_Continuar_11" runat="server" BackColor="#00554F"
                                                CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                                ForeColor="White" Height="35px" Text="CONTINUAR" Width="150px" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">Os campos assinalados com (*) são de preenchimento obrigatório.
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Label ID="lbl_Error_ID" runat="server" Font-Bold="True"
                                                                        Font-Names="Verdana" Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </td>
                                                <td width="10%">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:TabPanel>
                        <asp:TabPanel ID="TabPanel_12" runat="server" HeaderText="Categoria" Enabled="false" Visible="false" Height="500px" TabIndex="0">
                            <HeaderTemplate>Identificação Pessoa Física</HeaderTemplate>
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td width="10%">&#160;</td>
                                        <td colspan="2" width="80%" align="center">
                                            <asp:Panel ID="Pn_ID_PF" runat="server" BorderStyle="Solid" BorderWidth="1px"
                                                Width="75%">
                                                <table width="100%">
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                Font-Size="Medium" ForeColor="#0000CC">Identificação</asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td background="Imagens/Backgrounds/LinhaS.gif" colspan="2">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                Font-Size="Small" ForeColor="#0000CC">Agora precisamos de algumas 
                            informações sobre você</asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>&nbsp;</td>
                                                        <td align="left">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">Nome</td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txt_PF_Nome" runat="server" CssClass="form-control" MaxLength="70"
                                                                onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui seu Nome"
                                                                Width="400px"></asp:TextBox>
                                                            <asp:Label ID="Label2" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            <br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">R.G. :</td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txt_PF_RG" runat="server" CssClass="form-control" MaxLength="20"
                                                                onkeyup="this.value=this.value.toUpperCase();"
                                                                ToolTip="Informe aqui o RG do Requesentante Legal da Empresa" Width="300px"></asp:TextBox>
                                                            <asp:Label ID="Label568" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">PIS/PASEP :</td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txt_PF_PISPASEP" runat="server" CssClass="form-control" MaxLength="14"
                                                                onkeyup="this.value=this.value.toUpperCase();"
                                                                ToolTip="Informe aqui o PIS/PASEP" Width="300px"></asp:TextBox><asp:Label ID="Label569"
                                                                    runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">NIT :</td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txt_PF_NIT" runat="server" CssClass="form-control"
                                                                MaxLength="14" onkeyup="this.value=this.value.toUpperCase();"
                                                                ToolTip="Informe aqui o NIT" Width="300px"></asp:TextBox><asp:Label ID="Label570"
                                                                    runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">Nacionalidade :</td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txt_PF_Nacionalidade"
                                                                runat="server" CssClass="form-control" MaxLength="30"
                                                                onkeyup="this.value=this.value.toUpperCase();"
                                                                ToolTip="Informe aqui a nacionalidade do Requesentante Legal da Empresa"
                                                                Width="200px"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">Estado Civil 
                                :</td>
                                                        <td align="left">
                                                            <asp:DropDownList ID="ddl_PF_EstadoCivil" runat="server" Height="25px"
                                                                ToolTip="Informe aqui o estado civil do Requesentante Legal da Empresa"
                                                                Width="150px" CssClass="form-control">
                                                                <asp:ListItem Value=" Selecione "> Selecione uma opção</asp:ListItem>
                                                                <asp:ListItem>SOLTEIRO</asp:ListItem>
                                                                <asp:ListItem>CASADO</asp:ListItem>
                                                                <asp:ListItem>DIVORCIADO</asp:ListItem>
                                                                <asp:ListItem>VIÚVO</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">Profissão :</td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txt_PF_Profissao" runat="server" CssClass="form-control"
                                                                MaxLength="50" onkeyup="this.value=this.value.toUpperCase();"
                                                                ToolTip="Informe aqui a profissão do Requesentante Legal da Empresa"
                                                                Width="300px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">&nbsp;</td>
                                                        <td align="left">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">Senha :</td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txt_Senha0" runat="server" CssClass="form-control" MaxLength="10"
                                                                ToolTip="Informe aqui sua senha com no mínimo 6 caracteres ( números e/ou letras)"
                                                                Width="119px"></asp:TextBox>
                                                            <asp:Label ID="Label572" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">Confirme a senha :</td>
                                                        <td align="left">
                                                            <asp:TextBox ID="txt_Confirma_Senha0" runat="server" CssClass="form-control" MaxLength="10"
                                                                ToolTip="Redigite a senha para confirmá-la"
                                                                Width="119px"></asp:TextBox><asp:Label ID="Label573"
                                                                    runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">&nbsp;</td>
                                                        <td align="left">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" colspan="2">
                                                            <asp:Button ID="Imgbtn_Voltar_12" runat="server" BackColor="#00554F"
                                                                Font-Bold="True" ForeColor="White" Height="40px" Text="RETORNAR"
                                                                Width="150px" CausesValidation="False" />
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="Imgbtn_Continuar_12" runat="server" BackColor="#00554F"
                                Font-Bold="True" ForeColor="White" Height="40px" Text="CONTINUAR"
                                Width="150px" CausesValidation="False" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" colspan="2">Os campos assinalados com (*) são de 
                                preenchimento obrigatório.</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" colspan="2">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center" colspan="2">
                                                            <asp:Label ID="lbl_Error_ID0" runat="server" Font-Bold="True"
                                                                Font-Names="Verdana" Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left">&nbsp;</td>
                                                        <td align="left">&nbsp;</td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:TabPanel>
                        <asp:TabPanel ID="TabPanel_2" runat="server" HeaderText="Categoria" Enabled="false" Visible="true" Height="500px" TabIndex="0">
                            <HeaderTemplate>Contato</HeaderTemplate>
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td width="10%">&#160;</td>
                                        <td colspan="2" width="80%" align="center">&nbsp;<tr>
                                            <td width="10%">&nbsp;</td>
                                            <td align="center" colspan="2" width="80%">
                                                <asp:Panel ID="Pn_Contato" runat="server" BorderStyle="Solid" BorderWidth="1px"
                                                    Width="75%">
                                                    <table width="100%">
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                    Font-Size="Medium" ForeColor="#0000CC">Dados para contato</asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td background="Imagens/Backgrounds/LinhaS.gif" colspan="2">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                    Font-Size="Small" ForeColor="#0000CC">Agora precisamos dos dados para 
                                                contato</asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td align="left">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">C.E.P. :</td>
                                                            <td align="left">
                                                                <br />
                                                                <asp:TextBox ID="txt_CEP" runat="server" CssClass="form-control" MaxLength="10"
                                                                    ToolTip="Informe aqui o código de endereçamento postal e em seguida clique no botão Pesquisar CEP para o preenchimento automático do Endereço, Bairro, Cidade e UF."
                                                                    Width="300px"></asp:TextBox>
                                                                <asp:Button ID="btn_CEP" runat="server" CausesValidation="False" Height="20px"
                                                                    Text="Pesquisar CEP" />
                                                                <asp:Label ID="Label46" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RV_CEP" runat="server"
                                                                    ControlToValidate="txt_CEP" ErrorMessage="Informe o CEP">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">Endereço :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Endereco" runat="server" CssClass="form-control" MaxLength="100"
                                                                    onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o endereço da empresa" Width="400px"></asp:TextBox>
                                                                <asp:Label ID="Label47" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RV_Endereco" runat="server"
                                                                    ControlToValidate="txt_Endereco" ErrorMessage="Informe o Endereço">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">Número :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Numero" runat="server" CssClass="form-control" MaxLength="10"
                                                                    ToolTip="Informe aqui o número do endereço da empresa" Width="200px"></asp:TextBox>
                                                                <asp:Label ID="Label48" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RV_Numero" runat="server"
                                                                    ControlToValidate="txt_Numero" ErrorMessage="Informe o Número">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">Complemento :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Complemento" runat="server" CssClass="form-control"
                                                                    MaxLength="50" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o complemento do endereço da empresa se houver : bloco, andar, sala, etc."
                                                                    Width="300px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">Bairro :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Bairro" runat="server" CssClass="form-control" MaxLength="50"
                                                                    onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o bairro da empresa" Width="400px"></asp:TextBox>
                                                                <asp:Label ID="Label576" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">Cidade :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Cidade" runat="server" CssClass="form-control" MaxLength="50"
                                                                    onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui a cidade da empresa" Width="400px"></asp:TextBox>
                                                                <asp:Label ID="Label49" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RV_Cidade" runat="server"
                                                                    ControlToValidate="txt_Cidade" ErrorMessage="Informe a Cidade">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">UF :</td>
                                                            <td align="left">
                                                                <asp:DropDownList ID="ddl_UF" runat="server" Height="30px"
                                                                    ToolTip="Informe aqui a Unidade da Federação da empresa" Width="200px" CssClass="form-control">
                                                                    <asp:ListItem Value="Selecione"> Selecione uma opção</asp:ListItem>
                                                                    <asp:ListItem Value="DF">DISTRITO FEDERAL</asp:ListItem>
                                                                    <asp:ListItem Value="AC">ACRE</asp:ListItem>
                                                                    <asp:ListItem Value="AL">ALAGOAS</asp:ListItem>
                                                                    <asp:ListItem Value="AP">AMAPÁ</asp:ListItem>
                                                                    <asp:ListItem Value="AM">AMAZONAS</asp:ListItem>
                                                                    <asp:ListItem Value="BA">BAHIA</asp:ListItem>
                                                                    <asp:ListItem Value="CE">CEARÁ</asp:ListItem>
                                                                    <asp:ListItem Value="ES">ESPÍRITO SANTO</asp:ListItem>
                                                                    <asp:ListItem Value="GO">GOIÁS</asp:ListItem>
                                                                    <asp:ListItem Value="MA">MARANHÃO</asp:ListItem>
                                                                    <asp:ListItem Value="MT">MATO GROSSO</asp:ListItem>
                                                                    <asp:ListItem Value="MS">MATO GROSSO DO SUL</asp:ListItem>
                                                                    <asp:ListItem Value="MG">MINAS GERAIS</asp:ListItem>
                                                                    <asp:ListItem Value="PR">PARANÁ</asp:ListItem>
                                                                    <asp:ListItem Value="PB">PARAÍBA</asp:ListItem>
                                                                    <asp:ListItem Value="PA">PARÁ</asp:ListItem>
                                                                    <asp:ListItem Value="PE">PERNAMBUCO</asp:ListItem>
                                                                    <asp:ListItem Value="PI">PIAUÍ</asp:ListItem>
                                                                    <asp:ListItem Value="RJ">RIO DE JANEIRO</asp:ListItem>
                                                                    <asp:ListItem Value="RN">RIO GRANDE DO NORTE</asp:ListItem>
                                                                    <asp:ListItem Value="RS">RIO GRANDE DO SUL</asp:ListItem>
                                                                    <asp:ListItem Value="RO">RONDÔNIA</asp:ListItem>
                                                                    <asp:ListItem Value="RR">RORAIMA</asp:ListItem>
                                                                    <asp:ListItem Value="SC">SANTA CATARINA</asp:ListItem>
                                                                    <asp:ListItem Value="SE">SERGIPE</asp:ListItem>
                                                                    <asp:ListItem Value="SP">SÃO PAULO</asp:ListItem>
                                                                    <asp:ListItem Value="TO">TOCANTINS</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:Label ID="Label575" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">Telefone 1 :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Telefone" runat="server" CssClass="form-control" MaxLength="25"
                                                                    ToolTip="Informe aqui o DDD e o telefone da empresa" Width="200px" ValidateRequestMode="Enabled"></asp:TextBox>
                                                                <asp:Label ID="Label574" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">Telefone 2 :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Telefone_1" runat="server" CssClass="form-control" MaxLength="25"
                                                                    ToolTip="Informe aqui o DDD e o telefone da empresa" Width="200px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">Celular :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Celular" runat="server" CssClass="form-control" MaxLength="25"
                                                                    ToolTip="Informe aqui o DDD e o celular da empresa" Width="200px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">WhatsApp Corporativo :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_WhatsApp" runat="server" CssClass="form-control" MaxLength="25"
                                                                    ToolTip="Informe aqui o DDD e o celular da empresa" Width="200px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">E-mail 1 :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Email" runat="server" CssClass="form-control" MaxLength="50"
                                                                    ToolTip="Informe aqui o endereço de email da empresa - ATENÇÃO !!! Este será o email de contato com a Fundação Cultural "
                                                                    Width="300px"></asp:TextBox>
                                                                <asp:Label ID="Label564" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                <asp:RequiredFieldValidator ID="RV_Email" runat="server"
                                                                    ControlToValidate="txt_Email" ErrorMessage="Informe o email">*</asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">E-mail 2 :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Email_1" runat="server" CssClass="form-control" MaxLength="50"
                                                                    ToolTip="Informe aqui o endereço de email da empresa - ATENÇÃO !!! Este será o email de contato com a Fundação Cultural "
                                                                    Width="300px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">Website :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Site" runat="server" CssClass="form-control" MaxLength="50"
                                                                    onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o endereço da home page empresa se houver" Width="300px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">Pessoa de&nbsp;&nbsp; Contato :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Pessoa_Contato" runat="server" CssClass="form-control"
                                                                    MaxLength="50" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o endereço da home page empresa se houver" Width="300px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center" colspan="2">
                                                                <asp:Button ID="Imgbtn_Voltar_2" runat="server" BackColor="#00554F"
                                                                    CausesValidation="False" Font-Bold="True" ForeColor="White" Height="40px"
                                                                    Text="RETORNAR" Width="150px" />
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="Imgbtn_Continuar_2" runat="server" BackColor="#00554F"
                                                    CausesValidation="False" Font-Bold="True" ForeColor="White" Height="40px"
                                                    Text="CONTINUAR" Width="150px" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center" colspan="2">Os campos assinalados com (*) são de preenchimento obrigatório.</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center" colspan="2">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">&nbsp;</td>
                                                            <td align="center" colspan="2">
                                                                <asp:Label ID="lbl_erro_contato" runat="server" Font-Bold="True"
                                                                    Font-Names="Verdana" Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td align="left">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td align="left">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:TabPanel>
                        <asp:TabPanel ID="TabPanel_3" runat="server" HeaderText="Categoria" Enabled="false" Visible="true" Height="500px" TabIndex="0">
                            <HeaderTemplate>Dados Bancários</HeaderTemplate>
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td width="10%">&#160;</td>
                                        <td colspan="2" width="80%" align="center">&nbsp;<tr>
                                            <td width="10%">&nbsp;</td>
                                            <td align="center" colspan="2" width="80%">
                                                <asp:Panel ID="Panel2" runat="server" BorderStyle="Solid" BorderWidth="1px"
                                                    Width="75%">
                                                    <table width="100%">
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                    Font-Size="Medium" ForeColor="#0000CC">Dados Bancários</asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td background="Imagens/Backgrounds/LinhaS.gif" colspan="2">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                    Font-Size="Small" ForeColor="#0000CC">Agora informe seus dados bancários</asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td align="left">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" width="20%">Banco :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Banco_Codigo" runat="server" CssClass="form-control"
                                                                    Height="30px" MaxLength="3" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o código do banco" Width="200px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">Agência :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Banco_Agencia" runat="server" CssClass="form-control"
                                                                    MaxLength="4" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o código da agência" Width="200px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">Conta :</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_Banco_Conta" runat="server" CssClass="form-control"
                                                                    MaxLength="10" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o número da conta bancária" Width="200px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">Tipo de Conta:</td>
                                                            <td align="left">&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:DropDownList ID="ddl_Banco_TipoConta" runat="server" Height="30px"
                                                    ToolTip="Informe aqui o tipo de conta" Width="200px" CssClass="form-control">
                                                    <asp:ListItem Value=" Selecione "> Selecione uma opção</asp:ListItem>
                                                    <asp:ListItem>CORRENTE</asp:ListItem>
                                                    <asp:ListItem Value="POUPANCA">POUPANÇA</asp:ListItem>
                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" class="style2" colspan="2">
                                                                <asp:Button ID="Imgbtn_Voltar_3" runat="server" BackColor="#00554F"
                                                                    CausesValidation="False" Font-Bold="True" ForeColor="White" Height="40px"
                                                                    Text="RETORNAR" Width="150px" />
                                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="Imgbtn_Continuar_3" runat="server"
                                                                    BackColor="#00554F" CausesValidation="False" Font-Bold="True" ForeColor="White"
                                                                    Height="40px" Text="CONTINUAR" Width="150px" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" colspan="2">Os campos assinalados com (*) são de preenchimento obrigatório.</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" colspan="2">&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" colspan="2">
                                                                <asp:Label ID="lbl_Error_Banco" runat="server" Font-Bold="True"
                                                                    Font-Names="Verdana" Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">&nbsp;</td>
                                                            <td align="left">&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </td>
                                    </tr>


                                </table>

                            </ContentTemplate>
                        </asp:TabPanel>

                        <asp:TabPanel runat="server" ID="TabPanel_X" HeaderText="XXX" Enabled="false" Visible="false">
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td width="20px">&#160;</td>
                                        <td align="center" colspan="2" style="font-weight: bold">Informe, um a um, os prestadores de serviços de sua empresa.<br />
                                            Caso o próprio Representante Legal seja um dos Prestadores,&#160;
                                            <asp:LinkButton ID="Lnkbtn_01" runat="server" CausesValidation="False"
                                                Font-Bold="True" ForeColor="#3333CC">clique aqui</asp:LinkButton>&#160; para cadastrá-lo como um Prestador de Serviço<br />
                                            Para alterar os dados de um Prestador já cadastrado, clique na imagem&#160;&#160;
                                            <asp:Image ID="Image4" runat="server"
                                                ImageUrl="~/Imagens/Botoes/botao_editar.gif" />&#160;&#160; referente ao prestador.<td>&nbsp;</td>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="center" colspan="2" style="font-weight: bold">Os campos assinalados com (*) são de preenchimento obrigatório.</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td colspan="2">
                                                    <asp:GridView ID="GridView2" runat="server" AllowSorting="True"
                                                        AutoGenerateColumns="False" BorderColor="Gainsboro" BorderStyle="Solid"
                                                        BorderWidth="1px" CellPadding="6" DataKeyNames="PrexPre_ID"
                                                        DataSourceID="SqlPrexPre" OnRowCommand="GridView2_RowCommand"
                                                        OnRowDataBound="GridView2_RowDataBound" Width="100%" GridLines="None">
                                                        <AlternatingRowStyle BackColor="#EBEBEB" />
                                                        <Columns>
                                                            <asp:TemplateField ShowHeader="False">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="cmdDelete20" runat="server" CausesValidation="false"
                                                                        CommandArgument='<%# Eval("PrexPre_ID") %>' CommandName="Delete20"
                                                                        Text="&lt;IMG src=&quot;Imagens/botoes/botao_editar.gif&quot;  border=&quot;0&quot;&gt;">
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" Width="30px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Nome" SortExpression="PrexPre_Nome">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="Label52" runat="server" Text='<%# Bind("PrexPre_Nome") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="250px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Serviços" SortExpression="PrexPre_Servicos">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="Label55" runat="server" Text='<%# Bind("PrexPre_Servicos") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="80px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField ShowHeader="False">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="cmdDelete23" runat="server" CausesValidation="false"
                                                                        CommandArgument='<%# Eval("PrexPre_ID") %>' CommandName="Delete"
                                                                        Text="&lt;IMG src=&quot;Imagens/Botoes/Botao_apagar.gif&quot; border=&quot;0&quot; &gt;">
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="30px" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle BackColor="WhiteSmoke" />
                                                        <PagerStyle BackColor="WhiteSmoke" />
                                                        <RowStyle BackColor="Transparent" ForeColor="Transparent" />
                                                        <SelectedRowStyle BackColor="Transparent" Font-Bold="True"
                                                            ForeColor="Transparent" />
                                                    </asp:GridView>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td colspan="2">
                                                    <table width="100%">
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Nome :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Nome" runat="server" CssClass="form-control"
                                                                    MaxLength="70" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o nome do Prestador de Serviço" Width="400px"></asp:TextBox>
                                                                &nbsp;<asp:Label ID="Label57" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>R.G. :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_RG" runat="server" CssClass="form-control"
                                                                    MaxLength="20" ToolTip="Informe aqui o RG do Prestador de Serviço"
                                                                    Width="300px"></asp:TextBox>
                                                                &nbsp;<asp:Label ID="Label58" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>C.P.F. :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_CPF" runat="server" CausesValidation="True"
                                                                    CssClass="form-control" MaxLength="20"
                                                                    ToolTip="Informe aqui o CPF do Prestador de Serviço" Width="300px"></asp:TextBox>
                                                                &nbsp;<asp:Label ID="Label59" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Nacionalidade :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Nacionalidade" runat="server" CssClass="form-control"
                                                                    MaxLength="30" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui a nacionalidade do Prestador de Serviço" Width="300px"></asp:TextBox>
                                                                &nbsp;<asp:Label ID="Label60" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Estado Civil :</td>
                                                            <td>
                                                                <asp:DropDownList ID="ddl_Prestador_EstadoCivil" runat="server"
                                                                    ToolTip="Informe aqui o Estado Civil do Prestador de Serviço" Width="250px" CssClass="form-control" Height="30px">
                                                                    <asp:ListItem Value=" "> Selecione uma opção</asp:ListItem>
                                                                    <asp:ListItem>SOLTEIRO</asp:ListItem>
                                                                    <asp:ListItem>CASADO</asp:ListItem>
                                                                    <asp:ListItem>DIVORCIADO</asp:ListItem>
                                                                    <asp:ListItem>VIÚVO</asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<asp:Label ID="Label61" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Profissão :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Profissao" runat="server" CssClass="form-control"
                                                                    MaxLength="50" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui a Profissão do Prestador de Serviço" Width="300px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>C.E.P. :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_CEP" runat="server" CssClass="form-control"
                                                                    MaxLength="10" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o código de endereçamento postal e em seguida clique no botão Pesquisar CEP para o preenchimento automático do Endereço, Bairro, Cidade e UF."
                                                                    Width="300px"></asp:TextBox>
                                                                &nbsp;&nbsp;<asp:Label ID="Label62" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                &nbsp;&nbsp;<asp:Button ID="btn_CEP_Prestador" runat="server" CausesValidation="False"
                                                                    Height="20px" Text="Pesquisar CEP" />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Endereço :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Endereco" runat="server" CssClass="form-control"
                                                                    MaxLength="100" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o endereço do Prestador de Serviço" Width="400px"></asp:TextBox>
                                                                &nbsp;<asp:Label ID="Label63" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Número :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Numero" runat="server" CssClass="form-control"
                                                                    MaxLength="10"
                                                                    ToolTip="Informe aqui o número do endereço do Prestador de Serviço"
                                                                    Width="250px"></asp:TextBox>
                                                                &nbsp;<asp:Label ID="Label64" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Complemento :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Complemento" runat="server" CssClass="form-control"
                                                                    MaxLength="50" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o complemento do endereço do Prestador de Serviço se houver : bloco, andar, sala, etc."
                                                                    Width="300px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Bairro :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Bairro" runat="server" CssClass="form-control"
                                                                    MaxLength="50" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o bairro do Prestador de Serviço" Width="350px"></asp:TextBox>
                                                                &nbsp;<asp:Label ID="Label65" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Cidade :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Municipio" runat="server" CssClass="form-control"
                                                                    MaxLength="50" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui a cidade do Prestador de Serviço" Width="300px"></asp:TextBox>
                                                                &nbsp;<asp:Label ID="Label66" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>UF :</td>
                                                            <td>
                                                                <asp:DropDownList ID="ddl_Prestador_UF" runat="server" CssClass="form-control"
                                                                    ToolTip="Informe aqui a Unidade da Federação do Prestador de Serviço"
                                                                    Width="180px">
                                                                    <asp:ListItem Value=" ">&nbsp; Selecione uma opção</asp:ListItem>
                                                                    <asp:ListItem Value="DF">DISTRITO FEDERAL</asp:ListItem>
                                                                    <asp:ListItem Value="AC">ACRE</asp:ListItem>
                                                                    <asp:ListItem Value="AL">ALAGOAS</asp:ListItem>
                                                                    <asp:ListItem Value="AP">AMAPÁ</asp:ListItem>
                                                                    <asp:ListItem Value="AM">AMAZONAS</asp:ListItem>
                                                                    <asp:ListItem Value="BA">BAHIA</asp:ListItem>
                                                                    <asp:ListItem Value="CE">CEARÁ</asp:ListItem>
                                                                    <asp:ListItem Value="ES">ESPÍRITO SANTO</asp:ListItem>
                                                                    <asp:ListItem Value="GO">GOIÁS</asp:ListItem>
                                                                    <asp:ListItem Value="MA">MARANHÃO</asp:ListItem>
                                                                    <asp:ListItem Value="MT">MATO GROSSO</asp:ListItem>
                                                                    <asp:ListItem Value="MS">MATO GROSSO DO SUL</asp:ListItem>
                                                                    <asp:ListItem Value="MG">MINAS GERAIS</asp:ListItem>
                                                                    <asp:ListItem Value="PR">PARANÁ</asp:ListItem>
                                                                    <asp:ListItem Value="PB">PARAÍBA</asp:ListItem>
                                                                    <asp:ListItem Value="PA">PARÁ</asp:ListItem>
                                                                    <asp:ListItem Value="PE">PERNAMBUCO</asp:ListItem>
                                                                    <asp:ListItem Value="PI">PIAUÍ</asp:ListItem>
                                                                    <asp:ListItem Value="RJ">RIO DE JANEIRO</asp:ListItem>
                                                                    <asp:ListItem Value="RN">RIO GRANDE DO NORTE</asp:ListItem>
                                                                    <asp:ListItem Value="RS">RIO GRANDE DO SUL</asp:ListItem>
                                                                    <asp:ListItem Value="RO">RONDÔNIA</asp:ListItem>
                                                                    <asp:ListItem Value="RR">RORAIMA</asp:ListItem>
                                                                    <asp:ListItem Value="SC">SANTA CATARINA</asp:ListItem>
                                                                    <asp:ListItem Value="SE">SERGIPE</asp:ListItem>
                                                                    <asp:ListItem Value="SP">SÃO PAULO</asp:ListItem>
                                                                    <asp:ListItem Value="TO">TOCANTINS</asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<asp:Label ID="Label67" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Telefone :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Telefone" runat="server" CssClass="form-control"
                                                                    MaxLength="25"
                                                                    ToolTip="Informe aqui o DDD e o telefone do Prestador de Serviço" Width="300px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Celular :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Celular" runat="server" CssClass="form-control"
                                                                    MaxLength="25" ToolTip="Informe aqui o DDD e o celular do Prestador de Serviço"
                                                                    Width="300px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>E-mail :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Email" runat="server" CssClass="form-control"
                                                                    MaxLength="50"
                                                                    ToolTip="Informe aqui o endereço de email do Prestador de Serviço"
                                                                    Width="300px"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Serviços :</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_Prestador_Servico" runat="server" CssClass="form-control"
                                                                    MaxLength="100" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui o(s) serviço(s) prestado(s) separados por ;"
                                                                    Width="400px"></asp:TextBox>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <asp:ImageButton ID="btn_Salvar_Prestador" runat="server"
                                                                    CausesValidation="False" ImageUrl="~/Imagens/Botoes/Botao_SalvarAzul.gif" />
                                                                &nbsp;<asp:Button ID="btn_Salvar_Prestadorx" runat="server" BackColor="#3366FF"
                                                                    BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" Font-Bold="True"
                                                                    ForeColor="White" Text="S A L V A R" Visible="False" />
                                                                &nbsp;&nbsp;<asp:Label ID="lbl_erro_prestador" runat="server" Font-Bold="True"
                                                                    Font-Names="Verdana" Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_erro_prestador" runat="server" BorderColor="White"
                                                                    BorderStyle="None" Font-Bold="True" Font-Names="Verdana" Font-Size="Medium"
                                                                    ForeColor="Red" Height="50px" MaxLength="1000" ReadOnly="True" Rows="3"
                                                                    TextMode="MultiLine" Width="90%"></asp:TextBox>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txt_prexpre_registro" runat="server" BackColor="White"
                                                                    BorderStyle="None" CssClass="campo" ForeColor="White" MaxLength="10"
                                                                    Width="119px"></asp:TextBox>
                                                                <asp:TextBox ID="TextBox6" runat="server" BackColor="White" BorderStyle="None"
                                                                    CssClass="campo" ForeColor="White" MaxLength="300" Width="57px"></asp:TextBox>
                                                                <asp:TextBox ID="TextBox7" runat="server" BackColor="White" BorderStyle="None"
                                                                    CssClass="campo" ForeColor="White" MaxLength="300" Width="57px"></asp:TextBox>
                                                                <asp:ImageButton ID="Imgbtn_Continuar_X" runat="server"
                                                                    CausesValidation="False"
                                                                    ImageUrl="~/Imagens/Botoes/Botao_Continuar_Cadastro.gif" />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>

                        </asp:TabPanel>

                        <asp:TabPanel runat="server" ID="TabPanel_4" HeaderText="Materiais" Enabled="false" Visible="true">
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td width="20px">&#160;</td>
                                        <td colspan="2" align="center" style="font-weight: bold">
                                            <asp:Label ID="Label577" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                Font-Size="Medium" ForeColor="#0000CC">Materiais</asp:Label>
                                            <td>&nbsp;</td>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="center" background="Imagens/Backgrounds/LinhaS.gif" colspan="2"
                                                    style="font-weight: bold">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="center" colspan="2" style="font-weight: bold">Marque os materiais que podem ser&nbsp; fornecidos, clicando na descrição do 
                            material.</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="center" colspan="2" style="font-weight: bold">Se o material não constar na lista e desejar cadastrar, preencha o campo abaixo 
                            e clique no botão de adição</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td align="center">&nbsp;&nbsp;&nbsp; Material :
                            <asp:TextBox ID="txtdescservico" runat="server" CausesValidation="True"
                                CssClass="form-control" Height="20px" MaxLength="250"
                                onkeyup="this.value=this.value.toUpperCase();" Rows="1" Width="500px"></asp:TextBox>
                                                    &nbsp;&nbsp;
                            <asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False"
                                ImageUrl="~/Imagens/Botoes/botao_mais.gif" />
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td align="center">
                                                    <asp:DataGrid ID="Datagrid2" runat="server" AllowSorting="True"
                                                        AutoGenerateColumns="False" BackColor="White" BorderColor="Gainsboro"
                                                        BorderStyle="Solid" BorderWidth="1px" CellPadding="6" DataKeyField="PrexSM_ID"
                                                        OnDeleteCommand="DataGrid2_DeleteCommand"
                                                        OnItemDataBound="DataGrid2_ItemDataBound" PageSize="100" Width="90%">
                                                        <AlternatingItemStyle BackColor="#E6E6E6" />
                                                        <Columns>
                                                            <asp:TemplateColumn HeaderText="Lista dos Materiais">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="LnkBtnDel3" runat="server" CausesValidation="False"
                                                                        CommandName="Delete" Height="10px"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.SM_Descricao") %>'
                                                                        ToolTip="Marcar/Desmarcar este material da minha lista">
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="90%" />
                                                            </asp:TemplateColumn>
                                                            <asp:TemplateColumn>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="ckitem" runat="server" AutoPostBack="True"
                                                                        Checked='<%# DataBinder.Eval(Container, "DataItem.SM_Selecao") %>' Enabled="false" />
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                        </Columns>
                                                        <EditItemStyle VerticalAlign="Middle" />
                                                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                        <HeaderStyle BackColor="WhiteSmoke" Font-Bold="True" ForeColor="White"
                                                            HorizontalAlign="Center" Height="30px" />
                                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                                                            Font-Overline="False" Font-Size="Small" Font-Strikeout="False"
                                                            Font-Underline="False" VerticalAlign="Middle" HorizontalAlign="Left" />
                                                        <PagerStyle BackColor="WhiteSmoke" HorizontalAlign="Center" Mode="NumericPages"
                                                            NextPageText="Posterior" PrevPageText="Anterior" />
                                                        <SelectedItemStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                                    </asp:DataGrid>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td align="center">
                                                    <asp:Button ID="Imgbtn_Voltar_4" runat="server" BackColor="#00554F"
                                                        CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                                        ForeColor="White" Height="40px" Text="RETORNAR" Width="150px" />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="Imgbtn_Continuar_4" runat="server" BackColor="#00554F"
                                CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                ForeColor="White" Height="40px" Text="CONTINUAR" Width="150px" />
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="center" colspan="2">&nbsp;&nbsp;<br />
                                                    <br />
                                                    <asp:TextBox ID="txtcodservico" runat="server" BackColor="White"
                                                        BorderStyle="None" ForeColor="White" Width="30px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="center" colspan="2">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="left" colspan="2">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </td>
                                    </tr>
                                </table>

                            </ContentTemplate>
                        </asp:TabPanel>
                        <asp:TabPanel runat="server" ID="TabPanel_5" HeaderText="Serviços" Enabled="false" Visible="true">
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td width="20px">&#160;</td>
                                        <td colspan="2" align="center" style="font-weight: bold">
                                            <asp:Label ID="Label578" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                Font-Size="Medium" ForeColor="#0000CC">Serviços</asp:Label>
                                            <td>&nbsp;</td>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="center" background="Imagens/Backgrounds/LinhaS.gif" colspan="2"
                                                    style="font-weight: bold">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="center" colspan="2" style="font-weight: bold">Marque os serviços que podem ser&nbsp; fornecidos, clicando na descrição do serviço.</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="center" colspan="2" style="font-weight: bold">Se o serviço não constar na lista e desejar cadastrar, preencha o campo abaixo e 
                            clique no botão de adição</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td align="center">&nbsp;&nbsp;&nbsp; Serviço :
                            <asp:TextBox ID="txtdescservico1" runat="server" CausesValidation="True"
                                CssClass="form-control" Height="20px" MaxLength="250"
                                onkeyup="this.value=this.value.toUpperCase();" Rows="1" Width="500px"></asp:TextBox>
                                                    &nbsp;&nbsp;
                            <asp:ImageButton ID="ImageButton31" runat="server" CausesValidation="False"
                                ImageUrl="~/Imagens/Botoes/botao_mais.gif" />
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td align="center">
                                                    <asp:DataGrid ID="Datagrid3" runat="server" AllowSorting="True"
                                                        AutoGenerateColumns="False" BackColor="White" BorderColor="Gainsboro"
                                                        BorderStyle="Solid" BorderWidth="1px" CellPadding="6" DataKeyField="PrexSM_ID"
                                                        OnDeleteCommand="DataGrid3_DeleteCommand"
                                                        OnItemDataBound="DataGrid3_ItemDataBound" PageSize="100" Width="90%" GridLines="None">
                                                        <AlternatingItemStyle BackColor="#EEEEEE" />
                                                        <Columns>
                                                            <asp:TemplateColumn HeaderText="Lista dos Serviços">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="LnkBtnDel31" runat="server" CausesValidation="False"
                                                                        CommandName="Delete" Height="10px"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.SM_Descricao") %>'
                                                                        ToolTip="Marcar/Desmarcar este material da minha lista" Width="90%"></asp:LinkButton>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="90%" />
                                                            </asp:TemplateColumn>
                                                            <asp:TemplateColumn>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="ckitem" runat="server" AutoPostBack="True"
                                                                        Checked='<%# DataBinder.Eval(Container, "DataItem.SM_Selecao") %>'
                                                                        Enabled="false" />
                                                                </ItemTemplate>
                                                            </asp:TemplateColumn>
                                                        </Columns>
                                                        <EditItemStyle VerticalAlign="Middle" />
                                                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                        <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="White"
                                                            HorizontalAlign="Center" Height="25px" />
                                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Names="Verdana"
                                                            Font-Overline="False" Font-Size="Small" Font-Strikeout="False"
                                                            Font-Underline="False" VerticalAlign="Middle" HorizontalAlign="Left" />
                                                        <PagerStyle BackColor="WhiteSmoke" HorizontalAlign="Center" Mode="NumericPages"
                                                            NextPageText="Posterior" PrevPageText="Anterior" />
                                                        <SelectedItemStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                                    </asp:DataGrid>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td align="center">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td align="center">
                                                    <asp:Button ID="Imgbtn_Voltar_5" runat="server" BackColor="#00554F"
                                                        CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                                        ForeColor="White" Height="40px" Text="RETORNAR" Width="150px" />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="Imgbtn_Continuar_5" runat="server" BackColor="#00554F"
                                CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                ForeColor="White" Height="40px" Text="CONTINUAR" Width="150px" />
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td align="center">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td align="center">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="center" colspan="2">&nbsp;&nbsp;<br />
                                                    <br />
                                                    <asp:TextBox ID="TextBox5" runat="server" BackColor="White" BorderStyle="None"
                                                        ForeColor="White" Width="30px"></asp:TextBox>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="center" colspan="2">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td width="20px">&nbsp;</td>
                                                <td align="left" colspan="2">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </td>
                                    </tr>
                                </table>

                            </ContentTemplate>
                        </asp:TabPanel>
                        <asp:TabPanel runat="server" ID="TabPanel_Y" HeaderText="YYY" Enabled="false" Visible="false">
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td></td>
                                        <td align="center" colspan="2"
                                            style="font-weight: bold">Os documentos abaixo são de preenchimento obrigatório de acordo com sua categoria.<br />
                                            Para fazer o Upload e completar as informações, clique na imagem&#160;&#160;
                                            <asp:Image ID="Image3" runat="server"
                                                ImageUrl="~/Imagens/Botoes/botao_editar.gif" />&#160;&#160; referente ao documento.<br />
                                            Se desejar incluir um documento a mais, selecione-o da lista de Tipos de Documentos e preencha os demais campos.<br />
                                            <td></td>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td colspan="2">
                                                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True"
                                                        AutoGenerateColumns="False" BorderColor="Gainsboro" BorderStyle="Solid"
                                                        BorderWidth="1px" CellPadding="1" DataKeyNames="PrexDoc_ID"
                                                        DataSourceID="SqlPrexDoc" OnRowCommand="GridView1_RowCommand"
                                                        OnRowDataBound="GridView1_RowDataBound" Width="100%">
                                                        <AlternatingRowStyle BackColor="White" />
                                                        <Columns>
                                                            <asp:TemplateField ShowHeader="False">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="cmdDelete1" runat="server" CausesValidation="false"
                                                                        CommandArgument='<%# Eval("PrexDoc_ID") %>' CommandName="Delete1"
                                                                        HeaderText="Documento" SortExpression="Doc_Descricao"
                                                                        Text='<%# Bind("Doc_Descricao") %>'
                                                                        ToolTip="Editar as informações deste documento">
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Left" Width="40%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Complemento" SortExpression="PrexDoc_Observacao">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="Label41" runat="server" Text='<%# Bind("PrexDoc_Observacao") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="240px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Emitido em" SortExpression="PrexDoc_Emissao">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="Label5" runat="server"
                                                                        Text='<%# Bind("PrexDoc_Emissao", "{0:d}") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="80px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Válido até" SortExpression="PrexDoc_Validade">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="Label6" runat="server"
                                                                        Text='<%# Bind("PrexDoc_Validade", "{0:d}") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="80px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:HyperLink ID="HyperLink1" runat="server"
                                                                        NavigateUrl='<%# Eval("PrexDoc_Nome", "{0}") %>' Target="_blank"
                                                                        Text="&lt;IMG src=&quot;Imagens/botoes/search16_h.gif&quot;  border=&quot;0&quot;&gt;"
                                                                        ToolTip="Visualizar o Documento"></asp:HyperLink>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Size="Small" Width="30px" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="PrexDoc_Situacao" HeaderText="Situação"
                                                                Visible="False" />
                                                            <asp:TemplateField HeaderText="Situação">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="ImgSIT" runat="server" CausesValidation="False"
                                                                        ImageAlign="Middle" />
                                                                </ItemTemplate>
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle BackColor="WhiteSmoke" />
                                                        <PagerStyle BackColor="WhiteSmoke" />
                                                        <RowStyle BackColor="Transparent" ForeColor="Transparent" />
                                                        <SelectedRowStyle BackColor="Transparent" Font-Bold="True"
                                                            ForeColor="Transparent" />
                                                    </asp:GridView>
                                                </td>
                                                <td>&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;</td>
                                                <td>&nbsp;
                                                </td>
                                                <td>&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td colspan="2">
                                                    <table width="100%">
                                                        <tr>
                                                            <td>&nbsp;
                                                            </td>
                                                            <td>Tipo de Documento :
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlDocumento" runat="server" AutoPostBack="True"
                                                                    DataSourceID="SqlDocumento" DataTextField="Doc_Descricao"
                                                                    DataValueField="Doc_ID" Height="25px" Width="400px">
                                                                </asp:DropDownList>
                                                                &nbsp;
                                        <asp:Label ID="Label69" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                &nbsp;&nbsp;
                                                            </td>
                                                            <td>&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;
                                                            </td>
                                                            <td>Complemento :
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_prexdoc_obs" runat="server" CssClass="campo"
                                                                    MaxLength="300" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ToolTip="Informe aqui alguma observação complementar referente ao documento."
                                                                    Width="500px"></asp:TextBox>
                                                            </td>
                                                            <td>&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;
                                                            </td>
                                                            <td>Descritivo :
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_prexdoc_ajuda" runat="server" CssClass="campo"
                                                                    Height="60px" MaxLength="300" onkeyup="this.value=this.value.toUpperCase();"
                                                                    ReadOnly="True" Rows="5" TextMode="MultiLine"
                                                                    ToolTip="Informe aqui alguma observação complementar referente ao documento."
                                                                    Width="500px"></asp:TextBox>
                                                                &nbsp;
                                        <br />
                                                                <asp:HyperLink ID="hpl_modelo" runat="server" Target="_blank"> Clique aqui para 
                                        visualizar o Modelo
                                                                </asp:HyperLink>
                                                            </td>
                                                            <td>&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;
                                                            </td>
                                                            <td>&nbsp;
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtmodelo" runat="server" CssClass="campo" MaxLength="100"
                                                                    ToolTip="Informe aqui a Data de Emissão do Documento" Visible="False"
                                                                    Width="68px"></asp:TextBox>
                                                                <asp:TextBox ID="txt_prexdoc_doc" runat="server" CssClass="campo"
                                                                    Enabled="False" MaxLength="300" onkeyup="this.value=this.value.toUpperCase();"
                                                                    Visible="False" Width="116px"></asp:TextBox>
                                                            </td>
                                                            <td>&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;
                                                            </td>
                                                            <td>Emissão :
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_prexdoc_emissao" runat="server" CssClass="campo"
                                                                    MaxLength="10" ToolTip="Informe aqui a Data de Emissão do Documento"
                                                                    Width="119px"></asp:TextBox>
                                                                &nbsp;&nbsp;
                                        <asp:Label ID="Label68" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                                                                (dd/mm/aaaa)
                                        <asp:Label ID="lbl_Validade" runat="server" Text="Validade :" Visible="False"></asp:Label>
                                                                &nbsp;&nbsp;<asp:TextBox ID="txt_prexdoc_validade" runat="server" CssClass="campo"
                                                                    MaxLength="10"
                                                                    ToolTip="Informe aqui a Data de Validade do documento se houver, caso contrário, deixe em branco."
                                                                    Visible="False" Width="119px"></asp:TextBox>
                                                                &nbsp;&nbsp;<asp:Label ID="lbl_Validade_Formato" runat="server" Text="(dd/mm/aaaa)"
                                                                    Visible="False"></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>Selecione o arquivo :</td>
                                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:FileUpload ID="PrexDoc_Nome" runat="server"
                                            ToolTip="Selecione aqui o documento a enviar" Width="500px" />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>Tamanho máximo permitido do documento a enviar é de 800kbytes.<br />
                                                                Permitidos somente documentos nos formatos&nbsp; PDF.</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <asp:Label ID="lbl_data_upload" runat="server" Font-Bold="True"
                                                                    Font-Names="Verdana" Font-Overline="False" Font-Size="Small"
                                                                    Font-Strikeout="False" ForeColor="Black"></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_prexdoc_registro" runat="server" BackColor="White"
                                                                    BorderStyle="None" CssClass="campo" ForeColor="White" MaxLength="10"
                                                                    Width="119px"></asp:TextBox>
                                                                <asp:TextBox ID="txt_prexdoc_nome" runat="server" BackColor="White"
                                                                    BorderStyle="None" CssClass="campo" ForeColor="White" MaxLength="300"
                                                                    Width="57px"></asp:TextBox>
                                                                <asp:TextBox ID="txt_dias_validade" runat="server" BackColor="White"
                                                                    BorderStyle="None" CssClass="campo" ForeColor="White" MaxLength="300"
                                                                    Width="57px"></asp:TextBox>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <asp:ImageButton ID="btn_Salvar_Documento" runat="server"
                                                                    CausesValidation="False" ImageUrl="~/Imagens/Botoes/Botao_SalvarAzul.gif" />
                                                                &nbsp;&nbsp;&nbsp;
                                        <asp:ImageButton ID="btn_Excluir_Documento" runat="server"
                                            CausesValidation="False" ImageUrl="~/Imagens/Botoes/Botao_SalvarAzul.gif"
                                            Visible="False" />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <asp:Label ID="lbl_erro_documento" runat="server" Font-Bold="True"
                                                                    Font-Names="Verdana" Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                                                                <asp:Label ID="lbl_Error" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                    Font-Size="Medium" ForeColor="#CC0000"></asp:Label>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <asp:TextBox ID="txt_erro_documento" runat="server" BorderColor="White"
                                                                    BorderStyle="None" Font-Bold="True" Font-Names="Verdana" Font-Size="Medium"
                                                                    ForeColor="Red" Height="56px" MaxLength="1000" ReadOnly="True" Rows="3"
                                                                    TextMode="MultiLine" Width="85%"></asp:TextBox>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td align="center" colspan="2">
                                                                <asp:ImageButton ID="Imgbtn_Voltar_Y" runat="server" CausesValidation="False"
                                                                    ImageUrl="~/Imagens/Botoes/Botao_Continuar_Cadastro.gif" />
                                                                <asp:ImageButton ID="Imgbtn_Continuar_Y" runat="server"
                                                                    CausesValidation="False"
                                                                    ImageUrl="~/Imagens/Botoes/Botao_Continuar_Cadastro.gif" />
                                                            </td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:TabPanel>
                        <asp:TabPanel runat="server" ID="TabPanel_6" HeaderText="DECLARAÇÃO" Enabled="false" Visible="true">
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td width="10%">&#160;</td>
                                        <td width="80%" align="center">
                                            <asp:Panel ID="Panel3" runat="server" BorderStyle="Solid" BorderWidth="1px"
                                                Width="75%">
                                                <table width="100%">
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Names="Verdana"
                                                                Font-Size="Medium" ForeColor="#0000CC">Declaração</asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td background="Imagens/Backgrounds/LinhaS.gif" colspan="2">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"
                                                            style="font-weight: bold; font-size: medium; font-style: normal">DECLARO, nos termos da recomendação contida no PPIC nº. 59/07 da 7º Promotoria 
                                    de Justiça da Comarca de São José dos Campos e nos termos da Resolução nº 07/05, 
                                    atualizada pelas Resoluções nº. 09/05 e 21/06, todas do Conselho Nacional de 
                                    Justiça, que: Esta empresa não possui sócio que seja cônjuge, companheiro ou 
                                    parente em linha reta ou colateral até o terceiro grau, de quaisquer pessoas 
                                    ocupantes dos cargos de Prefeito, Vice-Prefeito, Secretários Municipais, Chefe 
                                    de Gabinete, Vereadores ou de Cargos de Direção, chefia ou de assessoramento da 
                                    Prefeitura ou desta Fundação Cultural Cassiano Ricardo, de igual forma se 
                                    compromete a não vir a contratar empregado nas mesmas condições. </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"
                                                            style="font-weight: bold; font-size: medium; font-style: normal">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"
                                                            style="font-weight: bold; font-size: medium; font-style: normal">
                                                            <asp:CheckBox ID="chk_aceite" runat="server" AutoPostBack="True"
                                                                Font-Bold="True" Text="  Li e estou de acordo" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"
                                                            style="font-weight: bold; font-size: medium; font-style: normal">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"
                                                            style="font-weight: bold; font-size: medium; font-style: normal">
                                                            <asp:Button ID="Imgbtn_Voltar_6" runat="server" BackColor="#00554F"
                                                                CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                                                ForeColor="White" Height="40px" Text="RETORNAR" Width="150px" />
                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="Imgbtn_Finalizar" runat="server" BackColor="#00554F"
                                    CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                    ForeColor="White" Height="40px" Text="FINALIZAR" Width="150px" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"
                                                            style="font-weight: bold; font-size: medium; font-style: normal">&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2"
                                                            style="font-weight: bold; font-size: medium; font-style: normal">
                                                            <asp:Label ID="lbl_Confirmar" runat="server" Font-Bold="True"
                                                                Font-Names="Verdana" Font-Size="Medium" ForeColor="#CC0000"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>&nbsp;</td>
                                                        <td align="left">&nbsp;</td>
                                                    </tr>
                                            </asp:Panel>
                                </table>
                                </td>
                                </tr>
                                
                                
                <table width="100%">
                    <tr>
                        <td width="20px">&#160;</td>
                        <td>&#160;</td>
                        <td>&#160;</td>
                        <td>&#160;</td>
                    </tr>
                    <tr>
                        <td width="20px">&#160;</td>
                        <td align="center" colspan="2">&nbsp;</td>
                        <td>&#160;</td>
                    </tr>
                </table>
                            </ContentTemplate>
                        </asp:TabPanel>



                    </asp:TabContainer>


                </td>
                <td>&nbsp;</td>
            </tr>

            <tr>
                <td width="20px">&nbsp;</td>
                <td colspan="2" style="margin-left: 40px">
                    <asp:Panel ID="pnlMensagem_Cadastro" runat="server" CssClass="popUpStyle" Width="550px" Style="display: none;">
                        <table align="center" bgcolor="#FFFF99" frame="border" border="0" cellpadding="1" cellspacing="1" rules="none" width="100%">
                            <tr>
                                <td>&nbsp;</td>
                                <td align="right">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td align="center">
                                    <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Size="Medium"
                                        ForeColor="Black" Text="ATENÇÃO !!!"></asp:Label>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td align="center">
                                    <!-- os botoes abaixo sao somente para o popup funcionar corretamente-->
                                    <asp:Button ID="Button4" runat="server" Text="..." Style="display: none;" />
                                    <asp:Button ID="Button5" runat="server" Text="..." Style="display: none;" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                         <asp:Label ID="lbl_mensagem_cadastro" runat="server" Font-Bold="True"
                             Font-Size="Medium" ForeColor="Black"></asp:Label>
                                </td>
                                <td>&nbsp;</td>
                            </tr>

                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td align="center">
                                    <asp:Button ID="Imgbtn_Fechar_Mensagem" runat="server" BackColor="#00554F"
                                        CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                        ForeColor="White" Height="35px" Text="FECHAR" Visible="False" Width="150px" />
                                    <asp:Button ID="Imgbtn_Sair_Mensagem" runat="server" BackColor="#00554F"
                                        CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                        ForeColor="White" Height="35px" Text="FECHAR" Visible="False" Width="150px" />
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td align="center">
                                    <asp:Button ID="Imgbtn_Sim_Mensagem" runat="server" BackColor="#00554F"
                                        CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                                        ForeColor="White" Height="35px" Text="S I M" Visible="False" Width="150px" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           <asp:Button ID="Imgbtn_Nao_Mensagem" runat="server" BackColor="#00554F"
                               CausesValidation="False" Font-Bold="True" Font-Names="Verdana"
                               ForeColor="White" Height="35px" Text="N Â O" Visible="False" Width="150px" />
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:ModalPopupExtender ID="MPE_Cadastro" runat="server"
                        BackgroundCssClass="popUpStyle1" PopupControlID="pnlMensagem_Cadastro"
                        DynamicServicePath="" Enabled="True"
                        TargetControlID="Button4"
                        CancelControlID="Button5" OkControlID="Button4" />
                </td>
                <td>&nbsp;</td>
            </tr>


            <tr>
                <td width="20px">&nbsp;</td>
                <td align="center" colspan="2">

                    <asp:Label ID="lbl_cod_tipoempresa" runat="server" BackColor="White"
                        ForeColor="Black" Visible="False"></asp:Label>
                    <asp:Label ID="lbl_cod_tipoprestador" runat="server" BackColor="White"
                        ForeColor="Black" Visible="False"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>


            <tr>
                <td width="20px">&nbsp;</td>
                <td colspan="2" align="center">&nbsp;<asp:Button runat="server" CausesValidation="False"
                    Text="CANCELAR CADASTRO" BackColor="#00554F" Font-Bold="True"
                    Font-Names="Verdana" ForeColor="White" Height="35px" Width="200px"
                    ID="Imgbtn_Cancelar"></asp:Button>

                </td>
                <td>&nbsp;</td>
            </tr>


            <tr>
                <td width="20px">&nbsp;</td>
                <td>&nbsp;</td>
                <td>


                    <asp:ValidationSummary ID="VS_01" runat="server" DisplayMode="List"
                        ShowMessageBox="True" ShowSummary="False" />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td width="20px">&nbsp;</td>
                <td>&nbsp;</td>
                <td>


                    <asp:SqlDataSource ID="SqlPrexDoc" runat="server"
                        ConnectionString="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString %>"
                        OldValuesParameterFormatString="original_{0}"
                        SelectCommand="SELECT tmp_prestadorxdocumento.PrexDoc_ID, tmp_prestadorxdocumento.Pre_ID, tmp_prestadorxdocumento.Pre_CNPJ, tmp_prestadorxdocumento.Doc_ID, tmp_prestadorxdocumento.Doc_Descricao, tmp_prestadorxdocumento.PrexDoc_Emissao, tmp_prestadorxdocumento.PrexDoc_Validade, tmp_prestadorxdocumento.PrexDoc_Nome, tmp_prestadorxdocumento.PrexDoc_Observacao, tmp_prestadorxdocumento.PrexDoc_Situacao, tmp_prestadorxdocumento.PrexDoc_Informacoes, cad_documento.Doc_Obrigatorio, cad_documento.Doc_Modelo FROM tmp_prestadorxdocumento INNER JOIN cad_documento ON tmp_prestadorxdocumento.Doc_ID = cad_documento.Doc_ID WHERE (tmp_prestadorxdocumento.Pre_CNPJ = @Pre_CNPJ)"
                        ProviderName="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString.ProviderName %>"
                        DeleteCommand="DELETE FROM tmp_prestadorxdocumento WHERE PrexDoc_ID = @original_PrexDoc_ID and Doc_Obrigatorio=2"
                        InsertCommand="INSERT INTO [tmp_prestadorxdocumento] ([Pre_ID], [Pre_CNPJ], [Doc_ID], [Doc_Descricao], [PrexDoc_Emissao], [PrexDoc_Validade], [PrexDoc_Nome], [PrexDoc_Observacao], [PrexDoc_Situacao], [PrexDoc_Informacoes]) VALUES (@Pre_ID, @Pre_CNPJ, @Doc_ID, @Doc_Descricao, @PrexDoc_Emissao, @PrexDoc_Validade, @PrexDoc_Nome, @PrexDoc_Observacao, @PrexDoc_Situacao, @PrexDoc_Informacoes)"
                        UpdateCommand="UPDATE [tmp_prestadorxdocumento] SET [Pre_ID] = @Pre_ID, [Pre_CNPJ] = @Pre_CNPJ, [Doc_ID] = @Doc_ID, [Doc_Descricao] = @Doc_Descricao, [PrexDoc_Emissao] = @PrexDoc_Emissao, [PrexDoc_Validade] = @PrexDoc_Validade, [PrexDoc_Nome] = @PrexDoc_Nome, [PrexDoc_Observacao] = @PrexDoc_Observacao, [PrexDoc_Situacao] = @PrexDoc_Situacao, [PrexDoc_Informacoes] = @PrexDoc_Informacoes WHERE [PrexDoc_ID] = @original_PrexDoc_ID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txt_CNPJ" Name="Pre_CNPJ" PropertyName="Text"
                                Type="String" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="original_PrexDoc_ID" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Pre_ID" Type="Int32" />
                            <asp:Parameter Name="Pre_CNPJ" Type="String" />
                            <asp:Parameter Name="Doc_ID" Type="Int32" />
                            <asp:Parameter Name="Doc_Descricao" Type="String" />
                            <asp:Parameter Name="PrexDoc_Emissao" Type="DateTime" />
                            <asp:Parameter Name="PrexDoc_Validade" Type="DateTime" />
                            <asp:Parameter Name="PrexDoc_Nome" Type="String" />
                            <asp:Parameter Name="PrexDoc_Observacao" Type="String" />
                            <asp:Parameter Name="PrexDoc_Situacao" Type="String" />
                            <asp:Parameter Name="PrexDoc_Informacoes" Type="String" />
                            <asp:Parameter Name="original_PrexDoc_ID" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Pre_ID" Type="Int32" />
                            <asp:Parameter Name="Pre_CNPJ" Type="String" />
                            <asp:Parameter Name="Doc_ID" Type="Int32" />
                            <asp:Parameter Name="Doc_Descricao" Type="String" />
                            <asp:Parameter Name="PrexDoc_Emissao" Type="DateTime" />
                            <asp:Parameter Name="PrexDoc_Validade" Type="DateTime" />
                            <asp:Parameter Name="PrexDoc_Nome" Type="String" />
                            <asp:Parameter Name="PrexDoc_Observacao" Type="String" />
                            <asp:Parameter Name="PrexDoc_Situacao" Type="String" />
                            <asp:Parameter Name="PrexDoc_Informacoes" Type="String" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDocumento" runat="server"
                        ConnectionString="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString %>"
                        SelectCommand="SELECT Doc_ID, Doc_Descricao, Doc_Validade, Doc_Onde_Obter, Doc_Prestador, Doc_Fornecedor, Doc_Situacao FROM cad_documento WHERE (Doc_Prestador = 1) order by  Doc_Descricao"
                        ProviderName="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString.ProviderName %>"></asp:SqlDataSource>


                    <asp:SqlDataSource ID="SqlPrexPre" runat="server"
                        ConnectionString="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString %>"
                        OldValuesParameterFormatString="original_{0}"
                        SelectCommand="SELECT * FROM tmp_prestadorxprestador WHERE (Pre_CNPJ = @Pre_CNPJ) ORDER BY PrexPre_Nome"
                        ProviderName="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString.ProviderName %>"
                        DeleteCommand="DELETE FROM tmp_prestadorxprestador WHERE PrexPre_ID = @original_PrexPre_ID"
                        InsertCommand="INSERT INTO [tmp_prestadorxprestador] ([Pre_ID], [Pre_CNPJ], [PrexPre_Nome], [PrexPre_RG], [PrexPre_CPF], [PrexPre_Nacionalidade], [PrexPre_Estado_Civil], [PrexPre_Profissao], [PrexPre_Endereco], [PrexPre_Numero], [PrexPre_Complemento], [PrexPre_Bairro], [PrexPre_CEP], [PrexPre_Municipio], [PrexPre_UF], [PrexPre_Telefone], [PrexPre_Celular], [PrexPre_Email], [PrexPre_Servicos]) VALUES (@Pre_ID, @Pre_CNPJ, @PrexPre_Nome, @PrexPre_RG, @PrexPre_CPF, @PrexPre_Nacionalidade, @PrexPre_Estado_Civil, @PrexPre_Profissao, @PrexPre_Endereco, @PrexPre_Numero, @PrexPre_Complemento, @PrexPre_Bairro, @PrexPre_CEP, @PrexPre_Municipio, @PrexPre_UF, @PrexPre_Telefone, @PrexPre_Celular, @PrexPre_Email, @PrexPre_Servicos)"
                        UpdateCommand="UPDATE [tmp_prestadorxprestador] SET [Pre_ID] = @Pre_ID, [Pre_CNPJ] = @Pre_CNPJ, [PrexPre_Nome] = @PrexPre_Nome, [PrexPre_RG] = @PrexPre_RG, [PrexPre_CPF] = @PrexPre_CPF, [PrexPre_Nacionalidade] = @PrexPre_Nacionalidade, [PrexPre_Estado_Civil] = @PrexPre_Estado_Civil, [PrexPre_Profissao] = @PrexPre_Profissao, [PrexPre_Endereco] = @PrexPre_Endereco, [PrexPre_Numero] = @PrexPre_Numero, [PrexPre_Complemento] = @PrexPre_Complemento, [PrexPre_Bairro] = @PrexPre_Bairro, [PrexPre_CEP] = @PrexPre_CEP, [PrexPre_Municipio] = @PrexPre_Municipio, [PrexPre_UF] = @PrexPre_UF, [PrexPre_Telefone] = @PrexPre_Telefone, [PrexPre_Celular] = @PrexPre_Celular, [PrexPre_Email] = @PrexPre_Email, [PrexPre_Servicos] = @PrexPre_Servicos WHERE [PrexPre_ID] = @original_PrexPre_ID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txt_CNPJ" Name="Pre_CNPJ" PropertyName="Text"
                                Type="String" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="original_PrexPre_ID" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="Pre_ID" Type="Int32" />
                            <asp:Parameter Name="Pre_CNPJ" Type="String" />
                            <asp:Parameter Name="PrexPre_Nome" Type="String" />
                            <asp:Parameter Name="PrexPre_RG" Type="String" />
                            <asp:Parameter Name="PrexPre_CPF" Type="String" />
                            <asp:Parameter Name="PrexPre_Nacionalidade" Type="String" />
                            <asp:Parameter Name="PrexPre_Estado_Civil" Type="String" />
                            <asp:Parameter Name="PrexPre_Profissao" Type="String" />
                            <asp:Parameter Name="PrexPre_Endereco" Type="String" />
                            <asp:Parameter Name="PrexPre_Numero" Type="String" />
                            <asp:Parameter Name="PrexPre_Complemento" Type="String" />
                            <asp:Parameter Name="PrexPre_Bairro" Type="String" />
                            <asp:Parameter Name="PrexPre_CEP" Type="String" />
                            <asp:Parameter Name="PrexPre_Municipio" Type="String" />
                            <asp:Parameter Name="PrexPre_UF" Type="String" />
                            <asp:Parameter Name="PrexPre_Telefone" Type="String" />
                            <asp:Parameter Name="PrexPre_Celular" Type="String" />
                            <asp:Parameter Name="PrexPre_Email" Type="String" />
                            <asp:Parameter Name="PrexPre_Servicos" Type="String" />
                            <asp:Parameter Name="original_PrexPre_ID" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="Pre_ID" Type="Int32" />
                            <asp:Parameter Name="Pre_CNPJ" Type="String" />
                            <asp:Parameter Name="PrexPre_Nome" Type="String" />
                            <asp:Parameter Name="PrexPre_RG" Type="String" />
                            <asp:Parameter Name="PrexPre_CPF" Type="String" />
                            <asp:Parameter Name="PrexPre_Nacionalidade" Type="String" />
                            <asp:Parameter Name="PrexPre_Estado_Civil" Type="String" />
                            <asp:Parameter Name="PrexPre_Profissao" Type="String" />
                            <asp:Parameter Name="PrexPre_Endereco" Type="String" />
                            <asp:Parameter Name="PrexPre_Numero" Type="String" />
                            <asp:Parameter Name="PrexPre_Complemento" Type="String" />
                            <asp:Parameter Name="PrexPre_Bairro" Type="String" />
                            <asp:Parameter Name="PrexPre_CEP" Type="String" />
                            <asp:Parameter Name="PrexPre_Municipio" Type="String" />
                            <asp:Parameter Name="PrexPre_UF" Type="String" />
                            <asp:Parameter Name="PrexPre_Telefone" Type="String" />
                            <asp:Parameter Name="PrexPre_Celular" Type="String" />
                            <asp:Parameter Name="PrexPre_Email" Type="String" />
                            <asp:Parameter Name="PrexPre_Servicos" Type="String" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:Timer ID="Timer1" runat="server" Enabled="False" Interval="5000">
                    </asp:Timer>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td width="20px">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>



    </form>
</body>
</html>
