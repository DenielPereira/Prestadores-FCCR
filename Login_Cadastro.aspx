<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login_Cadastro.aspx.vb" Inherits="Login_Cadastro" MaintainScrollPositionOnPostback="True" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<!DOCTYPE html>

<html>

<head id="Head1" runat="server">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
	<meta charset="utf-8" />
    <title>FCCR - Prestadores de Serviços</title>
	<link rel="icon" href="/favicon.ico" type="image/x-icon" />
	<link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	 crossorigin="anonymous"/>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	 crossorigin="anonymous"/>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>

<body style="overflow-x: hidden;">
	<form id="Form1" name="form1" runat="server">

		<asp:ToolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager2" ScriptMode="Release" />

		<div class="row bg-logo px-2">
			<div class="text-center mb-3 mt-3 w-100">
				<asp:Label ID="lbl_Titulo35" runat="server" CssClass="display-4">Prestadores de Serviços</asp:Label>
				<br />
				<asp:Label ID="lbl_Titulo" runat="server" CssClass="lead">Fundação Cultural Cassiano Ricardo</asp:Label>
			</div>
		</div>

		<hr class="align-self-center w-90" />

		<asp:Panel ID="Panel1" runat="server" CssClass="row align-items-center justify-content-center text-center v-center">

			<div class="container">

				<div class="card py-2 w-50 mx-auto">
					<div class="titulo">
						<asp:Label ID="lbl_Titulo15" runat="server">Seja bem-vindo</asp:Label>
					</div>
					<hr class="w-90  align-self-center" />
					<small>Digite seus dados abaixo para logar</small>
					<div class="card-body py-2 px-5">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<asp:Label ID="lbl_Titulo2" runat="server" CssClass="input-group-text">CNPJ</asp:Label>
							</div>
							<asp:TextBox ID="txt_CNPJ" runat="server" CssClass="ph-center campo form-control" ForeColor="Black" ToolTip="Digite apenas os números"
							 placeholder="Digite aqui apenas se você for pessoa jurídica" Value="Digite aqui apenas se você for pessoa jurídica" style="font-size: 14px;"></asp:TextBox>
						</div>

						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<asp:Label ID="lbl_Titulo5" runat="server" CssClass="input-group-text">CPF</asp:Label>
							</div>
							<asp:TextBox ID="txt_CPF" runat="server" CssClass="ph-center campo form-control" ForeColor="Black" ToolTip="Digite apenas os números"
							 placeholder="Digite aqui apenas se você for pessoa física" style="font-size: 14px;"></asp:TextBox>
						</div>

						<div class="input-group">
							<div class="input-group-prepend">
								<asp:Label ID="lbl_Titulo6" runat="server" CssClass="input-group-text">Senha</asp:Label>
							</div>
							<asp:TextBox ID="txt_Senha" runat="server" CssClass="ph-center campo form-control" ForeColor="Black" MaxLength="10"
							 TextMode="Password" ToolTip="Digite aqui sua senha" placeholder="Digite aqui sua senha"></asp:TextBox>
						</div>

						<div class="text-right">
							<small>
								<asp:LinkButton ID="lnk_esqueceu" runat="server">Esqueceu sua senha ?</asp:LinkButton>
							</small>
						</div>

						<asp:TextBox ID="txtCaptcha" runat="server" BackColor="White" BorderStyle="None" ForeColor="White" CssClass="align-self-center"
						 ></asp:TextBox>

						<div class="row justify-content-center">
							<div id="ReCaptchContainer" class="mb-2 mt-2"></div>
							<label id="lblMessage" runat="server" clientidmode="static" visible="False"></label>
							<div class="g-recaptcha" data-sitekey="6Lf26n0UAAAAAGrX52ppYaF5BdsEHsPUIr_2f6yJ"></div>
						</div>

						<asp:Button ID="btn_entrar" runat="server" CssClass="btn btn-primary w-50 align-self-center mb-2" Text="Entrar" />

						<p>
							Ainda não tem uma conta?
							<asp:LinkButton ID="LinkButton4" runat="server">Crie uma!</asp:LinkButton>
						</p>
					</div>
				</div>
			</div>
		</asp:Panel>

		<asp:Panel ID="pnlpopup" runat="server" CssClass="popUpStyle" Width="580px" Style="display: none;">
			<table align="center" bgcolor="#FFFF99" frame="border" border="0" cellpadding="1" cellspacing="1" rules="none" width="100%">
				<tr>
					<td>&nbsp;</td>
					<td align="right">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">
						<asp:Label ID="Label566" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#CC3300" Text="A T E N Ç Ã O   ! ! !"></asp:Label>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">
						<!-- os botoes abaixo sao somente para o popup funcionar corretamente -->
						<asp:Button ID="Button1" runat="server" Text="Salvar" Style="display: none;" />
						<asp:Button ID="Button2" runat="server" Text="Cancelar" Style="display: none;" />

						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">
						<asp:Label ID="lbl_mensagem_1" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#669900"></asp:Label>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">
						<asp:Label ID="lbl_mensagem_2" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#669900"></asp:Label>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">
						<asp:Button ID="btn_Confirma_Exclusao" runat="server" BackColor="#00554F" Font-Bold="True" Font-Names="Verdana"
						 ForeColor="White" Height="40px" Text="S I M" Visible="False" Width="150px" />
						&nbsp;&nbsp;&nbsp;
						<asp:Button ID="btn_Nao_Confirma" runat="server" BackColor="#00554F" Font-Bold="True" Font-Names="Verdana"
						 ForeColor="White" Height="40px" Text="N Â O" Visible="False" Width="150px" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="center">
						<asp:Button ID="img_btn_Fechar_Mensagem" runat="server" BackColor="#00554F" Font-Bold="True" Font-Names="Verdana"
						 ForeColor="White" Height="40px" Text="FECHAR" Visible="False" Width="150px" />
						<asp:Button ID="img_btn_sair_Mensagem" runat="server" BackColor="#00554F" Font-Bold="True" Font-Names="Verdana"
						 ForeColor="White" Height="40px" Text="FECHAR" Visible="False" Width="150px" />
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
			</table>

		</asp:Panel>
		<asp:ModalPopupExtender ID="MPE_Login" runat="server" BackgroundCssClass="popUpStyle1" PopupControlID="pnlpopup"
		 Enabled="True" TargetControlID="Button1" CancelControlID="Button2" OkControlID="Button1" />

	</form>
	<footer class="bg-green h-20 footer mt-3">
		<div class="text-center brands">
			<a href="http://facebook.com/fccrsjc" target="_blank">
				<i class="fab fa-facebook"></i>
			</a>
			<a href="http://instagram.com/fccrsjc" target="_blank">
				<i class="fab fa-instagram"></i>
			</a>
			<a href="http://twitter.com/fccrsjc" target="_blank">
				<i class="fab fa-twitter"></i>
			</a>
			<a href="http://youtube.com/fccrsjc" target="_blank">
				<i class="fab fa-youtube"></i>
			</a>
		</div>
		<div class="text-center text-light mt-2 copy">
			<p>
				&copy;2018 <a href="http://fccr.sp.gov.br" target="_blank">Fundação Cultural Cassiano Ricardo </a>
			</p>
		</div>
	</footer>

	<script src="https://www.google.com/recaptcha/api.js?onload=renderRecaptcha&render=explicit" async defer></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	 crossorigin="anonymous"></script>
	<script type="text/javascript" src="/js/functions.js"></script>
</body>

</html>