Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection

Partial Class Documento_Alt
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
        CodPrestador = Session("CodPrestador")
        CodDoc = Request.QueryString("CodDoc")
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
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_DC.Show()
        End Try
    End Sub

    Private Sub MostraDados()
        'abrindo conexao
        objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

        'pegar dados

        strreader = "SELECT "
        strreader = strreader & "cad_documento.Doc_ID,"
        strreader = strreader & "cad_documento.Doc_Descricao,"
        strreader = strreader & "cad_documento.Doc_Validade,"
        strreader = strreader & "cad_documento.Doc_Onde_Obter,"
        strreader = strreader & "cad_documento.Doc_Prestador,"
        strreader = strreader & "cad_documento.Doc_Fornecedor,"
        strreader = strreader & "cad_documento.Doc_AC,"
        strreader = strreader & "cad_documento.Doc_EPP,"
        strreader = strreader & "cad_documento.Doc_EI,"
        strreader = strreader & "cad_documento.Doc_LTDA,"
        strreader = strreader & "cad_documento.Doc_EIRELI,"
        strreader = strreader & "cad_documento.Doc_MEI,"
        strreader = strreader & "cad_documento.Doc_ME,"
        strreader = strreader & "cad_documento.Doc_SA,"
        strreader = strreader & "cad_documento.Doc_SS,"
        strreader = strreader & "cad_documento.Doc_PFisica,"
        strreader = strreader & "cad_documento.Doc_Situacao,"
        strreader = strreader & "cad_documento.Doc_Obrigatorio, "
        strreader = strreader & "cad_documento.Doc_Modelo, "
        strreader = strreader & "cad_documento.Doc_Qtde_Permitida "
        strreader = strreader & "FROM cad_documento "
        strreader = strreader & "WHERE cad_documento.Doc_ID=" & CodDoc & ""
        Try
            objCmd = New MySqlCommand(strreader, objConn)

            'criar datareader
            objCmd.Connection.Open()
            dr = objCmd.ExecuteReader()

            'se achar retorna verdadeiro
            If dr.Read() Then

                If Not IsDBNull(dr("Doc_Descricao")) Then
                    txt_Descricao.Text = dr("Doc_Descricao")
                End If
                If Not IsDBNull(dr("Doc_Validade")) Then
                    txt_Validade.Text = dr("Doc_Validade")
                End If
                If Not IsDBNull(dr("Doc_Onde_Obter")) Then
                    txt_Onde_Obter.Text = dr("Doc_Onde_Obter")
                End If
                If Not IsDBNull(dr("Doc_Prestador")) Then
                    If dr("Doc_Prestador") = 1 Then
                        chk_Prestador.Checked = "true"
                    Else
                        chk_Prestador.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_Fornecedor")) Then
                    If dr("Doc_Fornecedor") = 1 Then
                        chk_Fornecedor.Checked = "true"
                    Else
                        chk_Fornecedor.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_AC")) Then
                    If dr("Doc_AC") = 1 Then
                        chk_AC.Checked = "true"
                    Else
                        chk_AC.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_EPP")) Then
                    If dr("Doc_EPP") = 1 Then
                        chk_EPP.Checked = "true"
                    Else
                        chk_EPP.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_EI")) Then
                    If dr("Doc_EI") = 1 Then
                        chk_EI.Checked = "true"
                    Else
                        chk_EI.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_LTDA")) Then
                    If dr("Doc_LTDA") = 1 Then
                        chk_LTDA.Checked = "true"
                    Else
                        chk_LTDA.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_EIRELI")) Then
                    If dr("Doc_EIRELI") = 1 Then
                        chk_EIRELI.Checked = "true"
                    Else
                        chk_EIRELI.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_MEI")) Then
                    If dr("Doc_MEI") = 1 Then
                        chk_MEI.Checked = "true"
                    Else
                        chk_MEI.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_ME")) Then
                    If dr("Doc_ME") = 1 Then
                        chk_ME.Checked = "true"
                    Else
                        chk_ME.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_SA")) Then
                    If dr("Doc_SA") = 1 Then
                        chk_SA.Checked = "true"
                    Else
                        chk_SA.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_SS")) Then
                    If dr("Doc_SS") = 1 Then
                        chk_SS.Checked = "true"
                    Else
                        chk_SS.Checked = "false"
                    End If
                End If

                If Not IsDBNull(dr("Doc_PFisica")) Then
                    If dr("Doc_PFisica") = 1 Then
                        chk_PFisica.Checked = "true"
                    Else
                        chk_PFisica.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_Situacao")) Then
                    ddl_Situacao.SelectedValue = dr("Doc_Situacao")
                End If
                If Not IsDBNull(dr("Doc_Obrigatorio")) Then
                    If dr("Doc_Obrigatorio") = 1 Then
                        chk_Obrigatorio.Checked = "true"
                    Else
                        chk_Obrigatorio.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_Qtde_Permitida")) Then
                    If dr("Doc_Qtde_Permitida") = 1 Then
                        chk_Qtde_Permitida.Checked = "true"
                    Else
                        chk_Qtde_Permitida.Checked = "false"
                    End If
                End If
                If Not IsDBNull(dr("Doc_Modelo")) Then
                    txt_Modelo.Text = dr("Doc_Modelo")

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
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_DC.Show()
        End Try

    End Sub

    Protected Sub btn_Voltar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Voltar.Click
        Response.Redirect("Documento.aspx")
        Response.End()
    End Sub

    Protected Sub btn_Gravar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Gravar.Click
        Dim m_descricao, m_ondeobter, m_situacao As String
        Dim m_validade, m_prestador, m_fornecedor, m_mei, m_me, m_ltda, m_ac, m_epp, m_ei, m_eireli, m_sa, m_ss, m_pfisica, m_obrigatorio, m_qtde As Integer

        m_descricao = Replace(txt_Descricao.Text, "'", " ")
        m_descricao = Replace(m_descricao, ",", " ")
        m_ondeobter = Replace(txt_Onde_Obter.Text, "'", " ")
        m_ondeobter = Replace(m_ondeobter, ",", " ")
        m_situacao = ddl_Situacao.SelectedValue
        m_validade = Replace(txt_Validade.Text, "'", " ")
        m_validade = Replace(m_validade, ",", " ")
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
        If chk_Obrigatorio.Checked = "true" Then
            m_obrigatorio = 1
        Else
            m_obrigatorio = 0
        End If
        If chk_Qtde_Permitida.Checked = "true" Then
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
            'MsgBox(sImgFile)
        End If
        If Doc_Modelo.FileName <> "" Then
            txt_Modelo.Text = sImgFile
            'txt_Modelo.Text = Replace(txt_Modelo.Text, "\", ";")
            'MsgBox(txt_Modelo.Text)
        End If

        If Doc_Modelo.FileName <> "" Then
            txt_Modelo.Text = sImgFile
        Else
            txt_Modelo.Text = Replace(txt_Modelo.Text, "\", "\\")
        End If

        If m_descricao <> "" Then
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            'inserir dados
            strexec = "UPDATE cad_documento SET "
            strexec = strexec & "cad_documento.Doc_Descricao='" & m_descricao & "',"
            strexec = strexec & "cad_documento.Doc_Validade=" & m_validade & ","
            strexec = strexec & "cad_documento.Doc_Onde_Obter='" & m_ondeobter & "',"
            strexec = strexec & "cad_documento.Doc_Prestador=" & m_prestador & ","
            strexec = strexec & "cad_documento.Doc_Fornecedor=" & m_fornecedor & ","
            strexec = strexec & "cad_documento.Doc_AC=" & m_ac & ","
            strexec = strexec & "cad_documento.Doc_EPP=" & m_epp & ","
            strexec = strexec & "cad_documento.Doc_EI=" & m_ei & ","
            strexec = strexec & "cad_documento.Doc_LTDA=" & m_ltda & ","
            strexec = strexec & "cad_documento.Doc_EIRELI=" & m_eireli & ","
            strexec = strexec & "cad_documento.Doc_MEI=" & m_mei & ","
            strexec = strexec & "cad_documento.Doc_ME=" & m_me & ","
            strexec = strexec & "cad_documento.Doc_SA=" & m_sa & ","
            strexec = strexec & "cad_documento.Doc_SS=" & m_ss & ","
            strexec = strexec & "cad_documento.Doc_PFisica=" & m_pfisica & ","
            strexec = strexec & "cad_documento.Doc_Situacao='" & m_situacao & "',"
            strexec = strexec & "cad_documento.Doc_Obrigatorio=" & m_obrigatorio & ", "
            strexec = strexec & "cad_documento.Doc_Modelo='" & txt_Modelo.Text & "', "
            strexec = strexec & "cad_documento.Doc_Qtde_Permitida=" & m_qtde & " "
            strexec = strexec & "WHERE cad_documento.Doc_ID=" & CodDoc & ""

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
                MPE_DC.Show()


                'fechar
                objCmd.Connection.Close()
                objConn.Close()
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_DC.Show()
            End Try

        Else
            'dar mensagem
            lbl_mensagem_1.Text = "Verifique os campos obrigatórios !!!"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_DC.Show()
        End If
    End Sub

    Protected Sub btn_Excluir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Excluir.Click
        lbl_mensagem_1.Text = "SE CONFIRMAR A EXCLUSÃO, O REGISTRO SERÁ EXCLUIDO DEFINITIVAMENTE !!!"
        lbl_mensagem_2.Text = "CONFIRMA A EXCLUSÃO DO REGISTRO ?"
        img_btn_Fechar_Mensagem.Visible = "false"
        img_btn_sair_Mensagem.Visible = "false"
        btn_Confirma_Exclusao.Visible = "true"
        btn_Nao_Confirma.Visible = "true"
        MPE_DC.Show()
    End Sub

    Protected Sub btn_Confirma_Exclusao_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Confirma_Exclusao.Click
        'abrindo conexao
        objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

        'inserir dados
        strexec = "DELETE cad_documento FROM cad_documento "
        strexec = strexec & "WHERE cad_documento.Doc_ID=" & CodDoc & ""
        Try
            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()


            'dar mensagem

            lbl_mensagem_1.Text = "REGISTRO EXCLUIDO COM SUCESSO !!!"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "false"
            img_btn_sair_Mensagem.Visible = "true"
            btn_Confirma_Exclusao.Visible = "false"
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
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_DC.Show()
        End Try


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
