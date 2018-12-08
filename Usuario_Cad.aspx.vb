Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Partial Class Usuario_Cad
    Inherits System.Web.UI.Page
    Dim objConn As MySqlConnection
    Dim objDt As MySqlDataAdapter
    Dim ds As DataSet
    Dim objCmd As MySqlCommand
    Dim dr As MySqlDataReader
    Dim strexec, strreader As String
    Dim CtrLen, CtrTipo, CtrCodUsuario, CodSM As Integer
    Dim sFileName, sImgFile, sPath As String
    Dim mdia, mmes As Integer
    Dim CodPrestador As Integer
    Dim m_perfil As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        txt_usu_telefone_cad.Attributes.Add("onKeyPress", "javascript:MascaraTelefone(txt_usu_telefone_cad)")
        txt_usu_celular_cad.Attributes.Add("onKeyPress", "javascript:MascaraCelular(txt_usu_celular_cad)")
        txt_usu_email_cad.Attributes.Add("onBlur", "javascript:ValidaEmail(txt_usu_email_cad)")
        txt_usu_CPF_cad.Attributes.Add("onkeyup", "javascript:formatar(this, '###.###.###-##')")
        txt_usu_CPF_cad.Attributes.Add("onBlur", "javascript:valida_cpf(txt_usu_CPF_cad)")

        CodPrestador = Session("CodPrestador")
        If Not Page.IsPostBack Then
            Verifica_Acesso()
            txt_usu_CPF_cad.Focus()
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

    Protected Sub btn_Voltar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Voltar.Click
        Response.Redirect("Usuario.aspx")
        Response.End()
    End Sub

    Protected Sub btn_Gravar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Gravar.Click
        lbl_mensagem_1.Text = "CONFIRMA O CADASTRO ?"
        lbl_mensagem_2.Text = ""
        img_btn_Fechar_Mensagem.Visible = "false"
        img_btn_sair_Mensagem.Visible = "false"
        btn_Confirma_Cadastro.Visible = "true"
        btn_Nao_Confirma.Visible = "true"
        MPE_USU.Show()
    End Sub

    Protected Sub btn_Confirma_Cadastro_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Confirma_Cadastro.Click
        Dim m_codigo, m_nome, m_local, m_telefone, m_celular, m_email, m_senha, m_perfil, m_situacao, m_data_situacao, m_data As String
        Dim m_prestador, m_fornecedor, machou As Integer
        'lblError.Text = ""
        m_codigo = Replace(txt_usu_CPF_cad.Text, "'", " ")
        m_codigo = Replace(m_codigo, ",", " ")
        m_nome = Replace(txt_usu_nome_cad.Text, "'", " ")
        m_nome = Replace(m_nome, ",", " ")
        m_local = Replace(txt_usu_local_cad.Text, "'", " ")
        m_local = Replace(m_local, ",", " ")
        m_telefone = Replace(txt_usu_telefone_cad.Text, "'", " ")
        m_telefone = Replace(m_telefone, ",", " ")
        m_celular = Replace(txt_usu_celular_cad.Text, "'", " ")
        m_celular = Replace(m_celular, ",", " ")
        m_email = Replace(txt_usu_email_cad.Text, "'", " ")
        m_email = Replace(m_email, ",", " ")
        m_senha = Replace(txt_usu_senha_cad.Text, "'", " ")
        m_senha = Replace(m_senha, ",", " ")
        m_perfil = ddl_usu_perfil_cad.SelectedValue
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

        m_situacao = ddl_usu_situacao_cad.SelectedValue

        If m_codigo <> "" Then
            Try
                'abrindo conexao
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)



                strreader = "SELECT "
                strreader = strreader & "cad_usuario.usu_id,"
                strreader = strreader & "cad_usuario.usu_codigo,"
                strreader = strreader & "cad_usuario.usu_senha, "
                strreader = strreader & "cad_usuario.usu_perfil "
                strreader = strreader & "FROM cad_usuario "
                strreader = strreader & "WHERE cad_usuario.usu_codigo='" & m_codigo & "'"

                objCmd = New MySqlCommand(strreader, objConn)
                objCmd.Connection.Open()
                dr = objCmd.ExecuteReader()

                machou = 0
                'se achar retorna verdadeiro
                If dr.Read() Then

                    machou = 1

                End If

                dr.Close()
                dr = Nothing

                If machou = 0 Then
                    'inserir dados
                    strexec = "INSERT INTO cad_usuario ("
                    strexec = strexec & "usu_codigo,"
                    strexec = strexec & "usu_nome,"
                    strexec = strexec & "usu_local,"
                    strexec = strexec & "usu_telefone,"
                    strexec = strexec & "usu_celular,"
                    strexec = strexec & "usu_email,"
                    strexec = strexec & "usu_senha,"
                    strexec = strexec & "usu_perfil,"
                    strexec = strexec & "usu_situacao, "
                    strexec = strexec & "usu_situacao_data) VALUES ("

                    strexec = strexec & "'" & m_codigo & "',"
                    strexec = strexec & "'" & m_nome & "',"
                    strexec = strexec & "'" & m_local & "',"
                    strexec = strexec & "'" & m_telefone & "',"
                    strexec = strexec & "'" & m_celular & "',"
                    strexec = strexec & "'" & m_email & "',"
                    strexec = strexec & "'" & m_senha & "',"
                    strexec = strexec & "'" & m_perfil & "',"
                    strexec = strexec & "'" & m_situacao & "', "
                    strexec = strexec & "'" & m_data & "')"


                    objCmd = New MySqlCommand(strexec, objConn)
                    objCmd.ExecuteNonQuery()
                    'fechar
                    objCmd.Connection.Close()
                    objConn.Close()

                    'dar mensagem
                    lbl_mensagem_1.Text = "REGISTRO CADASTRADO COM SUCESSO !!!"
                    lbl_mensagem_2.Text = ""
                    img_btn_Fechar_Mensagem.Visible = "false"
                    img_btn_sair_Mensagem.Visible = "true"
                    btn_Confirma_Cadastro.Visible = "false"
                    btn_Nao_Confirma.Visible = "false"
                    MPE_USU.Show()

                Else
                    'dar mensagem
                    lbl_mensagem_1.Text = "ESTE USUÁRIO JÁ ESTÁ CADASTRADO !!!"
                    lbl_mensagem_2.Text = ""
                    img_btn_Fechar_Mensagem.Visible = "true"
                    img_btn_sair_Mensagem.Visible = "false"
                    btn_Confirma_Cadastro.Visible = "false"
                    btn_Nao_Confirma.Visible = "false"
                    MPE_USU.Show()
                    'fechar
                    objCmd.Connection.Close()
                    objConn.Close()

                End If
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
            lbl_mensagem_1.Text = "INFORME OS CAMPOS CORRETAMENTE !!!"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Cadastro.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_USU.Show()
        End If

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
End Class
