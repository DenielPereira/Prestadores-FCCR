<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login_Cadastro.aspx.vb" Inherits="Login_Cadastro"  MaintainScrollPositionOnPostBack = "True"%>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" >
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
      function PerdeFoco_Senha(idObjeto)
        {
       
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
      function RecebeFoco_Senha(idObjeto)
        {
        document.getElementById(idObjeto).value = "";
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
       
    <asp:toolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager2" ScriptMode="Release"  />
   
        <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="White">
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
                                    <asp:Panel ID="Panel1" runat="server" BorderStyle="Solid" BorderWidth="1px" 
                                        Height="520px" width="580px">
                                        <table width="580px">
                                            <tr>
                                            <td width="10%">
                                                    &nbsp;</td>
                                                <td align="center" colspan="3" height="40px" width="80%">
                                                    <asp:Label ID="lbl_Titulo15" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" Font-Size="Large" ForeColor="#0000CC">Login</asp:Label>
                                                </td>
                                                <td width="10%">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                            <td width="10%" height="1px">
                                                    &nbsp;</td>
                                                <td align="center" bgcolor="#00554F" colspan="3" width="80%"></td>
                                                <td width="10%">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                             <td width="10%">
                                                    &nbsp;</td>
                                                <td height="4px" width="25%">
                                                    &nbsp;</td>
                                                <td width="55%">
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                     <td width="10%">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                             <td height="22px" >&nbsp;</td>
                                                <td bgcolor="#00554F" height="22px">
                                                    <asp:Label ID="lbl_Titulo2" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana"  ForeColor="White" 
                                                        BackColor="#00554F">C.N.P.J. :</asp:Label>
                                                    <br />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_CNPJ" runat="server" CssClass="campo" ForeColor="Black" 
                                                        Width="300px" MaxLength="18" Height="30px" 
                                                        ToolTip="Digite aqui apenas se você for pessoa jurídica">Digite aqui apenas se você for pessoa jurídica</asp:TextBox>
                                                    <asp:Label ID="lbl_Titulo4" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" Font-Size="X-Small" ForeColor="#0000CC">(digite somente 
                                                    os números)</asp:Label>
                                                    <br />
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                                    <td >&nbsp;</td>
                                            </tr>
                                            <tr>
                                            <td >&nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                    <td >&nbsp;</td>
                                            </tr>
                                            <tr>
                                            <td>&nbsp;</td>
                                               <td bgcolor="#00554F" height="30px">
                                                    <asp:Label ID="lbl_Titulo5" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" ForeColor="White">C.P.F. :</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_CPF" runat="server" CssClass="campo" ForeColor="Black" 
                                                        MaxLength="14" Width="300px" Height="30px" 
                                                        ToolTip="Digite aqui apenas se você for pessoa física">Digite aqui apenas se você for pessoa física</asp:TextBox>
                                                    <asp:Label ID="lbl_Titulo12" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" Font-Size="X-Small" ForeColor="#0000CC">(digite somente 
                                                    os números)</asp:Label>
                                                    <br />
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                                    <td >&nbsp;</td>
                                            </tr>
                                            <tr>
                                            <td >&nbsp;</td>
                                                <td height="4px">
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                    <td >&nbsp;</td>
                                            </tr>
                                            <tr>
                                            <td >&nbsp;</td>
                                                <td bgcolor="#00554F" >
                                                    <asp:Label ID="lbl_Titulo6" runat="server" Font-Bold="True" 
                                                        Font-Names="Verdana" ForeColor="White">Senha :</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txt_Senha" runat="server" 
                                                        CssClass="campo" ForeColor="Black" Height="30px" MaxLength="10" 
                                                        Width="300px" TextMode="Password" ToolTip="Digite aqui sua senha">Digite aqui sua senha</asp:TextBox>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                    <td >&nbsp;</td>
                                            </tr>
                                            <tr>
                                            <td >&nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td align="right">
                                                    <asp:LinkButton ID="lnk_esqueceu" runat="server" Font-Bold="True">Esqueceu sua 
                                                    senha ?</asp:LinkButton>
                                                    &nbsp;&nbsp;&nbsp;&nbsp; </td>
                                                <td>
                                                    &nbsp;</td>
                                                    <td >&nbsp;</td>
                                            </tr>
                                            <tr>
                                            <td >&nbsp;</td>
                                                <td>
                                                    <asp:TextBox ID="txtCaptcha" runat="server" BackColor="White" BorderStyle="None" ForeColor="White" Width="10px"></asp:TextBox>
                                                </td>
                                                <td> &nbsp;  </td>
                                                <td>
                                                    &nbsp;</td>
                                                    <td >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td colspan="3" align="center"><div id="ReCaptchContainer"></div>
                                                    <label id="lblMessage" runat="server" clientidmode="static" visible="False"></label> 
                                                    <div class="g-recaptcha" data-sitekey="6Lf26n0UAAAAAGrX52ppYaF5BdsEHsPUIr_2f6yJ"></div> </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td align="center" colspan="3">&nbsp;</td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                            <td >&nbsp;</td>
                                                <td align="center" colspan="2">
                                                    <asp:Button ID="btn_entrar" runat="server" BackColor="#00554F" Font-Bold="True" 
                                                        ForeColor="White" Height="40px" Text="ENTRAR" Width="150px" />
                                                </td>
                                                <td>&nbsp;</td>
                                                <td >&nbsp;</td>
                                            </tr>
                                            <tr>
                                            <td >&nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    Ainda não é cadastrado ?&nbsp;
                                                    <asp:LinkButton ID="LinkButton4" runat="server" Font-Bold="True">Clique aqui</asp:LinkButton>
                                                </td>
                                                <td>
                                                    &nbsp;</td>
                                                    <td >&nbsp;</td>
                                            </tr>
                                            <tr>
                                            <td >&nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                <td>
                                                    &nbsp;</td>
                                                    <td >&nbsp;</td>
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
                         <asp:ModalPopupExtender ID="MPE_Login" runat="server" 
                     BackgroundCssClass="popUpStyle1" PopupControlID="pnlpopup" 
                     Enabled="True"  
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
                            Copyright @2018: Fundação Cultural Cassiano Ricardo               <td class="style18">
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
