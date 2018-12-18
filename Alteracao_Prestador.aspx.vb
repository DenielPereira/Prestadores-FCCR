Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Partial Class Alteracao_Prestador
    Inherits System.Web.UI.Page
    Dim objConn, objConn1, objConnd, objConne As MySqlConnection
    Dim objDt As MySqlDataAdapter
    Dim ds As DataSet
    Dim objCmd, objCmd1, objCmdd, objCmde As MySqlCommand
    Dim dr, dr1 As MySqlDataReader
    Dim strexec, strreader, strdt As String
    Dim CtrLen, CtrTipo, CtrCodUsuario, CodPrestador, MEI As Integer
    Dim sFileName, sImgFile, sPath As String
    Dim mdia, mmes As Integer
    Dim m_tipoempresa, m_tipoprestador, m_perfil As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        CodPrestador = Request.QueryString("CodPrestador")
        txt_CNPJ.Attributes.Add("onKeyPress", "javascript:MascaraCNPJ(txt_CNPJ)")
        txt_CNPJ.Attributes.Add("onBlur", "javascript:ValidarCNPJ(txt_CNPJ)")

        txt_Telefone.Attributes.Add("onKeyPress", "javascript:MascaraTelefone(txt_Telefone)")
        txt_Celular.Attributes.Add("onKeyPress", "javascript:MascaraCelular(txt_Celular)")
        txt_Email.Attributes.Add("onBlur", "javascript:ValidaEmail(Tabs_TabPanel_1_txt_Email)")

        txt_CEP.Attributes.Add("onkeyup", "javascript:formatar(this, '##.###-###')")
        txt_Prestador_CEP.Attributes.Add("onkeyup", "javascript:formatar(this, '##.###-###')")
        txt_Prestador_Telefone.Attributes.Add("onKeyPress", "javascript:MascaraTelefone(Tabs_TabPanel_2_txt_Prestador_Telefone)")
        txt_Prestador_Celular.Attributes.Add("onKeyPress", "javascript:MascaraCelular(Tabs_TabPanel_2_txt_Prestador_Celular)")
        txt_prexdoc_emissao.Attributes.Add("onkeyup", "javascript:formatar(this, '##/##/####')")
        txt_prexdoc_validade.Attributes.Add("onkeyup", "javascript:formatar(this, '##/##/####')")
        txt_prexdoc_validade.Attributes.Add("onkeyup", "javascript:formatar(this, '##/##/####')")

        txt_CPF.Attributes.Add("onkeyup", "javascript:formatar(this, '###.###.###-##')")
        txt_CPF.Attributes.Add("onBlur", "javascript:valida_cpf(Tabs_TabPanel_1_txt_CPF)")
        txt_Prestador_CPF.Attributes.Add("onkeyup", "javascript:formatar(this, '###.###.###-##')")
        txt_Prestador_CPF.Attributes.Add("onBlur", "javascript:valida_cpf(Tabs_TabPanel_2_txt_Prestador_CPF)")

        txt_Data_Desativacao.Attributes.Add("onkeyup", "javascript:formatar(this, '##/##/####')")

        If Not Page.IsPostBack Then
            Verifica_Acesso()
            pnl_documento_consulta.Visible = "false"
            If m_perfil = "Prestador" Then
                lnk_Menu_Anterior.Visible = "false"
            End If
            If lbl_perfil.Text = "Gerente" Then
                btn_Excluir_Documento_alt.Visible = "false"
                btn_Excluir_Prestador_alt.Visible = "false"
                btn_grava_meusdados.Visible = "false"
                btn_Salvar_Documento.Visible = "false"
                btn_Salvar_Documento.Visible = "false"
                btn_Salvar_Prestador.Visible = "false"
                pnl_prestador.Visible = "false"
                pnl_prestador_consulta.Visible = "true"
                pnl_material.Visible = "false"
                pnl_servico.Visible = "false"
                pnl_documento.Visible = "false"
                pnl_documento_consulta.Visible = "true"
            End If
            Me.MostraDados()
            Me.Limpa_TMP()
            If ddl_Categoria.SelectedValue <> 0 And ddl_Servico.SelectedValue <> 0 Then
                Me.Completa_TMP()
            End If
            Me.Carrega_TMP()
            Me.Atualiza_TMP()
            Tabs.ActiveTab = TabPanel_1
            'lbl_codcadastro.Text = "Seu código de identificação é : " & CodPrestador
        End If
    End Sub
    Private Sub Verifica_Acesso()
        Try
            'abrindo conexao
            objConn1 = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            strreader = "SELECT "
            strreader = strreader & "cad_usuario.usu_id,"
            strreader = strreader & "cad_usuario.usu_codigo,"
            strreader = strreader & "cad_usuario.usu_senha, "
            strreader = strreader & "cad_usuario.usu_perfil "
            strreader = strreader & "FROM cad_usuario "
            strreader = strreader & "WHERE cad_usuario.usu_id='" & Session("CodPrestador") & "' and cad_usuario.usu_senha='" & Session("PasPrestador") & "'"

            objCmd1 = New MySqlCommand(strreader, objConn1)

            'criar datareader
            objCmd1.Connection.Open()
            dr1 = objCmd1.ExecuteReader()

            'se achar retorna verdadeiro
            lbl_perfil.Text = ""
            If dr1.Read() Then

                m_perfil = dr1("usu_perfil")
                lbl_perfil.Text = m_perfil
            Else

                'abrindo conexao
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                strreader = "SELECT "
                strreader = strreader & "cad_prestador.Pre_CNPJ,"
                strreader = strreader & "cad_prestador.Pre_Senha "
                strreader = strreader & "FROM cad_prestador "
                strreader = strreader & "WHERE cad_prestador.Pre_ID=" & CodPrestador & ""

                objCmd = New MySqlCommand(strreader, objConn)

                'criar datareader
                objCmd.Connection.Open()
                dr = objCmd.ExecuteReader()

                'se achar retorna verdadeiro
                If dr.Read() Then

                    If dr("Pre_CNPJ") = Session("DocPrestador") And dr("Pre_Senha") = Session("PasPrestador") Then
                        m_perfil = "Prestador"
                        lbl_perfil.Text = m_perfil
                    Else
                        'fechando
                        objCmd.Connection.Close()
                        objConn.Close()
                        objConn = Nothing
                        Response.Redirect("Login_Cadastro.aspx")
                        Response.End()
                    End If

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
                objCmd.Connection.Close()
                objConn.Close()
                objConn = Nothing
            End If

            dr1.Close()
            dr1 = Nothing

            'fechar conexao
            objCmd1.Connection.Close()
            objConn1.Close()
            objConn1 = Nothing
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub
    Private Sub MostraDados()
        Dim m_data_cadastro, m_data_alteracao, m_data_desativacao As String

        ddl_Categoria.SelectedValue = 0
        ddl_Servico.SelectedValue = 0
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            'pegar dados

            strreader = "SELECT "
            strreader = strreader & "cad_prestador.Pre_CNPJ,"
            strreader = strreader & "cad_prestador.Pre_Razao_Social,"
            strreader = strreader & "cad_prestador.Pre_Nome_Fantasia,"
            strreader = strreader & "cad_prestador.Pre_IEstadual,"
            strreader = strreader & "cad_prestador.Pre_IMunicipal,"
            strreader = strreader & "cad_prestador.Pre_IMunicipal_Municipio,"
            strreader = strreader & "cad_prestador.Pre_IMunicipal_UF,"
            strreader = strreader & "cad_prestador.Pre_CNAE_Codigo,"
            strreader = strreader & "cad_prestador.Pre_CNAE_Descricao,"
            strreader = strreader & "cad_prestador.Pre_PIS_PASEP,"
            strreader = strreader & "cad_prestador.Pre_NIT,"
            strreader = strreader & "cad_prestador.Pre_Representante,"
            strreader = strreader & "cad_prestador.Pre_Representante_Cargo,"
            strreader = strreader & "cad_prestador.Pre_Representante_Estado_Civil,"
            strreader = strreader & "cad_prestador.Pre_Representante_Profissao,"
            strreader = strreader & "cad_prestador.Pre_Representante_CPF,"
            strreader = strreader & "cad_prestador.Pre_Representante_RG,"
            strreader = strreader & "cad_prestador.Pre_Nacionalidade,"
            strreader = strreader & "cad_prestador.Pre_Endereco,"
            strreader = strreader & "cad_prestador.Pre_Numero,"
            strreader = strreader & "cad_prestador.Pre_Complemento,"
            strreader = strreader & "cad_prestador.Pre_Bairro,"
            strreader = strreader & "cad_prestador.Pre_CEP,"
            strreader = strreader & "cad_prestador.Pre_Municipio,"
            strreader = strreader & "cad_prestador.Pre_UF,"
            strreader = strreader & "cad_prestador.Pre_Telefone,"
            strreader = strreader & "cad_prestador.Pre_Telefone_1,"
            strreader = strreader & "cad_prestador.Pre_Celular,"
            strreader = strreader & "cad_prestador.Pre_WhatsApp,"
            strreader = strreader & "cad_prestador.Pre_Email,"
            strreader = strreader & "cad_prestador.Pre_Email_1,"
            strreader = strreader & "cad_prestador.Pre_Site,"
            strreader = strreader & "cad_prestador.Pre_Pessoa_Contato,"
            strreader = strreader & "cad_prestador.Pre_Banco_Codigo,"
            strreader = strreader & "cad_prestador.Pre_Banco_Agencia,"
            strreader = strreader & "cad_prestador.Pre_Banco_Conta,"
            strreader = strreader & "cad_prestador.Pre_Banco_Tipo,"
            strreader = strreader & "cad_prestador.Pre_Senha, "
            strreader = strreader & "cad_prestador.Pre_TipoEmpresa, "
            strreader = strreader & "cad_prestador.Pre_TipoPrestador, "
            strreader = strreader & "cad_prestador.Pre_Participa_Licitacao, "
            strreader = strreader & "cad_prestador.Pre_Data_Cadastro, "
            strreader = strreader & "cad_prestador.Pre_Data_Alteracao, "
            strreader = strreader & "cad_prestador.Pre_Desativado, "
            strreader = strreader & "cad_prestador.Pre_Data_Desativado, "
            strreader = strreader & "cad_prestador.Pre_Motivo_Desativado, "
            strreader = strreader & "cad_prestador.Pre_Email_AlertaDocto "
            strreader = strreader & "FROM cad_prestador "
            strreader = strreader & "WHERE cad_prestador.Pre_ID=" & CodPrestador & ""

            objCmd = New MySqlCommand(strreader, objConn)

            'criar datareader
            objCmd.Connection.Open()
            dr = objCmd.ExecuteReader()

            'se achar retorna verdadeiro
            If dr.Read() Then

                If Not IsDBNull(dr("Pre_CNPJ")) Then
                    txt_CNPJ.Text = dr("Pre_CNPJ")
                End If
                If Not IsDBNull(dr("Pre_Razao_Social")) Then
                    txt_Razao_Social.Text = dr("Pre_Razao_Social")
                    txt_PF_Nome_alt.Text = dr("Pre_Razao_Social")
                End If
                If Not IsDBNull(dr("Pre_Nome_Fantasia")) Then
                    txt_Nome_Fantasia.Text = dr("Pre_Nome_Fantasia")
                End If
                If Not IsDBNull(dr("Pre_IEstadual")) Then
                    txt_IEstadual.Text = dr("Pre_IEstadual")
                End If
                If Not IsDBNull(dr("Pre_IMunicipal")) Then
                    txt_IMunicipal.Text = dr("Pre_IMunicipal")
                End If
                If Not IsDBNull(dr("Pre_IMunicipal_Municipio")) Then
                    txt_IM_Cidade.Text = dr("Pre_IMunicipal_Municipio")
                End If
                If Not IsDBNull(dr("Pre_IMunicipal_UF")) Then
                    ddl_IM_UF.SelectedValue = dr("Pre_IMunicipal_UF")
                End If
                If Not IsDBNull(dr("Pre_CNAE_Codigo")) Then
                    txt_PJ_CNAE_Cod.Text = dr("Pre_CNAE_Codigo")
                End If
                If Not IsDBNull(dr("Pre_CNAE_Descricao")) Then
                    txt_PJ_CNAE_Desc.Text = dr("Pre_CNAE_Descricao")
                End If
                If Not IsDBNull(dr("Pre_PIS_PASEP")) Then
                    txt_PF_PISPASEP_alt.Text = dr("Pre_PIS_PASEP")
                End If
                If Not IsDBNull(dr("Pre_NIT")) Then
                    txt_PF_NIT_alt.Text = dr("Pre_NIT")
                End If
                If Not IsDBNull(dr("Pre_Representante")) Then
                    txt_Representante.Text = dr("Pre_Representante")
                End If
                If Not IsDBNull(dr("Pre_Representante_Cargo")) Then
                    txt_Representante_Cargo.Text = dr("Pre_Representante_Cargo")
                End If
                If Not IsDBNull(dr("Pre_Representante_Estado_Civil")) Then
                    ddl_Representante_EstadoCivil.SelectedValue = dr("Pre_Representante_Estado_Civil")
                End If
                If Not IsDBNull(dr("Pre_Representante_Profissao")) Then
                    txt_Representante_Profissao.Text = dr("Pre_Representante_Profissao")
                End If
                If Not IsDBNull(dr("Pre_Representante_CPF")) Then
                    txt_CPF.Text = dr("Pre_Representante_CPF")
                End If
                If Not IsDBNull(dr("Pre_Representante_RG")) Then
                    txt_RG.Text = dr("Pre_Representante_RG")
                End If
                If Not IsDBNull(dr("Pre_Nacionalidade")) Then
                    txt_Nacionalidade.Text = dr("Pre_Nacionalidade")
                End If
                If Not IsDBNull(dr("Pre_Endereco")) Then
                    txt_Endereco.Text = dr("Pre_Endereco")
                End If
                If Not IsDBNull(dr("Pre_Numero")) Then
                    txt_Numero.Text = dr("Pre_Numero")
                End If
                If Not IsDBNull(dr("Pre_Complemento")) Then
                    txt_Complemento.Text = dr("Pre_Complemento")
                End If
                If Not IsDBNull(dr("Pre_Bairro")) Then
                    txt_Bairro.Text = dr("Pre_Bairro")
                End If
                If Not IsDBNull(dr("Pre_CEP")) Then
                    txt_CEP.Text = dr("Pre_CEP")
                End If
                If Not IsDBNull(dr("Pre_Municipio")) Then
                    txt_Cidade.Text = dr("Pre_Municipio")
                End If
                If Not IsDBNull(dr("Pre_UF")) Then
                    ddl_UF.SelectedValue = dr("Pre_UF")
                End If
                If Not IsDBNull(dr("Pre_Telefone")) Then
                    txt_Telefone.Text = dr("Pre_Telefone")
                End If
                If Not IsDBNull(dr("Pre_Telefone_1")) Then
                    txt_PJ_Telefone1.Text = dr("Pre_Telefone_1")
                End If
                If Not IsDBNull(dr("Pre_Celular")) Then
                    txt_Celular.Text = dr("Pre_Celular")
                End If
                If Not IsDBNull(dr("Pre_WhatsApp")) Then
                    txt_PF_Whatszap.Text = dr("Pre_WhatsApp")
                End If
                If Not IsDBNull(dr("Pre_Email")) Then
                    txt_Email.Text = dr("Pre_Email")
                End If
                If Not IsDBNull(dr("Pre_Email_1")) Then
                    txt_PJ_Email1.Text = dr("Pre_Email_1")
                End If
                If Not IsDBNull(dr("Pre_Site")) Then
                    txt_Site.Text = dr("Pre_Site")
                End If
                If Not IsDBNull(dr("Pre_Pessoa_Contato")) Then
                    txt_PJ_PessoaContato.Text = dr("Pre_Pessoa_Contato")
                End If
                If Not IsDBNull(dr("Pre_Banco_Codigo")) Then
                    txt_Banco_alt.Text = dr("Pre_Banco_Codigo")
                End If
                If Not IsDBNull(dr("Pre_Banco_Agencia")) Then
                    txt_Agencia_alt.Text = dr("Pre_Banco_Agencia")
                End If
                If Not IsDBNull(dr("Pre_Banco_Conta")) Then
                    txt_Conta_alt.Text = dr("Pre_Banco_Conta")
                End If
                If Not IsDBNull(dr("Pre_Banco_Tipo")) Then
                    ddl_TipoConta_alt.SelectedValue = dr("Pre_Banco_Tipo")
                End If
                If Not IsDBNull(dr("Pre_Senha")) Then
                    txt_Senha.Text = dr("Pre_Senha")
                    txt_Confirma_Senha.Text = dr("Pre_Senha")
                End If
                If Not IsDBNull(dr("Pre_Desativado")) Then
                    rbl_desativado.SelectedValue = dr("Pre_Desativado")
                End If
                If Not IsDBNull(dr("Pre_Motivo_Desativado")) Then
                    txt_Motivo_Desativacao.Text = dr("Pre_Motivo_Desativado")
                End If
                m_data_desativacao = ""
                If Not IsDBNull(dr("Pre_Data_Desativado")) Then
                    m_data_desativacao = ""
                    If Day(dr("Pre_Data_Desativado")) <= 9 Then
                        m_data_desativacao = "0" & Day(dr("Pre_Data_Desativado"))
                    Else
                        m_data_desativacao = Day(dr("Pre_Data_Desativado"))
                    End If

                    If Month(dr("Pre_Data_Desativado")) <= 9 Then
                        m_data_desativacao = m_data_desativacao & "/0" & Month(dr("Pre_Data_Desativado"))
                    Else
                        m_data_desativacao = m_data_desativacao & "/" & Month(dr("Pre_Data_Desativado"))
                    End If

                    m_data_desativacao = m_data_desativacao & "/" & Mid(Year(dr("Pre_Data_Desativado")), 1, 4)
                End If
                txt_Data_Desativacao.Text = m_data_desativacao
                If Not IsDBNull(dr("Pre_Email_AlertaDocto")) Then
                    rbl_email.SelectedValue = dr("Pre_Email_AlertaDocto")
                End If

                If Not IsDBNull(dr("Pre_TipoEmpresa")) Then
                    lbl_TipoEmpresa_cod.Text = dr("Pre_TipoEmpresa")
                    ddl_Categoria.SelectedValue = dr("Pre_TipoEmpresa")

                End If
                If Not IsDBNull(dr("Pre_Participa_Licitacao")) Then

                End If

                If Not IsDBNull(dr("Pre_TipoPrestador")) Then
                    lbl_TipoPrestador.Text = dr("Pre_TipoPrestador")
                    ddl_Servico.SelectedValue = dr("Pre_TipoPrestador")
                Else
                    lbl_TipoPrestador.Text = "0"
                End If

                m_data_cadastro = ""
                If Not IsDBNull(dr("Pre_Data_Cadastro")) Then
                    m_data_cadastro = ""
                    If Day(dr("Pre_Data_Cadastro")) <= 9 Then
                        m_data_cadastro = "0" & Day(dr("Pre_Data_Cadastro"))
                    Else
                        m_data_cadastro = Day(dr("Pre_Data_Cadastro"))
                    End If

                    If Month(dr("Pre_Data_Cadastro")) <= 9 Then
                        m_data_cadastro = m_data_cadastro & "/0" & Month(dr("Pre_Data_Cadastro"))
                    Else
                        m_data_cadastro = m_data_cadastro & "/" & Month(dr("Pre_Data_Cadastro"))
                    End If

                    m_data_cadastro = m_data_cadastro & "/" & Mid(Year(dr("Pre_Data_Cadastro")), 1, 4)
                End If
                m_data_alteracao = ""
                If Not IsDBNull(dr("Pre_Data_Alteracao")) Then
                    m_data_alteracao = ""
                    If Day(dr("Pre_Data_Alteracao")) <= 9 Then
                        m_data_alteracao = "0" & Day(dr("Pre_Data_Alteracao"))
                    Else
                        m_data_alteracao = Day(dr("Pre_Data_Alteracao"))
                    End If

                    If Month(dr("Pre_Data_Alteracao")) <= 9 Then
                        m_data_alteracao = m_data_alteracao & "/0" & Month(dr("Pre_Data_Alteracao"))
                    Else
                        m_data_alteracao = m_data_alteracao & "/" & Month(dr("Pre_Data_Alteracao"))
                    End If

                    m_data_alteracao = m_data_alteracao & "/" & Mid(Year(dr("Pre_Data_Alteracao")), 1, 4)
                End If
                lbl_datas.Text = "Cadastrado em :" & m_data_cadastro & " - Ultima atualização em : " & m_data_alteracao
            End If

            dr.Close()
            dr = Nothing

            strreader = "SELECT cad_documento.Doc_ID,cad_documento.Doc_Descricao,"
            strreader = strreader & "cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio "
            strreader = strreader & "FROM cad_documento "
            strreader = strreader & "WHERE cad_documento.Doc_ID>0 "

            If ddl_Servico.SelectedValue = 1 Then
                strreader = strreader & "and cad_documento.Doc_Prestador=1 "
            End If
            If ddl_Servico.SelectedValue = 2 Then
                strreader = strreader & "and cad_documento.Doc_Fornecedor=1 "
            End If

            If lbl_TipoEmpresa_cod.Text = "1" Then
                strreader = strreader & "and cad_documento.Doc_AC=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "2" Then
                strreader = strreader & "and cad_documento.Doc_EPP=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "3" Then
                strreader = strreader & "and cad_documento.Doc_EI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "4" Then
                strreader = strreader & "and cad_documento.Doc_LTDA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "5" Then
                strreader = strreader & "and cad_documento.Doc_EIRELI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "6" Then
                strreader = strreader & "and cad_documento.Doc_MEI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "7" Then
                strreader = strreader & "and cad_documento.Doc_ME=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "8" Then
                strreader = strreader & "and cad_documento.Doc_SA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "9" Then
                strreader = strreader & "and cad_documento.Doc_SS=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "10" Then
                strreader = strreader & "and cad_documento.Doc_PFisica=1 "
            End If


            strreader = strreader & "order by cad_documento.Doc_Descricao "
            SqlDocumento.SelectCommand = strreader

            ddlDocumento.ClearSelection()
            ddlDocumento.DataBind()

            'fechar conexao

            objConn.Close()
            objConn = Nothing

            lbl_nome_prestador.Text = txt_Razao_Social.Text
            lbl_cnpj_codigo.Text = txt_CNPJ.Text & " ID - " & CodPrestador

            If lbl_TipoEmpresa_cod.Text = 10 Then
                pnl_PF.Visible = True
                pnl_PJ.Visible = False
            Else
                pnl_PJ.Visible = True
                pnl_PF.Visible = False
            End If
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub
    Private Sub Carrega_Doc()
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            strreader = "SELECT cad_documento.Doc_ID,cad_documento.Doc_Descricao,"
            strreader = strreader & "cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio "
            strreader = strreader & "FROM cad_documento "
            strreader = strreader & "WHERE cad_documento.Doc_ID>0 "
            If ddl_Servico.SelectedValue = 1 Then
                strreader = strreader & "and cad_documento.Doc_Prestador=1 "
            End If
            If ddl_Servico.SelectedValue = 2 Then
                strreader = strreader & "and cad_documento.Doc_Fornecedor=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "1" Then
                strreader = strreader & "and cad_documento.Doc_AC=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "2" Then
                strreader = strreader & "and cad_documento.Doc_EPP=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "3" Then
                strreader = strreader & "and cad_documento.Doc_EI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "4" Then
                strreader = strreader & "and cad_documento.Doc_LTDA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "5" Then
                strreader = strreader & "and cad_documento.Doc_EIRELI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "6" Then
                strreader = strreader & "and cad_documento.Doc_MEI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "7" Then
                strreader = strreader & "and cad_documento.Doc_ME=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "8" Then
                strreader = strreader & "and cad_documento.Doc_SA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "9" Then
                strreader = strreader & "and cad_documento.Doc_SS=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "10" Then
                strreader = strreader & "and cad_documento.Doc_PFisica=1 "
            End If
            strreader = strreader & "order by cad_documento.Doc_Descricao "
            SqlDocumento.SelectCommand = strreader
            ddlDocumento.ClearSelection()
            ddlDocumento.DataBind()

            'fechar conexao

            objConn.Close()
            objConn = Nothing
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub
    Private Sub Limpa_TMP()
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            strexec = "DELETE tmp_prestadorxdocumento FROM tmp_prestadorxdocumento "
            strexec = strexec & "WHERE "
            strexec = strexec & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "'"
            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()

            strexec = "DELETE tmp_prestadorxsermat FROM tmp_prestadorxsermat "
            strexec = strexec & "WHERE tmp_prestadorxsermat.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.ExecuteNonQuery()

            strexec = "DELETE tmp_prestadorxprestador FROM tmp_prestadorxprestador "
            strexec = strexec & "WHERE tmp_prestadorxprestador.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.ExecuteNonQuery()

            strreader = "SELECT cad_documento.Doc_ID,cad_documento.Doc_Descricao,"
            strreader = strreader & "cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio "
            strreader = strreader & "FROM cad_documento "
            strreader = strreader & "WHERE cad_documento.Doc_ID>0 "
            If lbl_TipoPrestador.Text = "1" Then
                strreader = strreader & "and cad_documento.Doc_Prestador=1 "
            End If
            If lbl_TipoPrestador.Text = "2" Then
                strreader = strreader & "and cad_documento.Doc_Fornecedor=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "1" Then
                strreader = strreader & "and cad_documento.Doc_AC=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "2" Then
                strreader = strreader & "and cad_documento.Doc_EPP=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "3" Then
                strreader = strreader & "and cad_documento.Doc_EI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "4" Then
                strreader = strreader & "and cad_documento.Doc_LTDA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "5" Then
                strreader = strreader & "and cad_documento.Doc_EIRELI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "6" Then
                strreader = strreader & "and cad_documento.Doc_MEI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "7" Then
                strreader = strreader & "and cad_documento.Doc_ME=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "8" Then
                strreader = strreader & "and cad_documento.Doc_SA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "9" Then
                strreader = strreader & "and cad_documento.Doc_SS=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "10" Then
                strreader = strreader & "and cad_documento.Doc_PFisica=1 "
            End If
            strreader = strreader & "order by cad_documento.Doc_Descricao "

            SqlDocumento.SelectCommand = strreader
            ddlDocumento.ClearSelection()
            ddlDocumento.DataBind()

            strreader = "select tmp_prestadorxdocumento.PrexDoc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Modelo, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Obrigatorio, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Emissao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Validade, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Nome, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Observacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Situacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Informacoes "
            strreader = strreader & "FROM tmp_prestadorxdocumento,cad_documento "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id=cad_documento.Doc_ID and "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            strreader = strreader & "order by cad_documento.Doc_Obrigatorio,cad_documento.Doc_Descricao,tmp_prestadorxdocumento.Doc_Id "

            SqlPrexDoc.SelectCommand = strreader
            GridView1.DataBind()

            strreader = "select tmp_prestadorxprestador.PrexPre_Id, "
            strreader = strreader & "tmp_prestadorxprestador.Pre_Id, "
            strreader = strreader & "tmp_prestadorxprestador.Pre_CNPJ, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Nome, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_RG, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_CPF, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Nacionalidade, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Estado_Civil, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Profissao, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Endereco, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Numero, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Complemento, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Bairro, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_CEP, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Municipio, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_UF, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Servicos, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_1, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_2, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_3, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_4 "
            strreader = strreader & "FROM tmp_prestadorxprestador "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxprestador.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            strreader = strreader & "order by tmp_prestadorxprestador.PrexPre_Nome "

            SqlPrexPre.SelectCommand = strreader
            GridView2.DataBind()

            'montando a string--------------------------------------------------------
            strreader = "SELECT tmp_prestadorxsermat.PrexSM_ID,tmp_prestadorxsermat.Pre_ID,tmp_prestadorxsermat.Pre_CNPJ,tmp_prestadorxsermat.SM_ID,tmp_prestadorxsermat.SM_Descricao,tmp_prestadorxsermat.SM_Selecao  "
            strreader = strreader & "FROM tmp_prestadorxsermat "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxsermat.Pre_CNPJ =  '" & txt_CNPJ.Text & "' and tmp_prestadorxsermat.SM_Material=1"

            'configura o dataadpter----------------------------------------------------
            objDt = New MySqlDataAdapter(strreader, objConn)

            'criando dataset
            ds = New DataSet
            objDt.Fill(ds)

            Datagrid2.DataSource = ds
            Datagrid2.DataBind()

            'montando a string--------------------------------------------------------
            strreader = "SELECT tmp_prestadorxsermat.PrexSM_ID,tmp_prestadorxsermat.Pre_ID,tmp_prestadorxsermat.Pre_CNPJ,tmp_prestadorxsermat.SM_ID,tmp_prestadorxsermat.SM_Descricao,tmp_prestadorxsermat.SM_Selecao  "
            strreader = strreader & "FROM tmp_prestadorxsermat "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxsermat.Pre_CNPJ =  '" & txt_CNPJ.Text & "' and tmp_prestadorxsermat.SM_Servico=1"

            'configura o dataadpter----------------------------------------------------
            objDt = New MySqlDataAdapter(strreader, objConn)

            'criando dataset
            ds = New DataSet
            objDt.Fill(ds)

            Datagrid3.DataSource = ds
            Datagrid3.DataBind()

            objCmd.Connection.Close()

            'fechar
            objConn.Close()
            objConn = Nothing
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub
    Private Sub Limpa_Doc_TMP()
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            strexec = "DELETE tmp_prestadorxdocumento FROM tmp_prestadorxdocumento "
            strexec = strexec & "WHERE "
            strexec = strexec & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "'"
            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()

            strreader = "select tmp_prestadorxdocumento.PrexDoc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Modelo, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Obrigatorio, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Emissao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Validade, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Nome, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Observacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Situacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Informacoes "
            strreader = strreader & "FROM tmp_prestadorxdocumento,cad_documento "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id=cad_documento.Doc_ID and "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            strreader = strreader & "order by cad_documento.Doc_Obrigatorio,cad_documento.Doc_Descricao,tmp_prestadorxdocumento.Doc_Id "

            SqlPrexDoc.SelectCommand = strreader
            GridView1.DataBind()

            objCmd.Connection.Close()

            'fechar
            objConn.Close()
            objConn = Nothing
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub
    Private Sub Completa_TMP()

        m_tipoempresa = ddl_Categoria.SelectedValue
        lbl_TipoEmpresa_cod.Text = ddl_Categoria.SelectedValue
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            ' transferindo dados 
            'CodPrestador = 0
            strexec = "INSERT INTO tmp_prestadorxdocumento(Pre_ID,Pre_CNPJ,Doc_ID,"
            strexec = strexec & "Doc_Descricao,PrexDoc_Nome,PrexDoc_Observacao,PrexDoc_Situacao,PrexDoc_Informacoes,Doc_Obrigatorio) "
            strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',cad_documento.Doc_ID,cad_documento.Doc_Descricao,"
            strexec = strexec & "'','','Pendente',cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio "
            strexec = strexec & "FROM cad_documento "
            strexec = strexec & "WHERE cad_documento.Doc_Obrigatorio=1 "
            If ddl_Servico.SelectedValue = 1 Then
                strexec = strexec & "and cad_documento.Doc_Prestador=1 "
            End If
            If ddl_Servico.SelectedValue = 2 Then
                strexec = strexec & "and cad_documento.Doc_Fornecedor=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "1" Then
                strexec = strexec & "and cad_documento.Doc_AC=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "2" Then
                strexec = strexec & "and cad_documento.Doc_EPP=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "3" Then
                strexec = strexec & "and cad_documento.Doc_EI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "4" Then
                strexec = strexec & "and cad_documento.Doc_LTDA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "5" Then
                strexec = strexec & "and cad_documento.Doc_EIRELI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "6" Then
                strexec = strexec & "and cad_documento.Doc_MEI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "7" Then
                strexec = strexec & "and cad_documento.Doc_ME=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "8" Then
                strexec = strexec & "and cad_documento.Doc_SA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "9" Then
                strexec = strexec & "and cad_documento.Doc_SS=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "10" Then
                strexec = strexec & "and cad_documento.Doc_PFisica=1 "
            End If
            'lbl_TipoPrestador.Text = strexec

            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()

            strexec = "DELETE tmp_prestadorxdocumento FROM tmp_prestadorxdocumento,cad_prestadorxdocumento "
            strexec = strexec & "WHERE "
            strexec = strexec & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' and "
            strexec = strexec & "tmp_prestadorxdocumento.Pre_CNPJ=cad_prestadorxdocumento.Pre_CNPJ and "
            strexec = strexec & "tmp_prestadorxdocumento.Doc_ID = cad_prestadorxdocumento.Doc_ID "
            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.ExecuteNonQuery()

            objCmd.Connection.Close()

            'fechar conexao

            objConn.Close()
            objConn = Nothing
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub
    Private Sub Carrega_TMP()
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            ' transferindo dados 

            strexec = "INSERT INTO tmp_prestadorxdocumento(Pre_ID,Pre_CNPJ,Doc_ID,Doc_Descricao,"
            strexec = strexec & "PrexDoc_Emissao,PrexDoc_Validade,PrexDoc_Nome,PrexDoc_Observacao,PrexDoc_Situacao,PrexDoc_Informacoes,Doc_Obrigatorio,PrexDoc_Data_Alteracao) "
            strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',cad_prestadorxdocumento.Doc_ID,cad_prestadorxdocumento.Doc_Descricao,"
            strexec = strexec & "cad_prestadorxdocumento.PrexDoc_Emissao,cad_prestadorxdocumento.PrexDoc_Validade,cad_prestadorxdocumento.PrexDoc_Nome,"
            strexec = strexec & "cad_prestadorxdocumento.PrexDoc_Observacao,cad_prestadorxdocumento.PrexDoc_Situacao,cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio,cad_prestadorxdocumento.PrexDoc_Data_Alteracao "
            strexec = strexec & "FROM cad_prestadorxdocumento,cad_documento "
            strexec = strexec & "WHERE "
            strexec = strexec & "cad_prestadorxdocumento.Doc_ID=cad_documento.Doc_ID and cad_prestadorxdocumento.Pre_CNPJ= '" & txt_CNPJ.Text & "' "


            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()


            strexec = "INSERT INTO tmp_prestadorxprestador(Pre_ID,Pre_CNPJ,PrexPre_Nome,PrexPre_RG,PrexPre_CPF,PrexPre_Nacionalidade, "
            strexec = strexec & "PrexPre_Estado_Civil,PrexPre_Profissao,PrexPre_Endereco,PrexPre_Numero,PrexPre_Complemento,PrexPre_Bairro, "
            strexec = strexec & "PrexPre_CEP,PrexPre_Municipio,PrexPre_UF,PrexPre_Telefone,PrexPre_Celular,PrexPre_Email,PrexPre_Servicos, "
            strexec = strexec & "PrexPre_Doc_1,PrexPre_Doc_2,PrexPre_Doc_3,PrexPre_Doc_4) "
            strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',cad_prestadorxprestador.PrexPre_Nome,"
            strexec = strexec & "cad_prestadorxprestador.PrexPre_RG,cad_prestadorxprestador.PrexPre_CPF,cad_prestadorxprestador.PrexPre_Nacionalidade,"
            strexec = strexec & "cad_prestadorxprestador.PrexPre_Estado_Civil,cad_prestadorxprestador.PrexPre_Profissao,cad_prestadorxprestador.PrexPre_Endereco,"
            strexec = strexec & "cad_prestadorxprestador.PrexPre_Numero,cad_prestadorxprestador.PrexPre_Complemento,cad_prestadorxprestador.PrexPre_Bairro,"
            strexec = strexec & "cad_prestadorxprestador.PrexPre_CEP,cad_prestadorxprestador.PrexPre_Municipio,cad_prestadorxprestador.PrexPre_UF,"
            strexec = strexec & "cad_prestadorxprestador.PrexPre_Telefone,"
            strexec = strexec & "cad_prestadorxprestador.PrexPre_Celular,"
            strexec = strexec & "cad_prestadorxprestador.PrexPre_Email,"
            strexec = strexec & "cad_prestadorxprestador.PrexPre_Servicos, "
            strexec = strexec & "cad_prestadorxprestador.PrexPre_Doc_1, "
            strexec = strexec & "cad_prestadorxprestador.PrexPre_Doc_2, "
            strexec = strexec & "cad_prestadorxprestador.PrexPre_Doc_3, "
            strexec = strexec & "cad_prestadorxprestador.PrexPre_Doc_4 "
            strexec = strexec & "FROM cad_prestadorxprestador "
            strexec = strexec & "WHERE "
            strexec = strexec & "cad_prestadorxprestador.Pre_CNPJ= '" & txt_CNPJ.Text & "'"

            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.ExecuteNonQuery()

            strexec = "INSERT INTO tmp_prestadorxsermat(Pre_ID,Pre_CNPJ,SM_ID,SM_Descricao,SM_Selecao,SM_Material,SM_Servico) "
            strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',cad_servico_material.SM_Id,cad_servico_material.SM_Descricao,0,cad_servico_material.SM_Fornecedor,cad_servico_material.SM_Prestador "
            strexec = strexec & "FROM cad_servico_material "
            strexec = strexec & "WHERE cad_servico_material.SM_Situacao='Ativo' "

            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.ExecuteNonQuery()

            strexec = "UPDATE tmp_prestadorxsermat SET tmp_prestadorxsermat.SM_Selecao = ( SELECT 1 FROM cad_prestadorxsermat WHERE SM_ID = tmp_prestadorxsermat.SM_ID and cad_prestadorxsermat.SM_ID<>0 and cad_prestadorxsermat.Pre_CNPJ='" & txt_CNPJ.Text & "') "
            strexec = strexec & "WHERE tmp_prestadorxsermat.Pre_CNPJ='" & txt_CNPJ.Text & "'"

            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.ExecuteNonQuery()

            strexec = "UPDATE tmp_prestadorxsermat SET tmp_prestadorxsermat.SM_Selecao = 0 "
            strexec = strexec & "WHERE tmp_prestadorxsermat.Pre_CNPJ='" & txt_CNPJ.Text & "' and (tmp_prestadorxsermat.SM_Selecao is null)"

            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.ExecuteNonQuery()

            strexec = "INSERT INTO tmp_prestadorxsermat(Pre_ID,Pre_CNPJ,SM_ID,SM_Descricao,SM_Selecao,SM_Material,SM_Servico) "
            strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',cad_prestadorxsermat.SM_Id,cad_prestadorxsermat.SM_Descricao,1,cad_prestadorxsermat.SM_Material,cad_prestadorxsermat.SM_Servico "
            strexec = strexec & "FROM cad_prestadorxsermat "
            strexec = strexec & "WHERE cad_prestadorxsermat.SM_ID=0 and cad_prestadorxsermat.Pre_CNPJ='" & txt_CNPJ.Text & "'"

            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.ExecuteNonQuery()

            If lbl_perfil.Text = "Gerente" Then

                strexec = "DELETE tmp_prestadorxsermat FROM tmp_prestadorxsermat "
                strexec = strexec & "WHERE tmp_prestadorxsermat.Pre_CNPJ='" & txt_CNPJ.Text & "' and tmp_prestadorxsermat.SM_Selecao=0 "

                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()
            End If

            'montando a string--------------------------------------------------------
            strdt = "SELECT tmp_prestadorxsermat.PrexSM_ID,tmp_prestadorxsermat.Pre_ID,tmp_prestadorxsermat.Pre_CNPJ,tmp_prestadorxsermat.SM_ID,tmp_prestadorxsermat.SM_Descricao,tmp_prestadorxsermat.SM_Selecao  "
            strdt = strdt & "FROM tmp_prestadorxsermat "
            strdt = strdt & "WHERE "
            strdt = strdt & "tmp_prestadorxsermat.Pre_CNPJ =  '" & txt_CNPJ.Text & "' and tmp_prestadorxsermat.SM_Material=1"

            'configura o dataadpter----------------------------------------------------
            objDt = New MySqlDataAdapter(strdt, objConn)

            'criando dataset
            ds = New DataSet
            objDt.Fill(ds)

            Datagrid2.DataSource = ds
            Datagrid2.DataBind()

            'montando a string--------------------------------------------------------
            strdt = "SELECT tmp_prestadorxsermat.PrexSM_ID,tmp_prestadorxsermat.Pre_ID,tmp_prestadorxsermat.Pre_CNPJ,tmp_prestadorxsermat.SM_ID,tmp_prestadorxsermat.SM_Descricao,tmp_prestadorxsermat.SM_Selecao  "
            strdt = strdt & "FROM tmp_prestadorxsermat "
            strdt = strdt & "WHERE "
            strdt = strdt & "tmp_prestadorxsermat.Pre_CNPJ =  '" & txt_CNPJ.Text & "' and tmp_prestadorxsermat.SM_Servico=1"

            'configura o dataadpter----------------------------------------------------
            objDt = New MySqlDataAdapter(strdt, objConn)

            'criando dataset
            ds = New DataSet
            objDt.Fill(ds)

            Datagrid3.DataSource = ds
            Datagrid3.DataBind()
            objCmd.Connection.Close()

            strreader = "select tmp_prestadorxdocumento.PrexDoc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Modelo, "
            strreader = strreader & "cad_documento.Doc_Obrigatorio, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Emissao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Validade, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Nome, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Observacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Situacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Informacoes "
            strreader = strreader & "FROM tmp_prestadorxdocumento,cad_documento "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id=cad_documento.Doc_ID and "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            strreader = strreader & "order by cad_documento.Doc_Obrigatorio,cad_documento.Doc_Descricao,tmp_prestadorxdocumento.Doc_Id "

            SqlPrexDoc.SelectCommand = strreader

            GridView1.DataBind()

            strreader = "select tmp_prestadorxprestador.PrexPre_Id, "
            strreader = strreader & "tmp_prestadorxprestador.Pre_Id, "
            strreader = strreader & "tmp_prestadorxprestador.Pre_CNPJ, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Nome, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_RG, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_CPF, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Nacionalidade, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Estado_Civil, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Profissao, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Endereco, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Numero, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Complemento, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Bairro, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_CEP, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Municipio, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_UF, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Servicos, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_1, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_2, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_3, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_4 "
            strreader = strreader & "FROM tmp_prestadorxprestador "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxprestador.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            strreader = strreader & "order by tmp_prestadorxprestador.PrexPre_Nome "

            SqlPrexPre.SelectCommand = strreader

            GridView2.DataBind()

            'fechar conexao

            objConn.Close()
            objConn = Nothing
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub

    Private Sub Carrega_Doc_TMP()
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            ' transferindo dados 

            strexec = "INSERT INTO tmp_prestadorxdocumento(Pre_ID,Pre_CNPJ,Doc_ID,Doc_Descricao,"
            strexec = strexec & "PrexDoc_Emissao,PrexDoc_Validade,PrexDoc_Nome,PrexDoc_Observacao,PrexDoc_Situacao,PrexDoc_Informacoes,Doc_Obrigatorio,PrexDoc_Data_Alteracao) "
            strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',cad_prestadorxdocumento.Doc_ID,cad_prestadorxdocumento.Doc_Descricao,"
            strexec = strexec & "cad_prestadorxdocumento.PrexDoc_Emissao,cad_prestadorxdocumento.PrexDoc_Validade,cad_prestadorxdocumento.PrexDoc_Nome,"
            strexec = strexec & "cad_prestadorxdocumento.PrexDoc_Observacao,cad_prestadorxdocumento.PrexDoc_Situacao,cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio,cad_prestadorxdocumento.PrexDoc_Data_Alteracao "
            strexec = strexec & "FROM cad_prestadorxdocumento,cad_documento "
            strexec = strexec & "WHERE "
            strexec = strexec & "cad_prestadorxdocumento.Doc_ID=cad_documento.Doc_ID and cad_prestadorxdocumento.Pre_CNPJ= '" & txt_CNPJ.Text & "' "
            If ddl_Servico.SelectedValue = 1 Then
                strexec = strexec & "and cad_documento.Doc_Prestador=1 "
            End If
            If ddl_Servico.SelectedValue = 2 Then
                strexec = strexec & "and cad_documento.Doc_Fornecedor=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "1" Then
                strexec = strexec & "and cad_documento.Doc_AC=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "2" Then
                strexec = strexec & "and cad_documento.Doc_EPP=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "3" Then
                strexec = strexec & "and cad_documento.Doc_EI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "4" Then
                strexec = strexec & "and cad_documento.Doc_LTDA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "5" Then
                strexec = strexec & "and cad_documento.Doc_EIRELI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "6" Then
                strexec = strexec & "and cad_documento.Doc_MEI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "7" Then
                strexec = strexec & "and cad_documento.Doc_ME=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "8" Then
                strexec = strexec & "and cad_documento.Doc_SA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "9" Then
                strexec = strexec & "and cad_documento.Doc_SS=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "10" Then
                strexec = strexec & "and cad_documento.Doc_PFisica=1 "
            End If

            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()

            objCmd.Connection.Close()

            strreader = "select tmp_prestadorxdocumento.PrexDoc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Modelo, "
            strreader = strreader & "cad_documento.Doc_Obrigatorio, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Emissao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Validade, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Nome, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Observacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Situacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Informacoes "
            strreader = strreader & "FROM tmp_prestadorxdocumento,cad_documento "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id=cad_documento.Doc_ID and "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            strreader = strreader & "order by cad_documento.Doc_Obrigatorio,cad_documento.Doc_Descricao,tmp_prestadorxdocumento.Doc_Id "

            SqlPrexDoc.SelectCommand = strreader

            GridView1.DataBind()

            'fechar conexao

            objConn.Close()
            objConn = Nothing
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub
    Private Sub Atualiza_TMP()
        Dim mvez As Integer
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
            objConnd = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
            objConne = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            strexec = "UPDATE tmp_prestadorxdocumento SET tmp_prestadorxdocumento.PrexDoc_Situacao='Vigente' "
            strexec = strexec & "WHERE "
            strexec = strexec & "tmp_prestadorxdocumento.PrexDoc_Situacao<>'Opcional' and tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            objCmde = New MySqlCommand(strexec, objConne)
            objCmde.Connection.Open()
            objCmde.ExecuteNonQuery()

            strreader = "select A.Doc_Descricao, A.PrexDoc_Validade, B.Doc_Validade, B.Doc_Obrigatorio,A.PrexDoc_Nome,A.PrexDoc_ID,A.Pre_CNPJ "
            strreader = strreader & "FROM tmp_prestadorxdocumento as A,cad_documento as B "
            strreader = strreader & "WHERE "
            strreader = strreader & "A.Doc_ID=B.Doc_ID and B.Doc_Obrigatorio=1 and "
            strreader = strreader & "((B.Doc_Validade>0 and (A.PrexDoc_Validade<now() or A.PrexDoc_Validade is null)) or (A.PrexDoc_Emissao is null) or (A.PrexDoc_Nome='')) and A.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            objCmd = New MySqlCommand(strreader, objConn)
            objCmd.Connection.Open()

            dr = objCmd.ExecuteReader() '(CommandBehavior.SingleRow)

            'Se existirem dados, as informações são repassadas para os Labels.
            mvez = 0
            While dr.Read

                strexec = "UPDATE tmp_prestadorxdocumento SET tmp_prestadorxdocumento.PrexDoc_Situacao='Pendente' "
                strexec = strexec & "WHERE "
                strexec = strexec & "tmp_prestadorxdocumento.PrexDoc_ID=" & dr("PrexDoc_ID") & ""
                objCmdd = New MySqlCommand(strexec, objConnd)
                If mvez = 0 Then
                    objCmdd.Connection.Open()
                    mvez = 1
                End If
                objCmdd.ExecuteNonQuery()
            End While

            dr.Close()
            dr.Dispose()
            objCmd.Connection.Close()
            objCmde.Connection.Close()
            If mvez = 1 Then
                objCmdd.Connection.Close()
            End If

            strreader = "select tmp_prestadorxdocumento.PrexDoc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Modelo, "
            strreader = strreader & "cad_documento.Doc_Obrigatorio, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Emissao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Validade, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Nome, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Observacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Situacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Informacoes "
            strreader = strreader & "FROM tmp_prestadorxdocumento,cad_documento "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id=cad_documento.Doc_ID and "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            strreader = strreader & "order by cad_documento.Doc_Obrigatorio,cad_documento.Doc_Descricao,tmp_prestadorxdocumento.Doc_Id "

            SqlPrexDoc.SelectCommand = strreader

            GridView1.DataBind()

            'fechar conexao

            objConn.Close()
            objConn = Nothing
            objConne.Close()
            objConne = Nothing
            If mvez = 1 Then
                objConnd.Close()
                objConnd = Nothing
            End If
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub
    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Select Case e.Row.RowType
            Case DataControlRowType.DataRow

                Dim situacao As String = CType(e.Row.Cells(5).Text, String)
                Dim strimage As String

                situacao = DataBinder.Eval(e.Row.DataItem, "PrexDoc_Situacao").ToString()

                strimage = ""
                Select Case situacao
                    Case "Vigente"
                        strimage = "Imagens/Icones/check-circle-solid.svg"
                    Case "Pendente"
                        strimage = "Imagens/Icones/times-circle-solid.svg"
                    Case "Opcional"
                        strimage = "Imagens/Icones/info-circle-solid.svg"
                End Select
                Dim imgSIT As WebControls.Image = e.Row.FindControl("imgSIT")
                imgSIT.ImageUrl = strimage
        End Select
        If (e.Row.RowType = DataControlRowType.DataRow) Then

            If DataBinder.Eval(e.Row.DataItem, "Doc_Obrigatorio") = 1 Then

                Dim MyButton As LinkButton = e.Row.FindControl("cmdDelete")
                'MyButton.Attributes.Add("onclick", "javascript:return alert('Documento Obrigatório : " & DataBinder.Eval(e.Row.DataItem, "Doc_Descricao") & " EXCLUSÃO NÃO PERMITIDA !!!')")

            Else
                Dim MyButton As LinkButton = e.Row.FindControl("cmdDelete")
                'MyButton.Attributes.Add("onclick", "javascript:return " & "confirm('Confirma a exclusão do Documento " & DataBinder.Eval(e.Row.DataItem, "Doc_Descricao") & " ?')")

            End If
        End If

    End Sub
    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand

        If (e.CommandName = "Delete1") Then
            pnl_documento_detalhe.Visible = "true"
            Try
                Dim mregistro As Integer = Convert.ToInt32(e.CommandArgument)
                Dim conexao_1 As New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                strreader = "select tmp_prestadorxdocumento.PrexDoc_Id, "
                strreader = strreader & "tmp_prestadorxdocumento.Pre_Id, "
                strreader = strreader & "tmp_prestadorxdocumento.Doc_Id, "
                strreader = strreader & "tmp_prestadorxdocumento.Doc_Descricao, "
                strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Emissao, "
                strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Validade, "
                strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Nome, "
                strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Observacao, "
                strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Situacao, "
                strreader = strreader & "tmp_prestadorxdocumento.Doc_Obrigatorio, "
                strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Data_Alteracao, "
                strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Informacoes "
                strreader = strreader & "FROM tmp_prestadorxdocumento "
                strreader = strreader & "WHERE "
                strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Id = " & mregistro & ""

                objCmd = New MySqlCommand(strreader, conexao_1)
                objCmd.Connection.Open()
                dr = objCmd.ExecuteReader()

                txt_prexdoc_emissao.Text = ""
                txt_prexdoc_validade.Text = ""
                txt_prexdoc_nome.Text = ""
                txt_prexdoc_doc.Text = ""
                txt_prexdoc_obs.Text = ""
                lbl_data_upload.Text = ""
                btn_Excluir_Documento_alt.Visible = False
                While dr.Read()
                    txt_prexdoc_registro.Text = (dr(0))
                    If Not IsDBNull(dr(2)) Then
                        ddlDocumento.SelectedValue = dr(2)
                    End If
                    'txt_prexdoc_descricao.Text = (dr(3))
                    If Not IsDBNull(dr(4)) Then
                        txt_prexdoc_emissao.Text = "" 'dr(4)
                        If Day(dr(4)) <= 9 Then
                            txt_prexdoc_emissao.Text = "0" & Day(dr(4))
                        Else
                            txt_prexdoc_emissao.Text = Day(dr(4))
                        End If

                        If Month(dr(4)) <= 9 Then
                            txt_prexdoc_emissao.Text = txt_prexdoc_emissao.Text & "/0" & Month(dr(4))
                        Else
                            txt_prexdoc_emissao.Text = txt_prexdoc_emissao.Text & "/" & Month(dr(4))
                        End If

                        txt_prexdoc_emissao.Text = txt_prexdoc_emissao.Text & "/" & Mid(Year(dr(4)), 1, 4)
                    End If
                    If Not IsDBNull(dr(5)) Then
                        txt_prexdoc_validade.Text = "" 'dr(5)
                        If Day(dr(5)) <= 9 Then
                            txt_prexdoc_validade.Text = "0" & Day(dr(5))
                        Else
                            txt_prexdoc_validade.Text = Day(dr(5))
                        End If

                        If Month(dr(5)) <= 9 Then
                            txt_prexdoc_validade.Text = txt_prexdoc_validade.Text & "/0" & Month(dr(5))
                        Else
                            txt_prexdoc_validade.Text = txt_prexdoc_validade.Text & "/" & Month(dr(5))
                        End If

                        txt_prexdoc_validade.Text = txt_prexdoc_validade.Text & "/" & Mid(Year(dr(5)), 1, 4)
                    End If
                    If Not IsDBNull(dr(6)) Then
                        txt_prexdoc_nome.Text = dr(6)
                    End If
                    If Not IsDBNull(dr(6)) Then
                        txt_prexdoc_doc.Text = dr(6)
                    End If
                    If Not IsDBNull(dr(7)) Then
                        txt_prexdoc_obs.Text = dr(7)
                    End If
                    If Not IsDBNull(dr("PrexDoc_Data_Alteracao")) Then
                        lbl_data_upload.Text = "Ultima atualização em : " 'dr(4)
                        If Day(dr("PrexDoc_Data_Alteracao")) <= 9 Then
                            lbl_data_upload.Text = lbl_data_upload.Text & "0" & Day(dr("PrexDoc_Data_Alteracao"))
                        Else
                            lbl_data_upload.Text = lbl_data_upload.Text & Day(dr("PrexDoc_Data_Alteracao"))
                        End If

                        If Month(dr(4)) <= 9 Then
                            lbl_data_upload.Text = lbl_data_upload.Text & "/0" & Month(dr("PrexDoc_Data_Alteracao"))
                        Else
                            lbl_data_upload.Text = lbl_data_upload.Text & "/" & Month(dr("PrexDoc_Data_Alteracao"))
                        End If

                        lbl_data_upload.Text = lbl_data_upload.Text & "/" & Mid(Year(dr("PrexDoc_Data_Alteracao")), 1, 4)
                    End If
                    If Not IsDBNull(dr(9)) Then
                        If dr(9) = 0 Then
                            btn_Excluir_Documento_alt.Visible = True
                        End If
                    End If
                    If Not IsDBNull(dr(11)) Then
                        txt_prexdoc_ajuda_alt.Text = dr(11)
                    End If
                End While
                'fechar
                dr.Close()
                dr = Nothing

                strreader = "select cad_documento.Doc_Descricao,cad_documento.Doc_Validade,cad_documento.Doc_Obrigatorio,cad_documento.Doc_Onde_Obter,cad_documento.Doc_Qtde_Permitida,cad_documento.Doc_ID,cad_documento.Doc_Modelo "
                strreader = strreader & "FROM cad_documento "
                strreader = strreader & "WHERE "
                strreader = strreader & "cad_documento.Doc_Id = " & ddlDocumento.SelectedValue & ""
                'configurando datareader

                objCmd = New MySqlCommand(strreader, conexao_1)
                dr = objCmd.ExecuteReader()

                lbl_Validade.Visible = False
                txt_prexdoc_validade.Visible = False
                lbl_Validade.Visible = False
                lbl_Validade_Formato.Visible = False
                If dr.Read() Then
                    If Not IsDBNull(dr(1)) Then
                        If dr(1) <> 0 Then
                            lbl_Validade.Visible = True
                            txt_prexdoc_validade.Visible = True
                            lbl_Validade.Visible = True
                            lbl_Validade_Formato.Visible = True
                        End If
                        If Not IsDBNull(dr(6)) Then
                            hpl_modelo_alt.NavigateUrl = dr(6)
                        End If

                    End If

                End If

                'fechar
                dr.Close()
                dr = Nothing

                objCmd.Connection.Close()
                conexao_1.Close()
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao_Documento.Visible = "false"
                btn_Confirma_Exclusao_Prestador.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_Alteracao.Show()
            End Try
            lbl_mensagem_1.Text = ""

        End If
    End Sub
    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        'If (e.Row.RowType = DataControlRowType.DataRow) Then
        'Dim MyButton As LinkButton = e.Row.FindControl("cmdDelete23")
        'MyButton.Attributes.Add("onclick", "javascript:return " & "confirm('Confirma a exclusão do Prestador " & DataBinder.Eval(e.Row.DataItem, "PrexPre_Nome") & " ?')")
        'End If
    End Sub
    Protected Sub GridView2_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView2.RowCommand
        If (e.CommandName = "Delete20") Then

            pnl_prestador_detalhe.Visible = "true"

            Try
                Dim mregistro As Integer = Convert.ToInt32(e.CommandArgument)
                Dim conexao_1 As New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                strreader = "select tmp_prestadorxprestador.PrexPre_Id, "
                strreader = strreader & "tmp_prestadorxprestador.Pre_Id, "
                strreader = strreader & "tmp_prestadorxprestador.Pre_CNPJ, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Nome, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_RG, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_CPF, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Nacionalidade, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Estado_Civil, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Profissao, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Endereco, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Numero, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Complemento, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Bairro, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_CEP, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Municipio, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_UF, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Telefone,"
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Celular,"
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Email,"
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Servicos, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_1, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_2, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_3, "
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_4 "
                strreader = strreader & "FROM tmp_prestadorxprestador "
                strreader = strreader & "WHERE "
                strreader = strreader & " tmp_prestadorxprestador.PrexPre_Id = " & mregistro & ""
                'configurando datareader

                objCmd = New MySqlCommand(strreader, conexao_1)
                objCmd.Connection.Open()
                dr = objCmd.ExecuteReader()

                txt_Prestador_Nome.Text = ""
                txt_Prestador_RG.Text = ""
                txt_Prestador_CPF.Text = ""
                txt_Prestador_Nacionalidade.Text = ""
                txt_Prestador_Profissao.Text = ""
                txt_Prestador_Endereco.Text = ""
                txt_Prestador_Numero.Text = ""
                txt_Prestador_Complemento.Text = ""
                txt_Prestador_Bairro.Text = ""
                txt_Prestador_CEP.Text = ""
                txt_Prestador_Municipio.Text = ""
                txt_Prestador_Telefone.Text = ""
                txt_Prestador_Celular.Text = ""
                txt_Prestador_Email.Text = ""
                txt_Prestador_Servico.Text = ""
                txt_Prestador_Doc_1.Text = ""
                txt_Prestador_Doc_2.Text = ""
                txt_Prestador_Doc_3.Text = ""
                txt_Prestador_Doc_4.Text = ""
                hl_up_1.NavigateUrl = ""
                hl_up_2.NavigateUrl = ""
                hl_up_3.NavigateUrl = ""
                hl_up_4.NavigateUrl = ""

                While dr.Read()
                    txt_prexpre_registro.Text = (dr(0))
                    If Not IsDBNull(dr(3)) Then
                        txt_Prestador_Nome.Text = dr(3)
                    End If
                    If Not IsDBNull(dr(4)) Then
                        txt_Prestador_RG.Text = dr(4)
                    End If
                    If Not IsDBNull(dr(5)) Then
                        txt_Prestador_CPF.Text = dr(5)
                    End If
                    If Not IsDBNull(dr(6)) Then
                        txt_Prestador_Nacionalidade.Text = dr(6)
                    End If
                    If Not IsDBNull(dr(7)) Then
                        ddl_Prestador_EstadoCivil.SelectedValue = dr(7)
                    End If
                    If Not IsDBNull(dr(8)) Then
                        txt_Prestador_Profissao.Text = dr(8)
                    End If
                    If Not IsDBNull(dr(9)) Then
                        txt_Prestador_Endereco.Text = dr(9)
                    End If
                    If Not IsDBNull(dr(10)) Then
                        txt_Prestador_Numero.Text = dr(10)
                    End If
                    If Not IsDBNull(dr(11)) Then
                        txt_Prestador_Complemento.Text = dr(11)
                    End If
                    If Not IsDBNull(dr(12)) Then
                        txt_Prestador_Bairro.Text = dr(12)
                    End If
                    If Not IsDBNull(dr(13)) Then
                        txt_Prestador_CEP.Text = dr(13)
                    End If
                    If Not IsDBNull(dr(14)) Then
                        txt_Prestador_Municipio.Text = dr(14)
                    End If
                    If Not IsDBNull(dr(15)) Then
                        ddl_Prestador_UF.SelectedValue = dr(15)
                    End If
                    If Not IsDBNull(dr(16)) Then
                        txt_Prestador_Telefone.Text = dr(16)
                    End If
                    If Not IsDBNull(dr(17)) Then
                        txt_Prestador_Celular.Text = dr(17)
                    End If
                    If Not IsDBNull(dr(18)) Then
                        txt_Prestador_Email.Text = dr(18)
                    End If
                    If Not IsDBNull(dr(19)) Then
                        txt_Prestador_Servico.Text = dr(19)
                    End If
                    If Not IsDBNull(dr(20)) Then
                        txt_Prestador_Doc_1.Text = dr(20)
                        hl_up_1.NavigateUrl = dr(20)
                        hl_up_1.Text = dr(20)
                    End If
                    If Not IsDBNull(dr(21)) Then
                        txt_Prestador_Doc_2.Text = dr(21)
                        hl_up_2.NavigateUrl = dr(21)
                        hl_up_2.Text = dr(21)
                    End If
                    If Not IsDBNull(dr(22)) Then
                        txt_Prestador_Doc_3.Text = dr(22)
                        hl_up_3.NavigateUrl = dr(22)
                        hl_up_3.Text = dr(22)
                    End If
                    If Not IsDBNull(dr(23)) Then
                        txt_Prestador_Doc_4.Text = dr(23)
                        hl_up_4.NavigateUrl = dr(23)
                        hl_up_4.Text = dr(23)
                    End If
                End While
                'fechar
                dr.Close()
                dr = Nothing
                objCmd.Connection.Close()
                conexao_1.Close()
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao_Documento.Visible = "false"
                btn_Confirma_Exclusao_Prestador.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_Alteracao.Show()
            End Try
        End If
    End Sub

    Function BuscaCep(ByVal cep As String) As Hashtable
        Dim ds As DataSet
        Dim _resultado As String
        Dim ht As System.Collections.Hashtable
        Try
            ds = New DataSet()
            ds.ReadXml("http://cep.republicavirtual.com.br/web_cep.php?cep=" & cep.Replace("-", "").Trim() & "&formato=xml")
            'ds.ReadXml("http://cep.republicavirtual.com.br/web_cep.php?cep='12209675'&formato=xml")

            If Not IsNothing(ds) Then
                If (ds.Tables(0).Rows.Count > 0) Then
                    _resultado = ds.Tables(0).Rows(0).Item("resultado").ToString()
                    ht = New Hashtable

                    Select Case _resultado
                        Case "1"
                            ht.Add("UF", ds.Tables(0).Rows(0).Item("uf").ToString().Trim())
                            ddl_UF.SelectedValue = ds.Tables(0).Rows(0).Item("uf").ToString().Trim()
                            ht.Add("cidade", ds.Tables(0).Rows(0).Item("cidade").ToString().Trim())
                            txt_Cidade.Text = ds.Tables(0).Rows(0).Item("cidade").ToString().Trim()
                            ht.Add("bairro", ds.Tables(0).Rows(0).Item("bairro").ToString().Trim())
                            txt_Bairro.Text = ds.Tables(0).Rows(0).Item("bairro").ToString().Trim()
                            ht.Add("tipologradouro", ds.Tables(0).Rows(0).Item("tipo_logradouro").ToString().Trim())
                            ht.Add("logradouro", ds.Tables(0).Rows(0).Item("logradouro").ToString().Trim())
                            txt_Endereco.Text = ds.Tables(0).Rows(0).Item("tipo_logradouro").ToString().Trim() & " " & ds.Tables(0).Rows(0).Item("logradouro").ToString().Trim()
                            ht.Add("tipo", 1)

                        Case "2"
                            ht.Add("UF", ds.Tables(0).Rows(0).Item("uf").ToString().Trim())
                            ddl_UF.SelectedValue = ds.Tables(0).Rows(0).Item("uf").ToString().Trim()
                            ht.Add("cidade", ds.Tables(0).Rows(0).Item("cidade").ToString().Trim())
                            txt_Cidade.Text = ds.Tables(0).Rows(0).Item("cidade").ToString().Trim()
                            ht.Add("tipo", 2)
                        Case Else
                            ht.Add("tipo", 0)
                    End Select
                End If
            End If
            Return ht
        Catch ex As Exception
            Throw New Exception("Falha ao Buscar o Cep " & vbCrLf & ex.ToString)
            Return Nothing
        End Try
    End Function

    Function BuscaCep_Prestador(ByVal cep As String) As Hashtable
        Dim ds As DataSet
        Dim _resultado As String
        Dim ht As System.Collections.Hashtable
        Try
            ds = New DataSet()
            ds.ReadXml("http://cep.republicavirtual.com.br/web_cep.php?cep=" & cep.Replace("-", "").Trim() & "&formato=xml")
            'ds.ReadXml("http://cep.republicavirtual.com.br/web_cep.php?cep='12209675'&formato=xml")

            If Not IsNothing(ds) Then
                If (ds.Tables(0).Rows.Count > 0) Then
                    _resultado = ds.Tables(0).Rows(0).Item("resultado").ToString()
                    ht = New Hashtable

                    Select Case _resultado
                        Case "1"
                            ht.Add("UF", ds.Tables(0).Rows(0).Item("uf").ToString().Trim())
                            ddl_Prestador_UF.SelectedValue = ds.Tables(0).Rows(0).Item("uf").ToString().Trim()
                            ht.Add("cidade", ds.Tables(0).Rows(0).Item("cidade").ToString().Trim())
                            txt_Prestador_Municipio.Text = ds.Tables(0).Rows(0).Item("cidade").ToString().Trim()
                            ht.Add("bairro", ds.Tables(0).Rows(0).Item("bairro").ToString().Trim())
                            txt_Prestador_Bairro.Text = ds.Tables(0).Rows(0).Item("bairro").ToString().Trim()
                            ht.Add("tipologradouro", ds.Tables(0).Rows(0).Item("tipo_logradouro").ToString().Trim())
                            ht.Add("logradouro", ds.Tables(0).Rows(0).Item("logradouro").ToString().Trim())
                            txt_Prestador_Endereco.Text = ds.Tables(0).Rows(0).Item("tipo_logradouro").ToString().Trim() & " " & ds.Tables(0).Rows(0).Item("logradouro").ToString().Trim()
                            ht.Add("tipo", 1)

                        Case "2"
                            ht.Add("UF", ds.Tables(0).Rows(0).Item("uf").ToString().Trim())
                            ddl_Prestador_UF.SelectedValue = ds.Tables(0).Rows(0).Item("uf").ToString().Trim()
                            ht.Add("cidade", ds.Tables(0).Rows(0).Item("cidade").ToString().Trim())
                            txt_Prestador_Municipio.Text = ds.Tables(0).Rows(0).Item("cidade").ToString().Trim()
                            ht.Add("tipo", 2)
                        Case Else
                            ht.Add("tipo", 0)
                    End Select
                End If
            End If
            Return ht
        Catch ex As Exception
            Throw New Exception("Falha ao Buscar o Cep " & vbCrLf & ex.ToString)
            Return Nothing
        End Try
    End Function
    Protected Sub Imgbtn_Cadastrar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles Imgbtn_Cadastrar.Click
        'pegando dados

        Dim m_cnpj, m_razao, m_fantasia, m_iestadual, m_imunicipal, m_imcidaade, m_imuf As String
        Dim m_representante, m_representante_cargo, m_representante_estado_civil, m_representante_profissao, m_cpf_representante, m_rg_representante, m_nacionalidade As String
        Dim m_endereco, m_numero, m_complemento, m_bairro, m_cep As String
        Dim m_cidade, m_uf, m_telefone, m_celular, m_email, m_site, m_servico, m_categoria As String
        Dim m_senha, m_repete_senha, m_data As String

        m_servico = ddl_Servico.SelectedValue
        m_categoria = ddl_Categoria.SelectedValue

        m_cnpj = txt_CNPJ.Text
        m_razao = Replace(txt_Razao_Social.Text, "'", " ")
        m_razao = Replace(m_razao, ",", " ")
        m_fantasia = Replace(txt_Nome_Fantasia.Text, "'", " ")
        m_fantasia = Replace(m_fantasia, ",", " ")
        m_iestadual = Replace(txt_IEstadual.Text, "'", " ")
        m_iestadual = Replace(m_iestadual, ",", " ")
        m_imunicipal = Replace(txt_IMunicipal.Text, "'", " ")
        m_imunicipal = Replace(m_imunicipal, ",", " ")
        m_imcidaade = Replace(txt_IM_Cidade.Text, "'", " ")
        m_imcidaade = Replace(m_imcidaade, ",", " ")
        m_imuf = ddl_IM_UF.SelectedValue
        m_representante = Replace(txt_Representante.Text, "'", " ")
        m_representante = Replace(m_representante, ",", " ")
        m_representante_cargo = Replace(txt_Representante_Cargo.Text, "'", " ")
        m_representante_cargo = Replace(m_representante_cargo, ",", " ")
        m_representante_estado_civil = ddl_Representante_EstadoCivil.SelectedValue
        m_representante_profissao = Replace(txt_Representante_Profissao.Text, "'", " ")
        m_representante_profissao = Replace(m_representante_profissao, ",", " ")
        m_cpf_representante = Replace(txt_CPF.Text, "'", " ")
        m_cpf_representante = Replace(m_cpf_representante, ",", " ")
        m_rg_representante = Replace(txt_RG.Text, "'", " ")
        m_rg_representante = Replace(m_rg_representante, ",", " ")
        m_nacionalidade = Replace(txt_Nacionalidade.Text, "'", " ")
        m_nacionalidade = Replace(m_nacionalidade, ",", " ")
        m_endereco = Replace(txt_Endereco.Text, "'", " ")
        m_endereco = Replace(m_endereco, ",", " ")
        m_numero = Replace(txt_Numero.Text, "'", " ")
        m_numero = Replace(m_numero, ",", " ")
        m_complemento = Replace(txt_Complemento.Text, "'", " ")
        m_complemento = Replace(m_complemento, ",", " ")
        m_bairro = Replace(txt_Bairro.Text, "'", " ")
        m_bairro = Replace(m_bairro, ",", " ")
        m_cep = Replace(txt_CEP.Text, "'", " ")
        m_cep = Replace(m_cep, ",", " ")
        m_cidade = Replace(txt_Cidade.Text, "'", " ")
        m_cidade = Replace(m_cidade, ",", " ")
        m_uf = ddl_UF.SelectedValue
        m_telefone = Replace(txt_Telefone.Text, "'", " ")
        m_telefone = Replace(m_telefone, ",", " ")
        m_celular = Replace(txt_Celular.Text, "'", " ")
        m_celular = Replace(m_celular, ",", " ")
        m_email = Replace(txt_Email.Text, "'", " ")
        m_email = Replace(m_email, ",", " ")
        m_site = Replace(txt_Site.Text, "'", " ")
        m_site = Replace(m_site, ",", " ")
        m_senha = Replace(txt_Senha.Text, "'", " ")
        m_senha = Replace(m_senha, ",", " ")
        m_repete_senha = txt_Confirma_Senha.Text
        'm_tipoempresa_1 = m_tipoempresa
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
        If m_cnpj <> "" And ddl_Categoria.SelectedValue <> 0 And ddl_Servico.SelectedValue <> 0 Then

            Try
                'abrindo conexao
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                'inserir dados
                strexec = "UPDATE cad_prestador SET "
                strexec = strexec & "cad_prestador.Pre_Razao_Social='" & m_razao & "',"
                strexec = strexec & "cad_prestador.Pre_Nome_Fantasia='" & m_fantasia & "',"
                strexec = strexec & "cad_prestador.Pre_IEstadual='" & m_iestadual & "',"
                strexec = strexec & "cad_prestador.Pre_IMunicipal='" & m_imunicipal & "',"
                strexec = strexec & "cad_prestador.Pre_IMunicipal_Municipio='" & m_imcidaade & "',"
                strexec = strexec & "cad_prestador.Pre_IMunicipal_UF='" & m_imuf & "',"
                strexec = strexec & "cad_prestador.Pre_Representante='" & m_representante & "',"
                strexec = strexec & "cad_prestador.Pre_Representante_Cargo='" & m_representante_cargo & "',"
                strexec = strexec & "cad_prestador.Pre_Representante_Estado_Civil='" & m_representante_estado_civil & "',"
                strexec = strexec & "cad_prestador.Pre_Representante_Profissao='" & m_representante_profissao & "',"
                strexec = strexec & "cad_prestador.Pre_Representante_CPF='" & m_cpf_representante & "',"
                strexec = strexec & "cad_prestador.Pre_Representante_RG='" & m_rg_representante & "',"
                strexec = strexec & "cad_prestador.Pre_Nacionalidade='" & m_nacionalidade & "',"
                strexec = strexec & "cad_prestador.Pre_Endereco='" & m_endereco & "',"
                strexec = strexec & "cad_prestador.Pre_Complemento='" & m_complemento & "',"
                strexec = strexec & "cad_prestador.Pre_Bairro='" & m_bairro & "',"
                strexec = strexec & "cad_prestador.Pre_CEP='" & m_cep & "',"
                strexec = strexec & "cad_prestador.Pre_Municipio='" & m_cidade & "',"
                strexec = strexec & "cad_prestador.Pre_UF='" & m_uf & "',"
                strexec = strexec & "cad_prestador.Pre_Telefone='" & m_telefone & "',"
                strexec = strexec & "cad_prestador.Pre_Celular='" & m_celular & "',"
                strexec = strexec & "cad_prestador.Pre_Email='" & m_email & "',"
                strexec = strexec & "cad_prestador.Pre_Site='" & m_site & "',"
                strexec = strexec & "cad_prestador.Pre_Senha='" & m_senha & "', "
                strexec = strexec & "cad_prestador.Pre_TipoEmpresa='" & m_categoria & "', "
                strexec = strexec & "cad_prestador.Pre_TipoPrestador='" & m_servico & "', "
                strexec = strexec & "cad_prestador.Pre_Data_Alteracao='" & m_data & "' "
                strexec = strexec & "WHERE cad_prestador.Pre_ID=" & CodPrestador & ""

                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.Connection.Open()
                objCmd.ExecuteNonQuery()

                strexec = "DELETE cad_prestadorxdocumento FROM cad_prestadorxdocumento "
                strexec = strexec & "WHERE "
                strexec = strexec & "cad_prestadorxdocumento.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                ' transferindo dados 

                strexec = "INSERT INTO cad_prestadorxdocumento(Pre_ID,Pre_CNPJ,Doc_ID,"
                strexec = strexec & "Doc_Descricao,PrexDoc_Emissao,PrexDoc_Validade,PrexDoc_Nome,PrexDoc_Observacao,PrexDoc_Situacao,PrexDoc_Data_Alteracao) "
                strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',tmp_prestadorxdocumento.Doc_ID,tmp_prestadorxdocumento.Doc_Descricao,tmp_prestadorxdocumento.PrexDoc_Emissao,tmp_prestadorxdocumento.PrexDoc_Validade,"
                strexec = strexec & "tmp_prestadorxdocumento.PrexDoc_Nome,tmp_prestadorxdocumento.PrexDoc_Observacao,tmp_prestadorxdocumento.PrexDoc_Situacao,tmp_prestadorxdocumento.PrexDoc_Data_Alteracao "
                strexec = strexec & "FROM tmp_prestadorxdocumento "
                strexec = strexec & "WHERE "
                strexec = strexec & "tmp_prestadorxdocumento.Pre_CNPJ= '" & txt_CNPJ.Text & "'"

                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                strexec = "DELETE cad_prestadorxsermat FROM cad_prestadorxsermat "
                strexec = strexec & "WHERE "
                strexec = strexec & "cad_prestadorxsermat.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                ' transferindo dados 

                strexec = "INSERT INTO cad_prestadorxsermat(Pre_ID,Pre_CNPJ,SM_ID,SM_Descricao) "
                strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',tmp_prestadorxsermat.SM_ID,tmp_prestadorxsermat.SM_Descricao "
                strexec = strexec & "FROM tmp_prestadorxsermat "
                strexec = strexec & "WHERE "
                strexec = strexec & "tmp_prestadorxsermat.Pre_CNPJ= '" & txt_CNPJ.Text & "'"

                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                strexec = "DELETE cad_prestadorxprestador FROM cad_prestadorxprestador "
                strexec = strexec & "WHERE "
                strexec = strexec & "cad_prestadorxprestador.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                ' transferindo dados 

                strexec = "INSERT INTO cad_prestadorxprestador(Pre_ID,Pre_CNPJ,PrexPre_Nome,PrexPre_RG,PrexPre_CPF,PrexPre_Nacionalidade, "
                strexec = strexec & "PrexPre_Estado_Civil,PrexPre_Profissao,PrexPre_Endereco,PrexPre_Numero,PrexPre_Complemento,PrexPre_Bairro, "
                strexec = strexec & "PrexPre_CEP,PrexPre_Municipio,PrexPre_UF,PrexPre_Telefone,PrexPre_Celular,PrexPre_Email,PrexPre_Servicos, "
                strexec = strexec & "PrexPre_Doc_1,PrexPre_Doc_2,PrexPre_Doc_3,PrexPre_Doc_4) "
                strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',tmp_prestadorxprestador.PrexPre_Nome,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_RG,tmp_prestadorxprestador.PrexPre_CPF,tmp_prestadorxprestador.PrexPre_Nacionalidade,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Estado_Civil,tmp_prestadorxprestador.PrexPre_Profissao,tmp_prestadorxprestador.PrexPre_Endereco,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Numero,tmp_prestadorxprestador.PrexPre_Complemento,tmp_prestadorxprestador.PrexPre_Bairro,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_CEP,tmp_prestadorxprestador.PrexPre_Municipio,tmp_prestadorxprestador.PrexPre_UF,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Telefone,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Celular,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Email,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Servicos, "
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Doc_1, "
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Doc_2, "
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Doc_3, "
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Doc_4 "
                strexec = strexec & "FROM tmp_prestadorxprestador "
                strexec = strexec & "WHERE "
                strexec = strexec & "tmp_prestadorxprestador.Pre_CNPJ= '" & txt_CNPJ.Text & "'"

                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()


                'fechar
                objCmd.Connection.Close()
                objConn.Close()
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao_Documento.Visible = "false"
                btn_Confirma_Exclusao_Prestador.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_Alteracao.Show()
            End Try

        Else
            'dar mensagem
            'lblConfirm.Text = ""
            'lbl_Confirmar.Text = "Informe o Trabalho Oferecido e Sua Categoria !!!"
        End If


    End Sub
    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        'ModalPopupExtender2.Hide()
        Timer1.Interval = 3000
        Timer1.Enabled = False
        Response.Redirect("Login_Cadastro.aspx")
        'Response.End()
    End Sub
    Sub DataGrid2_itemdatabound(ByVal sender As Object, ByVal e As DataGridItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.SelectedItem Then
            Dim LinkButtonDelete As LinkButton = e.Item.FindControl("LnkBtnDel3")
        End If
    End Sub
    Sub DataGrid2_DeleteCommand(ByVal s As Object, ByVal e As DataGridCommandEventArgs)
        If lbl_perfil.Text <> "Gerente" Then

            Try
                Dim objConnd As New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
                Dim mselecao, mregistro As Integer

                mregistro = Datagrid2.DataKeys(CInt(e.Item.ItemIndex))

                'montando a string--------------------------------------------------------
                strreader = "SELECT tmp_prestadorxsermat.SM_Selecao "
                strreader = strreader & "FROM tmp_prestadorxsermat "
                strreader = strreader & "WHERE "
                strreader = strreader & "tmp_prestadorxsermat.PrexSM_ID = " & mregistro & " "
                'configurando datareader

                objCmdd = New MySqlCommand(strreader, objConnd)
                objCmdd.Connection.Open()
                dr = objCmdd.ExecuteReader()

                mselecao = 0
                While dr.Read()
                    If Not IsDBNull(dr(0)) Then
                        mselecao = dr(0)
                    End If
                End While

                'fechar
                dr.Close()
                dr = Nothing
                objCmdd.Connection.Close()
                objConnd.Close()

                'montando a string--------------------------------------------------------
                strexec = "UPDATE tmp_prestadorxsermat "
                If mselecao = 1 Then
                    strexec = strexec & "SET tmp_prestadorxsermat.SM_Selecao = 0 "
                Else
                    strexec = strexec & "SET tmp_prestadorxsermat.SM_Selecao = 1 "
                End If
                strexec = strexec & "WHERE tmp_prestadorxsermat.PrexSM_ID = " & mregistro & " "
                objCmd = New MySqlCommand(strexec, objConnd)
                objCmd.Connection.Open()
                objCmd.ExecuteNonQuery()

                objCmd.Connection.Close()


                'montando a string--------------------------------------------------------
                strdt = "SELECT tmp_prestadorxsermat.PrexSM_ID,tmp_prestadorxsermat.Pre_ID,tmp_prestadorxsermat.Pre_CNPJ,tmp_prestadorxsermat.SM_ID,tmp_prestadorxsermat.SM_Descricao,tmp_prestadorxsermat.SM_Selecao  "
                strdt = strdt & "FROM tmp_prestadorxsermat "
                strdt = strdt & "WHERE "
                strdt = strdt & "tmp_prestadorxsermat.Pre_CNPJ =  '" & txt_CNPJ.Text & "' and tmp_prestadorxsermat.SM_Material=1"

                'configura o dataadpter----------------------------------------------------
                objDt = New MySqlDataAdapter(strdt, objConnd)

                'criando dataset
                ds = New DataSet
                objDt.Fill(ds)

                Datagrid2.DataSource = ds
                Datagrid2.DataBind()


                ds = Nothing
                objDt = Nothing

                'fechar
                objConnd.Close()
                objConnd = Nothing
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao_Documento.Visible = "false"
                btn_Confirma_Exclusao_Prestador.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_Alteracao.Show()
            End Try
            Grava_Prestador_Alteracao()
        End If
    End Sub
    Private Sub DataGrid2_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles Datagrid2.PageIndexChanged
        Datagrid2.CurrentPageIndex = e.NewPageIndex
        Datagrid2.DataBind()
    End Sub
    Protected Sub ImageButton3_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton3.Click
        'pegando dados

        Dim objConn As New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
        Dim mnome_servico As String
        Dim mcodservico As Integer

        mnome_servico = txtdescservico.Text

        Dim exe_descservico As String
        exe_descservico = Replace(txtdescservico.Text, ",", " ")
        'exe_obs = Replace(txtobs.Text, ",", " ")

        If txtdescservico.Text = "" Then
            'exe_descservico = Replace(txtobs.Text, ",", " ")
        End If

        If (exe_descservico <> "") Then
            Try
                'abrindo conexao
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
                'excluir caso ja exista

                strexec = "DELETE tmp_prestadorxsermat FROM tmp_prestadorxsermat "
                strexec = strexec & "WHERE tmp_prestadorxsermat.SM_Descricao = '" & exe_descservico & "' and "
                strexec = strexec & "tmp_prestadorxsermat.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.Connection.Open()
                objCmd.ExecuteNonQuery()

                strexec = "INSERT INTO tmp_prestadorxsermat(Pre_ID,Pre_CNPJ,SM_ID,SM_Descricao,SM_Selecao,SM_Material,SM_Servico) "
                strexec = strexec & "VALUES(" & CodPrestador & ",'" & txt_CNPJ.Text & "',"
                strexec = strexec & "" & mcodservico & ",'" & exe_descservico & "',1,1,0)"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()



                'montando a string--------------------------------------------------------
                strdt = "SELECT tmp_prestadorxsermat.PrexSM_ID,tmp_prestadorxsermat.Pre_ID,tmp_prestadorxsermat.Pre_CNPJ,tmp_prestadorxsermat.SM_ID,tmp_prestadorxsermat.SM_Descricao,tmp_prestadorxsermat.SM_Selecao  "
                strdt = strdt & "FROM tmp_prestadorxsermat "
                strdt = strdt & "WHERE "
                strdt = strdt & "tmp_prestadorxsermat.Pre_CNPJ =  '" & txt_CNPJ.Text & "' and tmp_prestadorxsermat.SM_Material=1"

                'configura o dataadpter----------------------------------------------------
                objDt = New MySqlDataAdapter(strdt, objConn)

                'criando dataset
                ds = New DataSet
                objDt.Fill(ds)

                Datagrid2.DataSource = ds
                Datagrid2.DataBind()
                objCmd.Connection.Close()

                'fechar
                objConn.Close()
                objConn = Nothing
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao_Documento.Visible = "false"
                btn_Confirma_Exclusao_Prestador.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_Alteracao.Show()
            End Try
            'zerando campos
            txtdescservico.Text = ""
            txtcodservico.Text = ""
            txtdescservico.Focus()

            Grava_Prestador_Alteracao()

        Else
            'dar mensagem
            'lblConfirm.Text = ""
            'lblError.Text = "Informe o exame !!! "
            txtdescservico.Focus()
        End If
    End Sub

    Sub DataGrid3_itemdatabound(ByVal sender As Object, ByVal e As DataGridItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.SelectedItem Then
            Dim LinkButtonDelete As LinkButton = e.Item.FindControl("LnkBtnDel3")
        End If
    End Sub
    Sub DataGrid3_DeleteCommand(ByVal s As Object, ByVal e As DataGridCommandEventArgs)
        If lbl_perfil.Text <> "Gerente" Then
            Try
                Dim objConnd As New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
                Dim mselecao, mregistro As Integer

                mregistro = Datagrid3.DataKeys(CInt(e.Item.ItemIndex))

                'montando a string--------------------------------------------------------
                strreader = "SELECT tmp_prestadorxsermat.SM_Selecao "
                strreader = strreader & "FROM tmp_prestadorxsermat "
                strreader = strreader & "WHERE "
                strreader = strreader & "tmp_prestadorxsermat.PrexSM_ID = " & mregistro & " "
                'configurando datareader

                objCmdd = New MySqlCommand(strreader, objConnd)
                objCmdd.Connection.Open()
                dr = objCmdd.ExecuteReader()

                mselecao = 0
                While dr.Read()
                    If Not IsDBNull(dr(0)) Then
                        mselecao = dr(0)
                    End If
                End While

                'fechar
                dr.Close()
                dr = Nothing
                objCmdd.Connection.Close()
                objConnd.Close()

                'montando a string--------------------------------------------------------
                strexec = "UPDATE tmp_prestadorxsermat "
                If mselecao = 1 Then
                    strexec = strexec & "SET tmp_prestadorxsermat.SM_Selecao = 0 "
                Else
                    strexec = strexec & "SET tmp_prestadorxsermat.SM_Selecao = 1 "
                End If
                strexec = strexec & "WHERE tmp_prestadorxsermat.PrexSM_ID = " & mregistro & " "
                objCmd = New MySqlCommand(strexec, objConnd)
                objCmd.Connection.Open()
                objCmd.ExecuteNonQuery()

                objCmd.Connection.Close()


                'montando a string--------------------------------------------------------
                strdt = "SELECT tmp_prestadorxsermat.PrexSM_ID,tmp_prestadorxsermat.Pre_ID,tmp_prestadorxsermat.Pre_CNPJ,tmp_prestadorxsermat.SM_ID,tmp_prestadorxsermat.SM_Descricao,tmp_prestadorxsermat.SM_Selecao  "
                strdt = strdt & "FROM tmp_prestadorxsermat "
                strdt = strdt & "WHERE "
                strdt = strdt & "tmp_prestadorxsermat.Pre_CNPJ =  '" & txt_CNPJ.Text & "' and tmp_prestadorxsermat.SM_Servico=1"

                'configura o dataadpter----------------------------------------------------
                objDt = New MySqlDataAdapter(strdt, objConnd)

                'criando dataset
                ds = New DataSet
                objDt.Fill(ds)

                Datagrid3.DataSource = ds
                Datagrid3.DataBind()


                ds = Nothing
                objDt = Nothing

                'fechar
                objConnd.Close()
                objConnd = Nothing
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao_Documento.Visible = "false"
                btn_Confirma_Exclusao_Prestador.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_Alteracao.Show()
            End Try
            Grava_Prestador_Alteracao()
        End If
    End Sub
    Private Sub DataGrid3_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles Datagrid3.PageIndexChanged
        Datagrid3.CurrentPageIndex = e.NewPageIndex
        Datagrid3.DataBind()
    End Sub

    Protected Sub btn_CEP_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_CEP.Click
        BuscaCep(txt_CEP.Text)
    End Sub

    Protected Sub btn_CEP_Prestador_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_CEP_Prestador.Click
        BuscaCep_Prestador(txt_Prestador_CEP.Text)
    End Sub

    Protected Sub ddlDocumento_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlDocumento.SelectedIndexChanged
        Try
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            strreader = "select cad_documento.Doc_Descricao,cad_documento.Doc_Validade,cad_documento.Doc_Obrigatorio,cad_documento.Doc_Onde_Obter,cad_documento.Doc_Qtde_Permitida,cad_documento.Doc_ID "
            strreader = strreader & "FROM cad_documento "
            strreader = strreader & "WHERE "
            strreader = strreader & "cad_documento.Doc_Id = " & ddlDocumento.SelectedValue & ""
            'configurando datareader

            objCmd = New MySqlCommand(strreader, objConn)
            objCmd.Connection.Open()
            dr = objCmd.ExecuteReader()
            lbl_Validade.Visible = False
            txt_prexdoc_validade.Visible = False
            lbl_Validade.Visible = False
            lbl_Validade_Formato.Visible = False
            If dr.Read() Then
                If Not IsDBNull(dr(1)) Then
                    If dr(1) <> 0 Then
                        lbl_Validade.Visible = True
                        txt_prexdoc_validade.Visible = True
                        lbl_Validade.Visible = True
                        lbl_Validade_Formato.Visible = True
                    End If

                End If

            End If
            'fechar
            dr.Close()
            dr = Nothing
            objCmd.Connection.Close()
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub

    Protected Sub ddl_Servico_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddl_Servico.SelectedIndexChanged
        Me.Limpa_Doc_TMP()
        If ddl_Categoria.SelectedValue <> 0 And ddl_Servico.SelectedValue <> 0 Then
            Me.Completa_TMP()
        End If
        Me.Carrega_Doc_TMP()
        Me.Carrega_Doc()
    End Sub

    Protected Sub ddl_Categoria_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddl_Categoria.SelectedIndexChanged
        Me.Limpa_Doc_TMP()
        If ddl_Categoria.SelectedValue <> 0 And ddl_Servico.SelectedValue <> 0 Then
            Me.Completa_TMP()
        End If
        Me.Carrega_Doc_TMP()
        Me.Carrega_Doc()
    End Sub

    Protected Sub lnk_Material_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Material.Click
        Tabs.ActiveTab = TabPanel_3
    End Sub

    Protected Sub lnk_Servico_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Servico.Click
        Tabs.ActiveTab = TabPanel_4
    End Sub
    Protected Sub btn_cadserv_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_cadserv.Click
        Dim objConn As New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
        Dim mnome_servico As String
        Dim mcodservico As Integer

        mnome_servico = txt_servico.Text

        Dim exe_descservico As String
        exe_descservico = Replace(txt_servico.Text, ",", " ")
        'exe_obs = Replace(txtobs.Text, ",", " ")

        If txt_servico.Text = "" Then
            'exe_descservico = Replace(txtobs.Text, ",", " ")
        End If

        If (exe_descservico <> "") Then
            Try
                'abrindo conexao
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
                'excluir caso ja exista

                strexec = "DELETE tmp_prestadorxsermat FROM tmp_prestadorxsermat "
                strexec = strexec & "WHERE tmp_prestadorxsermat.SM_Descricao = '" & exe_descservico & "' and "
                strexec = strexec & "tmp_prestadorxsermat.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.Connection.Open()
                objCmd.ExecuteNonQuery()

                strexec = "INSERT INTO tmp_prestadorxsermat(Pre_ID,Pre_CNPJ,SM_ID,SM_Descricao,SM_Selecao,SM_Material,SM_Servico) "
                strexec = strexec & "VALUES(" & CodPrestador & ",'" & txt_CNPJ.Text & "',"
                strexec = strexec & "" & mcodservico & ",'" & exe_descservico & "',1,0,1)"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                'montando a string--------------------------------------------------------
                strdt = "SELECT tmp_prestadorxsermat.PrexSM_ID,tmp_prestadorxsermat.Pre_ID,tmp_prestadorxsermat.Pre_CNPJ,tmp_prestadorxsermat.SM_ID,tmp_prestadorxsermat.SM_Descricao,tmp_prestadorxsermat.SM_Selecao  "
                strdt = strdt & "FROM tmp_prestadorxsermat "
                strdt = strdt & "WHERE "
                strdt = strdt & "tmp_prestadorxsermat.Pre_CNPJ =  '" & txt_CNPJ.Text & "' and tmp_prestadorxsermat.SM_Servico=1"

                'configura o dataadpter----------------------------------------------------
                objDt = New MySqlDataAdapter(strdt, objConn)

                'criando dataset
                ds = New DataSet
                objDt.Fill(ds)

                Datagrid3.DataSource = ds
                Datagrid3.DataBind()
                objCmd.Connection.Close()

                'fechar
                objConn.Close()
                objConn = Nothing

                'zerando campos
                txt_servico.Text = ""
                txtcodservico.Text = ""
                txt_servico.Focus()
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao_Documento.Visible = "false"
                btn_Confirma_Exclusao_Prestador.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_Alteracao.Show()
            End Try
            Grava_Prestador_Alteracao()

        Else
            'dar mensagem
            'lblConfirm.Text = ""
            'lblError.Text = "Informe o exame !!! "
            txt_servico.Focus()
        End If
    End Sub

    Protected Sub lnk_Documento_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Documento.Click
        Tabs.ActiveTab = TabPanel_5
    End Sub

    Protected Sub lnk_Meusdados_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Meusdados.Click
        Tabs.ActiveTab = TabPanel_1
    End Sub

    Protected Sub lnk_Prestador_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Prestador.Click
        Tabs.ActiveTab = TabPanel_2
    End Sub
    Protected Sub btn_grava_meusdados_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_grava_meusdados.Click

        Grava_Prestador_Alteracao()

    End Sub
    Private Sub Grava_Prestador_Alteracao()
        'pegando dados

        Dim m_cnpj, m_razao, m_fantasia, m_iestadual, m_imunicipal, m_imcidade, m_imuf, m_cnae_cod, m_cnae_desc As String

        Dim m_representante, m_representante_cargo, m_cpf_representante, m_rg_representante, m_nacionalidade, m_representante_estado_civil As String
        Dim m_representante_profissao, m_representante_email As String

        Dim m_pispasep, m_nit As String

        Dim m_endereco, m_numero, m_complemento, m_bairro, m_cep As String
        Dim m_cidade, m_uf, m_telefone, m_telefone_1, m_celular, m_whatszap, m_email, m_email_1, m_site, m_pessoa_contato As String
        Dim m_banco, m_agencia, m_conta, m_tipo_conta As String
        Dim m_senha, m_repete_senha, m_data, m_data_desabilita As String
        Dim m_servico, m_categoria As String
        Dim m_email_doc, m_desabilita, m_motivo As String
        Dim m_erro As Integer

        m_erro = 0

        m_servico = ddl_Servico.SelectedValue
        m_categoria = ddl_Categoria.SelectedValue

        m_cnpj = txt_CNPJ.Text
        If m_categoria = "10" Then
            m_razao = Replace(txt_PF_Nome_alt.Text, "'", " ")
            m_razao = Replace(m_razao, ",", " ")
        Else
            m_razao = Replace(txt_Razao_Social.Text, "'", " ")
            m_razao = Replace(m_razao, ",", " ")
        End If
        m_fantasia = Replace(txt_Nome_Fantasia.Text, "'", " ")
        m_fantasia = Replace(m_fantasia, ",", " ")
        m_iestadual = Replace(txt_IEstadual.Text, "'", " ")
        m_iestadual = Replace(m_iestadual, ",", " ")
        m_imunicipal = Replace(txt_IMunicipal.Text, "'", " ")
        m_imunicipal = Replace(m_imunicipal, ",", " ")
        m_imcidade = Replace(txt_IM_Cidade.Text, "'", " ")
        m_imcidade = Replace(m_imcidade, ",", " ")
        m_imuf = ddl_IM_UF.SelectedValue
        m_cnae_cod = Replace(txt_PJ_CNAE_Cod.Text, "'", " ")
        m_cnae_cod = Replace(m_cnae_cod, ",", " ")
        m_cnae_desc = Replace(txt_PJ_CNAE_Desc.Text, "'", " ")
        m_cnae_desc = Replace(m_cnae_desc, ",", " ")

        m_representante = Replace(txt_Representante.Text, "'", " ")
        m_representante = Replace(m_representante, ",", " ")
        m_representante_cargo = Replace(txt_Representante_Cargo.Text, "'", " ")
        m_representante_cargo = Replace(m_representante_cargo, ",", " ")
        m_cpf_representante = Replace(txt_CPF.Text, "'", " ")
        m_cpf_representante = Replace(m_cpf_representante, ",", " ")

        If m_categoria = "10" Then
            m_representante_estado_civil = ddl_PF_EstadoCivil_alt.SelectedValue
            m_representante_profissao = Replace(txt_PF_Profissao_alt.Text, "'", " ")
            m_representante_profissao = Replace(m_representante_profissao, ",", " ")
            m_rg_representante = Replace(txt_PF_RG_alt.Text, "'", " ")
            m_rg_representante = Replace(m_rg_representante, ",", " ")
            m_nacionalidade = Replace(txt_PF_Nacionalidade_alt.Text, "'", " ")
            m_nacionalidade = Replace(m_nacionalidade, ",", " ")
        Else
            m_representante_estado_civil = ddl_Representante_EstadoCivil.SelectedValue
            m_representante_profissao = Replace(txt_Representante_Profissao.Text, "'", " ")
            m_representante_profissao = Replace(m_representante_profissao, ",", " ")
            m_rg_representante = Replace(txt_RG.Text, "'", " ")
            m_rg_representante = Replace(m_rg_representante, ",", " ")
            m_nacionalidade = Replace(txt_Nacionalidade.Text, "'", " ")
            m_nacionalidade = Replace(m_nacionalidade, ",", " ")
        End If

        m_pispasep = Replace(txt_PF_PISPASEP_alt.Text, "'", " ")
        m_pispasep = Replace(m_pispasep, ",", " ")
        m_nit = Replace(txt_PF_NIT_alt.Text, "'", " ")
        m_nit = Replace(m_nit, ",", " ")

        m_representante_email = Replace(txt_PJ_Representante_Email.Text, "'", " ")
        m_representante_email = Replace(m_representante_email, ",", " ")

        m_endereco = Replace(txt_Endereco.Text, "'", " ")
        m_endereco = Replace(m_endereco, ",", " ")
        m_numero = Replace(txt_Numero.Text, "'", " ")
        m_numero = Replace(m_numero, ",", " ")
        m_complemento = Replace(txt_Complemento.Text, "'", " ")
        m_complemento = Replace(m_complemento, ",", " ")
        m_bairro = Replace(txt_Bairro.Text, "'", " ")
        m_bairro = Replace(m_bairro, ",", " ")
        m_cep = Replace(txt_CEP.Text, "'", " ")
        m_cep = Replace(m_cep, ",", " ")
        m_cidade = Replace(txt_Cidade.Text, "'", " ")
        m_cidade = Replace(m_cidade, ",", " ")
        m_uf = ddl_UF.SelectedValue
        m_telefone = Replace(txt_Telefone.Text, "'", " ")
        m_telefone = Replace(m_telefone, ",", " ")
        m_telefone_1 = Replace(txt_PJ_Telefone1.Text, "'", " ")
        m_telefone_1 = Replace(m_telefone, ",", " ")
        m_celular = Replace(txt_Celular.Text, "'", " ")
        m_celular = Replace(m_celular, ",", " ")
        m_whatszap = Replace(txt_PF_Whatszap.Text, "'", " ")
        m_whatszap = Replace(m_whatszap, ",", " ")
        m_email = Replace(txt_Email.Text, "'", " ")
        m_email = Replace(m_email, ",", " ")
        m_email_1 = Replace(txt_PJ_Email1.Text, "'", " ")
        m_email_1 = Replace(m_email_1, ",", " ")
        m_site = Replace(txt_Site.Text, "'", " ")
        m_site = Replace(m_site, ",", " ")
        m_pessoa_contato = Replace(txt_PJ_PessoaContato.Text, "'", " ")
        m_pessoa_contato = Replace(m_pessoa_contato, ",", " ")

        m_banco = Replace(txt_Banco_alt.Text, "'", " ")
        m_banco = Replace(m_banco, ",", " ")
        m_agencia = Replace(txt_Agencia_alt.Text, "'", " ")
        m_agencia = Replace(m_agencia, ",", " ")
        m_conta = Replace(txt_Conta_alt.Text, "'", " ")
        m_conta = Replace(m_conta, ",", " ")
        m_tipo_conta = ddl_TipoConta_alt.SelectedValue

        m_senha = Replace(txt_Senha.Text, "'", " ")
        m_senha = Replace(m_senha, ",", " ")
        m_repete_senha = txt_Confirma_Senha.Text

        m_email_doc = rbl_email.SelectedValue
        m_desabilita = rbl_desativado.SelectedValue

        If IsDate(txt_Data_Desativacao.Text) Then
            m_data_desabilita = Year(txt_Data_Desativacao.Text)
            If Month(txt_Data_Desativacao.Text) <= 9 Then
                m_data_desabilita = m_data_desabilita & "/0" & Month(txt_Data_Desativacao.Text)
            Else
                m_data_desabilita = m_data_desabilita & "/" & Month(txt_Data_Desativacao.Text)
            End If
            If Day(txt_Data_Desativacao.Text) <= 9 Then
                m_data_desabilita = m_data_desabilita & "/0" & Day(txt_Data_Desativacao.Text)
            Else
                m_data_desabilita = m_data_desabilita & "/" & Day(txt_Data_Desativacao.Text)
            End If
        End If
        m_motivo = txt_Motivo_Desativacao.Text

        'm_tipoempresa_1 = m_tipoempresa
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

        If txt_Senha.Text <> txt_Confirma_Senha.Text Then
            lbl_mensagem_1.Text = "CONFIRA A SENHA !!! "
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
            m_erro = 1

        End If

        If m_cnpj <> "" And m_erro = 0 Then 'And ddl_Categoria.SelectedValue <> 0 And ddl_Servico.SelectedValue <> 0 Then
            Try
                'abrindo conexao
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                'inserir dados
                strexec = "UPDATE cad_prestador SET "
                strexec = strexec & "cad_prestador.Pre_Razao_Social='" & m_razao & "',"
                strexec = strexec & "cad_prestador.Pre_Nome_Fantasia='" & m_fantasia & "',"
                strexec = strexec & "cad_prestador.Pre_IEstadual='" & m_iestadual & "',"
                strexec = strexec & "cad_prestador.Pre_IMunicipal='" & m_imunicipal & "',"
                strexec = strexec & "cad_prestador.Pre_IMunicipal_Municipio='" & m_imcidade & "',"
                strexec = strexec & "cad_prestador.Pre_IMunicipal_UF='" & m_imuf & "',"
                strexec = strexec & "cad_prestador.Pre_CNAE_Codigo='" & m_cnae_cod & "',"
                strexec = strexec & "cad_prestador.Pre_CNAE_Descricao='" & m_cnae_desc & "',"
                strexec = strexec & "cad_prestador.Pre_Representante='" & m_representante & "',"
                strexec = strexec & "cad_prestador.Pre_Representante_Cargo='" & m_representante_cargo & "',"
                strexec = strexec & "cad_prestador.Pre_Representante_Estado_Civil='" & m_representante_estado_civil & "',"
                strexec = strexec & "cad_prestador.Pre_Representante_Profissao='" & m_representante_profissao & "',"
                strexec = strexec & "cad_prestador.Pre_Representante_Email='" & m_representante_email & "',"
                strexec = strexec & "cad_prestador.Pre_Representante_CPF='" & m_cpf_representante & "',"
                strexec = strexec & "cad_prestador.Pre_Representante_RG='" & m_rg_representante & "',"
                strexec = strexec & "cad_prestador.Pre_Nacionalidade='" & m_nacionalidade & "',"
                strexec = strexec & "cad_prestador.Pre_PIS_PASEP='" & m_pispasep & "',"
                strexec = strexec & "cad_prestador.Pre_NIT='" & m_nit & "',"
                strexec = strexec & "cad_prestador.Pre_Endereco='" & m_endereco & "',"
                strexec = strexec & "cad_prestador.Pre_Complemento='" & m_complemento & "',"
                strexec = strexec & "cad_prestador.Pre_Bairro='" & m_bairro & "',"
                strexec = strexec & "cad_prestador.Pre_CEP='" & m_cep & "',"
                strexec = strexec & "cad_prestador.Pre_Municipio='" & m_cidade & "',"
                strexec = strexec & "cad_prestador.Pre_UF='" & m_uf & "',"
                strexec = strexec & "cad_prestador.Pre_Telefone='" & m_telefone & "',"
                strexec = strexec & "cad_prestador.Pre_Telefone_1='" & m_telefone_1 & "',"
                strexec = strexec & "cad_prestador.Pre_Celular='" & m_celular & "',"
                strexec = strexec & "cad_prestador.Pre_WhatsApp='" & m_whatszap & "',"
                strexec = strexec & "cad_prestador.Pre_Email='" & m_email & "',"
                strexec = strexec & "cad_prestador.Pre_Email_1='" & m_email_1 & "',"
                strexec = strexec & "cad_prestador.Pre_Site='" & m_site & "',"
                strexec = strexec & "cad_prestador.Pre_Pessoa_Contato='" & m_pessoa_contato & "',"
                strexec = strexec & "cad_prestador.Pre_Banco_Codigo='" & m_banco & "',"
                strexec = strexec & "cad_prestador.Pre_Banco_Agencia='" & m_agencia & "',"
                strexec = strexec & "cad_prestador.Pre_Banco_Conta='" & m_conta & "',"
                strexec = strexec & "cad_prestador.Pre_Banco_Tipo='" & m_tipo_conta & "',"
                strexec = strexec & "cad_prestador.Pre_Senha='" & m_senha & "', "
                strexec = strexec & "cad_prestador.Pre_Email_AlertaDocto='" & m_email_doc & "', "
                strexec = strexec & "cad_prestador.Pre_Desativado='" & m_desabilita & "', "
                If m_data_desabilita <> "" Then
                    strexec = strexec & "cad_prestador.Pre_Data_Desativado='" & m_data_desabilita & "', "
                End If
                strexec = strexec & "cad_prestador.Pre_Motivo_Desativado='" & m_motivo & "', "
                strexec = strexec & "cad_prestador.Pre_TipoEmpresa='" & m_categoria & "', "
                strexec = strexec & "cad_prestador.Pre_TipoPrestador='" & m_servico & "', "
                'strexec = strexec & "cad_prestador.Pre_Participa_Licitacao='" & "" & "', "
                strexec = strexec & "cad_prestador.Pre_Data_Alteracao='" & m_data & "' "
                strexec = strexec & "WHERE cad_prestador.Pre_ID=" & CodPrestador & ""

                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.Connection.Open()
                objCmd.ExecuteNonQuery()

                strexec = "DELETE cad_prestadorxdocumento FROM cad_prestadorxdocumento "
                strexec = strexec & "WHERE "
                strexec = strexec & "cad_prestadorxdocumento.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                ' transferindo dados 

                strexec = "INSERT INTO cad_prestadorxdocumento(Pre_ID,Pre_CNPJ,Doc_ID,"
                strexec = strexec & "Doc_Descricao,PrexDoc_Emissao,PrexDoc_Validade,PrexDoc_Nome,PrexDoc_Observacao,PrexDoc_Situacao,PrexDoc_Data_Alteracao) "
                strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',tmp_prestadorxdocumento.Doc_ID,tmp_prestadorxdocumento.Doc_Descricao,tmp_prestadorxdocumento.PrexDoc_Emissao,tmp_prestadorxdocumento.PrexDoc_Validade,"
                strexec = strexec & "tmp_prestadorxdocumento.PrexDoc_Nome,tmp_prestadorxdocumento.PrexDoc_Observacao,tmp_prestadorxdocumento.PrexDoc_Situacao,tmp_prestadorxdocumento.PrexDoc_Data_Alteracao "
                strexec = strexec & "FROM tmp_prestadorxdocumento "
                strexec = strexec & "WHERE "
                strexec = strexec & "tmp_prestadorxdocumento.Pre_CNPJ= '" & txt_CNPJ.Text & "'"

                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                strexec = "DELETE cad_prestadorxsermat FROM cad_prestadorxsermat "
                strexec = strexec & "WHERE "
                strexec = strexec & "cad_prestadorxsermat.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                ' transferindo dados 

                strexec = "INSERT INTO cad_prestadorxsermat(Pre_ID,Pre_CNPJ,SM_ID,SM_Descricao,SM_Material,SM_Servico) "
                strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',tmp_prestadorxsermat.SM_ID,tmp_prestadorxsermat.SM_Descricao,tmp_prestadorxsermat.SM_Material,tmp_prestadorxsermat.SM_Servico "
                strexec = strexec & "FROM tmp_prestadorxsermat "
                strexec = strexec & "WHERE "
                strexec = strexec & "tmp_prestadorxsermat.Pre_CNPJ= '" & txt_CNPJ.Text & "' and tmp_prestadorxsermat.SM_Selecao=1"

                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                strexec = "DELETE cad_prestadorxprestador FROM cad_prestadorxprestador "
                strexec = strexec & "WHERE "
                strexec = strexec & "cad_prestadorxprestador.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                ' transferindo dados 

                strexec = "INSERT INTO cad_prestadorxprestador(Pre_ID,Pre_CNPJ,PrexPre_Nome,PrexPre_RG,PrexPre_CPF,PrexPre_Nacionalidade, "
                strexec = strexec & "PrexPre_Estado_Civil,PrexPre_Profissao,PrexPre_Endereco,PrexPre_Numero,PrexPre_Complemento,PrexPre_Bairro, "
                strexec = strexec & "PrexPre_CEP,PrexPre_Municipio,PrexPre_UF,PrexPre_Telefone,PrexPre_Celular,PrexPre_Email,PrexPre_Servicos, "
                strexec = strexec & "PrexPre_Doc_1,PrexPre_Doc_2,PrexPre_Doc_3,PrexPre_Doc_4) "
                strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',tmp_prestadorxprestador.PrexPre_Nome,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_RG,tmp_prestadorxprestador.PrexPre_CPF,tmp_prestadorxprestador.PrexPre_Nacionalidade,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Estado_Civil,tmp_prestadorxprestador.PrexPre_Profissao,tmp_prestadorxprestador.PrexPre_Endereco,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Numero,tmp_prestadorxprestador.PrexPre_Complemento,tmp_prestadorxprestador.PrexPre_Bairro,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_CEP,tmp_prestadorxprestador.PrexPre_Municipio,tmp_prestadorxprestador.PrexPre_UF,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Telefone,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Celular,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Email,"
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Servicos, "
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Doc_1, "
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Doc_2, "
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Doc_3, "
                strexec = strexec & "tmp_prestadorxprestador.PrexPre_Doc_4 "
                strexec = strexec & "FROM tmp_prestadorxprestador "
                strexec = strexec & "WHERE "
                strexec = strexec & "tmp_prestadorxprestador.Pre_CNPJ= '" & txt_CNPJ.Text & "'"

                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()


                'dar mensagem

                'fechar
                objCmd.Connection.Close()
                objConn.Close()
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao_Documento.Visible = "false"
                btn_Confirma_Exclusao_Prestador.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_Alteracao.Show()
            End Try

        Else
            'dar mensagem
            'lblConfirm.Text = ""
            'lbl_Confirmar.Text = "Informe o Trabalho Oferecido e Sua Categoria !!!"
        End If

    End Sub


    Private Sub Exclui_Documento()
        Try
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            If txt_prexdoc_registro.Text <> "" And txt_prexdoc_registro.Text <> "0" Then
                strexec = "DELETE tmp_prestadorxdocumento FROM tmp_prestadorxdocumento "
                strexec = strexec & "WHERE tmp_prestadorxdocumento.PrexDoc_Id = " & txt_prexdoc_registro.Text & " and "
                strexec = strexec & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            End If

            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()

            'montando a string--------------------------------------------------------
            strreader = "select tmp_prestadorxdocumento.PrexDoc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Modelo, "
            strreader = strreader & "cad_documento.Doc_Obrigatorio, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Emissao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Validade, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Nome, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Observacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Situacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Informacoes, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Obrigatorio "
            strreader = strreader & "FROM tmp_prestadorxdocumento,cad_documento "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id=cad_documento.Doc_ID and "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            strreader = strreader & "order by cad_documento.Doc_Obrigatorio,cad_documento.Doc_Descricao,tmp_prestadorxdocumento.Doc_Id "

            SqlPrexDoc.SelectCommand = strreader
            GridView1.DataBind()

            txt_prexdoc_registro.Text = ""
            txt_prexdoc_emissao.Text = ""
            txt_prexdoc_validade.Text = ""
            txt_prexdoc_doc.Text = ""
            txt_prexdoc_obs.Text = ""

            lbl_mensagem_1.Text = ""

            strreader = "SELECT cad_documento.Doc_ID,cad_documento.Doc_Descricao,"
            strreader = strreader & "cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio "
            strreader = strreader & "FROM cad_documento "
            strreader = strreader & "WHERE cad_documento.Doc_ID>0 "

            If ddl_Servico.SelectedValue = 1 Then
                strreader = strreader & "and cad_documento.Doc_Prestador=1 "
            End If
            If ddl_Servico.SelectedValue = 2 Then
                strreader = strreader & "and cad_documento.Doc_Fornecedor=1 "
            End If

            If lbl_TipoEmpresa_cod.Text = "1" Then
                strreader = strreader & "and cad_documento.Doc_AC=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "2" Then
                strreader = strreader & "and cad_documento.Doc_EPP=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "3" Then
                strreader = strreader & "and cad_documento.Doc_EI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "4" Then
                strreader = strreader & "and cad_documento.Doc_LTDA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "5" Then
                strreader = strreader & "and cad_documento.Doc_EIRELI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "6" Then
                strreader = strreader & "and cad_documento.Doc_MEI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "7" Then
                strreader = strreader & "and cad_documento.Doc_ME=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "8" Then
                strreader = strreader & "and cad_documento.Doc_SA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "9" Then
                strreader = strreader & "and cad_documento.Doc_SS=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "10" Then
                strreader = strreader & "and cad_documento.Doc_PFisica=1 "
            End If

            SqlDocumento.SelectCommand = strreader

            ddlDocumento.ClearSelection()
            ddlDocumento.DataBind()

            'fechar
            objConn.Close()
            objConn = Nothing

            Grava_Prestador_Alteracao()

            btn_Excluir_Documento_alt.Visible = False
            lbl_mensagem_1.Text = "REGISTRO EXCLUIDO COM SUCESSO !!!"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try

    End Sub


    Protected Sub btn_Confirma_Exclusao_Documento_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Confirma_Exclusao_Documento.Click
        Try
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            If txt_prexdoc_registro.Text <> "" And txt_prexdoc_registro.Text <> "0" Then
                strexec = "DELETE tmp_prestadorxdocumento FROM tmp_prestadorxdocumento "
                strexec = strexec & "WHERE tmp_prestadorxdocumento.PrexDoc_Id = " & txt_prexdoc_registro.Text & " and "
                strexec = strexec & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            End If

            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()

            'montando a string--------------------------------------------------------
            strreader = "select tmp_prestadorxdocumento.PrexDoc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Descricao, "
            strreader = strreader & "cad_documento.Doc_Modelo, "
            strreader = strreader & "cad_documento.Doc_Obrigatorio, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Emissao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Validade, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Nome, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Observacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Situacao, "
            strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Informacoes, "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Obrigatorio "
            strreader = strreader & "FROM tmp_prestadorxdocumento,cad_documento "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxdocumento.Doc_Id=cad_documento.Doc_ID and "
            strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            strreader = strreader & "order by cad_documento.Doc_Obrigatorio,cad_documento.Doc_Descricao,tmp_prestadorxdocumento.Doc_Id "

            SqlPrexDoc.SelectCommand = strreader
            GridView1.DataBind()

            txt_prexdoc_registro.Text = ""
            txt_prexdoc_emissao.Text = ""
            txt_prexdoc_validade.Text = ""
            txt_prexdoc_doc.Text = ""
            txt_prexdoc_obs.Text = ""

            lbl_mensagem_1.Text = ""

            strreader = "SELECT cad_documento.Doc_ID,cad_documento.Doc_Descricao,"
            strreader = strreader & "cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio "
            strreader = strreader & "FROM cad_documento "
            strreader = strreader & "WHERE cad_documento.Doc_ID>0 "

            If ddl_Servico.SelectedValue = 1 Then
                strreader = strreader & "and cad_documento.Doc_Prestador=1 "
            End If
            If ddl_Servico.SelectedValue = 2 Then
                strreader = strreader & "and cad_documento.Doc_Fornecedor=1 "
            End If

            If lbl_TipoEmpresa_cod.Text = "1" Then
                strreader = strreader & "and cad_documento.Doc_AC=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "2" Then
                strreader = strreader & "and cad_documento.Doc_EPP=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "3" Then
                strreader = strreader & "and cad_documento.Doc_EI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "4" Then
                strreader = strreader & "and cad_documento.Doc_LTDA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "5" Then
                strreader = strreader & "and cad_documento.Doc_EIRELI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "6" Then
                strreader = strreader & "and cad_documento.Doc_MEI=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "7" Then
                strreader = strreader & "and cad_documento.Doc_ME=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "8" Then
                strreader = strreader & "and cad_documento.Doc_SA=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "9" Then
                strreader = strreader & "and cad_documento.Doc_SS=1 "
            End If
            If lbl_TipoEmpresa_cod.Text = "10" Then
                strreader = strreader & "and cad_documento.Doc_PFisica=1 "
            End If

            SqlDocumento.SelectCommand = strreader

            ddlDocumento.ClearSelection()
            ddlDocumento.DataBind()

            'fechar
            objConn.Close()
            objConn = Nothing

            btn_Excluir_Documento_alt.Visible = False

            Grava_Prestador_Alteracao()

            lbl_mensagem_1.Text = "REGISTRO EXCLUIDO COM SUCESSO !!!"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub

    Protected Sub lnk_Inclui_Documento_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Inclui_Documento.Click
        pnl_documento_detalhe.Visible = "true"

        Dim mregistro As Integer

        mregistro = 0
        txt_prexdoc_registro.Text = ""

        txt_prexdoc_emissao.Text = ""
        txt_prexdoc_validade.Text = ""
        txt_prexdoc_nome.Text = ""
        txt_prexdoc_doc.Text = ""
        txt_prexdoc_obs.Text = ""
        lbl_data_upload.Text = ""


        lbl_mensagem_1.Text = ""

    End Sub
    Protected Sub img_btn_Fechar_Mensagem_click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_Fechar_Mensagem.Click
        MPE_Alteracao.Hide()
    End Sub

    Protected Sub lnk_Menu_Inicial_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Inicial.Click
        Response.Redirect("Login_Cadastro.aspx")
        Response.End()
    End Sub
    Protected Sub lnk_Menu_Anterior_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Anterior.Click
        Response.Redirect("Pesquisa_Prestador.aspx")
        Response.End()
    End Sub

    Protected Sub lnk_inclui_prestador_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_inclui_prestador.Click
        pnl_prestador_detalhe.Visible = "true"
    End Sub

    Protected Sub lnk_auto_inclusao_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_auto_inclusao.Click

        txt_Prestador_Nome.Text = Replace(txt_Representante.Text, ",", " ")
        txt_Prestador_Nome.Text = Replace(txt_Prestador_Nome.Text, "'", " ")
        txt_Prestador_RG.Text = Replace(txt_RG.Text, ",", " ")
        txt_Prestador_RG.Text = Replace(txt_Prestador_RG.Text, "'", " ")
        txt_Prestador_CPF.Text = Replace(txt_CPF.Text, ",", " ")
        txt_Prestador_CPF.Text = Replace(txt_Prestador_CPF.Text, "'", " ")
        txt_Prestador_Nacionalidade.Text = Replace(txt_Nacionalidade.Text, ",", " ")
        txt_Prestador_Nacionalidade.Text = Replace(txt_Prestador_Nacionalidade.Text, "'", " ")
        txt_Prestador_Profissao.Text = Replace(txt_Representante_Profissao.Text, ",", " ")
        txt_Prestador_Profissao.Text = Replace(txt_Prestador_Profissao.Text, "'", " ")
        txt_Prestador_Endereco.Text = Replace(txt_Endereco.Text, ",", " ")
        txt_Prestador_Endereco.Text = Replace(txt_Prestador_Endereco.Text, "'", " ")
        txt_Prestador_Numero.Text = Replace(txt_Numero.Text, ",", " ")
        txt_Prestador_Numero.Text = Replace(txt_Prestador_Numero.Text, "'", " ")
        txt_Prestador_Complemento.Text = Replace(txt_Complemento.Text, ",", " ")
        txt_Prestador_Complemento.Text = Replace(txt_Prestador_Complemento.Text, "'", " ")
        txt_Prestador_Bairro.Text = Replace(txt_Bairro.Text, ",", " ")
        txt_Prestador_Bairro.Text = Replace(txt_Prestador_Bairro.Text, "'", " ")
        txt_Prestador_CEP.Text = Replace(txt_CEP.Text, ",", " ")
        txt_Prestador_CEP.Text = Replace(txt_Prestador_CEP.Text, "'", " ")
        txt_Prestador_Municipio.Text = Replace(txt_Cidade.Text, ",", " ")
        txt_Prestador_Municipio.Text = Replace(txt_Prestador_Municipio.Text, "'", " ")
        txt_Prestador_Telefone.Text = Replace(txt_Telefone.Text, ",", " ")
        txt_Prestador_Telefone.Text = Replace(txt_Prestador_Telefone.Text, "'", " ")
        txt_Prestador_Celular.Text = Replace(txt_Celular.Text, ",", " ")
        txt_Prestador_Celular.Text = Replace(txt_Prestador_Celular.Text, "'", " ")
        txt_Prestador_Email.Text = Replace(txt_Email.Text, ",", " ")
        txt_Prestador_Email.Text = Replace(txt_Prestador_Email.Text, "'", " ")
        txt_Prestador_Servico.Text = Replace(txt_Representante_Cargo.Text, ",", " ")
        txt_Prestador_Servico.Text = Replace(txt_Prestador_Servico.Text, "'", " ")
        If LTrim(ddl_Representante_EstadoCivil.SelectedValue) <> "Selecione" Then
            ddl_Prestador_EstadoCivil.SelectedValue = ddl_Representante_EstadoCivil.SelectedValue
        End If
        ddl_Prestador_UF.SelectedValue = ddl_UF.SelectedValue
        pnl_prestador_detalhe.Visible = "true"
    End Sub

    Protected Sub btn_Salvar_Documento_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Salvar_Documento.Click
        'abrindo conexao
        Dim m_doc_descricao, m_cnpj, m_info, m_data As String
        Dim m_dias_validade, mdiferenca, m_obrigatorio, m_qtde_permitida, m_doc_ID, mdata_ok As Integer
        Dim mdata_emissao, mdata_validade As Date
        Dim m_grava_ok, m_upload_ok, m_desc_docto, m_extensao, m_arq As String
        Dim m_tamanho, m_permitido As Double

        Dim m_erro As Integer

        m_erro = 0

        m_permitido = 800

        Dim dtTextBox As DateTime
        Dim dtAtual As DateTime = DateTime.Now.Date

        m_grava_ok = "S"
        m_desc_docto = ddlDocumento.SelectedItem.Text
        If txt_prexdoc_emissao.Text = "" Then
            m_grava_ok = "N"
        End If
        If txt_prexdoc_emissao.Text <> "" And Not IsDate(txt_prexdoc_emissao.Text) Then
            m_grava_ok = "N"
        End If
        If txt_prexdoc_validade.Text <> "" And Not IsDate(txt_prexdoc_validade.Text) Then
            m_grava_ok = "N"
        End If
        If m_desc_docto = " Selecione o tipo de documento" Then
            m_grava_ok = "N"
            'lbl_erro_documento.Text = m_desc_docto & " " & m_grava_ok & "xxxxx"
        End If
        'lbl_erro_documento.Text = m_desc_docto & " - " & m_grava_ok

        If m_grava_ok <> "S" Then
            lbl_mensagem_1.Text = "Preencha os dados do documento corretamente !!!"
            m_erro = 1
        Else

            lbl_mensagem_1.Text = ""

            If IsDate(txt_prexdoc_validade.Text) Then
                dtTextBox = DateTime.Parse(txt_prexdoc_validade.Text)
            End If
            Try
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
                'excluir caso ja exista
                If txt_prexdoc_registro.Text = "" Then
                    txt_prexdoc_registro.Text = "0"
                End If

                strreader = "select cad_documento.Doc_Descricao,cad_documento.Doc_Validade,cad_documento.Doc_Obrigatorio,cad_documento.Doc_Onde_Obter,cad_documento.Doc_Qtde_Permitida,cad_documento.Doc_ID "
                strreader = strreader & "FROM cad_documento "
                strreader = strreader & "WHERE "
                strreader = strreader & "cad_documento.Doc_Id = " & ddlDocumento.SelectedValue & ""
                'configurando datareader

                objCmd = New MySqlCommand(strreader, objConn)
                objCmd.Connection.Open()
                dr = objCmd.ExecuteReader()

                m_doc_descricao = ""
                m_dias_validade = 0
                m_obrigatorio = 0
                m_qtde_permitida = 0
                m_doc_ID = 0
                m_info = ""
                If dr.Read() Then
                    If Not IsDBNull(dr(0)) Then
                        m_doc_descricao = (dr(0))
                    End If
                    If Not IsDBNull(dr(1)) Then
                        m_dias_validade = (dr(1))
                    End If
                    If Not IsDBNull(dr(2)) Then
                        m_obrigatorio = (dr(2))
                    End If
                    If Not IsDBNull(dr(3)) Then
                        m_info = (dr(3))
                    End If
                    If Not IsDBNull(dr(4)) Then
                        m_qtde_permitida = (dr(4))
                    End If
                    If Not IsDBNull(dr(5)) Then
                        m_doc_ID = (dr(5))
                    End If
                End If
                'fechar
                dr.Close()
                dr = Nothing
                objCmd.Connection.Close()

                mdata_ok = 0

                If IsDate(txt_prexdoc_emissao.Text) And IsDate(txt_prexdoc_validade.Text) Then
                    mdata_emissao = txt_prexdoc_emissao.Text
                    mdata_validade = txt_prexdoc_validade.Text
                    mdiferenca = DateDiff("d", mdata_emissao, mdata_validade)
                    If mdiferenca < 0 Then
                        mdata_ok = 1
                    End If
                End If

                If mdata_ok = 1 Then ' alterado em 11092015 ... provisoriamente ... mdiferenca <> m_dias_validade And m_dias_validade > 0 Then
                    lbl_mensagem_1.Text = lbl_mensagem_1.Text & " Data de Validade deve ser maior que a Data de Emissão !!!"
                    m_erro = 1
                Else
                    'UPLOAD

                    m_cnpj = txt_CNPJ.Text
                    m_cnpj = Replace(m_cnpj, ".", "")
                    m_cnpj = Replace(m_cnpj, "/", "")
                    m_cnpj = Replace(m_cnpj, "-", "")

                    sImgFile = ""
                    m_extensao = ""
                    m_upload_ok = "S"
                    If PrexDoc_Nome.FileName <> "" Then
                        m_tamanho = Convert.ToDouble(PrexDoc_Nome.PostedFile.ContentLength) / 1024
                        m_arq = PrexDoc_Nome.FileName
                        m_extensao = m_arq.Substring(m_arq.Length - 4).ToLower()
                        sPath = Server.MapPath("~/upload/") 'caminho onde vai ser salva a imagem
                        sFileName = m_cnpj & "_" & PrexDoc_Nome.FileName
                        sImgFile = sPath & sFileName
                        PrexDoc_Nome.SaveAs(sImgFile)
                        sImgFile = "~\\upload\\" & sFileName

                        If (m_tamanho > m_permitido) Then
                            m_upload_ok = "N"
                            lbl_mensagem_1.Text = lbl_mensagem_1.Text & " Tamanho Máximo permitido é de " & m_permitido & " kb !" & Chr(13)
                            m_erro = 1
                        End If

                        If ((m_extensao <> ".pdf")) Then
                            m_upload_ok = "N"
                            lbl_mensagem_1.Text = lbl_mensagem_1.Text & Chr(13) & "Extensão inválida, só é permitido .pdf ! " & Chr(13)
                            m_erro = 1
                        End If

                    End If

                    If m_obrigatorio = 1 And PrexDoc_Nome.FileName = "" And txt_prexdoc_doc.Text = "" Then
                        m_upload_ok = "N"
                        lbl_mensagem_1.Text = lbl_mensagem_1.Text & Chr(13) & "É obrigatório fazer o Upload do documento !!!"
                        m_erro = 1
                    End If

                    If m_upload_ok = "N" Then
                        'txt_erro_documento.Text = "ATENÇÃO !!! É obrigatório fazer o Upload do documento !!!"
                    Else

                        'txtCalendario_ATA.Text = "Documentos\" & FU_ATA.FileName
                        If txt_prexdoc_registro.Text <> "" And txt_prexdoc_registro.Text <> "0" Then
                            strexec = "DELETE tmp_prestadorxdocumento FROM tmp_prestadorxdocumento "
                            strexec = strexec & "WHERE tmp_prestadorxdocumento.PrexDoc_Id = " & txt_prexdoc_registro.Text & " and "
                            strexec = strexec & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
                        Else
                            strexec = "DELETE tmp_prestadorxdocumento FROM tmp_prestadorxdocumento,cad_documento "
                            strexec = strexec & "WHERE tmp_prestadorxdocumento.Doc_ID=cad_documento.Doc_ID and "
                            strexec = strexec & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' and "
                            strexec = strexec & "(cad_documento.Doc_Qtde_Permitida = 0 and tmp_prestadorxdocumento.Doc_Id = " & m_doc_ID & ") "
                        End If
                        objCmd = New MySqlCommand(strexec, objConn)
                        objCmd.Connection.Open()
                        objCmd.ExecuteNonQuery()

                        'lbl_TipoPrestador.Text = strexec

                        If PrexDoc_Nome.FileName <> "" Then
                            txt_prexdoc_nome.Text = sImgFile
                        Else
                            txt_prexdoc_nome.Text = txt_prexdoc_doc.Text
                            txt_prexdoc_nome.Text = Replace(txt_prexdoc_nome.Text, "\", "\\")
                        End If
                        'txt_prexdoc_nome.Text = sImgFile

                        strexec = "INSERT INTO tmp_prestadorxdocumento("
                        strexec = strexec & "Pre_Id, "
                        strexec = strexec & "Pre_CNPJ, "
                        strexec = strexec & "Doc_Id, "
                        strexec = strexec & "Doc_Descricao, "
                        If IsDate(txt_prexdoc_emissao.Text) Then
                            strexec = strexec & "PrexDoc_Emissao, "
                        End If
                        If IsDate(txt_prexdoc_validade.Text) Then
                            strexec = strexec & "PrexDoc_Validade, "
                        End If
                        'If txt_prexdoc_nome.Text <> txt_prexdoc_doc.Text And txt_prexdoc_nome.Text <> "" Then
                        ' strexec = strexec & "PrexDoc_Nome, "
                        'End If
                        strexec = strexec & "PrexDoc_Nome, "
                        strexec = strexec & "PrexDoc_Observacao, "
                        strexec = strexec & "PrexDoc_Situacao,PrexDoc_Informacoes,Doc_Obrigatorio,PrexDoc_Data_Alteracao) "
                        strexec = strexec & "VALUES(" & CodPrestador & ",'" & txt_CNPJ.Text & "'," & ddlDocumento.SelectedValue & ","
                        strexec = strexec & "'" & Replace(m_doc_descricao, ",", " ") & "',"
                        If IsDate(txt_prexdoc_emissao.Text) Then
                            m_data = Mid(txt_prexdoc_emissao.Text, 7, 4) & "/" & Mid(txt_prexdoc_emissao.Text, 4, 2) & "/" & Mid(txt_prexdoc_emissao.Text, 1, 2)
                            strexec = strexec & "'" & m_data & "" & "',"
                        End If
                        If IsDate(txt_prexdoc_validade.Text) Then
                            m_data = Mid(txt_prexdoc_validade.Text, 7, 4) & "/" & Mid(txt_prexdoc_validade.Text, 4, 2) & "/" & Mid(txt_prexdoc_validade.Text, 1, 2)

                            strexec = strexec & "'" & m_data & "" & "',"
                        End If
                        'If txt_prexdoc_nome.Text <> txt_prexdoc_doc.Text And txt_prexdoc_nome.Text <> "" Then
                        'End If
                        strexec = strexec & "'" & Replace(txt_prexdoc_nome.Text, ",", " ") & "',"
                        strexec = strexec & "'" & Replace(txt_prexdoc_obs.Text, ",", " ") & "',"
                        If m_obrigatorio = 1 Then
                            If dtTextBox < dtAtual And m_dias_validade > 0 Then
                                strexec = strexec & "'" & "Pendente" & "'"
                            Else
                                strexec = strexec & "'" & "Vigente" & "'"
                            End If
                        Else
                            strexec = strexec & "'" & "Opcional" & "'"
                        End If
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
                        strexec = strexec & ",'" & Replace(m_info, ",", " ") & "'," & m_obrigatorio & ",'" & m_data & "')"

                        objCmd = New MySqlCommand(strexec, objConn)

                        objCmd.ExecuteNonQuery()
                        objCmd.Connection.Close()

                        'montando a string--------------------------------------------------------
                        strreader = "select tmp_prestadorxdocumento.PrexDoc_Id, "
                        strreader = strreader & "tmp_prestadorxdocumento.Pre_Id, "
                        strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ, "
                        strreader = strreader & "tmp_prestadorxdocumento.Doc_Id, "
                        strreader = strreader & "tmp_prestadorxdocumento.Doc_Descricao, "
                        strreader = strreader & "cad_documento.Doc_Descricao, "
                        strreader = strreader & "cad_documento.Doc_Modelo, "
                        strreader = strreader & "cad_documento.Doc_Obrigatorio, "
                        strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Emissao, "
                        strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Validade, "
                        strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Nome, "
                        strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Observacao, "
                        strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Situacao, "
                        strreader = strreader & "tmp_prestadorxdocumento.PrexDoc_Informacoes, "
                        strreader = strreader & "tmp_prestadorxdocumento.Doc_Obrigatorio "
                        strreader = strreader & "FROM tmp_prestadorxdocumento,cad_documento "
                        strreader = strreader & "WHERE "
                        strreader = strreader & "tmp_prestadorxdocumento.Doc_Id=cad_documento.Doc_ID and "
                        strreader = strreader & "tmp_prestadorxdocumento.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
                        strreader = strreader & "order by cad_documento.Doc_Obrigatorio,cad_documento.Doc_Descricao,tmp_prestadorxdocumento.Doc_Id "

                        SqlPrexDoc.SelectCommand = strreader
                        GridView1.DataBind()

                        txt_prexdoc_registro.Text = ""
                        txt_prexdoc_emissao.Text = ""
                        txt_prexdoc_validade.Text = ""
                        txt_prexdoc_doc.Text = ""
                        txt_prexdoc_obs.Text = ""

                        lbl_mensagem_1.Text = ""

                        'strreader = "SELECT Doc_ID, Doc_Descricao, Doc_Validade, Doc_Onde_Obter, Doc_Prestador, Doc_Fornecedor, Doc_Situacao FROM cad_documento WHERE (Doc_Prestador = 1) order by  Doc_Descricao"
                        'SqlDocumento.SelectCommand = strreader
                        'SqlDocumento.DataBind()

                        strreader = "SELECT cad_documento.Doc_ID,cad_documento.Doc_Descricao,"
                        strreader = strreader & "cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio "
                        strreader = strreader & "FROM cad_documento "
                        strreader = strreader & "WHERE cad_documento.Doc_ID>0 "
                        If ddl_Servico.SelectedValue = 1 Then
                            strreader = strreader & "and cad_documento.Doc_Prestador=1 "
                        End If
                        If ddl_Servico.SelectedValue = 2 Then
                            strreader = strreader & "and cad_documento.Doc_Fornecedor=1 "
                        End If
                        If lbl_TipoEmpresa_cod.Text = "1" Then
                            strreader = strreader & "and cad_documento.Doc_AC=1 "
                        End If
                        If lbl_TipoEmpresa_cod.Text = "2" Then
                            strreader = strreader & "and cad_documento.Doc_EPP=1 "
                        End If
                        If lbl_TipoEmpresa_cod.Text = "3" Then
                            strreader = strreader & "and cad_documento.Doc_EI=1 "
                        End If
                        If lbl_TipoEmpresa_cod.Text = "4" Then
                            strreader = strreader & "and cad_documento.Doc_LTDA=1 "
                        End If
                        If lbl_TipoEmpresa_cod.Text = "5" Then
                            strreader = strreader & "and cad_documento.Doc_EIRELI=1 "
                        End If
                        If lbl_TipoEmpresa_cod.Text = "6" Then
                            strreader = strreader & "and cad_documento.Doc_MEI=1 "
                        End If
                        If lbl_TipoEmpresa_cod.Text = "7" Then
                            strreader = strreader & "and cad_documento.Doc_ME=1 "
                        End If
                        If lbl_TipoEmpresa_cod.Text = "8" Then
                            strreader = strreader & "and cad_documento.Doc_SA=1 "
                        End If
                        If lbl_TipoEmpresa_cod.Text = "9" Then
                            strreader = strreader & "and cad_documento.Doc_SS=1 "
                        End If
                        If lbl_TipoEmpresa_cod.Text = "10" Then
                            strreader = strreader & "and cad_documento.Doc_PFisica=1 "
                        End If

                        strreader = strreader & "order by cad_documento.Doc_Descricao "
                        SqlDocumento.SelectCommand = strreader

                        ddlDocumento.ClearSelection()
                        ddlDocumento.DataBind()

                        Grava_Prestador_Alteracao()

                        lbl_mensagem_1.Text = "REGISTRO GRAVADO COM SUCESSO !!! "
                        lbl_mensagem_2.Text = ""
                        img_btn_Fechar_Mensagem.Visible = "true"
                        img_btn_sair_Mensagem.Visible = "false"
                        btn_Confirma_Exclusao_Documento.Visible = "false"
                        btn_Confirma_Exclusao_Prestador.Visible = "false"
                        btn_Nao_Confirma.Visible = "false"
                        MPE_Alteracao.Show()

                        pnl_documento_detalhe.Visible = "false"

                    End If

                End If

                'objCmd.Connection.Close()

                'fechar
                objConn.Close()
                objConn = Nothing
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao_Documento.Visible = "false"
                btn_Confirma_Exclusao_Prestador.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_Alteracao.Show()
            End Try
        End If
        If m_erro = 1 Then

            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End If

    End Sub

    Protected Sub btn_Fechar_Documento_alt_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Fechar_Documento_alt.Click
        pnl_documento_detalhe.Visible = "false"
    End Sub

    Protected Sub btn_Excluir_Documento_alt_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Excluir_Documento_alt.Click
        lbl_mensagem_1.Text = "SE CONFIRMAR A EXCLUSÃO, O REGISTRO SERÁ EXCLUIDO DEFINITIVAMENTE !!!"
        lbl_mensagem_2.Text = "CONFIRMA A EXCLUSÃO DO REGISTRO ?"
        img_btn_Fechar_Mensagem.Visible = "false"
        img_btn_sair_Mensagem.Visible = "false"
        btn_Confirma_Exclusao_Documento.Visible = "true"
        btn_Confirma_Exclusao_Prestador.Visible = "false"
        btn_Nao_Confirma.Visible = "true"
        MPE_Alteracao.Show()

    End Sub

    Protected Sub btn_Salvar_Prestador_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Salvar_Prestador.Click
        'abrindo conexao
        Dim m_extensao, m_arq, m_cnpj, m_cpf, m_upload_ok As String
        Dim m_tamanho As Integer
        'Dim m_pre_endereco, m_pre_numero, m_pre_complemento, m_pre_bairro, m_pre_cep, m_pre_municipio As String
        'Dim m_pre_uf, m_pre_servicos As String

        m_cnpj = txt_CNPJ.Text
        m_cnpj = Replace(m_cnpj, ".", "")
        m_cnpj = Replace(m_cnpj, "/", "")
        m_cnpj = Replace(m_cnpj, "-", "")

        m_cpf = txt_Prestador_CPF.Text
        m_cpf = Replace(m_cpf, ".", "")
        m_cpf = Replace(m_cpf, "/", "")
        m_cpf = Replace(m_cpf, "-", "")

        objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
        'excluir caso ja exista
        If txt_prexpre_registro.Text = "" Then
            txt_prexpre_registro.Text = "0"
        End If

        If txt_Prestador_Nome.Text = "" Or txt_Prestador_RG.Text = "" Or txt_Prestador_CPF.Text = "" Or txt_Prestador_Nacionalidade.Text = "" Or ddl_Prestador_EstadoCivil.SelectedValue = "" Or txt_Prestador_CEP.Text = "" Or txt_Prestador_Endereco.Text = "" Or txt_Prestador_Numero.Text = "" Or txt_Prestador_Bairro.Text = "" Or txt_Prestador_Municipio.Text = "" Or ddl_Prestador_UF.SelectedValue = "" Then
            lbl_mensagem_1.Text = "ATENÇÃO !!! Preencha os campos corretamente !!! "
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()

        Else

            sImgFile = ""
            m_extensao = ""
            m_upload_ok = "S"
            If PrexPre_Doc_1.FileName <> "" Then
                m_tamanho = Convert.ToDouble(PrexPre_Doc_1.PostedFile.ContentLength) / 1024
                m_arq = PrexPre_Doc_1.FileName
                m_extensao = m_arq.Substring(m_arq.Length - 4).ToLower()
                sPath = Server.MapPath("~/upload/") 'caminho onde vai ser salva a imagem
                sFileName = m_cnpj & "_" & m_cpf & "_" & PrexPre_Doc_1.FileName
                sImgFile = sPath & sFileName
                PrexPre_Doc_1.SaveAs(sImgFile)
                sImgFile = "~\\upload\\" & sFileName

                If (m_tamanho > 800) Or ((m_extensao <> ".pdf")) Then
                    m_upload_ok = "N"
                Else
                    txt_Prestador_Doc_1.Text = sImgFile
                End If

            End If

            If PrexPre_Doc_2.FileName <> "" Then
                m_tamanho = Convert.ToDouble(PrexPre_Doc_2.PostedFile.ContentLength) / 1024
                m_arq = PrexPre_Doc_2.FileName
                m_extensao = m_arq.Substring(m_arq.Length - 4).ToLower()
                sPath = Server.MapPath("~/upload/") 'caminho onde vai ser salva a imagem
                sFileName = m_cnpj & "_" & m_cpf & "_" & PrexPre_Doc_2.FileName
                sImgFile = sPath & sFileName
                PrexPre_Doc_2.SaveAs(sImgFile)
                sImgFile = "~\\upload\\" & sFileName

                If (m_tamanho > 800) Or ((m_extensao <> ".pdf")) Then
                    m_upload_ok = "N"
                Else
                    txt_Prestador_Doc_2.Text = sImgFile
                End If
            End If

            If PrexPre_Doc_3.FileName <> "" Then
                m_tamanho = Convert.ToDouble(PrexPre_Doc_3.PostedFile.ContentLength) / 1024
                m_arq = PrexPre_Doc_3.FileName
                m_extensao = m_arq.Substring(m_arq.Length - 4).ToLower()
                sPath = Server.MapPath("~/upload/") 'caminho onde vai ser salva a imagem
                sFileName = m_cnpj & "_" & m_cpf & "_" & PrexPre_Doc_3.FileName
                sImgFile = sPath & sFileName
                PrexPre_Doc_3.SaveAs(sImgFile)
                sImgFile = "~\\upload\\" & sFileName
                If (m_tamanho > 800) Or ((m_extensao <> ".pdf")) Then
                    m_upload_ok = "N"
                Else
                    txt_Prestador_Doc_3.Text = sImgFile
                End If
            End If
            If PrexPre_Doc_4.FileName <> "" Then
                m_tamanho = Convert.ToDouble(PrexPre_Doc_4.PostedFile.ContentLength) / 1024
                m_arq = PrexPre_Doc_4.FileName
                m_extensao = m_arq.Substring(m_arq.Length - 4).ToLower()
                sPath = Server.MapPath("~/upload/") 'caminho onde vai ser salva a imagem
                sFileName = m_cnpj & "_" & m_cpf & "_" & PrexPre_Doc_4.FileName
                sImgFile = sPath & sFileName
                PrexPre_Doc_4.SaveAs(sImgFile)
                sImgFile = "~\\upload\\" & sFileName
                If (m_tamanho > 800) Or ((m_extensao <> ".pdf")) Then
                    m_upload_ok = "N"
                Else
                    txt_Prestador_Doc_4.Text = sImgFile
                End If
            End If

            If m_upload_ok = "N" Then
                lbl_mensagem_1.Text = "Verifique os arquivos a enviar !!! Tamanho máximo permitido é de 800 kb e somente arquivos em formato PDF ! "
                lbl_mensagem_2.Text = ""
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao_Documento.Visible = "false"
                btn_Confirma_Exclusao_Prestador.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_Alteracao.Show()
            End If


            If m_upload_ok <> "N" Then
                lbl_mensagem_1.Text = ""
                Try
                    strexec = "DELETE tmp_prestadorxprestador FROM tmp_prestadorxprestador "
                    strexec = strexec & "WHERE tmp_prestadorxprestador.PrexPre_CPF = '" & txt_Prestador_CPF.Text & "' and tmp_prestadorxprestador.Pre_CNPJ='" & txt_CNPJ.Text & "'"
                    objCmd = New MySqlCommand(strexec, objConn)
                    objCmd.Connection.Open()
                    objCmd.ExecuteNonQuery()


                    txt_Prestador_Nome.Text = Replace(txt_Prestador_Nome.Text, ",", " ")
                    txt_Prestador_Nome.Text = Replace(txt_Prestador_Nome.Text, "'", " ")
                    txt_Prestador_RG.Text = Replace(txt_Prestador_RG.Text, ",", " ")
                    txt_Prestador_RG.Text = Replace(txt_Prestador_RG.Text, "'", " ")
                    txt_Prestador_CPF.Text = Replace(txt_Prestador_CPF.Text, ",", " ")
                    txt_Prestador_CPF.Text = Replace(txt_Prestador_CPF.Text, "'", " ")
                    txt_Prestador_Nacionalidade.Text = Replace(txt_Prestador_Nacionalidade.Text, ",", " ")
                    txt_Prestador_Nacionalidade.Text = Replace(txt_Prestador_Nacionalidade.Text, "'", " ")
                    txt_Prestador_Profissao.Text = Replace(txt_Prestador_Profissao.Text, ",", " ")
                    txt_Prestador_Profissao.Text = Replace(txt_Prestador_Profissao.Text, "'", " ")
                    txt_Prestador_Endereco.Text = Replace(txt_Prestador_Endereco.Text, ",", " ")
                    txt_Prestador_Endereco.Text = Replace(txt_Prestador_Endereco.Text, "'", " ")
                    txt_Prestador_Numero.Text = Replace(txt_Prestador_Numero.Text, ",", " ")
                    txt_Prestador_Numero.Text = Replace(txt_Prestador_Numero.Text, "'", " ")
                    txt_Prestador_Complemento.Text = Replace(txt_Prestador_Complemento.Text, ",", " ")
                    txt_Prestador_Complemento.Text = Replace(txt_Prestador_Complemento.Text, "'", " ")
                    txt_Prestador_Bairro.Text = Replace(txt_Prestador_Bairro.Text, ",", " ")
                    txt_Prestador_Bairro.Text = Replace(txt_Prestador_Bairro.Text, "'", " ")
                    txt_Prestador_CEP.Text = Replace(txt_Prestador_CEP.Text, ",", " ")
                    txt_Prestador_CEP.Text = Replace(txt_Prestador_CEP.Text, "'", " ")
                    txt_Prestador_Municipio.Text = Replace(txt_Prestador_Municipio.Text, ",", " ")
                    txt_Prestador_Municipio.Text = Replace(txt_Prestador_Municipio.Text, "'", " ")
                    txt_Prestador_Telefone.Text = Replace(txt_Prestador_Telefone.Text, ",", " ")
                    txt_Prestador_Telefone.Text = Replace(txt_Prestador_Telefone.Text, "'", " ")
                    txt_Prestador_Celular.Text = Replace(txt_Prestador_Celular.Text, ",", " ")
                    txt_Prestador_Celular.Text = Replace(txt_Prestador_Celular.Text, "'", " ")
                    txt_Prestador_Email.Text = Replace(txt_Prestador_Email.Text, ",", " ")
                    txt_Prestador_Email.Text = Replace(txt_Prestador_Email.Text, "'", " ")
                    txt_Prestador_Servico.Text = Replace(txt_Prestador_Servico.Text, ",", " ")
                    txt_Prestador_Servico.Text = Replace(txt_Prestador_Servico.Text, "'", " ")

                    txt_Prestador_Doc_1.Text = Replace(txt_Prestador_Doc_1.Text, ",", " ")
                    txt_Prestador_Doc_1.Text = Replace(txt_Prestador_Doc_1.Text, "'", " ")
                    txt_Prestador_Doc_2.Text = Replace(txt_Prestador_Doc_2.Text, ",", " ")
                    txt_Prestador_Doc_2.Text = Replace(txt_Prestador_Doc_2.Text, "'", " ")
                    txt_Prestador_Doc_3.Text = Replace(txt_Prestador_Doc_3.Text, ",", " ")
                    txt_Prestador_Doc_3.Text = Replace(txt_Prestador_Doc_3.Text, "'", " ")
                    txt_Prestador_Doc_4.Text = Replace(txt_Prestador_Doc_4.Text, ",", " ")
                    txt_Prestador_Doc_4.Text = Replace(txt_Prestador_Doc_4.Text, "'", " ")

                    strexec = "INSERT INTO tmp_prestadorxprestador(Pre_ID,Pre_CNPJ,PrexPre_Nome,PrexPre_RG,PrexPre_CPF,PrexPre_Nacionalidade, "
                    strexec = strexec & "PrexPre_Estado_Civil,PrexPre_Profissao,PrexPre_Endereco,PrexPre_Numero,PrexPre_Complemento,PrexPre_Bairro, "
                    strexec = strexec & "PrexPre_CEP,PrexPre_Municipio,PrexPre_UF,PrexPre_Telefone,PrexPre_Celular,PrexPre_Email,PrexPre_Servicos, "
                    strexec = strexec & "PrexPre_Doc_1,PrexPre_Doc_2,PrexPre_Doc_3,PrexPre_Doc_4) "
                    strexec = strexec & "VALUES(" & CodPrestador & ",'" & txt_CNPJ.Text & "','" & txt_Prestador_Nome.Text & "','"
                    strexec = strexec & "" & txt_Prestador_RG.Text & "','" & txt_Prestador_CPF.Text & "','" & txt_Prestador_Nacionalidade.Text & "','"
                    strexec = strexec & "" & ddl_Prestador_EstadoCivil.SelectedValue & "','" & txt_Prestador_Profissao.Text & "','"
                    strexec = strexec & "" & txt_Prestador_Endereco.Text & "','" & txt_Prestador_Numero.Text & "','" & txt_Prestador_Complemento.Text & "','"
                    strexec = strexec & "" & txt_Prestador_Bairro.Text & "','" & txt_Prestador_CEP.Text & "','" & txt_Prestador_Municipio.Text & "','"
                    strexec = strexec & "" & ddl_Prestador_UF.SelectedValue & "','" & txt_Prestador_Telefone.Text & "','" & txt_Prestador_Celular.Text & "','"
                    strexec = strexec & "" & txt_Prestador_Email.Text & "','" & txt_Prestador_Servico.Text & "','"
                    strexec = strexec & "" & txt_Prestador_Doc_1.Text & "','" & txt_Prestador_Doc_2.Text & "','"
                    strexec = strexec & "" & txt_Prestador_Doc_3.Text & "','" & txt_Prestador_Doc_4.Text & "')"
                    objCmd = New MySqlCommand(strexec, objConn)

                    objCmd.ExecuteNonQuery()
                    objCmd.Connection.Close()

                    'montando a string--------------------------------------------------------
                    strreader = "select tmp_prestadorxprestador.PrexPre_Id, "
                    strreader = strreader & "tmp_prestadorxprestador.Pre_Id, "
                    strreader = strreader & "tmp_prestadorxprestador.Pre_CNPJ, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Nome, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_RG, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_CPF, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Nacionalidade, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Estado_Civil, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Profissao, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Endereco, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Numero, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Complemento, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Bairro, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_CEP, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Municipio, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_UF, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Servicos, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_1, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_2, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_3, "
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_4 "
                    strreader = strreader & "FROM tmp_prestadorxprestador "
                    strreader = strreader & "WHERE "
                    strreader = strreader & "tmp_prestadorxprestador.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
                    strreader = strreader & "order by tmp_prestadorxprestador.PrexPre_Nome "

                    SqlPrexPre.SelectCommand = strreader

                    GridView2.DataBind()

                    Grava_Prestador_Alteracao()

                    txt_Prestador_Nome.Text = ""
                    txt_Prestador_RG.Text = ""
                    txt_Prestador_CPF.Text = ""
                    txt_Prestador_Nacionalidade.Text = ""
                    txt_Prestador_Profissao.Text = ""
                    txt_Prestador_Endereco.Text = ""
                    txt_Prestador_Numero.Text = ""
                    txt_Prestador_Complemento.Text = ""
                    txt_Prestador_Bairro.Text = ""
                    txt_Prestador_CEP.Text = ""
                    txt_Prestador_Municipio.Text = ""
                    txt_Prestador_Telefone.Text = ""
                    txt_Prestador_Celular.Text = ""
                    txt_Prestador_Email.Text = ""
                    txt_Prestador_Servico.Text = ""
                    txt_Prestador_Doc_1.Text = ""
                    txt_Prestador_Doc_2.Text = ""
                    txt_Prestador_Doc_3.Text = ""
                    txt_Prestador_Doc_4.Text = ""


                    lbl_mensagem_1.Text = "REGISTRO GRAVADO COM SUCESSO !!! "
                    lbl_mensagem_2.Text = ""
                    img_btn_Fechar_Mensagem.Visible = "true"
                    img_btn_sair_Mensagem.Visible = "false"
                    btn_Confirma_Exclusao_Documento.Visible = "false"
                    btn_Confirma_Exclusao_Prestador.Visible = "false"
                    btn_Nao_Confirma.Visible = "false"
                    MPE_Alteracao.Show()

                    pnl_prestador_detalhe.Visible = "false"
                Catch ex As Exception
                    lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                    lbl_mensagem_2.Text = ex.Message
                    img_btn_Fechar_Mensagem.Visible = "true"
                    img_btn_sair_Mensagem.Visible = "false"
                    btn_Confirma_Exclusao_Documento.Visible = "false"
                    btn_Confirma_Exclusao_Prestador.Visible = "false"
                    btn_Nao_Confirma.Visible = "false"
                    MPE_Alteracao.Show()
                End Try
            End If


        End If

        'objCmd.Connection.Close()

        'fechar
        objConn.Close()
        objConn = Nothing
    End Sub

    Protected Sub btn_fechar_Prestador_alt_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_fechar_Prestador_alt.Click
        pnl_prestador_detalhe.Visible = "false"
    End Sub

    Protected Sub btn_Excluir_Prestador_alt_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Excluir_Prestador_alt.Click
        lbl_mensagem_1.Text = "SE CONFIRMAR A EXCLUSÃO, O REGISTRO SERÁ EXCLUIDO DEFINITIVAMENTE !!!"
        lbl_mensagem_2.Text = "CONFIRMA A EXCLUSÃO DO REGISTRO ?"
        img_btn_Fechar_Mensagem.Visible = "false"
        img_btn_sair_Mensagem.Visible = "false"
        btn_Confirma_Exclusao_Documento.Visible = "false"
        btn_Confirma_Exclusao_Prestador.Visible = "true"
        btn_Nao_Confirma.Visible = "true"
        MPE_Alteracao.Show()

    End Sub

    Protected Sub btn_Confirma_Exclusao_Prestador_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Confirma_Exclusao_Prestador.Click
        Try
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            If txt_prexpre_registro.Text <> "" And txt_prexpre_registro.Text <> "0" Then
                strexec = "DELETE tmp_prestadorxprestador FROM tmp_prestadorxprestador "
                strexec = strexec & "WHERE tmp_prestadorxprestador.PrexPre_Id = " & txt_prexpre_registro.Text & " and "
                strexec = strexec & "tmp_prestadorxprestador.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            End If

            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()

            'montando a string--------------------------------------------------------
            strreader = "select tmp_prestadorxprestador.PrexPre_Id, "
            strreader = strreader & "tmp_prestadorxprestador.Pre_Id, "
            strreader = strreader & "tmp_prestadorxprestador.Pre_CNPJ, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Nome, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_RG, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_CPF, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Nacionalidade, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Estado_Civil, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Profissao, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Endereco, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Numero, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Complemento, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Bairro, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_CEP, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Municipio, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_UF, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Telefone,"
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Celular,"
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Email,"
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Servicos, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_1, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_2, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_3, "
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Doc_4 "
            strreader = strreader & "FROM tmp_prestadorxprestador "
            strreader = strreader & "WHERE "
            strreader = strreader & "tmp_prestadorxprestador.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
            strreader = strreader & "order by tmp_prestadorxprestador.PrexPre_Nome "

            SqlPrexPre.SelectCommand = strreader
            GridView2.DataBind()

            lbl_mensagem_1.Text = ""

            'fechar
            objConn.Close()
            objConn = Nothing

            btn_Excluir_Prestador_alt.Visible = False

            Grava_Prestador_Alteracao()
            lbl_mensagem_1.Text = "REGISTRO EXCLUIDO COM SUCESSO !!! "
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
            pnl_prestador_detalhe.Visible = "false"
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao_Documento.Visible = "false"
            btn_Confirma_Exclusao_Prestador.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Alteracao.Show()
        End Try
    End Sub

    Protected Sub btn_Nao_Confirma_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Nao_Confirma.Click
        MPE_Alteracao.Hide()
    End Sub

    Protected Sub img_btn_sair_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_sair_Mensagem.Click
        Response.Redirect("Login_Cadastro.aspx")
        Response.End()
    End Sub


    Protected Sub txt_Site_TextChanged(sender As Object, e As EventArgs) Handles txt_Site.TextChanged

    End Sub
End Class
