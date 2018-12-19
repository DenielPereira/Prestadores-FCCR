<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Cadastro_Menu.aspx.vb" Inherits="Cadastro_Menu" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html>

<html>

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

		<div id="title" class="prestador_data text-center">
			<div class="display-4">
				<span>Administrador</span>
				<h5>Prestadores de Serviços - FCCR</h5>
			</div>
		</div>

<div id="content">
		<div class="ml-2 mt-5 mb-3">
			<div class="display-4">
				<span>Informações</span>
			</div>
		</div>
		<div class="text-justify px-3">
			<!-- ESSE TEXTO SERÁ ALTERADO, SERVE APENAS DE DEMONSTRAÇÃO -->
			<p style="text-indent: 2em;">Lorem ipsum, dolor sit amet consectetur adipisicing elit. Quaerat, autem. Temporibus, laboriosam mollitia. Iusto illum ratione culpa cumque ab, eius laborum voluptatum hic eos aperiam a eveniet sint, officiis blanditiis! Lorem ipsum dolor sit, amet consectetur adipisicing elit. Aut necessitatibus omnis iusto culpa possimus ex, quis totam suscipit repudiandae veritatis dolor magni hic deserunt, magnam nam delectus! Cumque, velit reiciendis!Tenetur modi soluta veritatis? Fugiat corrupti, ducimus mollitia illo nam quis officiis similique quae facilis molestias cum alias dolorem quaerat quod temporibus obcaecati tempora vero iure vel fuga. Consectetur, molestias?</p>
		</div>
		<div class="row">
			<div class="justify-content-center mx-auto">
				<img src="/Imagens/Logotipos/fccr_horizontal.png" alt="Logotipo da Fundação Cultural Cassiano Ricardo">
			</div>
		</div>
	</div>





		</asp:Panel>

		<asp:Panel ID="Panel2" runat="server" Height="100%">


			<asp:HyperLink ID="HyperLink5" runat="server" Font-Bold="True" NavigateUrl="~/Conversao_SQL.aspx" Visible="False">Conversão
				SQL</asp:HyperLink>

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
			<asp:ModalPopupExtender ID="MPE_Menu" runat="server" BackgroundCssClass="popUpStyle1" PopupControlID="pnlpopup"
			 DynamicServicePath="" Enabled="True" TargetControlID="Button1" CancelControlID="Button2" OkControlID="Button1" />
			</td>
			<td>
				&nbsp;</td>
			</tr>
			</table>
		</asp:Panel>
		</td>
		</tr>


	</form>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	 crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	 crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	 crossorigin="anonymous"></script>
	<script type="text/javascript" src="/js/tabs.js"></script>
	<script type="text/javascript" src="/js/functions.js"></script>
</body>

</html>