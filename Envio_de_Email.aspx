<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Envio_de_Email.aspx.vb" Inherits="Envio_de_Email" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
        <title>Administração | Prestadores de Servços - FCCR</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
        <link href="~/Styles/tabs.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
         crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
         crossorigin="anonymous">
</head>
<body>
    <form id="Form1" name="form1" runat="server" >
    <asp:toolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager3" ScriptMode="Release"  />
   
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
            <td>
                &nbsp;</td>
            <td align="center">
                <asp:Label ID="Label511" runat="server" Font-Bold="True" Font-Size="Medium" 
                    Text="Fundação Cultural Cassiano Ricardo"></asp:Label>
                 </td>
            <td>
                &nbsp;</td>
        </tr>
     
        <tr>
            <td>
                &nbsp;</td>
            <td align="center">
                <asp:Label ID="Label611" runat="server" Font-Bold="False" Font-Size="Medium" 
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
                <asp:Label ID="Label711" runat="server" Font-Bold="False" Font-Size="Large" 
                    Text="Envio de emails para atualização da documentação"></asp:Label>
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
                &nbsp;<asp:Button ID="btn_enviar" runat="server" BackColor="#00554F" 
                    Font-Bold="True" ForeColor="White" Height="30px" 
                    Text="Clique aqui para confirmar o envio dos emails" Width="400px" />
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
                
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                                        BorderColor="Gainsboro" BorderStyle="Solid" BorderWidth="1px" CellPadding="8"
                                        DataSourceID="SqlDocumento" Width="100%" AllowSorting="True" GridLines="None">
                                        <Columns>
                                             <asp:TemplateField HeaderText="Código" SortExpression="Pre_ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Pre_ID") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CNPJ/CPF" SortExpression="Pre_CNPJ">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Pre_CNPJ") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Prestador" SortExpression="Pre_Nome_Fantasia">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" 
                                                        Text='<%# Bind("Pre_Razao_Social") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="50%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Documentos Pendentes" >
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# string.concat(Eval("Qtde")&" Documento(s)") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" />
                                            </asp:TemplateField>
                                                                                  
                                            
                                        </Columns>
                                        <RowStyle BackColor="Transparent" ForeColor="Transparent" />
                                        <SelectedRowStyle BackColor="Transparent" Font-Bold="True" ForeColor="Transparent" />
                                        <PagerStyle BackColor="WhiteSmoke" />
                                        <HeaderStyle BackColor="WhiteSmoke" BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" />
                                        <AlternatingRowStyle BackColor="#E7E7E7" />
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="SqlDocumento" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:fccr_cadastro_mysql_ConnectionString %>"
                                        SelectCommand = "select A.Doc_Descricao, B.Doc_Validade, B.Doc_Obrigatorio,C.Pre_Nome_Fantasia FROM cad_prestadorxdocumento as A,cad_documento as B,cad_prestador as C WHERE A.Doc_ID=B.Doc_ID and A.Pre_ID=C.Pre_ID and B.Doc_Obrigatorio=1 order by C.Pre_Nome_Fantasia,A.Doc_Descricao "
                                        ProviderName="<%$ ConnectionStrings:fccr_cadastro_mysql_ConnectionString.ProviderName %>" >
                                    </asp:SqlDataSource>
                                   
                                                                      
                                    </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td align="center">
                <asp:Label ID="lbl_Erro" runat="server" Font-Bold="True" Font-Names="Verdana" 
                    ForeColor="#CC0000" Font-Size="Medium"></asp:Label>
                    </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                         <asp:ModalPopupExtender ID="MPE_Email" runat="server" 
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

