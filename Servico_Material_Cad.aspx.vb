Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Partial Class Servico_Material_Cad
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
        CodPrestador = Session("CodPrestador")
        If Not Page.IsPostBack Then
            Verifica_Acesso()
            txt_Descricao.Focus()
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
        strreader = strreader & "WHERE cad_usuario.usu_id=" & CodPrestador & " and cad_usuario.usu_senha='" & Session("PasPrestador") & "'"
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
            btn_Nao_Confirma.Visible = "false"
            MPE_SM.Show()
        End Try

    End Sub

    Protected Sub btn_Voltar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Voltar.Click
        Response.Redirect("Servico_Material.aspx")
        Response.End()
    End Sub

    Protected Sub btn_Cadastrar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Cadastrar.Click
        lbl_mensagem_1.Text = "CONFIRMA O CADASTRO ?"
        lbl_mensagem_2.Text = ""
        img_btn_Fechar_Mensagem.Visible = "false"
        img_btn_sair_Mensagem.Visible = "false"
        btn_Confirma_Cadastro.Visible = "true"
        btn_Nao_Confirma.Visible = "true"
        MPE_SM.Show()
    End Sub

    Protected Sub btn_Confirma_Cadastro_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Confirma_Cadastro.Click
        Dim m_descricao, m_codigo, m_situacao As String
        Dim m_prestador, m_fornecedor, machou As Integer
        lblError.Text = ""
        m_codigo = "000000" 'Replace(txt_Codigo.Text, "'", " ")
        m_codigo = Replace(m_codigo, ",", " ")
        m_descricao = Replace(txt_Descricao.Text, "'", " ")
        m_descricao = Replace(m_descricao, ",", " ")
        m_situacao = ddl_Situacao.SelectedValue
        If chk_Prestador.Checked = "true" Then
            m_prestador = 1
        Else
            m_prestador = 0
        End If
        If chk_Fornecedor.Checked = "true" Then
            m_fornecedor = 1
        Else
            m_fornecedor = 0
        End If
        If m_descricao <> "" Then

            Try
                'abrindo conexao
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)


                strreader = "SELECT "
                strreader = strreader & "SM_Descricao "
                strreader = strreader & "FROM cad_servico_material "
                strreader = strreader & "WHERE SM_Descricao LIKE '%" & m_descricao & "%' "

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
                    strexec = "INSERT INTO cad_servico_material(SM_Codigo,SM_Descricao,SM_Prestador,SM_Fornecedor,"
                    strexec = strexec & "SM_Situacao) VALUES("
                    strexec = strexec & "'" & m_codigo & "',"
                    strexec = strexec & "'" & m_descricao & "',"
                    strexec = strexec & "" & m_prestador & ","
                    strexec = strexec & "" & m_fornecedor & ","
                    strexec = strexec & "'" & m_situacao & "')"

                    objCmd = New MySqlCommand(strexec, objConn)
                    objCmd.ExecuteNonQuery()
                    'fechar
                    objCmd.Connection.Close()
                    objConn.Close()

                    lbl_mensagem_1.Text = "REGISTRO CADASTRADO COM SUCESSO !!!"
                    lbl_mensagem_2.Text = ""
                    img_btn_Fechar_Mensagem.Visible = "false"
                    img_btn_sair_Mensagem.Visible = "true"
                    btn_Confirma_Cadastro.Visible = "false"
                    btn_Nao_Confirma.Visible = "false"
                    MPE_SM.Show()

                    lblError.Text = ""
                    txt_Codigo.Text = ""
                    txt_Descricao.Text = ""
                    ddl_Situacao.SelectedValue = "Ativo"
                    chk_Prestador.Checked = "false"
                    chk_Fornecedor.Checked = "false"

                Else

                    lbl_mensagem_1.Text = "ESSE SERVIÇO/MATERIAL JÁ ESTÁ CADASTRADO !!!"
                    lbl_mensagem_2.Text = ""
                    img_btn_Fechar_Mensagem.Visible = "true"
                    img_btn_sair_Mensagem.Visible = "false"
                    btn_Confirma_Cadastro.Visible = "false"
                    btn_Nao_Confirma.Visible = "false"
                    MPE_SM.Show()
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
                MPE_SM.Show()
            End Try

        Else
            lbl_mensagem_1.Text = "VERIFIQUE OS CAMPOS OBRIGATÓRIOS !!!"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Cadastro.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_SM.Show()
        End If

    End Sub

    Protected Sub btn_Nao_Confirma_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Nao_Confirma.Click
        MPE_SM.Hide()
    End Sub

    Protected Sub img_btn_Fechar_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_Fechar_Mensagem.Click
        MPE_SM.Hide()
    End Sub

    Protected Sub img_btn_sair_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_sair_Mensagem.Click
        Response.Redirect("Servico_Material.aspx")
        Response.End()
    End Sub
End Class
