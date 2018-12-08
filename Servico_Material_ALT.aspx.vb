Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Partial Class Servico_Material_ALT
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
        CodSM = Request.QueryString("CodSM")
        If Not Page.IsPostBack Then
            Verifica_Acesso()
            Me.MostraDados()
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

    Private Sub MostraDados()
        'abrindo conexao
        objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

        'pegar dados

        strreader = "SELECT "
        strreader = strreader & "cad_servico_material.SM_ID,"
        strreader = strreader & "cad_servico_material.SM_Codigo,"
        strreader = strreader & "cad_servico_material.SM_Descricao,"
        strreader = strreader & "cad_servico_material.SM_Prestador,"
        strreader = strreader & "cad_servico_material.SM_Fornecedor,"
        strreader = strreader & "cad_servico_material.SM_Situacao "
        strreader = strreader & "FROM cad_servico_material "
        strreader = strreader & "WHERE cad_servico_material.SM_ID=" & CodSM & ""
        Try
            objCmd = New MySqlCommand(strreader, objConn)

            'criar datareader
            objCmd.Connection.Open()
            dr = objCmd.ExecuteReader()

            'se achar retorna verdadeiro
            If dr.Read() Then
                If Not IsDBNull(dr("SM_Codigo")) Then
                    txt_Codigo.Text = dr("SM_Codigo")
                End If
                If Not IsDBNull(dr("SM_Descricao")) Then
                    txt_Descricao.Text = dr("SM_Descricao")
                End If
                If Not IsDBNull(dr("SM_Prestador")) Then
                    If dr("SM_Prestador") = 1 Then
                        chk_Prestador.Checked = "true"
                    Else
                        chk_Prestador.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("SM_Fornecedor")) Then
                    If dr("SM_Fornecedor") = 1 Then
                        chk_Fornecedor.Checked = "true"
                    Else
                        chk_Fornecedor.Checked = "false"
                    End If
                End If

                If Not IsDBNull(dr("SM_Situacao")) Then
                    ddl_Situacao.SelectedValue = dr("SM_Situacao")
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
            MPE_SM.Show()
        End Try

    End Sub

  
    Protected Sub btn_Voltar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_Voltar.Click
        Response.Redirect("Servico_Material.aspx")
        Response.End()
    End Sub

    Protected Sub btn_Confirma_Exclusao_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Confirma_Exclusao.Click     'abrindo conexao
        objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

        'inserir dados
        strexec = "DELETE cad_servico_material FROM cad_servico_material "
        strexec = strexec & "WHERE cad_servico_material.SM_ID=" & CodSM & ""
        Try
            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()

            'fechar
            objCmd.Connection.Close()
            objConn.Close()

            lbl_mensagem_1.Text = "REGISTRO EXCLUIDO COM SUCESSO !!!"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "false"
            img_btn_sair_Mensagem.Visible = "true"
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_SM.Show()
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_SM.Show()

        End Try
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

    Protected Sub btn_Voltar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Voltar.Click
        Response.Redirect("Servico_Material.aspx")
        Response.End()
    End Sub

    Protected Sub btn_Gravar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Gravar.Click
        Dim m_descricao, m_codigo, m_situacao As String
        Dim m_prestador, m_fornecedor As Integer

        m_codigo = Replace(txt_Codigo.Text, "'", " ")
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
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            'inserir dados
            strexec = "UPDATE cad_servico_material SET "
            strexec = strexec & "cad_servico_material.SM_Codigo='" & m_codigo & "',"
            strexec = strexec & "cad_servico_material.SM_Descricao='" & m_descricao & "',"
            strexec = strexec & "cad_servico_material.SM_Prestador=" & m_prestador & ","
            strexec = strexec & "cad_servico_material.SM_Fornecedor=" & m_fornecedor & ","
            strexec = strexec & "cad_servico_material.SM_Situacao='" & m_situacao & "' "
            strexec = strexec & "WHERE cad_servico_material.SM_ID=" & CodSM & ""
            Try
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.Connection.Open()
                objCmd.ExecuteNonQuery()


                'dar mensagem
                lbl_mensagem_1.Text = "REGISTRO ALTERADO COM SUCESSO !!!"
                lbl_mensagem_2.Text = ""
                img_btn_Fechar_Mensagem.Visible = "false"
                img_btn_sair_Mensagem.Visible = "true"
                btn_Confirma_Exclusao.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_SM.Show()

                'fechar
                objCmd.Connection.Close()
                objConn.Close()
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_SM.Show()
            End Try

        Else
            'dar mensagem
            lbl_mensagem_1.Text = "Verifique os campos obrigatórios !!!"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_SM.Show()
        End If

    End Sub

    Protected Sub btn_Excluir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Excluir.Click
        lbl_mensagem_1.Text = "SE CONFIRMAR A EXCLUSÃO, O REGISTRO SERÁ EXCLUIDO DEFINITIVAMENTE !!!"
        lbl_mensagem_2.Text = "CONFIRMA A EXCLUSÃO DO REGISTRO ?"
        img_btn_Fechar_Mensagem.Visible = "false"
        img_btn_sair_Mensagem.Visible = "false"
        btn_Confirma_Exclusao.Visible = "true"
        btn_Nao_Confirma.Visible = "true"
        MPE_SM.Show()
    End Sub
   
End Class
