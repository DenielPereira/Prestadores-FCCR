<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ErroGenerico.aspx.vb" Inherits="ErroGenerico" %>


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
                                    <asp:Panel ID="Panel1" runat="server" BorderStyle="None" 
                                        Height="420px" width="580px">
                                    </asp:Panel>
                                </td>
                               
                              <td width="4%">
                            &nbsp;</td>
                                        
                    </tr>
                    
                </table>
                </td>
        </tr>
        <tr>
           <td><asp:Panel ID="pnlpopup" runat="server" CssClass="popUpStyle" width="580px" >
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
                         <asp:ModalPopupExtender ID="MPE_Erro" runat="server" 
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
                            Copyright @2018: Fundação Cultural Cassiano Ricardo</td>
                        <td class="style18">
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
</body>
</html>
