<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Cadastro_Menu.aspx.vb" Inherits="Cadastro_Menu" %>

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
 <asp:toolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager2" ScriptMode="Release"  />
   
    <table height="600px" cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="White">
     <tr>
                 <td align="left" valign="top" width="20%" height="100%" bgcolor="#00554F">
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
                                         ImageUrl="~/Imagens/Logotipos/fccr_main_n.png" Width="211px" />
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
                                         ForeColor="White">. Página Inicial</asp:LinkButton>
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
                                         ForeColor="White">. Serviços e Materiais</asp:LinkButton>
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
                                         ForeColor="White">. Documentos</asp:LinkButton>
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
                                         ForeColor="White">. Prestadores</asp:LinkButton>
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
                                         ForeColor="White">. E-mail</asp:LinkButton>
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
                                         ForeColor="White">. Usuários</asp:LinkButton>
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
                 <td align="left"  valign="top">
                     <asp:Panel ID="Panel2" runat="server" Height="100%">
                         <table class="style2">
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
                                     <asp:HyperLink ID="HyperLink5" runat="server" Font-Bold="True" 
                                         NavigateUrl="~/Conversao_SQL.aspx" Visible="False">Conversão SQL</asp:HyperLink>
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
                         <asp:ModalPopupExtender ID="MPE_Menu" runat="server" 
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

