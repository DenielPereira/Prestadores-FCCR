Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Partial Class Documento_Cad
    Inherits System.Web.UI.Page
    Dim objConn As MySqlConnection
    Dim objDt As MySqlDataAdapter
    Dim ds As DataSet
    Dim objCmd As MySqlCommand
    Dim dr As MySqlDataReader
    Dim strexec, strreader As String
    Dim CtrLen, CtrTipo, CtrCodUsuario As Integer
    Dim sFileName, sImgFile, sPath As String
    Dim mdia, mmes As Integer
    Dim CodPrestador As Integer
    Dim m_perfil As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CodPrestador = Session("CodPrestador")
        If Not Page.IsPostBack Then
            Verifica_Acesso()
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
            MPE_DC.Show()
        End Try
    End Sub

    Protected Sub btn_Voltar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Voltar.Click
        Response.Redirect("Documento.aspx")
        Response.End()
    End Sub

    Protected Sub btn_Gravar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Gravar.Click
        lbl_mensagem_1.Text = "CONFIRMA O CADASTRO ?"
        lbl_mensagem_2.Text = ""
        img_btn_Fechar_Mensagem.Visible = "false"
        img_btn_sair_Mensagem.Visible = "false"
        btn_Confirma_Cadastro.Visible = "true"
        btn_Nao_Confirma.Visible = "true"
        MPE_DC.Show()
    End Sub

    Protected Sub btn_Confirma_Cadastro_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Confirma_Cadastro.Click
        Dim m_descricao, m_ondeobter, m_situacao As String
        Dim m_validade, m_prestador, m_fornecedor, m_mei, m_me, m_ltda, m_ac, m_epp, m_ei, m_eireli, m_sa, m_ss, m_pfisica, m_obrigatorio, m_qtde As Integer

        m_descricao = Replace(txt_Descricao.Text, "'", " ")
        m_descricao = Replace(m_descricao, ",", " ")
        m_ondeobter = Replace(txt_Onde_Obter.Text, "'", " ")
        m_ondeobter = Replace(m_ondeobter, ",", " ")
        m_situacao = ddl_Situacao.SelectedValue
        m_validade = Replace(txt_Validade.Text, "'", " ")
        m_validade = Replace(m_validade, ",", " ")

        If chk_Prestador.Checked = True Then
            m_prestador = 1
        Else
            m_prestador = 0
        End If
        If chk_Fornecedor.Checked = True Then
            m_fornecedor = 1
        Else
            m_fornecedor = 0
        End If
        If chk_AC.Checked = True Then
            m_ac = 1
        Else
            m_ac = 0
        End If
        If chk_EPP.Checked = True Then
            m_epp = 1
        Else
            m_epp = 0
        End If
        If chk_EI.Checked = True Then
            m_ei = 1
        Else
            m_ei = 0
        End If
        If chk_LTDA.Checked = True Then
            m_ltda = 1
        Else
            m_ltda = 0
        End If
        If chk_EIRELI.Checked = True Then
            m_eireli = 1
        Else
            m_eireli = 0
        End If
        If chk_MEI.Checked = "true" Then
            m_mei = 1
        Else
            m_mei = 0
        End If
        If chk_ME.Checked = True Then
            m_me = 1
        Else
            m_me = 0
        End If
        If chk_SA.Checked = True Then
            m_sa = 1
        Else
            m_sa = 0
        End If
        If chk_SS.Checked = True Then
            m_ss = 1
        Else
            m_ss = 0
        End If
        If chk_PFisica.Checked = True Then
            m_pfisica = 1
        Else
            m_pfisica = 0
        End If
        If chk_Obrigatorio.Checked = True Then
            m_obrigatorio = 1
        Else
            m_obrigatorio = 0
        End If
        If chk_Qtde_Permitida.Checked = True Then
            m_qtde = 1
        Else
            m_qtde = 0
        End If
        sImgFile = ""
        If Doc_Modelo.FileName <> "" Then
            sPath = Server.MapPath("~/modelo/") 'caminho onde vai ser salva a imagem
            sFileName = Doc_Modelo.FileName
            sImgFile = sPath & sFileName
            Doc_Modelo.SaveAs(sImgFile)
            sImgFile = "~\modelo\" & sFileName
            sImgFile = "~\\modelo\\" & sFileName
        End If

        If m_descricao <> "" And txt_Validade.Text <> "" Then
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            'inserir dados
            strexec = "INSERT INTO cad_documento(Doc_Descricao,Doc_Validade,Doc_Onde_Obter,Doc_Prestador,Doc_Fornecedor,"
            strexec = strexec & "Doc_AC,Doc_EPP,Doc_EI,Doc_Ltda,Doc_EIRELI,"
            strexec = strexec & "Doc_MEI,Doc_ME,Doc_SA,Doc_SS,Doc_PFisica,"
            strexec = strexec & "Doc_Situacao,Doc_Modelo,Doc_Obrigatorio,Doc_Qtde_Permitida) VALUES('"
            strexec = strexec & "" & m_descricao & "',"
            strexec = strexec & "" & m_validade & ","
            strexec = strexec & "'" & m_ondeobter & "',"
            strexec = strexec & "" & m_prestador & ","
            strexec = strexec & "" & m_fornecedor & ","
            strexec = strexec & "" & m_ac & ","
            strexec = strexec & "" & m_epp & ","
            strexec = strexec & "" & m_ei & ","
            strexec = strexec & "" & m_ltda & ","
            strexec = strexec & "" & m_eireli & ","
            strexec = strexec & "" & m_mei & ","
            strexec = strexec & "" & m_me & ","
            strexec = strexec & "" & m_sa & ","
            strexec = strexec & "" & m_ss & ","
            strexec = strexec & "" & m_pfisica & ","
            strexec = strexec & "'" & m_situacao & "',"
            strexec = strexec & "'" & sImgFile & "',"
            strexec = strexec & "" & m_obrigatorio & ","
            strexec = strexec & "" & m_qtde & ") "
            Try

           
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.Connection.Open()
                objCmd.ExecuteNonQuery()


                'dar mensagem
                lbl_mensagem_1.Text = "REGISTRO CADASTRADO COM SUCESSO !!!"
                lbl_mensagem_2.Text = ""
                img_btn_Fechar_Mensagem.Visible = "false"
                img_btn_sair_Mensagem.Visible = "true"
                btn_Confirma_Cadastro.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_DC.Show()

                'fechar
                objCmd.Connection.Close()
                objConn.Close()
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_DC.Show()
            End Try
        Else
            'dar mensagem
            lbl_mensagem_1.Text = "INFORME OS CAMPOS CORRETAMENTE !!!"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Cadastro.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_DC.Show()

        End If

    End Sub

    Protected Sub btn_Nao_Confirma_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Nao_Confirma.Click
        MPE_DC.Hide()
    End Sub

    Protected Sub img_btn_Fechar_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_Fechar_Mensagem.Click
        MPE_DC.Hide()
    End Sub

    Protected Sub img_btn_sair_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_sair_Mensagem.Click
        Response.Redirect("Documento.aspx")
        Response.End()
    End Sub
End Class
