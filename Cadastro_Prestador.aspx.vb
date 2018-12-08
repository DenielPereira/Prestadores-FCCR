Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Imports System.Web.DynamicData

Partial Class Cadastro_Prestador
    Inherits System.Web.UI.Page
    Dim objConn As MySqlConnection
    Dim objDt As MySqlDataAdapter
    Dim ds As DataSet
    Dim objCmd, objCmdd As MySqlCommand
    Dim dr As MySqlDataReader
    Dim strexec, strreader, strdt As String
    Dim CtrLen, CtrTipo, CtrCodUsuario, CodPrestador, MEI As Integer
    Dim sFileName, sImgFile, sPath As String
    Dim mdia, mmes As Integer
    Dim m_tipoempresa, m_tipoprestador, m_perfil As String
    Dim m_novo_cadastro As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        txt_cad_CNPJ.Attributes.Add("onfocus", String.Format("RecebeFoco_CNPJ('Tabs_TabPanel_0_txt_cad_CNPJ','Tabs_TabPanel_0_txt_cad_CPF');", txt_cad_CNPJ.ClientID))
        txt_cad_CNPJ.Attributes.Add("onblur", String.Format("PerdeFoco_CNPJ('Tabs_TabPanel_0_txt_cad_CNPJ');", txt_cad_CNPJ.ClientID))
        txt_cad_CPF.Attributes.Add("onfocus", String.Format("RecebeFoco_CPF('Tabs_TabPanel_0_txt_cad_CPF','Tabs_TabPanel_0_txt_cad_CNPJ');", txt_cad_CPF.ClientID))
        txt_cad_CPF.Attributes.Add("onblur", String.Format("PerdeFoco_CPF('Tabs_TabPanel_0_txt_cad_CPF');", txt_cad_CPF.ClientID))

        txt_cad_CNPJ.Attributes.Add("onkeyup", "javascript:formatar(this, '##.###.###/####-##')")
        txt_cad_CNPJ.Attributes.Add("onBlur", "javascript:ValidarCNPJ(Tabs_TabPanel_0_txt_cad_CNPJ)")

        txt_cad_CPF.Attributes.Add("onkeyup", "javascript:formatar(this, '###.###.###-##')")
        txt_cad_CPF.Attributes.Add("onBlur", "javascript:valida_cpf(Tabs_TabPanel_0_txt_cad_CPF)")

        txt_CNPJ.Attributes.Add("onKeyPress", "javascript:MascaraCNPJ(txt_CNPJ)")
        txt_CNPJ.Attributes.Add("onBlur", "javascript:ValidarCNPJ(txt_CNPJ)")

        txt_Telefone.Attributes.Add("onKeyPress", "javascript:MascaraTelefone(Tabs_TabPanel_2_txt_Telefone)")
        txt_Telefone_1.Attributes.Add("onKeyPress", "javascript:MascaraTelefone(Tabs_TabPanel_2_txt_Telefone_1)")
        txt_Celular.Attributes.Add("onKeyPress", "javascript:MascaraCelular(Tabs_TabPanel_2_txt_Celular)")
        txt_Email.Attributes.Add("onBlur", "javascript:ValidaEmail(Tabs_TabPanel_2_txt_Email)")
        txt_Email_1.Attributes.Add("onBlur", "javascript:ValidaEmail(Tabs_TabPanel_2_txt_Email_1)")

        txt_CEP.Attributes.Add("onkeyup", "javascript:formatar(this, '##.###-###')")

        txt_Prestador_CEP.Attributes.Add("onkeyup", "javascript:formatar(this, '##.###-###')")
        txt_Prestador_Telefone.Attributes.Add("onKeyPress", "javascript:MascaraTelefone(txt_Prestador_Telefone)")
        txt_Prestador_Celular.Attributes.Add("onKeyPress", "javascript:MascaraCelular(txt_Prestador_Celular)")
        txt_prexdoc_emissao.Attributes.Add("onkeyup", "javascript:formatar(this, '##/##/####')")
        txt_prexdoc_validade.Attributes.Add("onkeyup", "javascript:formatar(this, '##/##/####')")
        txt_prexdoc_validade.Attributes.Add("onkeyup", "javascript:formatar(this, '##/##/####')")

        txt_CPF.Attributes.Add("onkeyup", "javascript:formatar(this, '###.###.###-##')")
        txt_CPF.Attributes.Add("onBlur", "javascript:valida_cpf(Tabs_TabPanel_11_txt_CPF)")

        txt_Prestador_CPF.Attributes.Add("onkeyup", "javascript:formatar(this, '###.###.###-##')")
        txt_Prestador_CPF.Attributes.Add("onBlur", "javascript:valida_cpf(Tabs_TabPanel_2_txt_Prestador_CPF)")

        If txt_cad_CNPJ.Text <> "Digite aqui apenas se você for pessoa jurídica" Then
            txt_cad_CPF.Text = "Digite aqui apenas se você for pessoa física"
            txt_cad_CPF.Enabled = "false"
        End If
        If txt_cad_CPF.Text <> "Digite aqui apenas se você for pessoa física" Then
            txt_cad_CNPJ.Text = "Digite aqui apenas se você for pessoa jurídica"
            txt_cad_CNPJ.Enabled = "false"
        End If

        If Not Page.IsPostBack Then

            txt_novo.Text = "Sim"

            Verifica_Acesso()

            TabPanel_0.Enabled = "true"
            Tabs.ActiveTab = TabPanel_0

            txt_CNPJ.Text = Request.QueryString("CNPJPrestador")
            m_tipoempresa = Request.QueryString("TipoEmpresa")
            m_tipoprestador = Request.QueryString("TipoPrestador")
            lbl_cod_tipoempresa.Text = Request.QueryString("TipoEmpresa")
            lbl_cod_tipoprestador.Text = Request.QueryString("TipoPrestador")
            Me.Limpa_TMP()
            Me.Carrega_TMP()
            txt_Cidade.Text = "SÃO JOSÉ DOS CAMPOS"
            txt_IM_Cidade.Text = "SÃO JOSÉ DOS CAMPOS"
            txt_Nacionalidade.Text = "BRASILEIRA"
            txt_Prestador_Municipio.Text = "SÃO JOSÉ DOS CAMPOS"
            txt_Prestador_Nacionalidade.Text = "BRASILEIRA"
            ddl_IM_UF.SelectedValue = "SP"
            ddl_Prestador_UF.SelectedValue = "SP"
            ddl_UF.SelectedValue = "SP"
            txt_dias_validade.Text = "0"

            txt_cad_CNPJ.Enabled = "false"
            txt_cad_CPF.Enabled = "false"

        End If

    End Sub
    Private Sub Verifica_Acesso()

        If Session("DocPrestador") = "" And Session("CNPJPrestador") = "" Then
            Response.Redirect("Login_Cadastro.aspx")
            Response.End()
        End If

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
            If lbl_cod_tipoprestador.Text = "1" Then
                strreader = strreader & "and cad_documento.Doc_Prestador=1 "
            End If
            If lbl_cod_tipoprestador.Text = "2" Then
                strreader = strreader & "and cad_documento.Doc_Fornecedor=1 "
            End If
            If lbl_cod_tipoempresa.Text = "1" Then
                strreader = strreader & "and cad_documento.Doc_AC=1 "
            End If
            If lbl_cod_tipoempresa.Text = "2" Then
                strreader = strreader & "and cad_documento.Doc_EPP=1 "
            End If
            If lbl_cod_tipoempresa.Text = "3" Then
                strreader = strreader & "and cad_documento.Doc_EI=1 "
            End If
            If lbl_cod_tipoempresa.Text = "4" Then
                strreader = strreader & "and cad_documento.Doc_LTDA=1 "
            End If
            If lbl_cod_tipoempresa.Text = "5" Then
                strreader = strreader & "and cad_documento.Doc_EIRELI=1 "
            End If
            If lbl_cod_tipoempresa.Text = "6" Then
                strreader = strreader & "and cad_documento.Doc_MEI=1 "
            End If
            If lbl_cod_tipoempresa.Text = "7" Then
                strreader = strreader & "and cad_documento.Doc_ME=1 "
            End If
            If lbl_cod_tipoempresa.Text = "8" Then
                strreader = strreader & "and cad_documento.Doc_SA=1 "
            End If
            If lbl_cod_tipoempresa.Text = "9" Then
                strreader = strreader & "and cad_documento.Doc_SS=1 "
            End If
            If lbl_cod_tipoempresa.Text = "10" Then
                strreader = strreader & "and cad_documento.Doc_PFisica=1 "
            End If
            strreader = strreader & "order by cad_documento.Doc_Descricao "

            SqlDocumento.SelectCommand = strreader

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
            strreader = strreader & "tmp_prestadorxprestador.PrexPre_Servicos "
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
            'dar mensagem
        Catch ex As Exception
            lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
        End Try

    End Sub
    Private Sub Carrega_TMP()
        Try
            'abrindo conexao
            objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            ' transferindo dados 
            CodPrestador = 0

            strexec = "INSERT INTO tmp_prestadorxdocumento(Pre_ID,Pre_CNPJ,Doc_ID,"
            strexec = strexec & "Doc_Descricao,PrexDoc_Nome,PrexDoc_Observacao,PrexDoc_Situacao,PrexDoc_Informacoes,Doc_Obrigatorio) "
            strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',cad_documento.Doc_ID,cad_documento.Doc_Descricao,"
            strexec = strexec & "'','','Pendente',cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio "
            strexec = strexec & "FROM cad_documento "
            strexec = strexec & "WHERE "
            strexec = strexec & "cad_documento.Doc_Obrigatorio=1 "
            If lbl_cod_tipoprestador.Text = "1" Then
                strexec = strexec & "and cad_documento.Doc_Prestador=1 "
            End If
            If lbl_cod_tipoprestador.Text = "2" Then
                strexec = strexec & "and cad_documento.Doc_Fornecedor=1 "
            End If
            If lbl_cod_tipoempresa.Text = "1" Then
                strexec = strexec & "and cad_documento.Doc_AC=1 "
            End If
            If lbl_cod_tipoempresa.Text = "2" Then
                strexec = strexec & "and cad_documento.Doc_EPP=1 "
            End If
            If lbl_cod_tipoempresa.Text = "3" Then
                strexec = strexec & "and cad_documento.Doc_EI=1 "
            End If
            If lbl_cod_tipoempresa.Text = "4" Then
                strexec = strexec & "and cad_documento.Doc_LTDA=1 "
            End If
            If lbl_cod_tipoempresa.Text = "5" Then
                strexec = strexec & "and cad_documento.Doc_EIRELI=1 "
            End If
            If lbl_cod_tipoempresa.Text = "6" Then
                strexec = strexec & "and cad_documento.Doc_MEI=1 "
            End If
            If lbl_cod_tipoempresa.Text = "7" Then
                strexec = strexec & "and cad_documento.Doc_ME=1 "
            End If
            If lbl_cod_tipoempresa.Text = "8" Then
                strexec = strexec & "and cad_documento.Doc_SA=1 "
            End If
            If lbl_cod_tipoempresa.Text = "9" Then
                strexec = strexec & "and cad_documento.Doc_SS=1 "
            End If
            If lbl_cod_tipoempresa.Text = "10" Then
                strexec = strexec & "and cad_documento.Doc_PFisica=1 "
            End If
            objCmd = New MySqlCommand(strexec, objConn)
            objCmd.Connection.Open()
            objCmd.ExecuteNonQuery()

            strexec = "INSERT INTO tmp_prestadorxsermat(Pre_ID,Pre_CNPJ,SM_ID,SM_Descricao,SM_Selecao,SM_Material,SM_Servico) "
            strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',cad_servico_material.SM_Id,cad_servico_material.SM_Descricao,0,cad_servico_material.SM_Fornecedor,cad_servico_material.SM_Prestador "
            strexec = strexec & "FROM cad_servico_material "
            strexec = strexec & "WHERE cad_servico_material.SM_Situacao='Ativo' "

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

            'fechar conexao

            objConn.Close()
            objConn = Nothing

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
        Catch ex As Exception
            lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
        End Try

    End Sub
    Private Sub Gravar_Prestador()
        'pegando dados

        Dim m_cnpj, m_razao, m_fantasia, m_iestadual, m_imunicipal, m_imcidade, m_imuf, m_cnae_cod, m_cnae_desc As String

        Dim m_representante, m_representante_cargo, m_cpf_representante, m_rg_representante, m_nacionalidade, m_representante_estado_civil As String
        Dim m_representante_profissao, m_representante_email As String

        Dim m_pispasep, m_nit As String

        Dim m_endereco, m_numero, m_complemento, m_bairro, m_cep As String
        Dim m_cidade, m_uf, m_telefone, m_telefone_1, m_celular, m_whatszap, m_email, m_email_1, m_site, m_pessoa_contato As String
        Dim m_banco, m_agencia, m_conta, m_tipo_conta As String
        Dim m_senha, m_repete_senha, m_data As String

        Dim m_licitacao As String

        m_licitacao = RB_Licitacao.SelectedValue

        If txt_CNPJ.Text <> "Digite aqui apenas se você for pessoa jurídica" Then
            txt_CNPJ.Text = RTrim(txt_CNPJ.Text)
        Else
            If txt_CPF.Text <> "Digite aqui apenas se você for pessoa física" Then
                txt_CNPJ.Text = RTrim(txt_CPF.Text)
            End If
        End If

        m_cnpj = txt_CNPJ.Text

        If lbl_cod_tipoempresa.Text = "10" Then
            m_razao = Replace(txt_PF_Nome.Text, "'", " ")
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
        m_cnae_cod = Replace(txt_CNAE_Codigo.Text, "'", " ")
        m_cnae_cod = Replace(m_cnae_cod, ",", " ")
        m_cnae_desc = Replace(txt_CNAE_Descricao.Text, "'", " ")
        m_cnae_desc = Replace(m_cnae_desc, ",", " ")

        m_representante = Replace(txt_Representante.Text, "'", " ")
        m_representante = Replace(m_representante, ",", " ")
        m_representante_cargo = Replace(txt_Representante_Cargo.Text, "'", " ")
        m_representante_cargo = Replace(m_representante_cargo, ",", " ")
        m_cpf_representante = Replace(txt_CPF.Text, "'", " ")
        m_cpf_representante = Replace(m_cpf_representante, ",", " ")

        If lbl_cod_tipoempresa.Text = "10" Then
            m_representante_estado_civil = ddl_PF_EstadoCivil.SelectedValue
            m_representante_profissao = Replace(txt_PF_Profissao.Text, "'", " ")
            m_representante_profissao = Replace(m_representante_profissao, ",", " ")
            m_rg_representante = Replace(txt_PF_RG.Text, "'", " ")
            m_rg_representante = Replace(m_rg_representante, ",", " ")
            m_nacionalidade = Replace(txt_PF_Nacionalidade.Text, "'", " ")
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

        m_pispasep = Replace(txt_PF_PISPASEP.Text, "'", " ")
        m_pispasep = Replace(m_pispasep, ",", " ")
        m_nit = Replace(txt_PF_NIT.Text, "'", " ")
        m_nit = Replace(m_nit, ",", " ")

        m_representante_email = Replace(txt_Representante_Email.Text, "'", " ")
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
        m_telefone_1 = Replace(txt_Telefone_1.Text, "'", " ")
        m_telefone_1 = Replace(m_telefone, ",", " ")
        m_celular = Replace(txt_Celular.Text, "'", " ")
        m_celular = Replace(m_celular, ",", " ")
        m_whatszap = Replace(txt_WhatsApp.Text, "'", " ")
        m_whatszap = Replace(m_whatszap, ",", " ")
        m_email = Replace(txt_Email.Text, "'", " ")
        m_email = Replace(m_email, ",", " ")
        m_email_1 = Replace(txt_Email_1.Text, "'", " ")
        m_email_1 = Replace(m_email_1, ",", " ")
        m_site = Replace(txt_Site.Text, "'", " ")
        m_site = Replace(m_site, ",", " ")
        m_pessoa_contato = Replace(txt_Pessoa_Contato.Text, "'", " ")
        m_pessoa_contato = Replace(m_pessoa_contato, ",", " ")

        m_banco = Replace(txt_Banco_Codigo.Text, "'", " ")
        m_banco = Replace(m_banco, ",", " ")
        m_agencia = Replace(txt_Banco_Agencia.Text, "'", " ")
        m_agencia = Replace(m_agencia, ",", " ")
        m_conta = Replace(txt_Banco_Conta.Text, "'", " ")
        m_conta = Replace(m_conta, ",", " ")
        m_tipo_conta = ddl_Banco_TipoConta.SelectedValue

        m_senha = Replace(txt_Senha.Text, "'", " ")
        m_senha = Replace(m_senha, ",", " ")
        m_repete_senha = txt_Confirma_Senha.Text

        m_tipoempresa = lbl_cod_tipoempresa.Text
        m_tipoprestador = lbl_cod_tipoprestador.Text

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

        If m_cnpj <> "" Then
            Try
                'abrindo conexao
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                strexec = "DELETE cad_prestador "
                strexec = strexec & "FROM cad_prestador "
                strexec = strexec & "WHERE cad_prestador.Pre_CNPJ='" & txt_CNPJ.Text & "'"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.Connection.Open()
                objCmd.ExecuteNonQuery()

                'inserir dados
                strexec = "INSERT INTO cad_prestador("
                strexec = strexec & "Pre_CNPJ,"
                strexec = strexec & "Pre_Razao_Social,"
                strexec = strexec & "Pre_Nome_Fantasia,"
                strexec = strexec & "Pre_IEstadual,"
                strexec = strexec & "Pre_IMunicipal,"
                strexec = strexec & "Pre_IMunicipal_Municipio,"
                strexec = strexec & "Pre_IMunicipal_UF,"
                strexec = strexec & "Pre_CNAE_Codigo,"
                strexec = strexec & "Pre_CNAE_Descricao,"
                strexec = strexec & "Pre_Representante,"
                strexec = strexec & "Pre_Representante_Cargo,"
                strexec = strexec & "Pre_Representante_CPF,"
                strexec = strexec & "Pre_Representante_RG,"
                strexec = strexec & "Pre_Nacionalidade,"
                strexec = strexec & "Pre_Representante_Estado_Civil,"
                strexec = strexec & "Pre_Representante_Profissao,"
                strexec = strexec & "Pre_Representante_Email,"
                strexec = strexec & "Pre_PIS_PASEP,"
                strexec = strexec & "Pre_NIT,"
                strexec = strexec & "Pre_Endereco,"
                strexec = strexec & "Pre_Numero,"
                strexec = strexec & "Pre_Complemento,"
                strexec = strexec & "Pre_Bairro,"
                strexec = strexec & "Pre_CEP,"
                strexec = strexec & "Pre_Municipio,"
                strexec = strexec & "Pre_UF,"
                strexec = strexec & "Pre_Telefone,"
                strexec = strexec & "Pre_Telefone_1,"
                strexec = strexec & "Pre_Celular,"
                strexec = strexec & "Pre_WhatsApp,"
                strexec = strexec & "Pre_Email,"
                strexec = strexec & "Pre_Email_1,"
                strexec = strexec & "Pre_Site,"
                strexec = strexec & "Pre_Pessoa_Contato,"
                strexec = strexec & "Pre_Banco_Codigo,"
                strexec = strexec & "Pre_Banco_Agencia,"
                strexec = strexec & "Pre_Banco_Conta,"
                strexec = strexec & "Pre_Banco_Tipo,"
                strexec = strexec & "Pre_Senha, "
                strexec = strexec & "Pre_TipoEmpresa,"
                strexec = strexec & "Pre_TipoPrestador, "
                strexec = strexec & "Pre_Participa_Licitacao, "
                strexec = strexec & "Pre_Data_Cadastro) "
                strexec = strexec & " VALUES ("
                strexec = strexec & "'" & m_cnpj & "',"
                strexec = strexec & "'" & m_razao & "',"
                strexec = strexec & "'" & m_fantasia & "',"
                strexec = strexec & "'" & m_iestadual & "',"
                strexec = strexec & "'" & m_imunicipal & "',"
                strexec = strexec & "'" & m_imcidade & "',"
                strexec = strexec & "'" & m_imuf & "',"
                strexec = strexec & "'" & m_cnae_cod & "',"
                strexec = strexec & "'" & m_cnae_desc & "',"
                strexec = strexec & "'" & m_representante & "',"
                strexec = strexec & "'" & m_representante_cargo & "',"
                strexec = strexec & "'" & m_cpf_representante & "',"
                strexec = strexec & "'" & m_rg_representante & "',"
                strexec = strexec & "'" & m_nacionalidade & "',"
                strexec = strexec & "'" & m_representante_estado_civil & "',"
                strexec = strexec & "'" & m_representante_profissao & "',"
                strexec = strexec & "'" & m_representante_email & "',"
                strexec = strexec & "'" & m_pispasep & "',"
                strexec = strexec & "'" & m_nit & "',"
                strexec = strexec & "'" & m_endereco & "',"
                strexec = strexec & "'" & m_numero & "',"
                strexec = strexec & "'" & m_complemento & "',"
                strexec = strexec & "'" & m_bairro & "',"
                strexec = strexec & "'" & m_cep & "',"
                strexec = strexec & "'" & m_cidade & "',"
                strexec = strexec & "'" & m_uf & "',"
                strexec = strexec & "'" & m_telefone & "', "
                strexec = strexec & "'" & m_telefone_1 & "', "
                strexec = strexec & "'" & m_celular & "', "
                strexec = strexec & "'" & m_whatszap & "', "
                strexec = strexec & "'" & m_email & "', "
                strexec = strexec & "'" & m_email_1 & "', "
                strexec = strexec & "'" & m_site & "', "
                strexec = strexec & "'" & m_pessoa_contato & "', "
                strexec = strexec & "'" & m_banco & "', "
                strexec = strexec & "'" & m_agencia & "', "
                strexec = strexec & "'" & m_conta & "', "
                strexec = strexec & "'" & m_tipo_conta & "', "
                strexec = strexec & "'" & m_senha & "',"
                strexec = strexec & "'" & m_tipoempresa & "',"
                strexec = strexec & "'" & m_tipoprestador & "',"
                strexec = strexec & "'" & m_licitacao & "',"
                strexec = strexec & "'" & m_data & "')"

                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                strreader = "SELECT "
                strreader = strreader & "cad_prestador.Pre_ID,"
                strreader = strreader & "cad_prestador.Pre_CNPJ "
                strreader = strreader & "FROM cad_prestador "
                strreader = strreader & "WHERE cad_prestador.Pre_CNPJ='" & txt_CNPJ.Text & "'"

                objCmd = New MySqlCommand(strreader, objConn)

                'criar datareader
                dr = objCmd.ExecuteReader()
                CodPrestador = 0
                'se achar retorna verdadeiro
                If dr.Read() Then

                    If Not IsDBNull(dr("Pre_ID")) Then
                        CodPrestador = dr("Pre_ID")
                        txt_ID.Text = dr("Pre_ID")
                    End If

                End If

                dr.Close()
                dr = Nothing

                If CodPrestador <> 0 Then
                    ' transferindo dados 

                    strexec = "DELETE cad_prestadorxdocumento "
                    strexec = strexec & "FROM cad_prestadorxdocumento "
                    strexec = strexec & "WHERE "
                    strexec = strexec & "cad_prestadorxdocumento.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                    objCmd = New MySqlCommand(strexec, objConn)
                    objCmd.ExecuteNonQuery()

                    strexec = "DELETE cad_prestadorxsermat "
                    strexec = strexec & "FROM cad_prestadorxsermat "
                    strexec = strexec & "WHERE "
                    strexec = strexec & "cad_prestadorxsermat.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                    objCmd = New MySqlCommand(strexec, objConn)
                    objCmd.ExecuteNonQuery()

                    strexec = "DELETE cad_prestadorxprestador "
                    strexec = strexec & "FROM cad_prestadorxprestador "
                    strexec = strexec & "WHERE "
                    strexec = strexec & "cad_prestadorxprestador.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                    objCmd = New MySqlCommand(strexec, objConn)
                    objCmd.ExecuteNonQuery()

                    strexec = "INSERT INTO cad_prestadorxdocumento(Pre_ID,Pre_CNPJ,Doc_ID,"
                    strexec = strexec & "Doc_Descricao,PrexDoc_Emissao,PrexDoc_Validade,PrexDoc_Nome,PrexDoc_Observacao,PrexDoc_Situacao,PrexDoc_Data_Alteracao) "
                    strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',tmp_prestadorxdocumento.Doc_ID,tmp_prestadorxdocumento.Doc_Descricao,tmp_prestadorxdocumento.PrexDoc_Emissao,tmp_prestadorxdocumento.PrexDoc_Validade,"
                    strexec = strexec & "tmp_prestadorxdocumento.PrexDoc_Nome,tmp_prestadorxdocumento.PrexDoc_Observacao,tmp_prestadorxdocumento.PrexDoc_Situacao,tmp_prestadorxdocumento.PrexDoc_Data_Alteracao "
                    strexec = strexec & "FROM tmp_prestadorxdocumento "
                    strexec = strexec & "WHERE "
                    strexec = strexec & "tmp_prestadorxdocumento.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                    objCmd = New MySqlCommand(strexec, objConn)
                    objCmd.ExecuteNonQuery()

                    strexec = "INSERT INTO cad_prestadorxsermat(Pre_ID,Pre_CNPJ,SM_ID,SM_Descricao,SM_Material,SM_Servico) "
                    strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',tmp_prestadorxsermat.SM_ID,tmp_prestadorxsermat.SM_Descricao,tmp_prestadorxsermat.SM_Material,tmp_prestadorxsermat.SM_Servico "
                    strexec = strexec & "FROM tmp_prestadorxsermat "
                    strexec = strexec & "WHERE "
                    strexec = strexec & "tmp_prestadorxsermat.Pre_CNPJ= '" & txt_CNPJ.Text & "' and tmp_prestadorxsermat.SM_Selecao=1"

                    objCmd = New MySqlCommand(strexec, objConn)
                    objCmd.ExecuteNonQuery()

                    strexec = "INSERT INTO cad_prestadorxprestador(Pre_ID,Pre_CNPJ,PrexPre_Nome,PrexPre_RG,PrexPre_CPF,PrexPre_Nacionalidade, "
                    strexec = strexec & "PrexPre_Estado_Civil,PrexPre_Profissao,PrexPre_Endereco,PrexPre_Numero,PrexPre_Complemento,PrexPre_Bairro, "
                    strexec = strexec & "PrexPre_CEP,PrexPre_Municipio,PrexPre_UF,PrexPre_Telefone,PrexPre_Celular,PrexPre_Email,PrexPre_Servicos) "
                    strexec = strexec & "SELECT " & CodPrestador & ",'" & txt_CNPJ.Text & "',tmp_prestadorxprestador.PrexPre_Nome,"
                    strexec = strexec & "tmp_prestadorxprestador.PrexPre_RG,tmp_prestadorxprestador.PrexPre_CPF,tmp_prestadorxprestador.PrexPre_Nacionalidade,"
                    strexec = strexec & "tmp_prestadorxprestador.PrexPre_Estado_Civil,tmp_prestadorxprestador.PrexPre_Profissao,tmp_prestadorxprestador.PrexPre_Endereco,"
                    strexec = strexec & "tmp_prestadorxprestador.PrexPre_Numero,tmp_prestadorxprestador.PrexPre_Complemento,tmp_prestadorxprestador.PrexPre_Bairro,"
                    strexec = strexec & "tmp_prestadorxprestador.PrexPre_CEP,tmp_prestadorxprestador.PrexPre_Municipio,tmp_prestadorxprestador.PrexPre_UF,"
                    strexec = strexec & "tmp_prestadorxprestador.PrexPre_Telefone,"
                    strexec = strexec & "tmp_prestadorxprestador.PrexPre_Celular,"
                    strexec = strexec & "tmp_prestadorxprestador.PrexPre_Email,"
                    strexec = strexec & "tmp_prestadorxprestador.PrexPre_Servicos "
                    strexec = strexec & "FROM tmp_prestadorxprestador "
                    strexec = strexec & "WHERE "
                    strexec = strexec & "tmp_prestadorxprestador.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                    objCmd = New MySqlCommand(strexec, objConn)
                    objCmd.ExecuteNonQuery()

                End If

                'fechar
                objCmd.Connection.Close()
                objConn.Close()
            Catch ex As Exception
                lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
                Imgbtn_Fechar_Mensagem.Visible = "true"
                Imgbtn_Sair_Mensagem.Visible = "false"
                Imgbtn_Sim_Mensagem.Visible = "false"
                Imgbtn_Nao_Mensagem.Visible = "false"
                MPE_Cadastro.Show()
            End Try


        Else
            'dar mensagem
            'lblConfirm.Text = ""
            'lblError.Text = "Verifique os campos obrigatórios !!!"
        End If

    End Sub
    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Select Case e.Row.RowType
            Case DataControlRowType.DataRow

                Dim situacao As String = CType(e.Row.Cells(5).Text, String)
                Dim strimage As String
                strimage = ""
                Select Case situacao
                    Case "Vigente"
                        strimage = "~/Imagens/Icones/Yes.ico"
                    Case "Pendente"
                        strimage = "~/Imagens/Icones/No.ico"
                    Case "Opcional"
                        strimage = "~/Imagens/Icones/Tipo_01.gif"
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
            Dim mregistro As Integer = Convert.ToInt32(e.CommandArgument)
            Dim conexao_1 As New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

            Try
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
                'configurando datareader

                objCmd = New MySqlCommand(strreader, conexao_1)
                objCmd.Connection.Open()
                dr = objCmd.ExecuteReader()

                txt_prexdoc_emissao.Text = ""
                txt_prexdoc_validade.Text = ""
                txt_prexdoc_nome.Text = ""
                txt_prexdoc_doc.Text = ""
                txt_prexdoc_obs.Text = ""
                lbl_data_upload.Text = ""

                btn_Excluir_Documento.Visible = False
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
                            btn_Excluir_Documento.Visible = True
                        End If
                    End If
                    If Not IsDBNull(dr(11)) Then
                        txt_prexdoc_ajuda.Text = dr(11)
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

                    End If
                    If Not IsDBNull(dr(6)) Then

                        txtmodelo.Text = dr(6)
                        hpl_modelo.NavigateUrl = dr(6)


                    End If

                End If

                'fechar
                dr.Close()
                dr = Nothing

                objCmd.Connection.Close()
                conexao_1.Close()
                lbl_erro_documento.Text = ""
            Catch ex As Exception
                lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
                Imgbtn_Fechar_Mensagem.Visible = "true"
                Imgbtn_Sair_Mensagem.Visible = "false"
                Imgbtn_Sim_Mensagem.Visible = "false"
                Imgbtn_Nao_Mensagem.Visible = "false"
                MPE_Cadastro.Show()
            End Try

        End If
    End Sub
    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim MyButton As LinkButton = e.Row.FindControl("cmdDelete23")
            MyButton.Attributes.Add("onclick", "javascript:return " & "confirm('Confirma a exclusão do Prestador " & DataBinder.Eval(e.Row.DataItem, "PrexPre_Nome") & " ?')")
        End If
    End Sub
    Protected Sub GridView2_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView2.RowCommand
        If (e.CommandName = "Delete20") Then
            Dim mregistro As Integer = Convert.ToInt32(e.CommandArgument)
            Dim conexao_1 As New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
            Try
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
                strreader = strreader & "tmp_prestadorxprestador.PrexPre_Servicos "
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

                End While
                'fechar
                dr.Close()
                dr = Nothing
                objCmd.Connection.Close()
                conexao_1.Close()
            Catch ex As Exception
                lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
                Imgbtn_Fechar_Mensagem.Visible = "true"
                Imgbtn_Sair_Mensagem.Visible = "false"
                Imgbtn_Sim_Mensagem.Visible = "false"
                Imgbtn_Nao_Mensagem.Visible = "false"
                MPE_Cadastro.Show()
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
                            txt_Cidade.Text = txt_Cidade.Text.ToUpper()
                            ht.Add("bairro", ds.Tables(0).Rows(0).Item("bairro").ToString().Trim())
                            txt_Bairro.Text = ds.Tables(0).Rows(0).Item("bairro").ToString().Trim()
                            txt_Bairro.Text = txt_Bairro.Text.ToUpper()
                            ht.Add("tipologradouro", ds.Tables(0).Rows(0).Item("tipo_logradouro").ToString().Trim())
                            ht.Add("logradouro", ds.Tables(0).Rows(0).Item("logradouro").ToString().Trim())
                            txt_Endereco.Text = ds.Tables(0).Rows(0).Item("tipo_logradouro").ToString().Trim() & " " & ds.Tables(0).Rows(0).Item("logradouro").ToString().Trim()
                            txt_Endereco.Text = txt_Endereco.Text.ToUpper()
                            ht.Add("tipo", 1)

                        Case "2"
                            ht.Add("UF", ds.Tables(0).Rows(0).Item("uf").ToString().Trim())
                            ddl_UF.SelectedValue = ds.Tables(0).Rows(0).Item("uf").ToString().Trim()
                            ht.Add("cidade", ds.Tables(0).Rows(0).Item("cidade").ToString().Trim())
                            txt_Cidade.Text = ds.Tables(0).Rows(0).Item("cidade").ToString().Trim()
                            txt_Cidade.Text = txt_Cidade.Text.ToUpper()
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
                            txt_Prestador_Municipio.Text = txt_Prestador_Municipio.Text.ToUpper()
                            ht.Add("bairro", ds.Tables(0).Rows(0).Item("bairro").ToString().Trim())
                            txt_Prestador_Bairro.Text = ds.Tables(0).Rows(0).Item("bairro").ToString().Trim()
                            txt_Prestador_Bairro.Text = txt_Prestador_Bairro.Text.ToUpper()
                            ht.Add("tipologradouro", ds.Tables(0).Rows(0).Item("tipo_logradouro").ToString().Trim())
                            ht.Add("logradouro", ds.Tables(0).Rows(0).Item("logradouro").ToString().Trim())
                            txt_Prestador_Endereco.Text = ds.Tables(0).Rows(0).Item("tipo_logradouro").ToString().Trim() & " " & ds.Tables(0).Rows(0).Item("logradouro").ToString().Trim()
                            txt_Prestador_Endereco.Text = txt_Prestador_Endereco.Text.ToUpper()
                            ht.Add("tipo", 1)

                        Case "2"
                            ht.Add("UF", ds.Tables(0).Rows(0).Item("uf").ToString().Trim())
                            ddl_Prestador_UF.SelectedValue = ds.Tables(0).Rows(0).Item("uf").ToString().Trim()
                            ht.Add("cidade", ds.Tables(0).Rows(0).Item("cidade").ToString().Trim())
                            txt_Prestador_Municipio.Text = ds.Tables(0).Rows(0).Item("cidade").ToString().Trim()
                            txt_Prestador_Municipio.Text = txt_Prestador_Municipio.Text.ToUpper()
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
        Dim objConnd As New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
        Dim mselecao, mregistro As Integer

        mregistro = Datagrid2.DataKeys(CInt(e.Item.ItemIndex))
        Try
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
            lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
        End Try

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
                lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
                Imgbtn_Fechar_Mensagem.Visible = "true"
                Imgbtn_Sair_Mensagem.Visible = "false"
                Imgbtn_Sim_Mensagem.Visible = "false"
                Imgbtn_Nao_Mensagem.Visible = "false"
                MPE_Cadastro.Show()
            End Try

            'zerando campos
            txtdescservico.Text = ""
            txtcodservico.Text = ""
            txtdescservico.Focus()


        Else
            'dar mensagem
            'lblConfirm.Text = ""
            'lblError.Text = "Informe o exame !!! "
            txtdescservico.Focus()
        End If
    End Sub
    Sub DataGrid3_itemdatabound(ByVal sender As Object, ByVal e As DataGridItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.SelectedItem Then
            Dim LinkButtonDelete As LinkButton = e.Item.FindControl("LnkBtnDel31")

        End If
    End Sub
    Sub DataGrid3_DeleteCommand(ByVal s As Object, ByVal e As DataGridCommandEventArgs)
        Dim objConnd As New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
        Dim mselecao, mregistro As Integer

        mregistro = Datagrid3.DataKeys(CInt(e.Item.ItemIndex))
        Try
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
            lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
        End Try

    End Sub
    Private Sub DataGrid3_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles Datagrid3.PageIndexChanged
        Datagrid3.CurrentPageIndex = e.NewPageIndex
        Datagrid3.DataBind()
    End Sub
    Protected Sub ImageButton31_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton31.Click
        'pegando dados

        Dim objConn As New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
        Dim mnome_servico As String
        Dim mcodservico As Integer

        mnome_servico = txtdescservico1.Text

        Dim exe_descservico As String
        exe_descservico = Replace(txtdescservico1.Text, ",", " ")
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
            Catch ex As Exception
                lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
                Imgbtn_Fechar_Mensagem.Visible = "true"
                Imgbtn_Sair_Mensagem.Visible = "false"
                Imgbtn_Sim_Mensagem.Visible = "false"
                Imgbtn_Nao_Mensagem.Visible = "false"
                MPE_Cadastro.Show()
            End Try

            'zerando campos
            txtdescservico.Text = ""
            txtcodservico.Text = ""
            txtdescservico.Focus()

        Else

            txtdescservico.Focus()
        End If
    End Sub


    Protected Sub btn_CEP_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_CEP.Click
        BuscaCep(txt_CEP.Text)
    End Sub

    Protected Sub btn_CEP_Prestador_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_CEP_Prestador.Click
        BuscaCep_Prestador(txt_Prestador_CEP.Text)
    End Sub

    Protected Sub Lnkbtn_01_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Lnkbtn_01.Click
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
        ddl_Prestador_EstadoCivil.SelectedValue = ddl_Representante_EstadoCivil.SelectedValue
        ddl_Prestador_UF.SelectedValue = ddl_UF.SelectedValue

    End Sub

    Protected Sub btn_Salvar_Documento_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_Salvar_Documento.Click
        'abrindo conexao
        Dim m_doc_descricao, m_cnpj, m_info, m_data As String
        Dim m_dias_validade, mdiferenca, m_obrigatorio, m_qtde_permitida, m_doc_ID, mdata_ok As Integer
        Dim mdata_emissao, mdata_validade As Date
        Dim m_grava_ok, m_upload_ok, m_desc_docto, m_extensao, m_arq As String
        Dim m_tamanho, m_permitido As Double

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
            txt_erro_documento.Text = "Preencha os dados do documento corretamente !!!"
        Else

            txt_erro_documento.Text = ""

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
                    txt_erro_documento.Text = "ATENÇÃO !!! Data de Validade Inválida !!!"
                    txt_erro_documento.Text = "ATENÇÃO !!! Data de Validade deve ser maior que a Data de Emissão !!!"
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
                            txt_erro_documento.Text = "Tamanho Máximo permitido é de " & m_permitido & " kb !"
                        End If

                        If (m_extensao <> ".pdf") Then
                            m_upload_ok = "N"
                            txt_erro_documento.Text = txt_erro_documento.Text & Chr(13) & "Extensão inválida, só é permitido .pdf !" & Chr(13)
                        End If

                    End If
                    If m_obrigatorio = 1 And PrexDoc_Nome.FileName = "" And txt_prexdoc_doc.Text = "" Then
                        m_upload_ok = "N"
                        txt_erro_documento.Text = txt_erro_documento.Text & Chr(13) & "ATENÇÃO !!! É obrigatório fazer o Upload do documento !!!"
                    End If

                    If m_upload_ok = "N" Then
                        'lbl_erro_documento.Text = "ATENÇÃO !!! É obrigatório fazer o Upload do documento !!!"
                    Else

                        'txtCalendario_ATA.Text = "Documentos\" & FU_ATA.FileName
                        strexec = "DELETE tmp_prestadorxdocumento FROM tmp_prestadorxdocumento "
                        strexec = strexec & "WHERE tmp_prestadorxdocumento.PrexDoc_Id = " & txt_prexdoc_registro.Text & ""

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
                        txt_prexdoc_ajuda.Text = ""


                        lbl_Error.Text = ""
                        lbl_erro_documento.Text = ""

                        strreader = "SELECT cad_documento.Doc_ID,cad_documento.Doc_Descricao,"
                        strreader = strreader & "cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio "
                        strreader = strreader & "FROM cad_documento "
                        strreader = strreader & "WHERE cad_documento.Doc_ID>0 "
                        If lbl_cod_tipoprestador.Text = "1" Then
                            strreader = strreader & "and cad_documento.Doc_Prestador=1 "
                        End If
                        If lbl_cod_tipoprestador.Text = "2" Then
                            strreader = strreader & "and cad_documento.Doc_Fornecedor=1 "
                        End If
                        If lbl_cod_tipoempresa.Text = "1" Then
                            strreader = strreader & "and cad_documento.Doc_AC=1 "
                        End If
                        If lbl_cod_tipoempresa.Text = "2" Then
                            strreader = strreader & "and cad_documento.Doc_EPP=1 "
                        End If
                        If lbl_cod_tipoempresa.Text = "3" Then
                            strreader = strreader & "and cad_documento.Doc_EI=1 "
                        End If
                        If lbl_cod_tipoempresa.Text = "4" Then
                            strreader = strreader & "and cad_documento.Doc_LTDA=1 "
                        End If
                        If lbl_cod_tipoempresa.Text = "5" Then
                            strreader = strreader & "and cad_documento.Doc_EIRELI=1 "
                        End If
                        If lbl_cod_tipoempresa.Text = "6" Then
                            strreader = strreader & "and cad_documento.Doc_MEI=1 "
                        End If
                        If lbl_cod_tipoempresa.Text = "7" Then
                            strreader = strreader & "and cad_documento.Doc_ME=1 "
                        End If
                        If lbl_cod_tipoempresa.Text = "8" Then
                            strreader = strreader & "and cad_documento.Doc_SA=1 "
                        End If
                        If lbl_cod_tipoempresa.Text = "9" Then
                            strreader = strreader & "and cad_documento.Doc_SS=1 "
                        End If
                        If lbl_cod_tipoempresa.Text = "10" Then
                            strreader = strreader & "and cad_documento.Doc_PFisica=1 "
                        End If
                        strreader = strreader & "order by cad_documento.Doc_Descricao "

                        SqlDocumento.SelectCommand = strreader

                        ddlDocumento.ClearSelection()
                        ddlDocumento.DataBind()

                    End If

                End If

                'objCmd.Connection.Close()

                'fechar
                objConn.Close()
                objConn = Nothing
            Catch ex As Exception
                lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
                Imgbtn_Fechar_Mensagem.Visible = "true"
                Imgbtn_Sair_Mensagem.Visible = "false"
                Imgbtn_Sim_Mensagem.Visible = "false"
                Imgbtn_Nao_Mensagem.Visible = "false"
                MPE_Cadastro.Show()
            End Try

        End If

    End Sub

    Protected Sub btn_Salvar_Prestador_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_Salvar_Prestador.Click
        'abrindo conexao
        ' Dim m_pre_nome, m_pre_rg, m_pre_cpf, m_pre_nacionalidade, m_pre_estadocivil, m_pre_profissao As String
        ' Dim m_pre_endereco, m_pre_numero, m_pre_complemento, m_pre_bairro, m_pre_cep, m_pre_municipio As String
        ' Dim m_pre_uf, m_pre_servicos As String

        objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)
        'excluir caso ja exista
        If txt_prexpre_registro.Text = "" Then
            txt_prexpre_registro.Text = "0"
        End If
        Try
            If txt_Prestador_Nome.Text = "" Or txt_Prestador_RG.Text = "" Or txt_Prestador_CPF.Text = "" Or txt_Prestador_Nacionalidade.Text = "" Or ddl_Prestador_EstadoCivil.SelectedValue = "" Or txt_Prestador_CEP.Text = "" Or txt_Prestador_Endereco.Text = "" Or txt_Prestador_Numero.Text = "" Or txt_Prestador_Bairro.Text = "" Or txt_Prestador_Municipio.Text = "" Or ddl_Prestador_UF.SelectedValue = "" Then
                txt_erro_prestador.Text = "ATENÇÃO !!! Preencha os campos corretamente !!! "

            Else
                txt_erro_prestador.Text = ""
                If 1 = 1 Then

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

                    strexec = "INSERT INTO tmp_prestadorxprestador(Pre_ID,Pre_CNPJ,PrexPre_Nome,PrexPre_RG,PrexPre_CPF,PrexPre_Nacionalidade, "
                    strexec = strexec & "PrexPre_Estado_Civil,PrexPre_Profissao,PrexPre_Endereco,PrexPre_Numero,PrexPre_Complemento,PrexPre_Bairro, "
                    strexec = strexec & "PrexPre_CEP,PrexPre_Municipio,PrexPre_UF,PrexPre_Telefone,PrexPre_Celular,PrexPre_Email,PrexPre_Servicos) "
                    strexec = strexec & "VALUES(" & CodPrestador & ",'" & txt_CNPJ.Text & "','" & txt_Prestador_Nome.Text & "','"
                    strexec = strexec & "" & txt_Prestador_RG.Text & "','" & txt_Prestador_CPF.Text & "','" & txt_Prestador_Nacionalidade.Text & "','"
                    strexec = strexec & "" & ddl_Prestador_EstadoCivil.SelectedValue & "','" & txt_Prestador_Profissao.Text & "','"
                    strexec = strexec & "" & txt_Prestador_Endereco.Text & "','" & txt_Prestador_Numero.Text & "','" & txt_Prestador_Complemento.Text & "','"
                    strexec = strexec & "" & txt_Prestador_Bairro.Text & "','" & txt_Prestador_CEP.Text & "','" & txt_Prestador_Municipio.Text & "','"
                    strexec = strexec & "" & ddl_Prestador_UF.SelectedValue & "','" & txt_Prestador_Telefone.Text & "','" & txt_Prestador_Celular.Text & "','"
                    strexec = strexec & "" & txt_Prestador_Email.Text & "','" & txt_Prestador_Servico.Text & "')"
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
                    strreader = strreader & "tmp_prestadorxprestador.PrexPre_Servicos "
                    strreader = strreader & "FROM tmp_prestadorxprestador "
                    strreader = strreader & "WHERE "
                    strreader = strreader & "tmp_prestadorxprestador.Pre_CNPJ = '" & txt_CNPJ.Text & "' "
                    strreader = strreader & "order by tmp_prestadorxprestador.PrexPre_Nome "

                    SqlPrexPre.SelectCommand = strreader

                    GridView2.DataBind()

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
                    lbl_erro_prestador.Text = ""
                End If


            End If

            'objCmd.Connection.Close()

            'fechar
            objConn.Close()
            objConn = Nothing
        Catch ex As Exception
            lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
        End Try

    End Sub
    Protected Sub chk_aceite_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chk_aceite.CheckedChanged
        'If chk_aceite.Checked = "true" Then
        ' Imgbtn_Cadastrar.Enabled = "true"
        ' Imgbtn_Cadastrar.Visible = "true"
        ' Else
        ' Imgbtn_Cadastrar.Enabled = "false"
        ' Imgbtn_Cadastrar.Visible = "false"
        ' End If
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
            lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
        End Try

    End Sub
    Protected Sub btn_Excluir_Documento_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_Excluir_Documento.Click
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
            lbl_Error.Text = ""
            lbl_erro_documento.Text = ""

            strreader = "SELECT cad_documento.Doc_ID,cad_documento.Doc_Descricao,"
            strreader = strreader & "cad_documento.Doc_Onde_Obter,cad_documento.Doc_Obrigatorio "
            strreader = strreader & "FROM cad_documento "
            strreader = strreader & "WHERE cad_documento.Doc_ID>0 "
            If lbl_cod_tipoprestador.Text = "1" Then
                strreader = strreader & "and cad_documento.Doc_Prestador=1 "
            End If
            If lbl_cod_tipoprestador.Text = "2" Then
                strreader = strreader & "and cad_documento.Doc_Fornecedor=1 "
            End If
            If lbl_cod_tipoempresa.Text = "1" Then
                strreader = strreader & "and cad_documento.Doc_MEI=1 "
            End If
            If lbl_cod_tipoempresa.Text = "2" Then
                strreader = strreader & "and cad_documento.Doc_ME=1 "
            End If
            If lbl_cod_tipoempresa.Text = "3" Then
                strreader = strreader & "and cad_documento.Doc_LTDA=1 "
            End If
            If lbl_cod_tipoempresa.Text = "4" Then
                strreader = strreader & "and cad_documento.Doc_AC=1 "
            End If
            If lbl_cod_tipoempresa.Text = "5" Then
                strreader = strreader & "and cad_documento.Doc_EIRELI=1 "
            End If
            If lbl_cod_tipoempresa.Text = "6" Then
                strreader = strreader & "and cad_documento.Doc_PFisica=1 "
            End If
            strreader = strreader & "order by cad_documento.Doc_Descricao "

            SqlDocumento.SelectCommand = strreader

            ddlDocumento.ClearSelection()
            ddlDocumento.DataBind()


            'fechar
            objConn.Close()
            objConn = Nothing
        Catch ex As Exception
            lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
        End Try

        btn_Excluir_Documento.Visible = False

    End Sub
    Protected Sub LinkButton4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton4.Click
        Response.Redirect("Login_Cadastro.aspx")
        Response.End()
    End Sub
    Protected Sub Imgbtn_Continuar_0_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Continuar_0.Click
        Dim m_tipo_empresa, m_licitacao, m_categoria As Integer
        Dim m_codigo As String
        Dim m_ok_cadastro As Integer

        m_ok_cadastro = 0

        If (txt_cad_CPF.Text = "" Or txt_cad_CPF.Text = "Digite aqui apenas se você for pessoa física") And (txt_cad_CNPJ.Text = "" Or txt_cad_CNPJ.Text = "Digite aqui apenas se você for pessoa jurídica") Then
            lbl_mensagem_cadastro.Text = "Para Pessoa Física informe o CPF ou para Pessoa Jurídica informe o CNPJ !!!"
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
            m_ok_cadastro = 1
        End If

        m_codigo = ""

        If m_ok_cadastro = 0 Then

            If (txt_cad_CPF.Text <> "" And txt_cad_CPF.Text <> "Digite aqui apenas se você for pessoa física") Then
                m_codigo = Trim(txt_cad_CPF.Text)
            Else
                If txt_cad_CNPJ.Text <> "" And txt_cad_CNPJ.Text <> "Digite aqui apenas se você for pessoa jurídica" Then
                    m_codigo = Trim(txt_cad_CNPJ.Text)
                End If
            End If

            txt_CNPJ.Text = m_codigo
            Try
                'abrindo conexao
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                'verificar se ja existe
                strreader = "SELECT cad_prestador.Pre_ID,cad_prestador.Pre_CNPJ,cad_prestador.Pre_Senha from cad_prestador WHERE "
                strreader = strreader & "cad_prestador.Pre_CNPJ='" & m_codigo & "'"
                objCmd = New MySqlCommand(strreader, objConn)

                'criar datareader
                objCmd.Connection.Open()
                dr = objCmd.ExecuteReader()

                'se achar
                If dr.Read Then
                    If txt_novo.Text = "Sim" Then
                        'primeira vez que esta verificando
                        lbl_mensagem_cadastro.Text = "Voce já está cadastrado !!! "
                        Imgbtn_Fechar_Mensagem.Visible = "false"
                        Imgbtn_Sair_Mensagem.Visible = "true"
                        Imgbtn_Sim_Mensagem.Visible = "false"
                        Imgbtn_Nao_Mensagem.Visible = "false"
                        MPE_Cadastro.Show()
                        m_ok_cadastro = 2
                        Label571.Visible = True
                        LinkButton4.Visible = True

                    End If
                Else
                    txt_novo.Text = "Nao"
                    'novo registro, nao tem cadastro
                End If

                objCmd.Connection.Close()

                'fechando
                dr.Close()
                dr = Nothing
                objConn.Close()
                objConn = Nothing
            Catch ex As Exception
                lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
                Imgbtn_Fechar_Mensagem.Visible = "true"
                Imgbtn_Sair_Mensagem.Visible = "false"
                Imgbtn_Sim_Mensagem.Visible = "false"
                Imgbtn_Nao_Mensagem.Visible = "false"
                MPE_Cadastro.Show()
            End Try

        End If

        If m_ok_cadastro = 0 Then

            Session("CNPJPrestador") = m_codigo
            Session("DocPrestador") = m_codigo

            m_tipo_empresa = 0
            m_licitacao = 0
            m_categoria = 0
            If RB_TipoEmpresa.SelectedValue = "1" Or RB_TipoEmpresa.SelectedValue = "2" Or RB_TipoEmpresa.SelectedValue = "3" Or RB_TipoEmpresa.SelectedValue = "4" Or RB_TipoEmpresa.SelectedValue = "5" Or RB_TipoEmpresa.SelectedValue = "6" Or RB_TipoEmpresa.SelectedValue = "7" Or RB_TipoEmpresa.SelectedValue = "8" Or RB_TipoEmpresa.SelectedValue = "9" Or RB_TipoEmpresa.SelectedValue = "10" Then
                m_tipo_empresa = 1
            End If
            If RB_Licitacao.SelectedValue = "Sim" Or RB_Licitacao.SelectedValue = "Nao" Then
                m_licitacao = 1
            End If
            If RB_Categoria.SelectedValue = "1" Or RB_Categoria.SelectedValue = "2" Then
                m_categoria = 1
            End If

            If m_tipo_empresa = 0 Or m_licitacao = 0 Or m_categoria = 0 Then
                Label19.Visible = "true"
                lbl_mensagem_cadastro.Text = "Informe os dados obrigatórios !!!"
                Imgbtn_Fechar_Mensagem.Visible = "true"
                Imgbtn_Sair_Mensagem.Visible = "false"
                Imgbtn_Sim_Mensagem.Visible = "false"
                Imgbtn_Nao_Mensagem.Visible = "false"
                MPE_Cadastro.Show()
            Else

                lbl_TipoEmpresa.Text = RB_TipoEmpresa.SelectedItem.Text
                lbl_cod_tipoempresa.Text = RB_TipoEmpresa.SelectedValue
                lbl_cod_tipoprestador.Text = RB_Categoria.SelectedValue

                Me.Limpa_TMP()
                Me.Carrega_TMP()
                Label19.Visible = "false"
                Label19.Text = ""
                If RB_TipoEmpresa.SelectedValue = "10" Then
                    TabPanel_0.Enabled = "false"
                    TabPanel_12.Enabled = "true"
                    TabPanel_12.Visible = "true"
                    Tabs.ActiveTab = TabPanel_12
                    TabPanel_11.Enabled = "false"
                    TabPanel_11.Visible = "false"
                Else
                    TabPanel_0.Enabled = "false"
                    TabPanel_11.Enabled = "true"
                    TabPanel_11.Visible = "true"
                    Tabs.ActiveTab = TabPanel_11
                    TabPanel_12.Enabled = "false"
                    TabPanel_12.Visible = "false"
                End If

            End If
        End If

    End Sub
    Protected Sub Imgbtn_Cancelar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Cancelar.Click
        lbl_mensagem_cadastro.Text = "Confirma o cancelamento de seu cadastro ? "
        Imgbtn_Fechar_Mensagem.Visible = "false"
        Imgbtn_Sair_Mensagem.Visible = "false"
        Imgbtn_Sim_Mensagem.Visible = "true"
        Imgbtn_Nao_Mensagem.Visible = "true"
        MPE_Cadastro.Show()
       
      
    End Sub

    Protected Sub Imgbtn_Continuar_11_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Continuar_11.Click
        If (txt_Senha.Text = "" Or txt_Confirma_Senha.Text = "") Or txt_Senha.Text <> txt_Confirma_Senha.Text Then

            lbl_mensagem_cadastro.Text = "Informe a senha corretamente !!!"
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()

        Else
            If txt_Razao_Social.Text = "" Then
                lbl_mensagem_cadastro.Text = "Informe a Razão Social corretamente !!!"
                Imgbtn_Fechar_Mensagem.Visible = "true"
                Imgbtn_Sair_Mensagem.Visible = "false"
                Imgbtn_Sim_Mensagem.Visible = "false"
                Imgbtn_Nao_Mensagem.Visible = "false"
                MPE_Cadastro.Show()
            Else
                Gravar_Prestador()
                lbl_Identificacao.Text = RTrim(txt_Razao_Social.Text) & " - CNPJ: " & txt_cad_CNPJ.Text & " - ID: " & txt_ID.Text
                lbl_Error_ID.Visible = "false"
                lbl_Error_ID.Text = ""
                lbl_Error_ID.Visible = "false"
                TabPanel_11.Enabled = "false"
                TabPanel_12.Enabled = "false"
                TabPanel_2.Enabled = "true"
                Tabs.ActiveTab = TabPanel_2
            End If

        End If
    End Sub

    Protected Sub Imgbtn_Voltar_11_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Voltar_11.Click
        lbl_Error_ID.Visible = "false"
        lbl_Error_ID.Text = ""
        lbl_Error_ID.Visible = "false"
        TabPanel_11.Enabled = "false"
        TabPanel_12.Enabled = "false"
        TabPanel_0.Enabled = "true"
        Tabs.ActiveTab = TabPanel_0
    End Sub

    Protected Sub Imgbtn_Continuar_12_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Continuar_12.Click
        If (txt_Senha0.Text = "" Or txt_Confirma_Senha0.Text = "") Or txt_Senha0.Text <> txt_Confirma_Senha0.Text Then

            lbl_mensagem_cadastro.Text = "Informe a senha corretamente !!!"
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
        Else
            If txt_PF_Nome.Text = "" Or txt_PF_RG.Text = "" Or (txt_PF_PISPASEP.Text = "" Or txt_PF_NIT.Text = "") Then
                lbl_mensagem_cadastro.Text = "Informe os campos obrigatórios corretamente !!!"
                Imgbtn_Fechar_Mensagem.Visible = "true"
                Imgbtn_Sair_Mensagem.Visible = "false"
                Imgbtn_Sim_Mensagem.Visible = "false"
                Imgbtn_Nao_Mensagem.Visible = "false"
                MPE_Cadastro.Show()
            Else
                lbl_Error_ID0.Visible = "false"
                lbl_Error_ID0.Text = ""
                Gravar_Prestador()
                lbl_Identificacao.Text = RTrim(txt_PF_Nome.Text) & " - CPF: " & txt_cad_CPF.Text & " - ID: " & txt_ID.Text
                lbl_Error_ID0.Visible = "false"
                TabPanel_11.Enabled = "false"
                TabPanel_12.Enabled = "false"
                TabPanel_2.Enabled = "true"
                Tabs.ActiveTab = TabPanel_2
            End If

        End If
    End Sub

    Protected Sub Imgbtn_Voltar_12_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Voltar_12.Click
        lbl_Error_ID0.Visible = "false"
        lbl_Error_ID0.Text = ""
        'Gravar_Prestador()
        TabPanel_11.Enabled = "false"
        TabPanel_12.Enabled = "false"
        TabPanel_0.Enabled = "true"
        Tabs.ActiveTab = TabPanel_0
    End Sub

    Protected Sub Imgbtn_Continuar_2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Continuar_2.Click
        If txt_CEP.Text = "" Or txt_Endereco.Text = "" Or txt_Numero.Text = "" Or txt_Bairro.Text = "" Or txt_Cidade.Text = "" Or ddl_UF.SelectedValue = "Selecione" Or txt_Telefone.Text = "" Or txt_Email.Text = "" Then
            lbl_mensagem_cadastro.Text = "Informe os campos obrigatórios corretamente !!!"
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
        Else
          
            Gravar_Prestador()
            TabPanel_2.Enabled = "false"
            TabPanel_3.Enabled = "true"
            Tabs.ActiveTab = TabPanel_3
        End If
    End Sub

    Protected Sub Imgbtn_Voltar_2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Voltar_2.Click
        If RB_TipoEmpresa.SelectedValue = "10" Then
            TabPanel_2.Enabled = "false"
            TabPanel_12.Enabled = "true"
            TabPanel_12.Visible = "true"
            Tabs.ActiveTab = TabPanel_12
            TabPanel_11.Enabled = "false"
            TabPanel_11.Visible = "false"
        Else
            TabPanel_2.Enabled = "false"
            TabPanel_11.Enabled = "true"
            TabPanel_11.Visible = "true"
            Tabs.ActiveTab = TabPanel_11
            TabPanel_12.Enabled = "false"
            TabPanel_12.Visible = "false"
        End If
     
    End Sub

    Protected Sub Imgbtn_Continuar_3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Continuar_3.Click
        Gravar_Prestador()
        TabPanel_3.Enabled = "false"
        TabPanel_4.Enabled = "true"
        Tabs.ActiveTab = TabPanel_4
    End Sub

    Protected Sub Imgbtn_Voltar_3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Voltar_3.Click
        Gravar_Prestador()
        TabPanel_3.Enabled = "false"
        TabPanel_2.Enabled = "true"
        Tabs.ActiveTab = TabPanel_2
    End Sub

    Protected Sub Imgbtn_Continuar_4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Continuar_4.Click
        Gravar_Prestador()
        TabPanel_4.Enabled = "false"
        TabPanel_5.Enabled = "true"
        Tabs.ActiveTab = TabPanel_5
    End Sub

    Protected Sub Imgbtn_Voltar_4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Voltar_4.Click
        Gravar_Prestador()
        TabPanel_4.Enabled = "false"
        TabPanel_3.Enabled = "true"
        Tabs.ActiveTab = TabPanel_3
    End Sub

    Protected Sub Imgbtn_Continuar_5_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Continuar_5.Click
        Gravar_Prestador()
        TabPanel_5.Enabled = "false"
        TabPanel_6.Enabled = "true"
        Tabs.ActiveTab = TabPanel_6
    End Sub

    Protected Sub Imgbtn_Voltar_5_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Voltar_5.Click
        Gravar_Prestador()
        TabPanel_5.Enabled = "false"
        TabPanel_4.Enabled = "true"
        Tabs.ActiveTab = TabPanel_4
    End Sub

    Protected Sub Imgbtn_Finalizar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Finalizar.Click
        If chk_aceite.Checked = "true" Then
            Gravar_Prestador()
            lbl_mensagem_cadastro.Text = "CADASTRO FINALIZADO COM SUCESSO !!! </BR> Utilize seus dados para acessar seu cadastro e complementá-lo."
            Imgbtn_Fechar_Mensagem.Visible = "false"
            Imgbtn_Sair_Mensagem.Visible = "true"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
            TabPanel_6.Enabled = "false"
         
        Else
            lbl_mensagem_cadastro.Text = "Caso não esteja de acordo com os termos, seu cadastro não será efetivado !!!"
            Imgbtn_Fechar_Mensagem.Visible = "true"
            Imgbtn_Sair_Mensagem.Visible = "false"
            Imgbtn_Sim_Mensagem.Visible = "false"
            Imgbtn_Nao_Mensagem.Visible = "false"
            MPE_Cadastro.Show()
        End If
    End Sub

    Protected Sub Imgbtn_Voltar_6_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Voltar_6.Click
        Gravar_Prestador()
        TabPanel_6.Enabled = "false"
        TabPanel_5.Enabled = "true"
        Tabs.ActiveTab = TabPanel_6
    End Sub

    Protected Sub Imgbtn_Fechar_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Fechar_Mensagem.Click
        MPE_Cadastro.Hide()
    End Sub

    Protected Sub Imgbtn_Sim_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Sim_Mensagem.Click
        If txt_novo.Text = "Sim" Then

            Try
                'abrindo conexao
                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                strexec = "DELETE cad_prestador "
                strexec = strexec & "FROM cad_prestador "
                strexec = strexec & "WHERE cad_prestador.Pre_CNPJ='" & txt_CNPJ.Text & "'"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.Connection.Open()
                objCmd.ExecuteNonQuery()

                strexec = "DELETE cad_prestadorxdocumento "
                strexec = strexec & "FROM cad_prestadorxdocumento "
                strexec = strexec & "WHERE "
                strexec = strexec & "cad_prestadorxdocumento.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                strexec = "DELETE cad_prestadorxsermat "
                strexec = strexec & "FROM cad_prestadorxsermat "
                strexec = strexec & "WHERE "
                strexec = strexec & "cad_prestadorxsermat.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                strexec = "DELETE cad_prestadorxprestador "
                strexec = strexec & "FROM cad_prestadorxprestador "
                strexec = strexec & "WHERE "
                strexec = strexec & "cad_prestadorxprestador.Pre_CNPJ= '" & txt_CNPJ.Text & "'"
                objCmd = New MySqlCommand(strexec, objConn)
                objCmd.ExecuteNonQuery()

                'fechar
                objCmd.Connection.Close()
                objConn.Close()
            Catch ex As Exception
                lbl_mensagem_cadastro.Text = "Ocorreu uma falha de conexão com o banco de dados !!! " & Chr(13) & ex.Message
                Imgbtn_Fechar_Mensagem.Visible = "true"
                Imgbtn_Sair_Mensagem.Visible = "false"
                Imgbtn_Sim_Mensagem.Visible = "false"
                Imgbtn_Nao_Mensagem.Visible = "false"
                MPE_Cadastro.Show()
            End Try

        End If
        lbl_mensagem_cadastro.Text = "Cadastro cancelado com sucesso !!!"
        Imgbtn_Fechar_Mensagem.Visible = "false"
        Imgbtn_Sair_Mensagem.Visible = "true"
        Imgbtn_Sim_Mensagem.Visible = "false"
        Imgbtn_Nao_Mensagem.Visible = "false"
        MPE_Cadastro.Show()
    End Sub

    Protected Sub Imgbtn_Nao_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Nao_Mensagem.Click
        MPE_Cadastro.Hide()
    End Sub

    Protected Sub Imgbtn_Sair_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Imgbtn_Sair_Mensagem.Click
        MPE_Cadastro.Hide()
        Response.Redirect("Login_Cadastro.aspx")
        Response.End()
    End Sub

    Protected Sub rb_pessoa_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rb_pessoa.SelectedIndexChanged

        If rb_pessoa.SelectedValue = "PF" Then

            txt_cad_CPF.Text = "Digite aqui apenas se você for pessoa física"
            txt_cad_CNPJ.Text = "Digite aqui apenas se você for pessoa jurídica"

            txt_cad_CNPJ.Enabled = "false"
            txt_cad_CPF.Enabled = "true"
            RB_TipoEmpresa.SelectedValue = 10
            RB_TipoEmpresa.Items(0).Enabled = "false"
            RB_TipoEmpresa.Items(1).Enabled = "false"
            RB_TipoEmpresa.Items(2).Enabled = "false"
            RB_TipoEmpresa.Items(3).Enabled = "false"
            RB_TipoEmpresa.Items(4).Enabled = "false"
            RB_TipoEmpresa.Items(5).Enabled = "false"
            RB_TipoEmpresa.Items(6).Enabled = "false"
            RB_TipoEmpresa.Items(7).Enabled = "false"
            RB_TipoEmpresa.Items(8).Enabled = "false"
            RB_TipoEmpresa.Items(9).Enabled = "true"
        End If
        If rb_pessoa.SelectedValue = "PJ" Then

            txt_cad_CPF.Text = "Digite aqui apenas se você for pessoa física"
            txt_cad_CNPJ.Text = "Digite aqui apenas se você for pessoa jurídica"

            txt_cad_CPF.Enabled = "false"
            txt_cad_CNPJ.Enabled = "true"
            RB_TipoEmpresa.SelectedValue = 1
            RB_TipoEmpresa.Items(0).Enabled = "true"
            RB_TipoEmpresa.Items(1).Enabled = "true"
            RB_TipoEmpresa.Items(2).Enabled = "true"
            RB_TipoEmpresa.Items(3).Enabled = "true"
            RB_TipoEmpresa.Items(4).Enabled = "true"
            RB_TipoEmpresa.Items(5).Enabled = "true"
            RB_TipoEmpresa.Items(6).Enabled = "true"
            RB_TipoEmpresa.Items(7).Enabled = "true"
            RB_TipoEmpresa.Items(8).Enabled = "true"
            RB_TipoEmpresa.Items(9).Enabled = "false"
        End If
    End Sub


    Protected Sub txt_Banco_Agencia_TextChanged(sender As Object, e As EventArgs) Handles txt_Banco_Agencia.TextChanged

    End Sub
End Class
