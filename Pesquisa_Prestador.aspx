<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pesquisa_Prestador.aspx.vb" Inherits="Pesquisa_Prestador" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

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
<body class="bg-fccr1">
    <form id="Form1" name="form1" runat="server">
    <asp:toolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager2" ScriptMode="Release"  />
 
<table  align="center" width="100%" height="640px">
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
            <td align="center" colspan="3">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center">
                &nbsp;</td>
            <td align="center" colspan="3">
                <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Names="Verdana" 
                    Font-Overline="False" Font-Size="Medium" Font-Strikeout="False" 
                    ForeColor="#3333CC" Text="PESQUISA DOS PRESTADORES DE SERVIÇOS"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
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
            <td>
                &nbsp;</td>
            <td align="right">
                &nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_descricao" runat="server" CssClass="campo" Width="650px">Digite aqui o Código ou o CNPJ ou o CPF ou a Razão Social ou o Nome ou o Nome Fantasia para pesquisar</asp:TextBox>
            &nbsp;&nbsp;
                <asp:ImageButton ID="ImgBtn_Pesquisar" runat="server" 
                    ImageUrl="~/Imagens/Botoes/search16_h.gif" BorderColor="Black" 
                    BorderStyle="Solid" />
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
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                
                                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        BorderColor="Gainsboro" BorderStyle="Solid" BorderWidth="1px" CellPadding="5"
                                        DataKeyNames="Pre_ID" DataSourceID="SqlPrestador" Width="100%" 
                                        AllowSorting="True" Font-Size="Small" PageSize="15" >
                                        <Columns>
                                            <asp:CommandField ShowDeleteButton="True" Visible="false" />
                                        <asp:TemplateField HeaderText="Código">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="HyperLink1" runat="server" 
                                                        NavigateUrl='<%# Eval("Pre_ID", "Alteracao_Prestador.aspx?CodPrestador={0}") %>' Text='<%# Bind("Pre_ID") %>'></asp:HyperLink>
                                                </ItemTemplate>
                                                <ItemStyle Width="30px" />
                                            </asp:TemplateField>
                                            
                                            <asp:TemplateField HeaderText="CNPJ/CPF" SortExpression="Pre_CNPJ" >
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" 
                                                        Text='<%# Bind("Pre_CNPJ") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="150px" />
                                                <ItemStyle Width="150px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Razão Social/Nome" SortExpression="Pre_Razao_Social">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label11" runat="server" 
                                                        Text='<%# Bind("Pre_Razao_Social") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="400px" />
                                                <ItemStyle Width="400px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Nome Fantasia" SortExpression="Pre_Nome_Fantasia">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label31" runat="server" Text='<%# Eval("Pre_Nome_Fantasia") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="300px" />
                                                <ItemStyle Width="300px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Situação" >
                                                <ItemTemplate>
                                                    <asp:imagebutton ID="imgSIT_PRE" runat="server" CausesValidation="false" ImageAlign="Middle" />
                                                    </ItemTemplate>
                                                <ItemStyle Width="80px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status" SortExpression="Pre_Desativado" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Pre_Desativado") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="80px" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <RowStyle BackColor="Transparent" ForeColor="Transparent" />
                                        <SelectedRowStyle BackColor="Transparent" Font-Bold="True" ForeColor="Transparent" />
                                        <PagerStyle BackColor="WhiteSmoke" />
                                        <HeaderStyle BackColor="WhiteSmoke" />
                                        <AlternatingRowStyle BackColor="White" />
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="SqlDocumento" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:fccr_cadastro_mysql_ConnectionString %>"
                                        OldValuesParameterFormatString="original_{0}" 
                                        
                                        SelectCommand="SELECT Doc_ID,Doc_Descricao, Doc_Validade,Doc_Onde_Obter,Doc_Prestador, Doc_Fornecedor,Doc_MEI,Doc_Obrigatorio, Doc_Situacao,Doc_Modelo FROM cad_documento" 
                                        
                                        
                                        ProviderName="<%$ ConnectionStrings:fccr_cadastro_mysql_ConnectionString.ProviderName %>" 
                                        DeleteCommand="DELETE FROM cad_documento WHERE Doc_ID = @original_Doc_ID" 
                                        InsertCommand="INSERT INTO [cad_documento] ([Doc_Descricao], [Doc_Validade], [Doc_Onde_Obter], [Doc_Prestador], [Doc_Fornecedor], [Doc_MEI], [Doc_Obrigatorio], [Doc_Situacao]) VALUES (@Doc_Descricao, @Doc_Validade, @Doc_Onde_Obter, @Doc_Prestador, @Doc_Fornecedor, @Doc_MEI, @Doc_Obrigatorio, @Doc_Situacao)" 
                                        
                                        
                                        UpdateCommand="UPDATE [cad_documento] SET [Doc_Descricao] = @Doc_Descricao, [Doc_Validade] = @Doc_Validade, [Doc_Onde_Obter] = @Doc_Onde_Obter, [Doc_Prestador] = @Doc_Prestador, [Doc_Fornecedor] = @Doc_Fornecedor, [Doc_MEI] = @Doc_MEI, [Doc_Obrigatorio] = @Doc_Obrigatorio, [Doc_Situacao] = @Doc_Situacao WHERE [Doc_ID] = @original_Doc_ID">
                                        <DeleteParameters>
                                            <asp:Parameter Name="original_Doc_ID" Type="Int32" />
                                        </DeleteParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="Doc_Descricao" Type="String" />
                                            <asp:Parameter Name="Doc_Validade" Type="Int16" />
                                            <asp:Parameter Name="Doc_Onde_Obter" Type="String" />
                                            <asp:Parameter Name="Doc_Prestador" Type="Int16" />
                                            <asp:Parameter Name="Doc_Fornecedor" Type="Int16" />
                                            <asp:Parameter Name="Doc_MEI" Type="Int16" />
                                            <asp:Parameter Name="Doc_Obrigatorio" Type="Int16" />
                                            <asp:Parameter Name="Doc_Situacao" Type="String" />
                                            <asp:Parameter Name="original_Doc_ID" Type="Int32" />
                                        </UpdateParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="Doc_Descricao" Type="String" />
                                            <asp:Parameter Name="Doc_Validade" Type="Int16" />
                                            <asp:Parameter Name="Doc_Onde_Obter" Type="String" />
                                            <asp:Parameter Name="Doc_Prestador" Type="Int16" />
                                            <asp:Parameter Name="Doc_Fornecedor" Type="Int16" />
                                            <asp:Parameter Name="Doc_MEI" Type="Int16" />
                                            <asp:Parameter Name="Doc_Obrigatorio" Type="Int16" />
                                            <asp:Parameter Name="Doc_Situacao" Type="String" />
                                        </InsertParameters>
                                    </asp:SqlDataSource>
                                   
                                                                      
                                    <asp:SqlDataSource ID="SqlPrestador" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:fccr_cadastro_mysql_ConnectionString %>"
                                        OldValuesParameterFormatString="original_{0}" 
                                        
                                        SelectCommand="SELECT Pre_ID,Pre_CNPJ, Pre_Razao_Social,Pre_Nome_Fantasia,Pre_Desativado FROM cad_prestador order by Pre_Razao_Social" 
                                        
                                        
                                        ProviderName="<%$ ConnectionStrings:fccr_cadastro_mysql_ConnectionString.ProviderName %>" 
                                        DeleteCommand="DELETE FROM cad_documento WHERE Doc_ID = @original_Doc_ID" 
                                        InsertCommand="INSERT INTO [cad_documento] ([Doc_Descricao], [Doc_Validade], [Doc_Onde_Obter], [Doc_Prestador], [Doc_Fornecedor], [Doc_MEI], [Doc_Obrigatorio], [Doc_Situacao]) VALUES (@Doc_Descricao, @Doc_Validade, @Doc_Onde_Obter, @Doc_Prestador, @Doc_Fornecedor, @Doc_MEI, @Doc_Obrigatorio, @Doc_Situacao)" 
                                        
                                        
                                        
                                        UpdateCommand="UPDATE [cad_documento] SET [Doc_Descricao] = @Doc_Descricao, [Doc_Validade] = @Doc_Validade, [Doc_Onde_Obter] = @Doc_Onde_Obter, [Doc_Prestador] = @Doc_Prestador, [Doc_Fornecedor] = @Doc_Fornecedor, [Doc_MEI] = @Doc_MEI, [Doc_Obrigatorio] = @Doc_Obrigatorio, [Doc_Situacao] = @Doc_Situacao WHERE [Doc_ID] = @original_Doc_ID">
                                        <DeleteParameters>
                                            <asp:Parameter Name="original_Doc_ID" Type="Int32" />
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
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
&nbsp;&nbsp;&nbsp;&nbsp;
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
                         <asp:ModalPopupExtender ID="MPE_Pesquisa" runat="server" 
                     BackgroundCssClass="popUpStyle1" PopupControlID="pnlpopup" 
                     DynamicServicePath="" Enabled="True"  
                     TargetControlID="Button1"  
                     CancelControlID="Button2" OkControlID="Button1"
                     />
           </td>
            <td>
                &nbsp;</td>
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

