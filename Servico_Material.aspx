<%@ Page Title="" Language="VB" AutoEventWireup="false" CodeFile="Servico_Material.aspx.vb" Inherits="cad_servico_material" %>

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
		<asp:toolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager2" ScriptMode="Release" />


		<asp:Panel ID="Panel1" runat="server">
			<nav id="sidebar">
				<div class="sidebar-header">
					<div class="text-right">
						<ul class="logo nav navbar-nav navbar-left">
							<asp:Image ID="Image2" runat="server" EnableTheming="True" ImageUrl="~/Imagens/Logotipos/fccr_main_n.png" />
						</ul>
					</div>
				</div>

				<div>
					<ul class="list-unstyled components tab ">
						<li>
							<asp:LinkButton ID="lnk_Menu_Material" runat="server" CausesValidation="False">Serviços e Materiais</asp:LinkButton>

							<asp:LinkButton ID="lnk_Menu_Documento" runat="server" CausesValidation="False">Documentos</asp:LinkButton>

							<asp:LinkButton ID="lnk_Menu_Prestador" runat="server" CausesValidation="False">Prestadores</asp:LinkButton>

							<asp:LinkButton ID="lnk_Menu_Email" runat="server" CausesValidation="False">E-mail</asp:LinkButton>

							<asp:LinkButton ID="lnk_Menu_Usuario" runat="server" CausesValidation="False">Usuários</asp:LinkButton>

							<asp:LinkButton ID="lnk_Menu_Inicial" runat="server" CausesValidation="False">Fazer Logoff</asp:LinkButton>
						</li>
					</ul>
				</div>
			</nav>
			<div class="p-1 position-fixed" style="z-index: 1;">
				<span id="botao_abrir" style="display: none;">
					<a href="#" onclick="abrir_menu()" style="color: #00544f;" data-toggle="tooltip" data-placement="right" title="Abrir Menu">
						<i class="fas fa-bars"></i>
					</a>
				</span>
				<span id="botao_fechar">
					<a href="#" onclick="fechar_menu()" style="color: #00544f;" data-toggle="tooltip" data-placement="right" title="Fechar Menu">
						<i class="fas fa-angle-double-left"></i>
					</a>
				</span>
			</div>
		</asp:Panel>

		<asp:Panel ID="Panel2" runat="server">

			<div id="title" class="prestador_data text-center">
				<div class="display-4">
					<asp:Label ID="Label6" runat="server" Text="Administrador"></asp:Label>
					<h5>Prestadores de Serviços - FCCR</h5>
				</div>
			</div>

			<div class="ml-2 mt-5 mb-3">
				<div class="display-4">
					<asp:Label ID="Label7" runat="server" Text="Cadastro de Serviços e Materiais"></asp:Label>
				</div>
			</div>

			<div class="row justify-content-end align-items-end mr-5 mb-3">
				<div class="input-group w-25">
					<asp:TextBox ID="txt_descricao" runat="server" CssClass="form-control" placeholder="Pesquisar"></asp:TextBox>
					<div class="input-group-append">
						<asp:ImageButton ID="ImgBtn_Pesquisar" runat="server" ImageUrl="/Imagens/Icones/search-solid.svg" BorderColor="Black"
						 CssClass="btn btn-secondary" style="height: calc(2.25rem + 2px)" />
					</div>
				</div>
			</div>



			<div class="p-3">
				<asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="6" DataKeyNames="SM_ID" DataSourceID="SqlServico_Material"
				 OnRowDataBound="GridView1_RowDataBound" PageSize="15" GridLines="None" CssClass="table table-borderless border-0">
					<Columns>
						<asp:CommandField ShowDeleteButton="True" Visible="false" />
						<asp:TemplateField HeaderText="Material / Serviço" SortExpression="SM_Descricao">
							<ItemTemplate>
								<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("SM_ID", "Servico_Material_ALT.aspx?CodSM={0}") %>'
								 Text='<%# Bind("SM_Descricao") %>' CssClass="text-dark"></asp:HyperLink>
							</ItemTemplate>
							<ItemStyle />
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Situação">
							<ItemTemplate>
								<asp:ImageButton ID="imgSIT_SM" runat="server" CausesValidation="false" ImageAlign="Middle"  style="width: 18px;"/>
							</ItemTemplate>
							<ItemStyle HorizontalAlign="Center"/>
						</asp:TemplateField>
						<asp:TemplateField ShowHeader="False" Visible="false">
							<ItemTemplate>
								<asp:Label ID="Label3" runat="server" Text='<%# Eval("SM_Situacao") %>'></asp:Label>
							</ItemTemplate>
						</asp:TemplateField>

					</Columns>
					<RowStyle BackColor="Transparent" ForeColor="Transparent" CssClass="border-bottom"/>
					<SelectedRowStyle BackColor="Transparent" Font-Bold="True" ForeColor="Transparent" />
					<PagerStyle BackColor="WhiteSmoke" />
					<FooterStyle BackColor="#006666" />
					<HeaderStyle BackColor="transparent" ForeColor="Black" CssClass="border-bottom-2px border-top"/>
					<AlternatingRowStyle BackColor="transparent" />
				</asp:GridView>

				<asp:ImageButton ID="btn_cadastrar" runat="server" ImageUrl="~/Imagens/Icones/plus-solid.svg" style="width: 18px;" />
			</div>
			<!-- daqui pra cima -->

			<asp:SqlDataSource ID="SqlServico_Material" runat="server" ConnectionString="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString %>"
			 DeleteCommand="DELETE FROM cad_servico_material WHERE SM_ID = @original_SM_ID" InsertCommand="INSERT INTO [cad_servico_material] ([SM_ID], [SM_Codigo], [SM_Descricao], [SM_Prestador], [SM_Fornecedor], [SM_Situacao]) VALUES (@SM_ID, @SM_Codigo, @SM_Descricao, @SM_Prestador, @SM_Fornecedor, @SM_Situacao)"
			 OldValuesParameterFormatString="original_{0}" ProviderName="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString.ProviderName %>"
			 SelectCommand="SELECT SM_ID, SM_Codigo, SM_Descricao, SM_Prestador, SM_Fornecedor, SM_Situacao FROM cad_servico_material order by SM_Descricao "
			 UpdateCommand="UPDATE [cad_servico_material] SET [SM_Codigo] = @SM_Codigo, [SM_Descricao] = @SM_Descricao, [SM_Prestador] = @SM_Prestador, [SM_Fornecedor] = @SM_Fornecedor, [SM_Situacao] = @SM_Situacao WHERE [SM_ID] = @original_SM_ID">
				<DeleteParameters>
					<asp:Parameter Name="original_SM_ID" Type="Int32" />
				</DeleteParameters>
				<UpdateParameters>
					<asp:Parameter Name="SM_Codigo" Type="String" />
					<asp:Parameter Name="SM_Descricao" Type="String" />
					<asp:Parameter Name="SM_Prestador" Type="Int16" />
					<asp:Parameter Name="SM_Fornecedor" Type="Int16" />
					<asp:Parameter Name="SM_Situacao" Type="String" />
					<asp:Parameter Name="original_SM_ID" Type="Int32" />
				</UpdateParameters>
				<InsertParameters>
					<asp:Parameter Name="SM_ID" Type="Int32" />
					<asp:Parameter Name="SM_Codigo" Type="String" />
					<asp:Parameter Name="SM_Descricao" Type="String" />
					<asp:Parameter Name="SM_Prestador" Type="Int16" />
					<asp:Parameter Name="SM_Fornecedor" Type="Int16" />
					<asp:Parameter Name="SM_Situacao" Type="String" />
				</InsertParameters>
			</asp:SqlDataSource>
			</td>
			<td>
				&nbsp;</td>
			</tr>
			<tr>
				<td>
					&nbsp;</td>
				<td>
					<asp:Panel ID="pnlpopup" runat="server" CssClass="popUpStyle" width="580px" style="display:none;">
						<table align="center" bgcolor="#FFFF99" frame="border" border="0" cellpadding="1" cellspacing="1" rules="none"
						 width="100%">
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
									<asp:Label ID="Label566" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#CC3300" Text="A T E N Ç Ã O   ! ! !"></asp:Label>
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
									<asp:Label ID="lbl_mensagem_1" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#669900"></asp:Label>
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
									<asp:Label ID="lbl_mensagem_2" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#669900"></asp:Label>
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
									<asp:Button ID="btn_Confirma_Exclusao" runat="server" BackColor="#00554F" Font-Bold="True" Font-Names="Verdana"
									 ForeColor="White" Height="40px" Text="S I M" Visible="False" Width="150px" />
									&nbsp;&nbsp;&nbsp;
									<asp:Button ID="btn_Nao_Confirma" runat="server" BackColor="#00554F" Font-Bold="True" Font-Names="Verdana"
									 ForeColor="White" Height="40px" Text="N Â O" Visible="False" Width="150px" />
								</td>
								<td>
									&nbsp;</td>
							</tr>
							<tr>
								<td>
									&nbsp;</td>
								<td align="center">
									<asp:Button ID="img_btn_Fechar_Mensagem" runat="server" BackColor="#00554F" Font-Bold="True" Font-Names="Verdana"
									 ForeColor="White" Height="40px" Text="FECHAR" Visible="False" Width="150px" />
									<asp:Button ID="img_btn_sair_Mensagem" runat="server" BackColor="#00554F" Font-Bold="True" Font-Names="Verdana"
									 ForeColor="White" Height="40px" Text="FECHAR" Visible="False" Width="150px" />
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
					<asp:ModalPopupExtender ID="MPE_SM" runat="server" BackgroundCssClass="popUpStyle1" PopupControlID="pnlpopup"
					 DynamicServicePath="" Enabled="True" TargetControlID="Button1" CancelControlID="Button2" OkControlID="Button1" />
				</td>
				<td>
					&nbsp;</td>
			</tr>
			</table>
			</div>
		</asp:Panel>
		</td>
		</tr>
		</table>

	</form>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	 crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	 crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	 crossorigin="anonymous"></script>
	<script type="text/javascript" src="/js/tabs.js"></script>
	<script type="text/javascript" src="/js/functions.js"></script>
	<script type="text/javascript">
		function abrir_menu() {
			document.getElementById("sidebar").style.display = "initial";
			document.getElementById("sidebar").style.maxWidth = "250px";
			document.getElementById("sidebar").style.left = "0";
			document.getElementById("botao_abrir").style.display = "none";
			document.getElementById("botao_fechar").style.display = "initial";
			document.getElementById("botao_fechar").style.marginLeft = "250px";
			document.getElementById("Panel2").style.marginLeft = "250px";
		}

		function fechar_menu() {
			document.getElementById('sidebar').style.left = "-250px";
			document.getElementById("sidebar").style.maxWidth = "0";
			document.getElementById("botao_fechar").style.display = "none";
			document.getElementById("botao_abrir").style.display = "initial";
			document.getElementById("botao_abrir").style.marginLeft = "0";
			document.getElementById("Panel2").style.marginLeft = "0";
		}
	</script>
</body>

</html>