Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Imports System.Web.DynamicData
Imports System.Web.Routing
Imports System.Net.Mail
Partial Class ErroGenerico
    Inherits System.Web.UI.Page
    Dim DescError As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        DescError = Request.QueryString("DescError")
        If Not Page.IsPostBack Then
            Me.MostraErro()
        End If
    End Sub
    Private Sub MostraErro()
        lbl_mensagem_1.Text = "OCORREU UM PROBLEMA !!!"
        lbl_mensagem_2.Text = DescError
        img_btn_Fechar_Mensagem.Visible = "false"
        img_btn_sair_Mensagem.Visible = "true"
        btn_Confirma_Exclusao.Visible = "false"
        btn_Nao_Confirma.Visible = "false"
        MPE_Erro.Show()
    End Sub
    Protected Sub img_btn_Fechar_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_Fechar_Mensagem.Click
        MPE_Erro.Hide()
    End Sub

    Protected Sub img_btn_sair_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_sair_Mensagem.Click
        Response.Redirect("Login_Cadastro.aspx")
        Response.End()
    End Sub
End Class
