<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Enviar_Senha.aspx.vb" Inherits="Enviar_Senha" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta charset="utf-8">
 
  <!-- Isso é necessário para funcionar a versão mobile -->
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
 
  <!-- CSS -->
  
  <link rel="stylesheet" type="text/css" href="//assets.locaweb.com.br/locastyle/2.0.6/stylesheets/locastyle.css">

    <title></title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="~/Styles/links.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" >
    
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    
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
             if (cnpj != "Digite aqui apenas se você for pessoa jurídica")
             {
            if (cnpj != "")
            {
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
            var TamanhoMascara = campoSoNumeros.length; ;

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
        
      function valida_cpf(cpfvalue){
      var numeros, digitos, soma, i, resultado, digitos_iguais;
      var cpf = cpfvalue.value;
      exp = /\.|\-/g;
      cpf = cpf.toString().replace(exp, "");
      digitos_iguais = 1;
      
      if (cpfvalue.value != "Digite aqui apenas se você for pessoa física")
      
      {
      if (cpf.length > 0)
      {
     
      if (cpf.length < 11)
      {
           alert('C.P.F. Invalido!');
                cpfvalue.value = "";
                cpfvalue.select();
      }
      else 
      {    
      for (i = 0; i < cpf.length - 1; i++)
            if (cpf.charAt(i) != cpf.charAt(i + 1))
                  {
                  digitos_iguais = 0;
                  break;
                  }
      if (!digitos_iguais)
            {
            numeros = cpf.substring(0,9);
            digitos = cpf.substring(9);
            soma = 0;
            for (i = 10; i > 1; i--)
                  soma += numeros.charAt(10 - i) * i;
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(0))
            {
            alert('C.P.F. Invalido!');
                cpfvalue.value = "";
                cpfvalue.select();
            } 
            else
            {
            numeros = cpf.substring(0,10);
            soma = 0;
            for (i = 11; i > 1; i--)
                  soma += numeros.charAt(11 - i) * i;
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(1))
            {
                alert('C.P.F. Invalido!');
                cpfvalue.value = "";
                cpfvalue.select();
            } 
            return true;
            }
            }
      else
            {
                alert('C.P.F. Invalido!');
                cpfvalue.value = "";
                cpfvalue.select();
            } 
      }
      }
      }
      }
      
      function PerdeFoco(idObjeto)
        {
        if( document.getElementById(idObjeto).value == "" )
        {
        document.getElementById(idObjeto).value = "Digite aqui seu e-mail";
        }
        }
         function PerdeFoco_CNPJ(idObjeto)
        {
        if( document.getElementById(idObjeto).value == "" )
        {
        document.getElementById(idObjeto).value = "Digite aqui apenas se você for pessoa jurídica";
        }
        }
      function PerdeFoco_CPF(idObjeto)
        {
        if( document.getElementById(idObjeto).value == "" )
        {
        document.getElementById(idObjeto).value = "Digite aqui apenas se você for pessoa física";
        }
        }
      function RecebeFoco(idObjeto)
        {
        document.getElementById(idObjeto).value = "";
        }
        function RecebeFoco_CNPJ(idObjeto)
        {
        document.getElementById(idObjeto).value = "";
        document.getElementById( '<%=txt_CPF.ClientID%>' ).value = "Digite aqui apenas se você for pessoa física";
        }
      function RecebeFoco_CPF(idObjeto)
        {
        document.getElementById(idObjeto).value = "";
        document.getElementById( '<%=txt_CNPJ.ClientID%>' ).value = "Digite aqui apenas se você for pessoa jurídica";      
        }
//-->
</script>

    
    <style type="text/css">
              .popUpStyle
    {
         font: normal 11px auto "Trebuchet MS", Verdana;    
        background-color: #4F4F4F;
        color: #FF9900;  
        padding:6px; 
               
               
    }
        .popUpStyle1
    {
        font: normal 11px auto "Trebuchet MS", Verdana;    
        background-color: gray;
        color: #ff9900;  
        padding:6px;
                    margin-left: 0px;
        filter:alpha(opacity=80);
        opacity:0.8;
                }
    
        .style16
        {
            width: 899px;
        }
        .style17
        {
            width: 100%;
        }
        .style18
        {
            height: 19px;
        }
        </style>
        <script language="javascript" type="text/javascript">
<!--
function OnlyNumber(){
		k = event.keyCode
		//alert(k)

		//backspace - tab - shift - . alfa - . num
		if(k==8 || k == 9 || k == 16 ){
			event.returnValue=true
			return
		}
		//0-9 alfa
		if(k>=48 && k<=57){
			event.returnValue=true
			return
		}
		
		//a
		if(k=97) {
			event.returnValue=false
			return
		}
		
		//0-9 num
		if(k>=96 && k<=105){
			event.returnValue=true
			return
		}
		//setas
		if(k>=37 && k<=40){
			event.returnValue=true
			return
		}
		//delete
		if(k==46){
			event.returnValue=true
			return
		}

		event.returnValue=false
	}
	
	function formatar(conteudo, mascara) 
		{
		var cont = conteudo.value.length;
		var saida = mascara.substring(0,1);
		var entrada = mascara.substring(cont)

		if (entrada.substring(0,1) != saida) 
		{
		conteudo.value += entrada.substring(0,1);
		}
		}

        function clickButton(e, buttonid){   
  
          var evt = e ? e : window.event;  
  
          var bt = document.getElementById(buttonid);  
  
          if (bt){   
  
              if (evt.keyCode == 13){   
  
                    bt.click();   
  
                    return false;   
  
              }   
  
          }   
  
        }  
        

// -->


			</script>
     <script  src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>  
 
<script type="text/javascript">  
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
         document.getElementById( '<%=txtCaptcha.ClientID%>' ).value = "F";
        if (response !== '') {  
            jQuery('#lblMessage').css('color', 'green').html('V');
             document.getElementById( '<%=txtCaptcha.ClientID%>' ).value = "V";
        }  
    };  
  
    jQuery('button[type="button"]').click(function(e) {  
        var message = 'Please checck the checkbox';  
        if (typeof (grecaptcha) != 'undefined') {  
            var response = grecaptcha.getResponse();  
            (response.length === 0) ? (message = 'Captcha verification failed') : (message = 'Success!');  
        }  
        jQuery('#lblMessage').html(message);  
        jQuery('#lblMessage').css('color', (message.toLowerCase() == 'success!') ? "green" : "red");  
    });  
  
</script>  
	
			   			
</head>
<body>
    <form id="Form1" name="form1" runat="server" >
      <asp:toolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager3" ScriptMode="Release"  />
 
        <table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="White">
            <tr>
            <td colspan="3" align="left" width="15%" valign="top">
                <asp:Image ID="Image2" runat="server" ImageAlign="Middle"
                    ImageUrl="~/Imagens/Logotipos/fccr_horizontal.png" />
            </td>
            <td align="center" width="85%" bgcolor="White">&nbsp;<table class="style17">
                <tr>
                    <td>
                        &nbsp;</td>
                                <td>
                <asp:Label ID="lbl_Titulo35" runat="server" Font-Bold="True" Font-Names="Verdana" 
                    ForeColor="#0000CC" Font-Size="X-Large">Prestadores de Serviços</asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                                <td>
                <asp:Label ID="lbl_Titulo" runat="server" Font-Bold="True" Font-Names="Verdana" 
                    ForeColor="#0000CC" Font-Size="X-Large">Fundação Cultural Cassiano Ricardo</asp:Label>
                                </td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                        </table>
            </td>
                        <td>
                            <table class="style17">
                                <tr>
                                    <td align="center">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;</td>
                                </tr>
                            </table>
                </td>
        </tr>
        <tr> 
            <td bgcolor="#00554F" colspan="5" height="1px"></td>
        </tr>
        
        
        <tr>
            <td height="5px">
                &nbsp;</td>
            <td align="right">
                &nbsp;</td>
            <td >
                &nbsp;</td>
            <td align="center" class="style16">
                &nbsp;</td>
            <td >
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="5">
                <table width="100%">
                    <tr>
                        <td width="5%">
                            &nbsp;</td>
                                <td width="90%" align=center>
                                    <asp:Panel ID="Panel1" runat="server" BorderStyle="Dashed" BorderWidth="1px" 
                                        Height="520px" width="560px">
                                        <table width="100%">
                                            <tr>
                                                <td align="center" colspan="3" height="40px">
                                                    <asp:Label ID="lbl_Titulo15" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" Font-Size="Large" ForeColor="#0000CC">Esqueceu sua 
                                                    senha ?</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" bgcolor="#00554F" colspan="3" height="1px"></td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3" height="1px">
                                                    <asp:Label ID="lbl_Titulo36" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" Font-Size="X-Small" ForeColor="#0000CC">Informe os 
                                                    dados abaixo para enviarmos sua senha</asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="4px">
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_Titulo2" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" Font-Size="Small" ForeColor="#0000CC">C.N.P.J. :</asp:Label>
                                                    <br />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_CNPJ" runat="server" CssClass="form-control" ForeColor="Black" 
                                                        Width="300px" MaxLength="18">Digite aqui apenas se você for pessoa jurídica</asp:TextBox>
                                                    <br />
                                                    <asp:Label ID="lbl_Titulo4" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" Font-Size="X-Small" ForeColor="#0000CC">(digite somente 
                                                    os números)</asp:Label>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="4px">
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_Titulo5" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" Font-Size="Small" ForeColor="#0000CC">C.P.F. :</asp:Label>
                                                    <br />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_CPF" runat="server" CssClass="form-control" ForeColor="Black" 
                                                        MaxLength="14" Width="300px">Digite aqui apenas se você for pessoa física</asp:TextBox>
                                                    <br />
                                                    <asp:Label ID="lbl_Titulo12" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" Font-Size="X-Small" ForeColor="#0000CC">(digite somente 
                                                    os números)</asp:Label>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="4px">
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbl_Titulo6" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" Font-Size="Small" ForeColor="#0000CC">E-mail :</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_Email" runat="server" CssClass="form-control" ForeColor="Black" 
                                                        MaxLength="50" Width="300px">Digite aqui seu e-mail</asp:TextBox>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtCaptcha" runat="server" Width="10px" BorderColor="White" BorderStyle="None" ForeColor="White"></asp:TextBox>
                                                </td>
                                                <td align="right">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td align="center"><div id="ReCaptchContainer"></div>
                                                    <label id="lblMessage" runat="server" clientidmode="static" visible="False"></label> 
                                                    <div class="g-recaptcha" data-sitekey="6Lf26n0UAAAAAGrX52ppYaF5BdsEHsPUIr_2f6yJ"></div></td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                          
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2">
                                                    <asp:Button ID="btn_entrar_senha" runat="server" BackColor="#00554F" 
                                                        Font-Bold="True" ForeColor="White" Height="40px" Text="ENVIAR SENHA" 
                                                        Width="150px" />
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    Se você não esqueceu sua senha,&nbsp;
                                                    <asp:LinkButton ID="LinkButton4" runat="server" Font-Bold="True">Clique aqui</asp:LinkButton>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                               
                              <td width="4%">
                            &nbsp;</td>
                                        
                    </tr>
                    
                </table>
                </td>
        </tr>
        <tr>
           <td><asp:Panel ID="pnlpopup" runat="server" CssClass="popUpStyle" width="580px" style="display:none;">
                    <table align="center" bgcolor="#FFFF99" frame="border" border="0" 
                                                        cellpadding="1" cellspacing="1" rules="none" width="100%">
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td align="right">
                                                                &nbsp;</td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td align="center">
                                                                <asp:Label ID="Label566" runat="server" Font-Bold="True" Font-Size="Medium" 
                                                                    ForeColor="#CC3300" Text="A T E N Ç Ã O   ! ! !"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td align="center">
                                                               <!-- os botoes abaixo sao somente para o popup funcionar corretamente-->
                                                               <asp:Button ID="Button1" runat="server" Text="Salvar" style="display:none;" />
                                                               <asp:Button ID="Button2" runat="server" Text="Cancelar" style="display:none;" />     
                                                               
                                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                            </td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td align="center">
                                                                <asp:Label ID="lbl_mensagem_1" runat="server" Font-Bold="True" 
                                                                    Font-Size="Medium" ForeColor="#669900"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td align="center">
                                                                &nbsp;</td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td align="center">
                                                                <asp:Label ID="lbl_mensagem_2" runat="server" Font-Bold="True" 
                                                                    Font-Size="Medium" ForeColor="#669900"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td align="center">
                                                                &nbsp;</td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td align="center">
                                                                &nbsp;</td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td align="center">
                                                                <asp:Button ID="btn_Confirma_Exclusao" runat="server" 
                                                                    BackColor="#00554F" Font-Bold="True" Font-Names="Verdana" ForeColor="White" 
                                                                    Height="40px" Text="S I M" Visible="False" Width="150px" />
                                                                &nbsp;&nbsp;&nbsp;                                                                
                                                                <asp:Button ID="btn_Nao_Confirma" runat="server" BackColor="#00554F" 
                                                                    Font-Bold="True" Font-Names="Verdana" ForeColor="White" Height="40px" 
                                                                    Text="N Â O" Visible="False" Width="150px" />
                                                            </td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td align="center">
                                                                <asp:Button ID="img_btn_Fechar_Mensagem" runat="server" BackColor="#00554F" 
                                                                    Font-Bold="True" Font-Names="Verdana" ForeColor="White" Height="40px" 
                                                                    Text="FECHAR" Visible="False" Width="150px" />
                                                                <asp:Button ID="img_btn_sair_Mensagem" runat="server" BackColor="#00554F" 
                                                                    Font-Bold="True" Font-Names="Verdana" ForeColor="White" Height="40px" 
                                                                    Text="FECHAR" Visible="False" Width="150px" />
                                                            </td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                    </table>

                        </asp:Panel>
                         <asp:ModalPopupExtender ID="MPE_Senha" runat="server" 
                     BackgroundCssClass="popUpStyle1" PopupControlID="pnlpopup" 
                     DynamicServicePath="" Enabled="True"  
                     TargetControlID="Button1"  
                     CancelControlID="Button2" OkControlID="Button1"
                     />
           </td>
        </tr>
        <tr>
           <td width="5%" align="center" colspan="5" style="width: 20%" bgcolor="#00554F" forecolor="White">
                <table class="style17" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="style18">
                            </td>
                        <td class="style18" style="color: #FFFFFF">
                            Copyright @2018: Fundação Cultural Cassiano Ricardo                        <td class="style18">
                            </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
           <td width="5%" align="center" colspan="5" style="width: 20%">
                &nbsp;</td>
        </tr>
       </table>
      
    
    </form>
      <script src="https://www.google.com/recaptcha/api.js?onload=renderRecaptcha&render=explicit" async defer></script>  
     
</body>
</html>
