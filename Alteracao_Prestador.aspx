﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Alteracao_Prestador.aspx.vb" Inherits="Alteracao_Prestador" MaintainScrollPositionOnPostBack = "True" %>


<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
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

        //valida email
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

        function validarCPFx(cpfvalue) {
            var cpf = cpfvalue.value;
            exp = /\.|\-/g
            cpf = cpf.toString().replace(exp, "");
               if(cpf == '') return false;       
               // Elimina CPFs invalidos conhecidos     
               if (cpf.length != 11 ||         
                cpf == "00000000000" ||          
                cpf == "11111111111" ||          
                cpf == "22222222222" ||          
                cpf == "33333333333" ||         
                 cpf == "44444444444" ||          
                 cpf == "55555555555" ||         
                  cpf == "66666666666" ||          
                  cpf == "77777777777" ||          
                  cpf == "88888888888" ||          
                  cpf == "99999999999")         
                  return false;           
                  // Valida 1o digito     
                  add = 0;     
                  for (i=0; i < 9; i ++)         
                  add += parseInt(cpf.charAt(i)) * (10 - i);     
                  rev = 11 - (add % 11);     
                  if (rev == 10 || rev == 11)         
                  rev = 0;     
                  if (rev != parseInt(cpf.charAt(9)))         
                  return false;
              // Valida 2o digito
              add = 0;
              for (i = 0; i < 10; i++)
                  add += parseInt(cpf.charAt(i)) * (11 - i);
              rev = 11 - (add % 11);
              if (rev == 10 || rev == 11)
                  rev = 0;
              if (rev != parseInt(cpf.charAt(10)))
                  return false;
              return true;     
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
    
            .drag
         {
                 background-color: #dddddd;
                 cursor: move;
              border:solid 1px gray ;
    }
    
.campo {font-family: Verdana, Arial, Helvetica, sans-serif;
font-size: 11px; color: #4E6070;
background-color: #FFFFFF; border: 1px solid #999999; 
            height: 17px;
            margin-bottom: 0px;
        }


    .MyTabStyle .ajax__tab_header
        {
            background: transparent; 
    border: none; 
   
    -moz-border-radius: 0px; 
    -webkit-border-radius: 0px; 
    -border-radius: 0px; 
     text-align: center; 

        }
        .MyTabStyle .ajax__tab_header .ajax__tab_outer
        {
            border-color: #222;
            color: #222;
            padding-left: 10px;
            margin-right: 3px;
            border: none;
        }
        .MyTabStyle .ajax__tab_header .ajax__tab_inner
        {
            border-color: #666;
            color: #666;
            padding: 3px 10px 2px 0px;
             border: none;
            
        }
        .MyTabStyle .ajax__tab_hover .ajax__tab_outer
        {
            background-color:#9c3;
             border: none;
        }
        .MyTabStyle .ajax__tab_hover .ajax__tab_inner
        {
            color: #fff;
             border: none;
               font-weight:bolder;
              font-size:medium;
        }
        .MyTabStyle .ajax__tab_active .ajax__tab_outer
        {
            border-bottom-color: #ffffff;
           background: transparent;
              font-weight:bolder;
              font-size:medium;
         
    border: none; 
    color: #459e00;
        }
        .MyTabStyle .ajax__tab_active .ajax__tab_inner
        {
            color: #000;
            border-color: #333;
            
    border: none; 
    font-weight:bolder;
      font-size:medium;
        }
        .MyTabStyle .ajax__tab_body
        {
            font-family: verdana,tahoma,helvetica;
            /*font-size: 10pt;*/            
            background-color: #fff;
            border-top-width: 0;
            border: none;
            /*border-top-color: #ffffff;*/
        }        
          .MyTabStyle .ajax__tab_tab
        {
           
    color: #666666;   
    height:35px;

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


    
</head>
<body>
    <form id="Form1" name="form1" runat="server" enctype="multipart/form-data">
    
    
    <asp:toolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager1" ScriptMode="Release"  />
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
     <table  align="center" width="100%" height="640px" >
     <tr>
                 <td width="20%" valign="top" height="100%" bgcolor="#00554F">
            <asp:Panel ID="Panel1" runat="server" height="100%">
                         <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#00554F">
                    <tr>
                        <td width="25px">
                            &nbsp;</td>
                        <td>
                            <asp:Image ID="Image2" runat="server" EnableTheming="True" Height="72px" 
                                ImageAlign="Middle" ImageUrl="~/Imagens/Logotipos/fccr_horizontal.png" 
                                Width="211px" />
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
                            <asp:LinkButton ID="lnk_Menu_Inicial" runat="server" CausesValidation="False" 
                                Font-Names="Verdana" Font-Size="Small" ForeColor="White">Página Inicial</asp:LinkButton>
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
                            <asp:LinkButton ID="lnk_Meusdados" runat="server" CausesValidation="False" 
                                Font-Names="Verdana" Font-Size="Small" ForeColor="White">Meus dados</asp:LinkButton>
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
                            <asp:LinkButton ID="lnk_Material" runat="server" CausesValidation="False" 
                                Font-Names="Verdana" Font-Size="Small" ForeColor="White">Materiais</asp:LinkButton>
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
                            <asp:LinkButton ID="lnk_Servico" runat="server" CausesValidation="False" 
                                Font-Names="Verdana" Font-Size="Small" ForeColor="White">Serviços</asp:LinkButton>
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
                            <asp:LinkButton ID="lnk_Prestador" runat="server" CausesValidation="False" 
                                Font-Names="Verdana" Font-Size="Small" ForeColor="White">Prestadores</asp:LinkButton>
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
                            <asp:LinkButton ID="lnk_Documento" runat="server" CausesValidation="False" 
                                Font-Names="Verdana" Font-Size="Small" ForeColor="White">Documentação</asp:LinkButton>
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
                                     <asp:LinkButton ID="lnk_Menu_Anterior" runat="server" CausesValidation="False" 
                                         ForeColor="White">Menu Anterior</asp:LinkButton>
                                 </td>
                                 <td>
                                     &nbsp;</td>
                             </tr>
                             <tr>
                                 <td>
                                     &nbsp;</td>
                                 <td>
                                     <br />
                                     <br />
                                     <asp:TextBox ID="txt_CNPJ" runat="server" CssClass="form-control" Enabled="False" 
                                         Font-Bold="True" ReadOnly="True" Visible="False" Width="156px"></asp:TextBox>
                                     <br />
                                     <asp:Label ID="lbl_perfil" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                         Font-Size="Small" ForeColor="#669900" Visible="False"></asp:Label>
                                     <br />
                                     <asp:Label ID="lbl_TipoEmpresa" runat="server" Font-Bold="True" 
                                         Font-Names="Verdana" Font-Size="Small" ForeColor="#669900" Visible="False"></asp:Label>
                                     <br />
                                     <asp:Label ID="lbl_TipoEmpresa_cod" runat="server" Font-Bold="True" 
                                         Font-Names="Verdana" Font-Size="Small" ForeColor="#669900" Visible="False"></asp:Label>
                                     <br />
                                     <asp:Label ID="lbl_TipoPrestador" runat="server" Font-Bold="True" 
                                         Font-Names="Verdana" Font-Size="Small" ForeColor="#669900" Visible="False"></asp:Label>
                                     <br />
                                     <asp:Label ID="lbl_codcadastro" runat="server" Font-Bold="True" 
                                         Font-Names="Verdana" Font-Overline="False" Font-Size="Medium" 
                                         Font-Strikeout="False" ForeColor="#9933FF" Visible="False"></asp:Label>
                                     <br />
                                 </td>
                                 <td>
                                     &nbsp;</td>
                             </tr>
                </table>
                </asp:Panel>
                </td>
                <td valign="top" bgcolor="white">
                <table  cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="white" align="center" >
            
        <tr>
            <td width="20px">
                &nbsp;</td>
            <td>
        <asp:Label runat="server" ID="CurrentTab" />
        <asp:Label runat="server" ID="Messages" />
                                 </td>
            <td>
                &nbsp;</td>
            <td width="20px">
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20px">
                &nbsp;</td>
            <td align="center" colspan="2">
                <asp:Label ID="lbl_nome_prestador" runat="server" Font-Bold="True" Font-Names="Verdana" 
                    Font-Overline="False" Font-Size="Medium" 
                    Font-Strikeout="False" ForeColor="Black"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20px">
                &nbsp;</td>
            <td align="center" colspan="2">
                <asp:Label ID="lbl_cnpj_codigo" runat="server" Font-Bold="False" Font-Names="Verdana" 
                    Font-Overline="False" Font-Size="Medium" 
                    Font-Strikeout="False" ForeColor="Black"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        
        <tr>
            <td width="20px">&nbsp;</td>
            <td  background="Imagens/Backgrounds/LinhaS.gif" align="center" colspan="2" >&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
              
        <tr>
            <td width="20px">
                &nbsp;</td>
            <td colspan="2">
                <asp:TabContainer runat="server" ScrollBars="Auto" ID="Tabs"  
                    ActiveTabIndex="0" borderstyle="None" EnableTheming="true" 
                    CssClass="MyTabStyle" >
                <asp:TabPanel runat="server" HeaderText="Identificação"  ID="TabPanel_1" Enabled="true" Visible="true" Height="500px" TabIndex="0">
                    <HeaderTemplate></HeaderTemplate>
                <ContentTemplate><table width="100%"><tr><td width="20px">&#160;</td><td width="150px">Trabalho oferecido :</td><td><asp:DropDownList 
                        ID="ddl_Servico" runat="server" AutoPostBack="True" 
            CssClass="form-control" Height="30px" 
            ToolTip="Informe aqui o Estado de sua Inscrição Municipal" Width="250px" 
                        Enabled="False"><asp:ListItem Value="0"> Selecione uma opção</asp:ListItem><asp:ListItem Value="1">Serviços Artísticos</asp:ListItem><asp:ListItem Value="2">Bens e outros serviços</asp:ListItem></asp:DropDownList><asp:Label ID="Label564" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td></tr><tr><td width="20px">&#160;</td><td width="150px">Categoria :</td><td><asp:DropDownList 
                            ID="ddl_Categoria" runat="server" AutoPostBack="True" 
                CssClass="form-control" Height="30px" 
                ToolTip="Informe aqui o Estado de sua Inscrição Municipal" Width="250px" 
                            Enabled="False"><asp:ListItem Value="0"> Selecione uma opção</asp:ListItem><asp:ListItem Value="6">Micro Empreendedor Individual ( M.E.I. )</asp:ListItem><asp:ListItem Value="7">Micro Empresa ( M.E. )</asp:ListItem><asp:ListItem Value="3">Empresa Individual</asp:ListItem><asp:ListItem Value="4">Empresa Ltda</asp:ListItem><asp:ListItem Value="1">Associações e Cooperativas</asp:ListItem><asp:ListItem Value="5">Empresa Individual de Responsabilidade Limitada (E.I.R.E.L.I.)</asp:ListItem><asp:ListItem Value="6">Pessoa Física</asp:ListItem><asp:ListItem Value="2">Empresa de Pequeno Porte (EPP)</asp:ListItem><asp:ListItem Value="8">Sociedade Anônima (S/A)</asp:ListItem><asp:ListItem Value="9">Sociedade Simples (SS)</asp:ListItem></asp:DropDownList><asp:Label ID="Label565" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td></tr><tr><td width="20px">&#160;</td><td colspan="2"><asp:Panel ID="pnl_PF" runat="server" Visible="False"><table><tr><td width="150px">
                        <br />
                        Nome :<br /> </td><td><asp:TextBox ID="txt_PF_Nome_alt" runat="server" CssClass="form-control" 
                                MaxLength="70" onkeyup="this.value=this.value.toUpperCase();" 
                                ToolTip="Informe aqui sua Razão Social" Width="400px"></asp:TextBox></td></tr><tr><td>RG : </td><td><asp:TextBox ID="txt_PF_RG_alt" runat="server" CssClass="form-control" MaxLength="20" 
                                ToolTip="Informe aqui sua Inscrição Estadual, se não houver, informe ISENTO " Width="300px"></asp:TextBox></td></tr><tr><td>PIS/PASEP :</td><td><asp:TextBox ID="txt_PF_PISPASEP_alt" runat="server" CssClass="form-control" 
                                MaxLength="14" 
                                ToolTip="Informe aqui sua Inscrição Estadual, se não houver, informe ISENTO " Width="300px"></asp:TextBox></td></tr><tr><td>NIT :</td><td><asp:TextBox ID="txt_PF_NIT_alt" runat="server" CssClass="form-control" MaxLength="14" 
                                ToolTip="Informe aqui sua Inscrição Estadual, se não houver, informe ISENTO " Width="300px"></asp:TextBox></td></tr><tr><td>Nacionalidade :</td><td><asp:TextBox ID="txt_PF_Nacionalidade_alt" runat="server" CssClass="form-control" 
                                MaxLength="30" onkeyup="this.value=this.value.toUpperCase();" 
                                ToolTip="Informe aqui a nacionalidade do Requesentante Legal da Empresa" 
                                Width="300px"></asp:TextBox></td></tr><tr><td>Estado Civil :</td><td><asp:DropDownList ID="ddl_PF_EstadoCivil_alt" runat="server" Height="30px" 
                                ToolTip="Informe aqui o estado civil do Requesentante Legal da Empresa" 
                                Width="300px" CssClass="form-control"><asp:ListItem Value=" Selecione"> Selecione uma opção</asp:ListItem><asp:ListItem>SOLTEIRO</asp:ListItem><asp:ListItem>CASADO</asp:ListItem><asp:ListItem>DIVORCIADO</asp:ListItem><asp:ListItem>VIÚVO</asp:ListItem></asp:DropDownList></td></tr><tr><td>Profissão :</td><td><asp:TextBox ID="txt_PF_Profissao_alt" runat="server" CssClass="form-control" 
                                MaxLength="50" onkeyup="this.value=this.value.toUpperCase();" 
                                ToolTip="Informe aqui a profissão do Requesentante Legal da Empresa" 
                                Width="300px"></asp:TextBox></td></tr></table><br /></asp:Panel></td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td colspan="2"><asp:Panel ID="pnl_PJ" runat="server" 
                            Visible="False"><table 
                            class="style2"><tr><td width="150px">Razão Social :</td><td><asp:TextBox ID="txt_Razao_Social" runat="server" 
                                    CssClass="form-control" MaxLength="70" onkeyup="this.value=this.value.toUpperCase();" 
                                    ToolTip="Informe aqui sua Razão Social" Width="400px"></asp:TextBox><asp:Label 
                                    ID="Label43" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label><asp:RequiredFieldValidator 
                                    ID="RV_RazaoSocial" runat="server" ControlToValidate="txt_Razao_Social" 
                                    ErrorMessage="Informe a Razão Social">*</asp:RequiredFieldValidator></td></tr><tr><td>Nome Fantasia :</td><td><asp:TextBox 
                                ID="txt_Nome_Fantasia" runat="server" CssClass="form-control" MaxLength="25" 
                                onkeyup="this.value=this.value.toUpperCase();" 
                                ToolTip="Informe aqui seu Nome Fantasia caso tenha" Width="300px"></asp:TextBox><asp:Label 
                                ID="Label44" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label><asp:RequiredFieldValidator 
                                ID="RV_NomeFantasia" runat="server" ControlToValidate="txt_Nome_Fantasia" 
                                ErrorMessage="Informe o Nome Fantasia">*</asp:RequiredFieldValidator></td></tr><tr><td>Inscrição Estadual :</td><td><asp:TextBox 
                                ID="txt_IEstadual" runat="server" CssClass="form-control" MaxLength="20" 
                                ToolTip="Informe aqui sua Inscrição Estadual, se não houver, informe ISENTO " Width="300px"></asp:TextBox>
                                <br />
                                </td></tr><tr><td>Inscrição Municipal :</td><td><asp:TextBox 
                                ID="txt_IMunicipal" runat="server" CssClass="form-control" MaxLength="20" 
                                ToolTip="Informe aqui sua Incrição Municipal" Width="300px"></asp:TextBox><asp:Label 
                                ID="Label45" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label><asp:RequiredFieldValidator 
                                ID="RV_IMunicipal" runat="server" ControlToValidate="txt_IMunicipal" 
                                ErrorMessage="Informe a Inscrição Municipal">*</asp:RequiredFieldValidator></td></tr><tr><td>&#160;</td><td>Cidade da Inscrição: <asp:TextBox 
                                ID="txt_IM_Cidade" runat="server" CssClass="form-control" MaxLength="50" 
                                onkeyup="this.value=this.value.toUpperCase();" 
                                ToolTip="Informe aqui a cidade de sua Inscrição Municipal" Width="407px"></asp:TextBox></td></tr><tr><td>&#160;</td><td>UF : <asp:DropDownList 
                                ID="ddl_IM_UF" runat="server" CssClass="form-control" Height="30px" 
                                ToolTip="Informe aqui o Estado de sua Inscrição Municipal" Width="300px"><asp:ListItem 
                                Value="Selecione "> Selecione uma opção</asp:ListItem><asp:ListItem 
                                Value="DF">DISTRITO FEDERAL</asp:ListItem><asp:ListItem Value="AC">ACRE</asp:ListItem><asp:ListItem 
                                Value="AL">ALAGOAS</asp:ListItem><asp:ListItem Value="AP">AMAPÁ</asp:ListItem><asp:ListItem 
                                Value="AM">AMAZONAS</asp:ListItem><asp:ListItem Value="BA">BAHIA</asp:ListItem><asp:ListItem 
                                Value="CE">CEARÁ</asp:ListItem><asp:ListItem Value="ES">ESPÍRITO SANTO</asp:ListItem><asp:ListItem 
                                Value="GO">GOIÁS</asp:ListItem><asp:ListItem Value="MA">MARANHÃO</asp:ListItem><asp:ListItem 
                                Value="MT">MATO GROSSO</asp:ListItem><asp:ListItem Value="MS">MATO GROSSO DO SUL</asp:ListItem><asp:ListItem 
                                Value="MG">MINAS GERAIS</asp:ListItem><asp:ListItem Value="PR">PARANÁ</asp:ListItem><asp:ListItem 
                                Value="PB">PARAÍBA</asp:ListItem><asp:ListItem Value="PA">PARÁ</asp:ListItem><asp:ListItem 
                                Value="PE">PERNAMBUCO</asp:ListItem><asp:ListItem Value="PI">PIAUÍ</asp:ListItem><asp:ListItem 
                                Value="RJ">RIO DE JANEIRO</asp:ListItem><asp:ListItem Value="RN">RIO GRANDE DO NORTE</asp:ListItem><asp:ListItem 
                                Value="RS">RIO GRANDE DO SUL</asp:ListItem><asp:ListItem Value="RO">RONDÔNIA</asp:ListItem><asp:ListItem 
                                Value="RR">RORAIMA</asp:ListItem><asp:ListItem Value="SC">SANTA CATARINA</asp:ListItem><asp:ListItem 
                                Value="SE">SERGIPE</asp:ListItem><asp:ListItem Value="SP">SÃO PAULO</asp:ListItem><asp:ListItem 
                                Value="TO">TOCANTINS</asp:ListItem></asp:DropDownList>
                                <br />
                                </td></tr><tr><td>Código CNAE :</td><td><asp:TextBox ID="txt_PJ_CNAE_Cod" runat="server" 
                                    CssClass="form-control" MaxLength="9" 
                                    ToolTip="Informe aqui sua Inscrição Estadual, se não houver, informe ISENTO " Width="300px"></asp:TextBox>
                                <br />
                                </td></tr><tr><td>Descrição CNAE :</td><td><asp:TextBox 
                                ID="txt_PJ_CNAE_Desc" runat="server" CssClass="form-control" MaxLength="150" 
                                onkeyup="this.value=this.value.toUpperCase();" 
                                ToolTip="Informe aqui a cidade de sua Inscrição Municipal" Width="400px"></asp:TextBox></td></tr><tr><td>&#160;</td><td>&#160;</td></tr><tr><td>Representante :</td><td><asp:TextBox 
                            ID="txt_Representante" runat="server" CssClass="form-control" MaxLength="50" 
                            onkeyup="this.value=this.value.toUpperCase();" 
                            ToolTip="Informe aqui o nome do Requesentante Legal da Empresa" Width="400px"></asp:TextBox>
                            <br />
                            </td></tr><tr><td>Cargo :</td><td><asp:TextBox 
                                ID="txt_Representante_Cargo" runat="server" CssClass="form-control" MaxLength="40" 
                                onkeyup="this.value=this.value.toUpperCase();" 
                                ToolTip="Informe aqui o cargo do Requesentante Legal da Empresa" Width="400px"></asp:TextBox>
                                <br />
                                </td></tr><tr><td>C.P.F. :</td><td><asp:TextBox 
                                ID="txt_CPF" runat="server" CssClass="form-control" MaxLength="20" 
                                ToolTip="Informe aqui o CPF do Requesentante Legal da Empresa" Width="300px"></asp:TextBox>
                                <br />
                                </td></tr><tr><td>R.G. :</td><td><asp:TextBox 
                                ID="txt_RG" runat="server" CssClass="form-control" MaxLength="20" 
                                onkeyup="this.value=this.value.toUpperCase();" 
                                ToolTip="Informe aqui o RG do Requesentante Legal da Empresa"></asp:TextBox>
                                <br />
                                </td></tr><tr><td>Nacionalidade :</td><td><asp:TextBox 
                                ID="txt_Nacionalidade" runat="server" CssClass="form-control" MaxLength="30" 
                                onkeyup="this.value=this.value.toUpperCase();" 
                                ToolTip="Informe aqui a nacionalidade do Requesentante Legal da Empresa" 
                                Width="300px"></asp:TextBox>
                                <br />
                                </td></tr><tr><td>Estado Civil :</td><td><asp:DropDownList 
                                ID="ddl_Representante_EstadoCivil" runat="server" Height="30px" 
                                ToolTip="Informe aqui o estado civil do Requesentante Legal da Empresa" 
                                Width="300px" CssClass="form-control"><asp:ListItem Value=" Selecione"> Selecione uma opção</asp:ListItem><asp:ListItem>SOLTEIRO</asp:ListItem><asp:ListItem>CASADO</asp:ListItem><asp:ListItem>DIVORCIADO</asp:ListItem><asp:ListItem>VIÚVO</asp:ListItem></asp:DropDownList>
                                <br />
                                </td></tr><tr><td>Profissão :</td><td><asp:TextBox ID="txt_Representante_Profissao" 
                                    runat="server" CssClass="form-control" MaxLength="50" 
                                    onkeyup="this.value=this.value.toUpperCase();" 
                                    ToolTip="Informe aqui a profissão do Requesentante Legal da Empresa" 
                                    Width="300px"></asp:TextBox>
                                <br />
                                </td></tr><tr><td>E-mail :</td><td><asp:TextBox 
                                ID="txt_PJ_Representante_Email" runat="server" CssClass="form-control" MaxLength="50" 
                                onkeyup="this.value=this.value.toUpperCase();" 
                                ToolTip="Informe aqui a profissão do Requesentante Legal da Empresa" 
                                Width="300px"></asp:TextBox></td></tr></table></asp:Panel></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>C.E.P. :</td><td><asp:TextBox 
                        ID="txt_CEP" runat="server" CssClass="form-control" 
                        MaxLength="10" ToolTip="Informe aqui o código de endereçamento postal e em seguida clique no botão Pesquisar CEP para o preenchimento automático do Endereço, Bairro, Cidade e UF." 
                        Width="300px"></asp:TextBox>&#160;<asp:Button ID="btn_CEP" runat="server" 
                        CausesValidation="False" Height="40px" Text="Pesquisar CEP" Width="200px" />&#160;&#160;<asp:Label 
                        ID="Label46" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>&#160;<asp:RequiredFieldValidator 
                        ID="RV_CEP" runat="server" ControlToValidate="txt_CEP" 
                        ErrorMessage="Informe o CEP">*</asp:RequiredFieldValidator>
                    <br />
                    <br />
                    </td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Endereço :</td><td><asp:TextBox 
                        ID="txt_Endereco" runat="server" CssClass="form-control" MaxLength="100" 
                        ToolTip="Informe aqui o endereço da empresa" Width="400px" 
                        onkeyup="this.value=this.value.toUpperCase();"></asp:TextBox>&#160;<asp:Label 
                        ID="Label47" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>&#160;<asp:RequiredFieldValidator 
                        ID="RV_Endereco" runat="server" ControlToValidate="txt_Endereco" 
                        ErrorMessage="Informe o Endereço">*</asp:RequiredFieldValidator></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Número :</td><td><asp:TextBox 
                        ID="txt_Numero" runat="server" CssClass="form-control" MaxLength="10" 
                        ToolTip="Informe aqui o número do endereço da empresa" 
                        Width="200px"></asp:TextBox>&#160;<asp:Label ID="Label48" runat="server" 
                        ForeColor="#FF3300" Text=" * "></asp:Label>&#160;<asp:RequiredFieldValidator 
                        ID="RV_Numero" runat="server" ControlToValidate="txt_Numero" 
                        ErrorMessage="Informe o Número">*</asp:RequiredFieldValidator></td><td>&#160;</td></tr><tr><td width="20px">&nbsp;</td><td>Complemento :</td><td><asp:TextBox 
                        ID="txt_Complemento" runat="server" CssClass="form-control" MaxLength="50" 
                        onkeyup="this.value=this.value.toUpperCase();" 
                        
                        ToolTip="Informe aqui o complemento do endereço da empresa se houver : bloco, andar, sala, etc." 
                        Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&nbsp;</td></tr><tr><td width="20px">&nbsp;</td><td>Bairro :</td><td><asp:TextBox 
                        ID="txt_Bairro" runat="server" CssClass="form-control" MaxLength="50" 
                        onkeyup="this.value=this.value.toUpperCase();" 
                        ToolTip="Informe aqui o bairro da empresa" Width="400px"></asp:TextBox>
                    <br />
                    </td><td>&nbsp;</td></tr><tr><td width="20px">&#160;</td><td>Cidade :</td><td><asp:TextBox 
                        ID="txt_Cidade" runat="server" CssClass="form-control" MaxLength="50" 
                        onkeyup="this.value=this.value.toUpperCase();" 
                        ToolTip="Informe aqui a cidade da empresa" Width="400px"></asp:TextBox>&#160;<asp:Label 
                        ID="Label49" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>&#160;<asp:RequiredFieldValidator 
                        ID="RV_Cidade" runat="server" ControlToValidate="txt_Cidade" 
                        ErrorMessage="Informe a Cidade">*</asp:RequiredFieldValidator></td><td>&nbsp;</td></tr><tr><td width="20px">&#160;</td><td>UF :</td><td><asp:DropDownList 
                        ID="ddl_UF" runat="server" Height="30px" 
                        ToolTip="Informe aqui a Unidade da Federação da empresa" Width="300px" CssClass="form-control"><asp:ListItem 
                        Value="Selecione"> Selecione uma opção</asp:ListItem><asp:ListItem 
                        Value="DF">DISTRITO FEDERAL</asp:ListItem><asp:ListItem Value="AC">ACRE</asp:ListItem><asp:ListItem 
                        Value="AL">ALAGOAS</asp:ListItem><asp:ListItem Value="AP">AMAPÁ</asp:ListItem><asp:ListItem 
                        Value="AM">AMAZONAS</asp:ListItem><asp:ListItem Value="BA">BAHIA</asp:ListItem><asp:ListItem 
                        Value="CE">CEARÁ</asp:ListItem><asp:ListItem Value="ES">ESPÍRITO SANTO</asp:ListItem><asp:ListItem 
                        Value="GO">GOIÁS</asp:ListItem><asp:ListItem Value="MA">MARANHÃO</asp:ListItem><asp:ListItem 
                        Value="MT">MATO GROSSO</asp:ListItem><asp:ListItem Value="MS">MATO GROSSO DO SUL</asp:ListItem><asp:ListItem 
                        Value="MG">MINAS GERAIS</asp:ListItem><asp:ListItem Value="PR">PARANÁ</asp:ListItem><asp:ListItem 
                        Value="PB">PARAÍBA</asp:ListItem><asp:ListItem Value="PA">PARÁ</asp:ListItem><asp:ListItem 
                        Value="PE">PERNAMBUCO</asp:ListItem><asp:ListItem Value="PI">PIAUÍ</asp:ListItem><asp:ListItem 
                        Value="RJ">RIO DE JANEIRO</asp:ListItem><asp:ListItem Value="RN">RIO GRANDE DO NORTE</asp:ListItem><asp:ListItem 
                        Value="RS">RIO GRANDE DO SUL</asp:ListItem><asp:ListItem Value="RO">RONDÔNIA</asp:ListItem><asp:ListItem 
                        Value="RR">RORAIMA</asp:ListItem><asp:ListItem Value="SC">SANTA CATARINA</asp:ListItem><asp:ListItem 
                        Value="SE">SERGIPE</asp:ListItem><asp:ListItem Value="SP">SÃO PAULO</asp:ListItem><asp:ListItem 
                        Value="TO">TOCANTINS</asp:ListItem></asp:DropDownList>
                    <br />
                    </td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Telefone 1 :</td><td><asp:TextBox 
                        ID="txt_Telefone" runat="server" CssClass="form-control" MaxLength="25" 
                        ToolTip="Informe aqui o DDD e o telefone da empresa" Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Telefone 2 :</td><td><asp:TextBox 
                        ID="txt_PJ_Telefone1" runat="server" CssClass="form-control" MaxLength="25" 
                        ToolTip="Informe aqui o DDD e o telefone da empresa" Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Celular :</td><td><asp:TextBox 
                        ID="txt_Celular" runat="server" CssClass="form-control" MaxLength="25" 
                        ToolTip="Informe aqui o DDD e o celular da empresa" 
                        Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Whatszap corporativo :</td><td><asp:TextBox 
                        ID="txt_PF_Whatszap" runat="server" CssClass="form-control" MaxLength="25" 
                        ToolTip="Informe aqui o DDD e o celular da empresa" Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>E-mail 1 :</td><td><asp:TextBox 
                        ID="txt_Email" runat="server" CssClass="form-control" MaxLength="50" 
                        ToolTip="Informe aqui o endereço de email da empresa - ATENÇÃO !!! Este será o email de contato com a Fundação Cultural " 
                        Width="300px"></asp:TextBox><asp:RequiredFieldValidator ID="RV_Email" 
                        runat="server" ControlToValidate="txt_Email" ErrorMessage="Informe o email">*</asp:RequiredFieldValidator></td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td>E-mail 2 :</td><td><asp:TextBox ID="txt_PJ_Email1" 
                        runat="server" CssClass="form-control" MaxLength="50" 
                        ToolTip="Informe aqui o endereço de email da empresa - ATENÇÃO !!! Este será o email de contato com a Fundação Cultural " 
                        Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Site :</td><td><asp:TextBox 
                        ID="txt_Site" runat="server" CssClass="form-control" MaxLength="50" 
                        onkeyup="this.value=this.value.toUpperCase();" 
                        ToolTip="Informe aqui o endereço da home page empresa se houver" Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Pessoa de Contato :</td><td><asp:TextBox 
                        ID="txt_PJ_PessoaContato" runat="server" CssClass="form-control" MaxLength="50" 
                        onkeyup="this.value=this.value.toUpperCase();" 
                        ToolTip="Informe aqui o endereço da home page empresa se houver" Width="300px"></asp:TextBox></td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td>Banco :</td><td><asp:TextBox ID="txt_Banco_alt" 
                        runat="server" CssClass="form-control" MaxLength="3" 
                        ToolTip="Informe aqui o DDD e o celular da empresa" Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td>Agência :</td><td><asp:TextBox ID="txt_Agencia_alt" 
                        runat="server" CssClass="form-control" MaxLength="4" 
                        ToolTip="Informe aqui o DDD e o celular da empresa" Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td>Conta : </td><td><asp:TextBox ID="txt_Conta_alt" 
                        runat="server" CssClass="form-control" MaxLength="10" 
                        ToolTip="Informe aqui o DDD e o celular da empresa" Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td>Tipo de Conta : </td><td><asp:DropDownList 
                        ID="ddl_TipoConta_alt" runat="server" Height="30px" 
                        ToolTip="Informe aqui o estado civil do Requesentante Legal da Empresa" 
                        Width="300px" CssClass="form-control"><asp:ListItem Value=" Selecione "> Selecione uma opção</asp:ListItem><asp:ListItem>CORRENTE</asp:ListItem><asp:ListItem 
                        Value="POUPANCA">POUPANÇA</asp:ListItem></asp:DropDownList></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Senha :</td><td><asp:TextBox 
                        ID="txt_Senha" runat="server" CssClass="form-control" MaxLength="10" 
                        
                        ToolTip="Informe aqui sua senha com no mínimo 6 caracteres ( números e/ou letras)" 
                        Width="200px"></asp:TextBox><asp:Label ID="Label563" runat="server" 
                        ForeColor="#FF3300" Text=" * "></asp:Label><asp:RequiredFieldValidator 
                        ID="RV_Senha" runat="server" ControlToValidate="txt_Senha" 
                        ErrorMessage="Informe sua senha de acesso">*</asp:RequiredFieldValidator></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Confirme a Senha :</td><td><asp:TextBox 
                        ID="txt_Confirma_Senha" runat="server" CssClass="form-control" MaxLength="10" 
                        ToolTip="Redigite a senha para confirmá-la" Width="200px"></asp:TextBox></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Desejo receber e-mail<br />para atualização :</td><td><asp:RadioButtonList ID="rbl_email" runat="server" Height="32px" Width="202px" CssClass="radio"><asp:ListItem 
                        Selected="True" Value="1">Sim</asp:ListItem><asp:ListItem Value="0">Não</asp:ListItem></asp:RadioButtonList>
                    <br />
                    </td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>Desejo&#160; desativar<br />minha conta :</td><td><asp:RadioButtonList ID="rbl_desativado" runat="server" Width="202px"><asp:ListItem 
                        Value="1">Sim</asp:ListItem><asp:ListItem Value="0" Selected="True">Não</asp:ListItem></asp:RadioButtonList>
                    <br />
                    </td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td>Data :&#160;&#160;&#160;&#160; <asp:TextBox ID="txt_Data_Desativacao" runat="server" CssClass="form-control" 
                MaxLength="10" ToolTip="Redigite a senha para confirmá-la" Width="200px"></asp:TextBox></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td>Motivo : <asp:TextBox ID="txt_Motivo_Desativacao" runat="server" CssClass="form-control" 
                MaxLength="200" ToolTip="Redigite a senha para confirmá-la" Width="400px"></asp:TextBox></td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td align="center" colspan="2"><asp:Button 
                            ID="btn_grava_meusdados" runat="server" BackColor="#00554F" Font-Bold="True" 
                            Font-Names="Verdana" ForeColor="White" Height="40px" Text="ATUALIZAR CADASTRO" 
                            Width="250px" /></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td><asp:Label 
                        ID="lbl_datas" runat="server" Font-Bold="True" Font-Names="Verdana" 
                        Font-Overline="False" Font-Size="Small" Font-Strikeout="False" 
                        ForeColor="Black"></asp:Label></td><td>&#160;</td></tr></table>
                    
                    
                    </ContentTemplate>
                
</asp:TabPanel>
                
                <asp:TabPanel runat="server" ID="TabPanel_2" HeaderText="" Enabled="true">
                <ContentTemplate><table width="100%"><tr><td width="20px">&#160;</td><td align="center" style="font-weight: bold"><asp:Panel ID="pnl_prestador" runat="server" ><table cellpadding="0" cellspacing="0"><tr><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td>&#160;</td><td align="center" colspan="2" style="font-weight: bold">Informe, um a um, os prestadores de serviços de sua empresa.<br />Caso o próprio Representante Legal seja um dos Prestadores,&#160; <asp:LinkButton ID="lnk_auto_inclusao" runat="server" CausesValidation="False" 
                                Font-Bold="True" ForeColor="#3333CC">clique aqui</asp:LinkButton>&#160; para cadastrá-lo como um Prestador de Serviço.<br /><br />Se desejar cadastrar um Prestador&#160; <asp:LinkButton ID="lnk_inclui_prestador" runat="server" 
                        CausesValidation="False" Font-Bold="True" ForeColor="#3333CC">clique aqui</asp:LinkButton>&#160;.<br /><br />Para alterar os dados de um Prestador já cadastrado, clique no nome do prestador.</td><td>&#160;</td></tr><tr><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr></table></asp:Panel><asp:Panel ID="pnl_prestador_consulta" runat="server" Visible="False"><table cellpadding="0" cellspacing="0"><tr><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td>&#160;</td><td align="center" colspan="2" style="font-weight: bold">Para consultar os dados do Prestador cadastrado, clique no nome do prestador.</td><td>&#160;</td></tr><tr><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr></table></asp:Panel></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>
                    <asp:GridView 
                        ID="GridView2" runat="server" AllowSorting="True" 
                            AutoGenerateColumns="False" BorderColor="Gainsboro" BorderStyle="Solid" 
                            BorderWidth="1px" CellPadding="5" DataKeyNames="PrexPre_ID" 
                            DataSourceID="SqlPrexPre" OnRowCommand="GridView2_RowCommand" 
                            OnRowDataBound="GridView2_RowDataBound" Width="100%" PageSize="100" GridLines="None" ><Columns><asp:TemplateField HeaderText="Prestador"><ItemTemplate><asp:LinkButton ID="cmdDelete20" runat="server" CausesValidation="false" 
                                            CommandArgument='<%# Eval("PrexPre_ID") %>' CommandName="Delete20" 
                                            Text='<%# Bind("PrexPre_Nome") %>'> </asp:LinkButton></ItemTemplate><ItemStyle HorizontalAlign="Left" Width="250px" /></asp:TemplateField><asp:TemplateField HeaderText="Serviços" SortExpression="PrexPre_Servicos"><ItemTemplate><asp:Label ID="Label55" runat="server" Text='<%# Bind("PrexPre_Servicos") %>'></asp:Label></ItemTemplate><ItemStyle Width="80px" /></asp:TemplateField></Columns><AlternatingRowStyle BackColor="#E7E7E7" />
                        <FooterStyle ForeColor="#CCCCCC" />
                        <HeaderStyle BackColor="#FFFFFF" /><PagerStyle BackColor="WhiteSmoke" /><RowStyle BackColor="Transparent" ForeColor="Transparent" /><SelectedRowStyle BackColor="Transparent" Font-Bold="True" 
                                ForeColor="Transparent" /></asp:GridView></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td><table width="100%"><tr><td>&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td>&#160;</td><td colspan="2"><asp:Panel ID="pnl_prestador_detalhe" runat="server" Visible="False"><table class="style1"><tr><td>Nome :</td><td><asp:TextBox ID="txt_Prestador_Nome" runat="server" CssClass="form-control" 
                                                    MaxLength="70" onkeyup="this.value=this.value.toUpperCase();" 
                                                    ToolTip="Informe aqui o nome do Prestador de Serviço" Width="400px"></asp:TextBox><asp:Label ID="Label57" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>&#160;</td><td>&#160;</td></tr><tr><td>R.G. :</td><td><asp:TextBox ID="txt_Prestador_RG" runat="server" CssClass="form-control" 
                                                    MaxLength="20" ToolTip="Informe aqui o RG do Prestador de Serviço" 
                                                    Width="300px"></asp:TextBox><asp:Label ID="Label58" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td><td>&#160;</td></tr><tr><td>C.P.F. :</td><td><asp:TextBox ID="txt_Prestador_CPF" runat="server" CssClass="form-control" 
                                                    MaxLength="20" ToolTip="Informe aqui o CPF do Prestador de Serviço" 
                                                    Width="300px"></asp:TextBox><asp:Label ID="Label59" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td><td>&#160;</td></tr><tr><td>Nacionalidade :</td><td><asp:TextBox ID="txt_Prestador_Nacionalidade" runat="server" CssClass="form-control" 
                                                    MaxLength="30" onkeyup="this.value=this.value.toUpperCase();" 
                                                    ToolTip="Informe aqui a nacionalidade do Prestador de Serviço" Width="300px"></asp:TextBox><asp:Label ID="Label60" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td><td>&#160;</td></tr><tr><td>Estado Civil :</td><td><asp:DropDownList ID="ddl_Prestador_EstadoCivil" runat="server" 
                                                    ToolTip="Informe aqui o Estado Civil do Prestador de Serviço" Width="300px" Height="30px"><asp:ListItem Value=" "> Selecione uma opção</asp:ListItem><asp:ListItem>SOLTEIRO</asp:ListItem><asp:ListItem>CASADO</asp:ListItem><asp:ListItem>DIVORCIADO</asp:ListItem><asp:ListItem>VIÚVO</asp:ListItem></asp:DropDownList><asp:Label ID="Label61" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td><td>&#160;</td></tr><tr><td>Profissão :</td><td><asp:TextBox ID="txt_Prestador_Profissao" runat="server" CssClass="form-control" 
                                                    MaxLength="50" onkeyup="this.value=this.value.toUpperCase();" 
                                                    ToolTip="Informe aqui a Profissão do Prestador de Serviço" Width="300px"></asp:TextBox></td><td>&#160;</td></tr><tr><td>C.E.P. :</td><td><asp:TextBox ID="txt_Prestador_CEP" runat="server" CssClass="form-control" 
                                                    MaxLength="10" onkeyup="this.value=this.value.toUpperCase();" 
                                                    ToolTip="Informe aqui o código de endereçamento postal e em seguida clique no botão Pesquisar CEP para o preenchimento automático do Endereço, Bairro, Cidade e UF." 
                                                    Width="200px"></asp:TextBox><asp:Label ID="Label62" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>&#160;&nbsp;<asp:Button ID="btn_CEP_Prestador" runat="server" CausesValidation="False" 
                                                    Height="30px" Text="Pesquisar CEP" /></td><td>&#160;</td></tr><tr><td>Endereço :</td><td><asp:TextBox ID="txt_Prestador_Endereco" runat="server" CssClass="form-control" 
                                                    MaxLength="100" onkeyup="this.value=this.value.toUpperCase();" 
                                                    ToolTip="Informe aqui o endereço do Prestador de Serviço" Width="400px"></asp:TextBox><asp:Label ID="Label63" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td><td>&#160;</td></tr><tr><td>Número :</td><td><asp:TextBox ID="txt_Prestador_Numero" runat="server" CssClass="form-control" 
                                                    MaxLength="10" 
                                                    ToolTip="Informe aqui o número do endereço do Prestador de Serviço" 
                                                    Width="200px"></asp:TextBox><asp:Label ID="Label64" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td><td>&#160;</td></tr><tr><td>Complemento :</td><td><asp:TextBox ID="txt_Prestador_Complemento" runat="server" CssClass="form-control" 
                                                    MaxLength="50" onkeyup="this.value=this.value.toUpperCase();" 
                                                    ToolTip="Informe aqui o complemento do endereço do Prestador de Serviço se houver : bloco, andar, sala, etc." 
                                                    Width="300px"></asp:TextBox></td><td>&#160;</td></tr><tr><td>Bairro :</td><td><asp:TextBox ID="txt_Prestador_Bairro" runat="server" CssClass="form-control" 
                                                    MaxLength="50" onkeyup="this.value=this.value.toUpperCase();" 
                                                    ToolTip="Informe aqui o bairro do Prestador de Serviço" Width="400px"></asp:TextBox><asp:Label ID="Label65" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td><td>&#160;</td></tr><tr><td>Cidade :</td><td><asp:TextBox ID="txt_Prestador_Municipio" runat="server" CssClass="form-control" 
                                                    MaxLength="50" onkeyup="this.value=this.value.toUpperCase();" 
                                                    ToolTip="Informe aqui a cidade do Prestador de Serviço" Width="300px"></asp:TextBox><asp:Label ID="Label66" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td><td>&#160;</td></tr><tr><td>UF :</td><td><asp:DropDownList ID="ddl_Prestador_UF" runat="server" CssClass="form-control" 
                                                    ToolTip="Informe aqui a Unidade da Federação do Prestador de Serviço" 
                                                    Width="300px"><asp:ListItem Value=" ">&nbsp; Selecione uma opção</asp:ListItem><asp:ListItem Value="DF">DISTRITO FEDERAL</asp:ListItem><asp:ListItem Value="AC">ACRE</asp:ListItem><asp:ListItem Value="AL">ALAGOAS</asp:ListItem><asp:ListItem Value="AP">AMAPÁ</asp:ListItem><asp:ListItem Value="AM">AMAZONAS</asp:ListItem><asp:ListItem Value="BA">BAHIA</asp:ListItem><asp:ListItem Value="CE">CEARÁ</asp:ListItem><asp:ListItem Value="ES">ESPÍRITO SANTO</asp:ListItem><asp:ListItem Value="GO">GOIÁS</asp:ListItem><asp:ListItem Value="MA">MARANHÃO</asp:ListItem><asp:ListItem Value="MT">MATO GROSSO</asp:ListItem><asp:ListItem Value="MS">MATO GROSSO DO SUL</asp:ListItem><asp:ListItem Value="MG">MINAS GERAIS</asp:ListItem><asp:ListItem Value="PR">PARANÁ</asp:ListItem><asp:ListItem Value="PB">PARAÍBA</asp:ListItem><asp:ListItem Value="PA">PARÁ</asp:ListItem><asp:ListItem Value="PE">PERNAMBUCO</asp:ListItem><asp:ListItem Value="PI">PIAUÍ</asp:ListItem><asp:ListItem Value="RJ">RIO DE JANEIRO</asp:ListItem><asp:ListItem Value="RN">RIO GRANDE DO NORTE</asp:ListItem><asp:ListItem Value="RS">RIO GRANDE DO SUL</asp:ListItem><asp:ListItem Value="RO">RONDÔNIA</asp:ListItem><asp:ListItem Value="RR">RORAIMA</asp:ListItem><asp:ListItem Value="SC">SANTA CATARINA</asp:ListItem><asp:ListItem Value="SE">SERGIPE</asp:ListItem><asp:ListItem Value="SP">SÃO PAULO</asp:ListItem><asp:ListItem Value="TO">TOCANTINS</asp:ListItem></asp:DropDownList><asp:Label ID="Label67" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td><td>&#160;</td></tr><tr><td>Telefone :</td><td><asp:TextBox ID="txt_Prestador_Telefone" runat="server" CssClass="form-control" 
                                                    MaxLength="25" 
                                                    ToolTip="Informe aqui o DDD e o telefone do Prestador de Serviço" Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td>Celular :</td><td><asp:TextBox ID="txt_Prestador_Celular" runat="server" CssClass="form-control" 
                                                    MaxLength="25" ToolTip="Informe aqui o DDD e o celular do Prestador de Serviço" 
                                                    Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td>E-mail :</td><td><asp:TextBox ID="txt_Prestador_Email" runat="server" CssClass="form-control" 
                                                    MaxLength="50" 
                                                    ToolTip="Informe aqui o endereço de email do Prestador de Serviço" 
                                                    Width="300px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td>Serviços :</td><td><asp:TextBox ID="txt_Prestador_Servico" runat="server" CssClass="form-control" 
                                                    MaxLength="100" onkeyup="this.value=this.value.toUpperCase();" 
                                                    ToolTip="Informe aqui o(s) serviço(s) prestado(s) separados por ;" 
                                                    Width="400px"></asp:TextBox>
                    <br />
                    </td><td>&#160;</td></tr><tr><td>&#160;</td><td>
                    Informe abaixo os arquivos com informações do prestador,
                    <br />
                    Tamanho máximo permitido de 800kb e&nbsp; somente formato PDF.</td><td>&#160;</td></tr><tr><td>
                    <asp:TextBox ID="txt_Prestador_Doc_1" runat="server" CssClass="form-control" 
                        MaxLength="150" ReadOnly="True" 
                        ToolTip="Informe aqui o DDD e o celular do Prestador de Serviço" 
                        Visible="False" Width="56px"></asp:TextBox>
                    </td><td><asp:FileUpload ID="PrexPre_Doc_1" runat="server" 
                                ToolTip="Selecione aqui o documento a enviar" Width="400px" CssClass="form-control" Height="40px" />
                        <br />
                        <asp:HyperLink ID="hl_up_1" runat="server" CssClass="form-control" Target="_blank">...</asp:HyperLink>
                    </td><td>&#160;</td></tr><tr><td>
                    <asp:TextBox ID="txt_Prestador_Doc_2" runat="server" CssClass="form-control" 
                        MaxLength="150" 
                        ToolTip="Informe aqui o DDD e o celular do Prestador de Serviço" 
                        Visible="False" Width="64px"></asp:TextBox>
                    </td><td><asp:FileUpload ID="PrexPre_Doc_2" runat="server" 
                                ToolTip="Selecione aqui o documento a enviar" Width="500px" />
                        <br />
                        <asp:HyperLink ID="hl_up_2" runat="server" CssClass="form-control" Target="_blank">...</asp:HyperLink>
                    </td><td>&#160;</td></tr><tr><td>
                    <asp:TextBox ID="txt_Prestador_Doc_3" runat="server" CssClass="form-control" 
                        MaxLength="150" 
                        ToolTip="Informe aqui o DDD e o celular do Prestador de Serviço" 
                        Visible="False" Width="64px"></asp:TextBox>
                    </td><td><asp:FileUpload ID="PrexPre_Doc_3" runat="server" 
                                ToolTip="Selecione aqui o documento a enviar" Width="500px" />
                        <br />
                        <asp:HyperLink ID="hl_up_3" runat="server" CssClass="form-control" Target="_blank">...</asp:HyperLink>
                    </td><td>&#160;</td></tr><tr><td>
                    <asp:TextBox ID="txt_Prestador_Doc_4" runat="server" CssClass="form-control" 
                        MaxLength="150" 
                        ToolTip="Informe aqui o DDD e o celular do Prestador de Serviço" 
                        Visible="False" Width="64px"></asp:TextBox>
                    </td><td><asp:FileUpload ID="PrexPre_Doc_4" runat="server" 
                            ToolTip="Selecione aqui o documento a enviar" Width="500px" />
                        <br />
                        <asp:HyperLink ID="hl_up_4" runat="server" CssClass="form-control" Target="_blank">...</asp:HyperLink>
                    </td><td>&#160;</td></tr><tr><td>&#160;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&#160;</td><td><asp:Button ID="btn_Salvar_Prestador" runat="server" BackColor="#00554F" 
                        Font-Bold="True" Font-Names="Verdana" ForeColor="White" Height="40px" 
                        Text="GRAVAR" Width="150px" />&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;<asp:Button ID="btn_fechar_Prestador_alt" runat="server" 
                        BackColor="#00554F" Font-Bold="True" Font-Names="Verdana" ForeColor="White" 
                        Height="40px" Text="FECHAR" Width="150px" /></td><td><asp:Button ID="btn_Excluir_Prestador_alt" runat="server" BackColor="#00554F" 
                            Font-Bold="True" Font-Names="Verdana" ForeColor="White" Height="40px" 
                            Text="EXCLUIR" Width="150px" /></td></tr><tr><td>&#160;</td><td>&nbsp;</td><td>&#160;</td></tr><tr><td>&#160;</td><td>Os campos assinalados com (*) são de preenchimento obrigatório.</td><td>&#160;</td></tr><tr><td>&#160;</td><td>&nbsp;</td><td>&#160;</td></tr><tr><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr></table></asp:Panel></td><td>&#160;</td></tr><tr><td>&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td>&#160;</td><td>&#160;</td><td align="left"><asp:TextBox ID="txt_prexpre_registro" runat="server" BackColor="White" 
                                    BorderStyle="None" CssClass="form-control" ForeColor="White" MaxLength="10" 
                                    Width="119px"></asp:TextBox><asp:TextBox ID="TextBox6" runat="server" BackColor="White" BorderStyle="None" 
                                    CssClass="form-control" ForeColor="White" MaxLength="300" Width="57px"></asp:TextBox><asp:TextBox ID="TextBox7" runat="server" BackColor="White" BorderStyle="None" 
                                    CssClass="form-control" ForeColor="White" MaxLength="300" Width="57px"></asp:TextBox></td><td>&#160;</td></tr></table></td><td>&#160;</td></tr></table>
                    
                    
                    </ContentTemplate>
            

</asp:TabPanel>
                
               <asp:TabPanel runat="server" ID="TabPanel_3" HeaderText=""  Enabled="true">
                <ContentTemplate><table width="100%"><tr><td width="20px">&#160;</td><td colspan="2" align="center" style="font-weight: bold"><asp:Panel ID="pnl_material" runat="server"><table cellpadding="0" cellspacing="0" ><tr><td>&#160;</td><td align="center" style="font-weight: bold">Marque os materiais que podem ser&#160; fornecidos, clicando na descrição do material.</td><td>&#160;</td></tr><tr><td>&#160;</td><td align="center"  style="font-weight: bold">
                    Se o material não constar na lista e desejar cadastrar, preencha o campo abaixo 
                    e clique no botão de adição</td><td>&#160;</td></tr><tr><td>&#160;</td><td align="center" style="font-weight: bold">Material : <asp:TextBox ID="txtdescservico" runat="server" CausesValidation="True" 
                                        CssClass="form-control" Height="30px" MaxLength="250" 
                                        onkeyup="this.value=this.value.toUpperCase();" Rows="1" Width="500px"></asp:TextBox>
                    &nbsp;<asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False" 
                                        ImageUrl="~/Imagens/Botoes/botao_mais.gif" /></td><td>&#160;</td></tr></table></asp:Panel></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td align="center"><asp:DataGrid 
                        ID="Datagrid2" runat="server" AllowSorting="True" 
                            AutoGenerateColumns="False" BackColor="White" BorderColor="Gainsboro" 
                            BorderStyle="Solid" BorderWidth="1px" CellPadding="5" DataKeyField="PrexSM_ID" 
                            OnDeleteCommand="DataGrid2_DeleteCommand" 
                            OnItemDataBound="DataGrid2_ItemDataBound" PageSize="100" Width="90%"><Columns><asp:TemplateColumn HeaderText="Lista dos Materiais"><ItemTemplate><asp:LinkButton ID="LnkBtnDel3" runat="server" CausesValidation="False" 
                                            CommandName="Delete" Height="10px" 
                                            Text='<%# DataBinder.Eval(Container, "DataItem.SM_Descricao") %>' 
                                            ToolTip="Marcar/Desmarcar este material da minha lista"> </asp:LinkButton></ItemTemplate><HeaderStyle Width="90%" /></asp:TemplateColumn><asp:TemplateColumn><ItemTemplate><asp:CheckBox ID="ckitem" runat="server" AutoPostBack="True" Enabled="false" 
                                            Checked='<%# DataBinder.Eval(Container, "DataItem.SM_Selecao") %>' /></ItemTemplate></asp:TemplateColumn></Columns><EditItemStyle VerticalAlign="Middle" /><FooterStyle BackColor="#CCCCCC" ForeColor="Black" /><HeaderStyle BackColor="WhiteSmoke" Font-Bold="True" ForeColor="White" /><ItemStyle Font-Bold="False" Font-Italic="False" Font-Names="Verdana" 
                                Font-Overline="False" Font-Size="Small" Font-Strikeout="False" 
                                Font-Underline="False" HorizontalAlign="Left" VerticalAlign="Middle" /><PagerStyle BackColor="WhiteSmoke" HorizontalAlign="Center" Mode="NumericPages" 
                                NextPageText="Posterior" PrevPageText="Anterior" /><SelectedItemStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" /></asp:DataGrid></td><td>&#160; </td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td>&#160;</td><td>&nbsp;</td></tr><tr><td width="20px">&#160;</td><td align="center" colspan="2">&nbsp;&nbsp;<br /><br /><asp:TextBox ID="txtcodservico" runat="server" BackColor="White" 
                            BorderStyle="None" ForeColor="White" Width="30px"></asp:TextBox></td><td>&nbsp;</td></tr><tr><td width="20px">&#160;</td><td align="center" colspan="2">&nbsp;</td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td align="left" colspan="2">&#160;</td><td>&#160;</td></tr></table>
                    
                    
                    
                    
                    </ContentTemplate>
            
</asp:TabPanel>
             <asp:TabPanel runat="server" ID="TabPanel_4" HeaderText=""  Enabled="true">
                <ContentTemplate><table width="100%"><tr><td width="20px">&#160;</td><td colspan="2" align="center" style="font-weight: bold"><asp:Panel ID="pnl_servico" runat="server"><table cellpadding="0" cellspacing="0" ><tr><td>&#160;</td><td align="center" style="font-weight: bold">Marque os serviços que podem ser&#160; prestados, clicando na descrição do serviço.</td><td>&#160;</td></tr><tr><td>&#160;</td><td align="center" style="font-weight: bold">
                    Se o serviço não constar na lista e desejar cadastrar, preencha o campo abaixo e 
                    clique no botão de adição</td><td>&#160;</td></tr><tr><td>&#160;</td><td>Serviço :&#160; <asp:TextBox ID="txt_servico" runat="server" CausesValidation="True" 
                                        CssClass="form-control" Height="20px" MaxLength="250" 
                                        onkeyup="this.value=this.value.toUpperCase();" Rows="1" Width="500px"></asp:TextBox>
                    &nbsp;<asp:ImageButton ID="btn_cadserv" runat="server" CausesValidation="False" 
                                        ImageUrl="~/Imagens/Botoes/botao_mais.gif" /></td><td>&#160;</td></tr></table></asp:Panel></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td align="center"><asp:DataGrid 
                        ID="Datagrid3" runat="server" AllowSorting="True" 
                            AutoGenerateColumns="False" BackColor="White" BorderColor="Gainsboro" 
                            BorderStyle="Solid" BorderWidth="1px" CellPadding="5" DataKeyField="PrexSM_ID" 
                            OnDeleteCommand="DataGrid3_DeleteCommand" 
                            OnItemDataBound="DataGrid3_ItemDataBound" PageSize="100" Width="90%" GridLines="None" Height="200px">
                    <AlternatingItemStyle BackColor="#E7E7E7" />
                    <Columns><asp:TemplateColumn HeaderText="Lista dos Serviços"><ItemTemplate><asp:LinkButton ID="LnkBtnDel3" runat="server" CausesValidation="False" 
                                            CommandName="Delete" Height="10px" 
                                            Text='<%# DataBinder.Eval(Container, "DataItem.SM_Descricao") %>' 
                                            ToolTip="Marcar/Desmarcar este material da minha lista"> </asp:LinkButton></ItemTemplate><HeaderStyle Width="90%" /></asp:TemplateColumn><asp:TemplateColumn><ItemTemplate><asp:CheckBox ID="ckitem" runat="server" AutoPostBack="True" Enabled="false" 
                                            Checked='<%# DataBinder.Eval(Container, "DataItem.SM_Selecao") %>' /></ItemTemplate></asp:TemplateColumn></Columns><EditItemStyle VerticalAlign="Middle" /><FooterStyle BackColor="#CCCCCC" ForeColor="Black" /><HeaderStyle BackColor="WhiteSmoke" Font-Bold="True" ForeColor="White" /><ItemStyle 
                        Font-Bold="False" Font-Italic="False" Font-Names="Verdana" 
                                Font-Overline="False" Font-Size="Small" Font-Strikeout="False" 
                                Font-Underline="False" VerticalAlign="Middle" 
                        HorizontalAlign="Left" /><PagerStyle BackColor="WhiteSmoke" HorizontalAlign="Center" Mode="NumericPages" 
                                NextPageText="Posterior" PrevPageText="Anterior" /><SelectedItemStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" /></asp:DataGrid></td><td>&#160; </td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td>&#160; </td><td>&#160; </td></tr><tr><td width="20px">&#160;</td><td>&#160;</td><td align="center">&#160; </td><td>&#160; </td></tr><tr><td width="20px">&#160;</td><td>&nbsp;</td><td>&#160;</td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td align="center" colspan="2">&nbsp;&nbsp; <br /><br /><asp:TextBox ID="TextBox2" runat="server" BackColor="White" 
                            BorderStyle="None" ForeColor="White" Width="30px"></asp:TextBox></td><td>&nbsp;&nbsp;</td></tr><tr><td width="20px">&#160;</td><td align="center" 
                        colspan="2">&#160;</td><td>&#160; </td></tr><tr><td width="20px">&#160;</td><td align="left" colspan="2">&#160;</td><td>&#160; </td></tr></table>
                    
                    
                    
                    
                    </ContentTemplate>
            
</asp:TabPanel>
            <asp:TabPanel runat="server" ID="TabPanel_5" HeaderText=""  Enabled="true">
                <ContentTemplate><table width="100%"><tr><td>&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td></td><td align="center" colspan="2" 
                        style="font-weight: bold"><asp:Panel ID="pnl_documento" runat="server"><table cellpadding="0" cellspacing="0"><tr><td>&#160;</td><td 
                        align="center" style="font-weight: bold">Os documentos abaixo são de preenchimento obrigatório de acordo com sua categoria.<br />Para fazer o Upload e completar as informações, clique na descrição do documento.<br /><br />Se desejar incluir um documento a mais, &#160; <asp:LinkButton ID="lnk_Inclui_Documento" runat="server" ForeColor="#3333CC">clique aqui &#160; </asp:LinkButton>&#160;e selecione-o da lista de Tipos de Documentos e preencha os demais campos.<br /><br /></td><td>&#160;</td></tr></table></asp:Panel><asp:Panel ID="pnl_documento_consulta" runat="server"><table cellpadding="0" cellspacing="0" class="style1"><tr><td>&#160;</td><td align="center" style="font-weight: bold">Para consultar os dados do Documento cadastrado, clique na descrição do mesmo.</td><td>&#160;</td></tr></table></asp:Panel></td><td></td></tr><tr><td>&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td></td><td colspan="2"><asp:GridView 
                        ID="GridView1" runat="server" AutoGenerateColumns="False"
                                        BorderColor="Gainsboro" BorderStyle="Solid" 
                        BorderWidth="1px" CellPadding="5"
                                        DataKeyNames="PrexDoc_ID" DataSourceID="SqlPrexDoc" Width="100%"
                                        OnRowDataBound="GridView1_RowDataBound"  
                                        OnRowCommand="GridView1_RowCommand" AllowSorting="True" 
                        PageSize="500"><Columns><asp:TemplateField HeaderText="Descrição do Documento" ><ItemTemplate><asp:LinkButton ID="cmdDelete1" Text='<%# Bind("Doc_Descricao") %>'
                                                                CommandArgument='<%# Eval("PrexDoc_ID") %>' 
                                                                CommandName="Delete1" runat="server" CausesValidation="false" ToolTip="Editar as informações deste documento"> </asp:LinkButton></ItemTemplate><ItemStyle HorizontalAlign="Left" Width="300px" /></asp:TemplateField><asp:TemplateField HeaderText="Complemento" SortExpression="PrexDoc_Observacao"><ItemTemplate><asp:Label ID="Label41" runat="server" 
                                                        Text='<%# Bind("PrexDoc_Observacao") %>'></asp:Label></ItemTemplate><ItemStyle Width="240px" /></asp:TemplateField><asp:TemplateField HeaderText="Emitido em" SortExpression="PrexDoc_Emissao"><ItemTemplate><asp:Label ID="Label5" runat="server" 
                                                        Text='<%# Bind("PrexDoc_Emissao", "{0:d}") %>'></asp:Label></ItemTemplate><ItemStyle Width="80px" /></asp:TemplateField><asp:TemplateField HeaderText="Válido até" SortExpression="PrexDoc_Validade"><ItemTemplate><asp:Label ID="Label6" runat="server" 
                                                        Text='<%# Bind("PrexDoc_Validade", "{0:d}") %>'></asp:Label></ItemTemplate><ItemStyle Width="80px" /></asp:TemplateField><asp:TemplateField><ItemTemplate><asp:HyperLink ID="HyperLink1" runat="server" Text='<IMG src="Imagens/botoes/search16_h.gif"  border="0">' NavigateUrl='<%# Eval("PrexDoc_Nome", "{0}") %>' Target="_blank"  ToolTip="Visualizar o Documento"></asp:HyperLink></ItemTemplate><ItemStyle Width="30px" Font-Bold="False" Font-Size="Small" /></asp:TemplateField><asp:TemplateField HeaderText="Situação" SortExpression="PrexDoc_Situacao"><ItemTemplate><asp:imagebutton ID="imgSIT" runat="server" CausesValidation="false" ImageAlign="Middle" /></ItemTemplate><ItemStyle horizontalalign="Center" /></asp:TemplateField></Columns><AlternatingRowStyle BackColor="White" /><HeaderStyle BackColor="WhiteSmoke" /><PagerStyle BackColor="WhiteSmoke" /><RowStyle BackColor="Transparent" ForeColor="Transparent" /><SelectedRowStyle BackColor="Transparent" Font-Bold="True" ForeColor="Transparent" /></asp:GridView></td><td>&#160; </td></tr><tr><td></td><td 
                        colspan="2">&#160;<asp:Panel ID="pnl_documento_detalhe" 
        runat="server" Visible="False"><table width="100%"><tr><td>&#160;&nbsp;</td><td>&#160;&nbsp;</td><td>&#160;&nbsp;</td><td>&#160;&nbsp;</td></tr><tr><td>&#160;&nbsp;</td><td>Tipo de Documento : </td><td><asp:DropDownList ID="ddlDocumento" runat="server" AutoPostBack="True" 
                        DataSourceID="SqlDocumento" DataTextField="Doc_Descricao" 
                        DataValueField="Doc_ID" Height="25px" Width="400px"></asp:DropDownList>&#160;&#160;<asp:Label ID="Label69" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label></td><td>&#160;&nbsp;</td></tr><tr><td>&#160;&nbsp;</td><td>Complemento : </td><td><asp:TextBox ID="txt_prexdoc_obs" runat="server" CssClass="form-control" 
                        MaxLength="300" onkeyup="this.value=this.value.toUpperCase();" 
                        ToolTip="Informe aqui alguma observação complementar referente ao documento." 
                        Width="500px"></asp:TextBox></td><td>&#160;&nbsp;</td></tr><tr><td>&#160;&nbsp;</td><td>Descritivo : </td><td><asp:TextBox ID="txt_prexdoc_ajuda_alt" runat="server" CssClass="form-control" 
                        Height="70px" MaxLength="300" onkeyup="this.value=this.value.toUpperCase();" 
                        ReadOnly="True" Rows="4" TextMode="MultiLine" 
                        ToolTip="Informe aqui alguma observação complementar referente ao documento." 
                        Width="500px"></asp:TextBox></td><td>&#160;&nbsp;</td></tr><tr><td>&#160;&nbsp;</td><td>&#160;&nbsp;</td><td><asp:HyperLink ID="hpl_modelo_alt" runat="server" Target="_blank"> Clique aqui para visualizar o Modelo do Documento </asp:HyperLink><asp:TextBox ID="txt_prexdoc_doc" runat="server" CssClass="form-control" 
                        Enabled="False" MaxLength="300" onkeyup="this.value=this.value.toUpperCase();" 
                        Visible="False" Width="74px"></asp:TextBox></td><td>&#160;&nbsp;</td></tr><tr><td>&#160;&nbsp;</td><td>Emissão : </td><td><asp:TextBox ID="txt_prexdoc_emissao" runat="server" CssClass="form-control" 
                        MaxLength="10" ToolTip="Informe aqui a Data de Emissão do Documento" 
                        Width="119px"></asp:TextBox>&#160;&#160; <asp:Label ID="Label68" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>(dd/mm/aaaa) &#160;&#160;&#160; <asp:Label ID="lbl_Validade" runat="server" Text="Validade :" Visible="False"></asp:Label>&#160;&#160;&#160; <asp:TextBox ID="txt_prexdoc_validade" runat="server" CssClass="form-control" 
                        MaxLength="10" 
                        ToolTip="Informe aqui a Data de Validade do documento se houver, caso contrário, deixe em branco." 
                        Visible="False" Width="119px"></asp:TextBox>&#160;&#160; <asp:Label ID="lbl_Validade_Formato" runat="server" Text="(dd/mm/aaaa)" 
                        Visible="False"></asp:Label></td><td>&#160;&nbsp;</td></tr><tr><td>&#160;&nbsp;</td><td>Selecione o arquivo : </td><td><asp:FileUpload ID="PrexDoc_Nome" runat="server" 
                        ToolTip="Selecione aqui o documento a enviar" Width="500px" /></td><td>&#160;&nbsp;</td></tr><tr><td>&#160;&nbsp;</td><td>&#160;&nbsp;</td><td>Tamanho máximo permitido do documento a enviar é de 800kbytes. <br />Permitidos somente documentos no formato&#160;PDF.</td><td>&#160;</td></tr><tr><td>&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td>&#160;</td><td>&#160;</td><td><asp:Label ID="lbl_data_upload" runat="server" Font-Bold="True" 
                        Font-Names="Verdana" Font-Overline="False" Font-Size="Small" 
                        Font-Strikeout="False" ForeColor="Black"></asp:Label></td><td>&#160;</td></tr><tr><td>&#160;</td><td>&#160;</td><td><asp:TextBox ID="txt_prexdoc_registro" runat="server" BackColor="White" 
                        BorderStyle="None" CssClass="form-control" ForeColor="White" MaxLength="10" 
                        Width="119px"></asp:TextBox><asp:TextBox ID="txt_prexdoc_nome" runat="server" BackColor="White" 
                        BorderStyle="None" CssClass="form-control" ForeColor="White" MaxLength="300" 
                        Width="57px"></asp:TextBox><asp:TextBox ID="txt_dias_validade" runat="server" BackColor="White" 
                        BorderStyle="None" CssClass="form-control" ForeColor="White" MaxLength="300" 
                        Width="57px"></asp:TextBox></td><td>&#160;</td></tr><tr><td>&#160;</td><td>&#160;</td><td><asp:Button 
                                ID="btn_Salvar_Documento" runat="server" BackColor="#00554F" Font-Bold="True" 
                                Font-Names="Verdana" ForeColor="White" Height="40px" Text="SALVAR" 
                                Width="150px" />&#160;&#160;&#160; &#160; <asp:Button ID="btn_Fechar_Documento_alt" runat="server" 
                                BackColor="#00554F" Font-Bold="True" Font-Names="Verdana" ForeColor="White" 
                                Height="40px" Text="FECHAR" Width="150px" />&#160;&#160; &#160; &#160;&#160; <br /></td><td><asp:Button ID="btn_Excluir_Documento_alt" runat="server" 
                                    BackColor="#00554F" Font-Bold="True" Font-Names="Verdana" ForeColor="White" 
                                    Height="40px" Text="EXCLUIR" Width="150px" /></td></tr><tr><td>&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr></table></asp:Panel><br />&#160;</td><td>&#160;</td></tr><tr><td>&#160;</td><td colspan="2">&#160;</td><td>&#160;</td></tr></table>
                    
                    </ContentTemplate>
            
</asp:TabPanel>
            <asp:TabPanel runat="server" ID="TabPanel_6" HeaderText="" Enabled="true">
                <ContentTemplate><table width="100%"><tr><td width="20px">&#160;</td><td>&#160;</td><td>&#160;</td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td colspan="2">&#160;</td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td align="center" colspan="2"><asp:Label ID="lbl_TipoEmpresa0" runat="server" Font-Bold="True" 
                                Font-Names="Verdana" Font-Size="Small" ForeColor="Black">Os documentos cadastrados deverão ser apresentados e certificados</asp:Label></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td colspan="2" align="center"><asp:Label ID="lbl_TipoEmpresa1" runat="server" Font-Bold="True" 
                            Font-Names="Verdana" Font-Size="Small" ForeColor="Black">(de acordo com os originais), no ato de eventual contratação.</asp:Label></td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td align="center" colspan="2"><asp:Label 
                            ID="lbl_TipoEmpresa2" runat="server" Font-Bold="True" Font-Names="Verdana" 
                            Font-Size="Small" ForeColor="Black">Os documentos originais deverão ser apresentados nos termos e prescrições legais.</asp:Label></td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td align="center" colspan="2"><asp:Label 
                            ID="lbl_TipoEmpresa3" runat="server" Font-Bold="True" Font-Names="Verdana" 
                            Font-Size="Small" ForeColor="Black">O procedimento de inclusão dos dados no sistema Cadastro Digital não exime o usuário</asp:Label></td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td align="center" colspan="2"><asp:Label 
                            ID="lbl_TipoEmpresa4" runat="server" Font-Bold="True" Font-Names="Verdana" 
                            Font-Size="Small" ForeColor="Black">de proceder conforme legislação pertinente e ordenamento jurídico vigente.</asp:Label></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td 
                        colspan="2" align="center">&nbsp;</td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td 
                        colspan="2">&#160;</td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td align="center" colspan="2"><asp:ImageButton 
                        ID="Imgbtn_Cadastrar" runat="server" 
                        ImageUrl="~/Imagens/Botoes/Botao_EfetivarAlteracao.gif" /></td><td>&#160;</td></tr><tr><td width="20px">&#160;</td><td align="center" colspan="2">&#160;</td><td>&#160;</td></tr><tr><td 
                        width="20px">&#160;</td><td align="center" colspan="2"><asp:Label ID="lbl_Confirmar" 
                            runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="Medium" 
                            ForeColor="#CC0000"></asp:Label></td><td>&#160;</td></tr></table>
                    
                    
                    </ContentTemplate>
            
</asp:TabPanel>
             
                
                </asp:TabContainer>
                               
                </td>
            <td>
                &nbsp;</td>
        </tr>
       
        <tr>
            <td width="20px">
                &nbsp;</td>
            <td colspan="2" style="margin-left: 40px">
                &nbsp;
                                               
                </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20px">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>                  
                                    <asp:ValidationSummary ID="VS_01" runat="server" DisplayMode="List" 
                                        ShowMessageBox="True" ShowSummary="False" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
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
                                        
                                        SelectCommand="SELECT Doc_ID, Doc_Descricao, Doc_Validade, Doc_Onde_Obter, Doc_Prestador, Doc_Fornecedor, Doc_Situacao FROM cad_documento order by  Doc_Descricao" 
                                        
                                        ProviderName="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString.ProviderName %>">
                                    </asp:SqlDataSource>
                                    
                                   
                                    <asp:SqlDataSource ID="SqlPrexPre" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString %>"
                                        OldValuesParameterFormatString="original_{0}" 
                                        
                    
                                        SelectCommand="SELECT PrexPre_Id,Pre_CNPJ,PrexPre_Nome,PrexPre_RG,PrexPre_CPF,PrexPre_Nacionalidade,PrexPre_Estado_Civil,PrexPre_Profissao,PrexPre_Endereco,PrexPre_Numero,PrexPre_Complemento,PrexPre_Bairro,PrexPre_CEP,PrexPre_Municipio,PrexPre_UF,PrexPre_Servicos,PrexPre_Doc_1,PrexPre_Doc_2,PrexPre_Doc_3,PrexPre_Doc_4 FROM tmp_prestadorxprestador WHERE (Pre_CNPJ = @Pre_CNPJ) ORDER BY PrexPre_Nome" 
               
                                        
                                        ProviderName="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString.ProviderName %>" 
                                        DeleteCommand="DELETE FROM tmp_prestadorxprestador WHERE PrexPre_ID = @original_PrexPre_ID" 
                                        InsertCommand="INSERT INTO [tmp_prestadorxprestador] ([Pre_ID], [Pre_CNPJ], [PrexPre_Nome], [PrexPre_RG], [PrexPre_CPF], [PrexPre_Nacionalidade], [PrexPre_Estado_Civil], [PrexPre_Profissao], [PrexPre_Endereco], [PrexPre_Numero], [PrexPre_Complemento], [PrexPre_Bairro], [PrexPre_CEP], [PrexPre_Municipio], [PrexPre_UF], [PrexPre_Telefone], [PrexPre_Celular], [PrexPre_Email], [PrexPre_Servicos]) VALUES (@Pre_ID, @Pre_CNPJ, @PrexPre_Nome, @PrexPre_RG, @PrexPre_CPF, @PrexPre_Nacionalidade, @PrexPre_Estado_Civil, @PrexPre_Profissao, @PrexPre_Endereco, @PrexPre_Numero, @PrexPre_Complemento, @PrexPre_Bairro, @PrexPre_CEP, @PrexPre_Municipio, @PrexPre_UF, @PrexPre_Telefone, @PrexPre_Celular, @PrexPre_Email, @PrexPre_Servicos,@PrexPre_Doc_1,,@PrexPre_Doc_2,@PrexPre_Doc_3,@PrexPre_Doc_4)" 
                                        
                                        
                                        
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
                                            
                                        </InsertParameters>
                                    </asp:SqlDataSource>
                                    <asp:Timer ID="Timer1" runat="server" Enabled="False" Interval="5000">
                                    </asp:Timer>
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
            <td colspan="2">
               
                    <asp:Panel ID="pnlpopup" runat="server" CssClass="popUpStyle" width="580px" style="display:none;">
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
                                                                    Font-Size="Small" ForeColor="#669900"></asp:Label>
                                                            </td>
                                                            <td>
                                                                &nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td align="center">
                                                                <asp:Label ID="lbl_mensagem_2" runat="server" Font-Bold="True" 
                                                                    Font-Size="Small" ForeColor="#669900"></asp:Label>
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
                                                                <asp:Button ID="btn_Confirma_Exclusao_Documento" runat="server" 
                                                                    BackColor="#00554F" Font-Bold="True" Font-Names="Verdana" ForeColor="White" 
                                                                    Height="40px" Text="S I M" Visible="False" Width="150px" />
                                                                &nbsp;&nbsp;&nbsp;
                                                                <asp:Button ID="btn_Confirma_Exclusao_Prestador" runat="server" 
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
                         <asp:ModalPopupExtender ID="MPE_Alteracao" runat="server" 
                     BackgroundCssClass="popUpStyle1" PopupControlID="pnlpopup" 
                     DynamicServicePath="" Enabled="True"  
                     TargetControlID="Button1"  
                     CancelControlID="Button2" OkControlID="Button1"
                     />
            </td>
        </tr>
    </table>
       
    </td>
                </tr>
                </table>
    
    </form>
</body>
</html>