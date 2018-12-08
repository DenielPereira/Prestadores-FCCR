Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Partial Class Usuario_Alt
    Inherits System.Web.UI.Page
    Dim objConn As MySqlConnection
    Dim objDt As MySqlDataAdapter
    Dim ds As DataSet
    Dim objCmd As MySqlCommand
    Dim dr As MySqlDataReader
    Dim strexec, strreader As String
    Dim CtrLen, CtrTipo, CtrCodUsuario, CodUSU As Integer
    Dim sFileName, sImgFile, sPath As String
    Dim mdia, mmes As Integer
    Dim CodPrestador As Integer
    Dim m_perfil As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CodPrestador = Session("CodPrestador")
        CodUSU = Request.QueryString("CodUsu")

        txt_usu_telefone.Attributes.Add("onKeyPress", "javascript:MascaraTelefone(txt_usu_telefone)")
        txt_usu_celular.Attributes.Add("onKeyPress", "javascript:MascaraCelular(txt_usu_celular)")
        txt_usu_email.Attributes.Add("onBlur", "javascript:ValidaEmail(txt_usu_email)")

        If Not Page.IsPostBack Then
            Verifica_Acesso()
            Me.MostraDados()
        End If
    End Sub
    Private Sub Verifica_Acesso()
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            strreader = "SELECT "
            strreader = strreader & "cad_usuario.usu_id,"
            strreader = strreader & "cad_usuario.usu_codigo,"
            strreader = strreader & "cad_usuario.usu_senha, "
            strreader = strreader & "cad_usuario.usu_perfil "
            strreader = strreader & "FROM cad_usuario "
            strreader = strreader & "WHERE cad_usuario.usu_id=" & CodPrestador & " and cad_usuario.usu_senha='" & Session("PasPrestador") & "'"

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
            btn_Nao_Confirma.Visible = "false"
            MPE_USU.Show()
        End Try
    End Sub

    Private Sub MostraDados()
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            'pegar dados

            strreader = "SELECT "
            strreader = strreader & "cad_usuario.usu_id,"
            strreader = strreader & "cad_usuario.usu_codigo,"
            strreader = strreader & "cad_usuario.usu_nome, "
            strreader = strreader & "cad_usuario.usu_local, "
            strreader = strreader & "cad_usuario.usu_telefone, "
            strreader = strreader & "cad_usuario.usu_celular, "
            strreader = strreader & "cad_usuario.usu_email, "
            strreader = strreader & "cad_usuario.usu_senha, "
            strreader = strreader & "cad_usuario.usu_situacao, "
            strreader = strreader & "cad_usuario.usu_situacao_data, "
            strreader = strreader & "cad_usuario.usu_perfil "
            strreader = strreader & "FROM cad_usuario "
            strreader = strreader & "WHERE cad_usuario.usu_id='" & CodUSU & "'"


            objCmd = New MySqlCommand(strreader, objConn)

            'criar datareader
            objCmd.Connection.Open()
            dr = objCmd.ExecuteReader()

            'se achar retorna verdadeiro
            If dr.Read() Then
                If Not IsDBNull(dr("usu_codigo")) Then
                    txt_usu_CPF.Text = dr("usu_codigo")
                End If
                If Not IsDBNull(dr("usu_nome")) Then
                    txt_usu_nome.Text = dr("usu_nome")
                End If
                If Not IsDBNull(dr("usu_local")) Then
                    txt_usu_local.Text = dr("usu_local")
                End If
                If Not IsDBNull(dr("usu_telefone")) Then
                    txt_usu_telefone.Text = dr("usu_telefone")
                End If
                If Not IsDBNull(dr("usu_celular")) Then
                    txt_usu_celular.Text = dr("usu_celular")
                End If
                If Not IsDBNull(dr("usu_email")) Then
                    txt_usu_email.Text = dr("usu_email")
                End If
                If Not IsDBNull(dr("usu_senha")) Then
                    txt_usu_senha.Text = dr("usu_senha")
                End If
                If Not IsDBNull(dr("usu_perfil")) Then
                    ddl_usu_perfil.SelectedValue = dr("usu_perfil")
                End If
                If Not IsDBNull(dr("usu_situacao")) Then
                    ddl_usu_situacao.SelectedValue = dr("usu_situacao")
                End If
                If Not IsDBNull(dr("usu_situacao_data")) Then
                    txt_usu_data.Text = dr("usu_situacao_data")
                End If
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
            btn_Nao_Confirma.Visible = "false"
            MPE_USU.Show()
        End Try
    End Sub

    Protected Sub btn_Voltar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_Voltar.Click
        Response.Redirect("Usuario.aspx")
        Response.End()
    End Sub

    Protected Sub btn_Confirma_Exclusao_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Confirma_Exclusao.Click
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            'inserir dados
            strexec = "DELETE cad_usuario FROM cad_usuario "
            strexec = strexec & "WHERE cad_usuario.usu_ID=" & CodUSU & ""

            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()

            lbl_mensagem_1.Text = "REGISTRO EXCLUIDO COM SUCESSO !!!"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "false"
            img_btn_sair_Mensagem.Visible = "true"
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_USU.Show()

            'fechar
            objCmd.Connection.Close()
            objConn.Close()
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_USU.Show()
        End Try
    End Sub
    Protected Sub btn_Nao_Confirma_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Nao_Confirma.Click
        MPE_USU.Hide()
    End Sub
    Protected Sub img_btn_Fechar_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_Fechar_Mensagem.Click
        MPE_USU.Hide()
    End Sub
    Protected Sub img_btn_sair_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_sair_Mensagem.Click
        Response.Redirect("Usuario.aspx")
        Response.End()
    End Sub

    Protected Sub btn_Voltar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Voltar.Click
        Response.Redirect("Usuario.aspx")
        Response.End()
    End Sub

    Protected Sub btn_Gravar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Gravar.Click
        Dim m_codigo, m_nome, m_local, m_telefone, m_celular, m_email, m_senha, m_perfil, m_situacao, m_data_situacao, m_data As String
        Dim m_prestador, m_fornecedor As Integer

        m_codigo = Replace(txt_usu_CPF.Text, "'", " ")
        m_codigo = Replace(m_codigo, ",", " ")
        m_nome = Replace(txt_usu_nome.Text, "'", " ")
        m_nome = Replace(m_nome, ",", " ")
        m_local = Replace(txt_usu_local.Text, "'", " ")
        m_local = Replace(m_local, ",", " ")
        m_telefone = Replace(txt_usu_telefone.Text, "'", " ")
        m_telefone = Replace(m_telefone, ",", " ")
        m_celular = Replace(txt_usu_celular.Text, "'", " ")
        m_celular = Replace(m_celular, ",", " ")
        m_email = Replace(txt_usu_email.Text, "'", " ")
        m_email = Replace(m_email, ",", " ")
        m_senha = Replace(txt_usu_senha.Text, "'", " ")
        m_senha = Replace(m_senha, ",", " ")
        m_perfil = ddl_usu_perfil.SelectedValue
        m_data = Mid(Year(Today()), 1, 4)
        If Month(Today()) <= 9 Then
            m_data = m_data & "/0" & Month(Today())
        Else
            m_data = m_data & "/" & Month(Today())
        End If
        If Day(Today()) <= 9 Then
            m_data = m_data & "/0" & Day(Today())
        Else
            m_data = m_data & "/" & Day(Today())
        End If

        m_situacao = ddl_usu_situacao.SelectedValue

        If m_nome <> "" Then
            Try
                'abrindo conexao
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                'inserir dados
                strexec = "UPDATE cad_usuario SET "
                strexec = strexec & "cad_usuario.usu_nome='" & m_nome & "',"
                strexec = strexec & "cad_usuario.usu_local='" & m_local & "',"
                strexec = strexec & "cad_usuario.usu_telefone='" & m_telefone & "',"
                strexec = strexec & "cad_usuario.usu_celular='" & m_celular & "',"
                strexec = strexec & "cad_usuario.usu_email='" & m_email & "',"
                strexec = strexec & "cad_usuario.usu_senha='" & m_senha & "',"
                strexec = strexec & "cad_usuario.usu_perfil='" & m_perfil & "',"
                strexec = strexec & "cad_usuario.usu_situacao='" & m_situacao & "', "
                strexec = strexec & "cad_usuario.usu_situacao_data='" & m_data & "' "
                strexec = strexec & "WHERE cad_usuario.usu_ID=" & CodUSU & ""

                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.Connection.Open()
                objCmd.ExecuteNonQuery()

                'fechar
                objCmd.Connection.Close()
                objConn.Close()

                'dar mensagem
                lbl_mensagem_1.Text = "REGISTRO ALTERADO COM SUCESSO !!!"
                lbl_mensagem_2.Text = ""
                img_btn_Fechar_Mensagem.Visible = "false"
                img_btn_sair_Mensagem.Visible = "true"
                btn_Confirma_Exclusao.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_USU.Show()
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_USU.Show()
            End Try


        Else
            'dar mensagem
            lbl_mensagem_1.Text = "Verifique os campos obrigatórios !!!"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_USU.Show()
        End If

    End Sub

    Protected Sub btn_Excluir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Excluir.Click
        lbl_mensagem_1.Text = "SE CONFIRMAR A EXCLUSÃO, O REGISTRO SERÁ EXCLUIDO DEFINITIVAMENTE !!!"
        lbl_mensagem_2.Text = "CONFIRMA A EXCLUSÃO DO REGISTRO ?"
        img_btn_Fechar_Mensagem.Visible = "false"
        img_btn_sair_Mensagem.Visible = "false"
        btn_Confirma_Exclusao.Visible = "true"
        btn_Nao_Confirma.Visible = "true"
        MPE_USU.Show()
    End Sub
End Class
