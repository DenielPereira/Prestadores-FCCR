Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Partial Class Cadastro_Menu
    Inherits System.Web.UI.Page
    Dim objConn As MySqlConnection
    Dim objDt As MySqlDataAdapter
    Dim ds As DataSet
    Dim objCmd As MySqlCommand
    Dim dr As MySqlDataReader
    Dim strexec, strreader As String
    Dim CtrLen, CtrTipo, CtrCodUsuario, CodDoc As Integer
    Dim sFileName, sImgFile, sPath As String
    Dim mdia, mmes As Integer
    Dim CodPrestador As Integer
    Dim m_perfil As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CodPrestador = Session("CodPrestador") 'Request.QueryString("CodPrestador")
        m_perfil = ""

        'lnk_Menu_Sair.Attributes.Add("OnClick", "fechatudo()")

        If Not Page.IsPostBack Then
            Verifica_Acesso()
            If m_perfil <> "Administrador" Then
                lnk_Menu_Email.Visible = "False"
                lnk_Menu_Usuario.Visible = "False"
            End If
        End If
    End Sub
    Private Sub Verifica_Acesso()

        'abrindo conexao
        objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

        strreader = "SELECT "
        strreader = strreader & "cad_usuario.usu_id,"
        strreader = strreader & "cad_usuario.usu_codigo,"
        strreader = strreader & "cad_usuario.usu_senha, "
        strreader = strreader & "cad_usuario.usu_perfil "
        strreader = strreader & "FROM cad_usuario "
        strreader = strreader & "WHERE cad_usuario.usu_id='" & CodPrestador & "' and cad_usuario.usu_senha='" & Session("PasPrestador") & "'"

        Try
            objCmd = New MySqlCommand(strreader, objConn)

            'criar datareader
            objCmd.Connection.Open()
            dr = objCmd.ExecuteReader()

            'se achar retorna verdadeiro
            If dr.Read() Then
                ' usuario é administrador/gerente
                m_perfil = dr("usu_perfil")

            Else
                objCmd.Connection.Close()
                objConn.Close()
                objConn = Nothing
                Response.Redirect("Login_Cadastro.aspx")
                Response.End()
            End If

            dr.Close()
            dr = Nothing

            'fechar conexao

            objConn.Close()
            objConn = Nothing
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Menu.Show()
        End Try

    End Sub


    Protected Sub lnk_Menu_Material_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Material.Click
        Response.Redirect("Servico_Material.aspx")
        Response.End()
    End Sub

    Protected Sub lnk_Menu_Documento_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Documento.Click
        Response.Redirect("Documento.aspx")
        Response.End()
    End Sub

    Protected Sub lnk_Menu_Prestador_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Prestador.Click
        Response.Redirect("Pesquisa_Prestador.aspx")
        Response.End()
    End Sub

    Protected Sub lnk_Menu_Email_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Email.Click
        Response.Redirect("Envio_de_Email.aspx")
        Response.End()
    End Sub

    Protected Sub lnk_Menu_Usuario_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Usuario.Click
        Response.Redirect("Usuario.aspx")
        Response.End()
    End Sub

    Protected Sub lnk_Menu_Inicial_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Inicial.Click
        Response.Redirect("Login_Cadastro.aspx")
        Response.End()
    End Sub
    Protected Sub img_btn_Fechar_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_Fechar_Mensagem.Click
        MPE_Menu.Hide()
    End Sub

End Class
