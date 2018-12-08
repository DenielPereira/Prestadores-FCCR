<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Usuario_Alt.aspx.vb" Inherits="Usuario_Alt" %>


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
        
   
    

//-->
</script>

    
    <style type="text/css">
       .style1
        {
            height: 35px;
            background-color: #fff;
    margin: 20px auto 0px auto;
    border: 1px solid #496077;
        }
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
background-color: #FFFFFF; border: #999999; border-style: solid;
border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px;
border-left-width: 1px}

        .auto-style1 {
            width: 122px;
        }

        </style>

    
</head>
<body>
    <form id="Form1" name="form1" runat="server">
     <asp:toolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager3" ScriptMode="Release"  />
    
    <table class="style1" width="100%">
            <tr>
            <td colspan="4" align="center">
                <table cellpadding="0" cellspacing="0" class="style2">
                    <tr>
                        <td width="30%">
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td><asp:Image ID="Image2" runat="server" ImageAlign="Middle"
                    ImageUrl="~/Imagens/Logotipos/fccr_horizontal.png" /></td>
                        <td>
                            &nbsp;</td>
                        <td>
                <asp:Label ID="lbl_Titulo35" runat="server" Font-Bold="False" Font-Names="Verdana" 
                    ForeColor="#0000CC" Font-Size="X-Large">Usuários</asp:Label></td>
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
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
                </td>
               
        </tr>
        <tr>
            <td bgcolor="#00554F" colspan="4" height="5px"></td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                CPF :</td>
            <td>
                                                    <asp:TextBox ID="txt_usu_CPF" 
                    runat="server" CssClass="form-control" ForeColor="Black" 
                                                        MaxLength="14" Width="200px" Enabled="False" ReadOnly="True"></asp:TextBox>
                </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                Nome :</td>
            <td>
                <asp:TextBox ID="txt_usu_nome" runat="server" MaxLength="50" Width="400px" 
                    CssClass="form-control"></asp:TextBox>
                <br />
                </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                Local/Depto :</td>
            <td>
                <asp:TextBox ID="txt_usu_local" runat="server" MaxLength="70" Width="400px" 
                    CssClass="form-control"></asp:TextBox>
                <br />
                </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                Telefone :</td>
            <td>
                <asp:TextBox ID="txt_usu_telefone" runat="server" MaxLength="25" Width="200px" 
                    CssClass="form-control"></asp:TextBox>
                <br />
                </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                Celular :</td>
            <td>
                <asp:TextBox ID="txt_usu_celular" runat="server" MaxLength="25" Width="200px" 
                    CssClass="form-control"></asp:TextBox>
                <br />
                </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                E-mail :</td>
            <td>
                <asp:TextBox ID="txt_usu_email" runat="server" MaxLength="50" Width="400px" 
                    CssClass="form-control"></asp:TextBox>
                <br />
                </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                Perfil :</td>
            <td>
                <asp:DropDownList ID="ddl_usu_perfil" runat="server" CssClass="form-control" 
                    Width="200px">
                    <asp:ListItem>Selecione</asp:ListItem>
                    <asp:ListItem>Administrador</asp:ListItem>
                    <asp:ListItem>Gerente</asp:ListItem>
                </asp:DropDownList>
                <br />
                </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                Senha :</td>
            <td>
                <asp:TextBox ID="txt_usu_senha" runat="server" MaxLength="6" Width="200px" 
                    CssClass="form-control"></asp:TextBox>
                <br />
                </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                Situação :</td>
            <td>
                <asp:DropDownList ID="ddl_usu_situacao" runat="server" CssClass="form-control" 
                    Height="30px" Width="200px">
                    <asp:ListItem>Ativo</asp:ListItem>
                    <asp:ListItem>Inativo</asp:ListItem>
                </asp:DropDownList>
                <br />
                </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                Data&nbsp; atualização :</td>
            <td>
                <asp:TextBox ID="txt_usu_data" runat="server" MaxLength="25" Width="200px" 
                    CssClass="form-control" Enabled="False" ReadOnly="True"></asp:TextBox>
                <br />
                </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                &nbsp;</td>
            <td>
                                    
                                   
                                    &nbsp;&nbsp;
                                            &nbsp;
                                                    
                                   
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                                                    
                                   
                                    </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                &nbsp;</td>
            <td>
                <asp:Button ID="btn_Voltar" runat="server" BackColor="#00554F" Font-Bold="True" 
                                                        ForeColor="White" Height="30px" 
                    Text="Voltar" Width="120px" Font-Names="Verdana" />
                                                &nbsp;&nbsp;&nbsp;
                                                    <asp:Button ID="btn_Gravar" runat="server" 
                    BackColor="#00554F" Font-Bold="True" 
                                                        ForeColor="White" Height="30px" 
                    Text="Gravar" Width="120px" Font-Names="Verdana" />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Button ID="btn_Excluir" runat="server" 
                    BackColor="#00554F" Font-Bold="True" 
                                                        ForeColor="White" Height="30px" 
                    Text="Excluir" Width="120px" Font-Names="Verdana" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td width="20%">
                &nbsp;</td>
            <td class="auto-style1">
                &nbsp;</td>
            <td><asp:Panel ID="pnlpopup" runat="server" CssClass="popUpStyle" width="580px" style="display:none;" >
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
                         <asp:ModalPopupExtender ID="MPE_USU" runat="server" 
                     BackgroundCssClass="popUpStyle1" PopupControlID="pnlpopup" 
                     DynamicServicePath="" Enabled="True"  
                     TargetControlID="Button1"  
                     CancelControlID="Button2" OkControlID="Button1"
                     /></td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    
    
    </form>
</body>
</html>
