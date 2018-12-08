<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Usuario.aspx.vb" Inherits="Usuario" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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

        </style>

    
</head>
<body>
    <form id="Form1" name="form1" runat="server">
    
    <asp:toolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager2" ScriptMode="Release"  />
 
    <table align="center" width="100%" height="640px">
        <tr>
            <td width="20%" valign="top" height="100%" bgcolor="#00554F">
            <asp:Panel ID="Panel1" runat="server" height="100%">
                         <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#00554F">
                             <tr>
                                 <td width="15%">
                                     &nbsp;</td>
                                 <td>
                                     &nbsp;</td>
                                 <td>
                                     &nbsp;</td>
                             </tr>
                             <tr>
                                 <td width="15%">
                                     &nbsp;</td>
                                 <td>
                                     <asp:Image ID="Image2" runat="server" Height="72px" ImageAlign="Middle" 
                                         ImageUrl="~/Imagens/Logotipos/fccr_horizontal.png" Width="211px" 
                                         EnableTheming="True" />
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
                                         ForeColor="White">Página Inicial</asp:LinkButton>
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
                                     <asp:LinkButton ID="lnk_Menu_Material" runat="server" CausesValidation="False" 
                                         ForeColor="White">Serviços e Materiais</asp:LinkButton>
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
                                     <asp:LinkButton ID="lnk_Menu_Documento" runat="server" CausesValidation="False" 
                                         ForeColor="White">Documentos</asp:LinkButton>
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
                                     <asp:LinkButton ID="lnk_Menu_Prestador" runat="server" CausesValidation="False" 
                                         ForeColor="White">Prestadores</asp:LinkButton>
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
                                     <asp:LinkButton ID="lnk_Menu_Email" runat="server" CausesValidation="False" 
                                         ForeColor="White">E-mail</asp:LinkButton>
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
                                     <asp:LinkButton ID="lnk_Menu_Usuario" runat="server" CausesValidation="False" 
                                         ForeColor="White">Usuários</asp:LinkButton>
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
                                     &nbsp;</td>
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
                                     &nbsp;</td>
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
            <td valign="top" height="100%" bgcolor="white"><asp:Panel ID="Panel2" runat="server" height="100%" Width="100%" >
            
    <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="white" align="center">
       
        <tr>
            <td align="center" width="2%">
                &nbsp;</td>
            <td align="center">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center">
                &nbsp;</td>
            <td align="center">
                <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="Medium" 
                    Text="Fundação Cultural Cassiano Ricardo"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center">
                &nbsp;</td>
            <td align="center">
                <asp:Label ID="Label6" runat="server" Font-Bold="False" Font-Size="Medium" 
                    Text="Administrador"></asp:Label>
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
                <asp:Label ID="Label7" runat="server" Font-Bold="False" Font-Size="Large" 
                    Text="Cadastro de Usuários"></asp:Label>
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
            <td align="right">
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_descricao" runat="server" CssClass="campo" Width="288px">Digite aqui o Usuário a pesquisar</asp:TextBox>
                &nbsp;&nbsp;
                <asp:ImageButton ID="ImgBtn_Pesquisar" runat="server" 
                    ImageUrl="~/Imagens/Botoes/search16_h.gif" />
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
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                    AllowSorting="True" AutoGenerateColumns="False" BorderColor="Gainsboro" 
                    BorderStyle="Solid" BorderWidth="1px" CellPadding="6" DataKeyNames="usu_ID" 
                    DataSourceID="SqlUsuario" OnRowDataBound="GridView1_RowDataBound" PageSize="15" 
                    Width="100%" GridLines="None">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" Visible="false" />
                        <asp:TemplateField HeaderText="Usuário" SortExpression="usu_nome">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" 
                                    NavigateUrl='<%# Eval("usu_ID", "Usuario_ALT.aspx?CodUsu={0}") %>' 
                                    Text='<%# Bind("usu_nome") %>'></asp:HyperLink>
                            </ItemTemplate>
                            <ItemStyle Width="450px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Situação">
                            <ItemTemplate>
                                <asp:ImageButton ID="imgSIT_usu" runat="server" CausesValidation="false" 
                                    ImageAlign="Middle" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="80px" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("usu_situacao") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                    </Columns>
                    <RowStyle BackColor="Transparent" ForeColor="Transparent" />
                    <SelectedRowStyle BackColor="Transparent" Font-Bold="True" 
                        ForeColor="Transparent" />
                    <PagerStyle BackColor="WhiteSmoke" />
                    <HeaderStyle BackColor="#006666" ForeColor="#CCCCCC" Height="40px" />
                    <AlternatingRowStyle BackColor="#EBEBEB" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlUsuario" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString %>" 
                    DeleteCommand="DELETE FROM cad_usuario WHERE usu_ID = @original_usu_ID" 
                    OldValuesParameterFormatString="original_{0}" 
                    ProviderName="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString.ProviderName %>" 
                    SelectCommand="SELECT usu_ID, usu_codigo, usu_nome, usu_situacao FROM cad_usuario order by usu_nome ">
                    <DeleteParameters>
                        <asp:Parameter Name="original_usu_ID" Type="Int32" />
                    </DeleteParameters>
                </asp:SqlDataSource>
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
                &nbsp;<asp:ImageButton ID="btn_cadastrar" runat="server" 
                    ImageUrl="~/Imagens/Botoes/botao_mais.gif" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
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
                         <asp:ModalPopupExtender ID="MPE_Usuario" runat="server" 
                     BackgroundCssClass="popUpStyle1" PopupControlID="pnlpopup" 
                     DynamicServicePath="" Enabled="True"  
                     TargetControlID="Button1"  
                     CancelControlID="Button2" OkControlID="Button1"
                     />
           </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    </asp:Panel>
            </td>
            </tr>
            </table>
            
    </form>
</body>
</html>
