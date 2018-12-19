Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Imports System.Web.DynamicData
Imports System.Web.Routing
Imports System.Net.Mail

Partial Class Login_Cadastro
    Inherits System.Web.UI.Page
    Dim objConn, objConn1 As MySqlConnection
    Dim objCmd, objCmd1 As MySqlCommand
    Dim dr, dr1 As MySqlDataReader
    Dim strReader As String
    Dim Email, Senha As String
    Dim data, DadosUsuario As String
    Dim objEmail As System.Net.Mail.MailMessage
    Dim objSmtp As New System.Net.Mail.SmtpClient
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        txt_CNPJ.Attributes.Add("onfocus", String.Format("RecebeFoco_CNPJ('{0}');", txt_CNPJ.ClientID))
        txt_CNPJ.Attributes.Add("onblur", String.Format("PerdeFoco_CNPJ('{0}');", txt_CNPJ.ClientID))
        'txt_CNPJ.Attributes.Add("onblur", String.Format("desativar();", txt_CNPJ.ClientID))
        txt_CPF.Attributes.Add("onfocus", String.Format("RecebeFoco_CPF('{0}');", txt_CPF.ClientID))
        txt_CPF.Attributes.Add("onblur", String.Format("PerdeFoco_CPF('{0}');", txt_CPF.ClientID))
        'txt_CPF.Attributes.Add("onblur", String.Format("desativar();", txt_CPF.ClientID))
        txt_Senha.Attributes.Add("onfocus", String.Format("RecebeFoco_Senha('{0}');", txt_Senha.ClientID))

        'txt_Senha_Mostra.Attributes.Add("onfocus", String.Format("RecebeFoco_Senha('{0}');", txt_Senha.ClientID))
        'txt_Senha.Attributes.Add("onblur", String.Format("PerdeFoco_Senha('{0}');", txt_Senha.ClientID))

        'txt_CNPJ.Attributes.Add("onKeyPress", "javascript:MascaraCNPJ(txt_CNPJ)")
        txt_CNPJ.Attributes.Add("onkeyup", "javascript:formatar(this, '##.###.###/####-##')")
        ' txt_CNPJ.Attributes.Add("onBlur", "javascript:ValidarCNPJ(txt_CNPJ)")
        txt_CPF.Attributes.Add("onkeyup", "javascript:formatar(this, '###.###.###-##')")
        ' txt_CPF.Attributes.Add("onBlur", "javascript:valida_cpf(txt_CPF)")


        If txt_CNPJ.Text <> "Digite aqui apenas se você for pessoa jurídica" Then
            txt_CPF.Text = "Digite aqui apenas se você for pessoa física"
            'txt_CPF.Enabled = "false"
        End If
        If txt_CPF.Text <> "Digite aqui apenas se você for pessoa física" Then
            txt_CNPJ.Text = "Digite aqui apenas se você for pessoa jurídica"
            'txt_CNPJ.Enabled = "false"
        End If

    End Sub
  
    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_esqueceu.Click

        Response.Redirect("Enviar_Senha.aspx")
        Response.End()

      
    End Sub
    Protected Sub LinkButton4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton4.Click
        Session("CNPJPrestador") = "0"

        Session("DocPrestador") = "0"

        Response.Redirect("Cadastro_Prestador.aspx")
        Response.End()
    End Sub
    Protected Sub btn_entrar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_entrar.Click

        Dim m_codigo As String
        'pegando dados
        Email = txt_CNPJ.Text
        Senha = txt_Senha.Text

        m_codigo = ""

        If txt_CNPJ.Text <> "Digite aqui apenas se você for pessoa jurídica" Then
            m_codigo = RTrim(txt_CNPJ.Text)
        Else
            If txt_CPF.Text <> "Digite aqui apenas se você for pessoa física" Then
                m_codigo = RTrim(txt_CPF.Text)
            End If
        End If

        If 1 = 1 Then

            If txtCaptcha.Text <> "V" Then

                lbl_mensagem_1.Text = "FALHA NA AUTENTICAÇÃO !!!"
                lbl_mensagem_2.Text = " VOCE É UM ROBÔ ?"
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_Login.Show()

                txtCaptcha.Text = ""

            Else
                Dim TestValue As String = txtCaptcha.Text.Trim.ToUpper(System.Globalization.CultureInfo.CreateSpecificCulture("en-US"))
                If 1 = 1 Then ' StrComp(TestValue, Session("ASPCAPTCHA").ToString.Trim, CompareMethod.Text) = 0 Then
                    'lblResult.Text = "CAPTCHA PASSED"
                    'lblResult.ForeColor = Drawing.Color.Green
                    If m_codigo <> "" Then
                        'pegando dados

                        Senha = txt_Senha.Text

                        'abrindo conexao
                        objConn1 = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                        'verifica se é administrador/gerente
                        strReader = "SELECT "
                        strReader = strReader & "cad_usuario.usu_id,"
                        strReader = strReader & "cad_usuario.usu_codigo,"
                        strReader = strReader & "cad_usuario.usu_perfil,"
                        strReader = strReader & "cad_usuario.usu_senha "
                        strReader = strReader & "FROM cad_usuario "
                        strReader = strReader & "WHERE cad_usuario.usu_codigo='" & m_codigo & "' and cad_usuario.usu_senha='" & Senha & "' "

                        Try

                            objCmd1 = New MySqlCommand(strReader, objConn1)

                            'criar datareader
                            objCmd1.Connection.Open()
                            dr1 = objCmd1.ExecuteReader()

                            'se achar
                            If dr1.Read Then
                                Session("CodPrestador") = dr1("usu_id")
                                Session("Perfil") = dr1("usu_perfil")
                                Session("PasPrestador") = txt_Senha.Text
                                objCmd1.Connection.Close()
                                objConn1.Close()
                                objConn1 = Nothing
                                Response.Redirect("Cadastro_Menu.aspx")
                                Response.End()
                            Else

                                'abrindo conexao
                                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                                'verificar se ja existe
                                strReader = "SELECT cad_prestador.Pre_ID,cad_prestador.Pre_CNPJ,cad_prestador.Pre_Senha from cad_prestador WHERE "
                                strReader = strReader & "cad_prestador.Pre_CNPJ='" & m_codigo & "' AND cad_prestador.Pre_Senha='" & Senha & "' "
                                objCmd = New MySqlCommand(strReader, objConn)

                                'criar datareader
                                objCmd.Connection.Open()
                                dr = objCmd.ExecuteReader()

                                'se achar
                                If dr.Read Then
                                    Session("CodPrestador") = dr("Pre_ID")
                                    Session("DocPrestador") = m_codigo
                                    Session("PasPrestador") = txt_Senha.Text
                                    Session("Perfil") = "Prestador"

                                    'fechando

                                    objCmd.Connection.Close()
                                    objConn.Close()
                                    objConn = Nothing
                                    Response.Redirect("Alteracao_Prestador.aspx?CodPrestador=" & Session("CodPrestador") & "")
                                    Response.End()

                                Else

                                    lbl_mensagem_1.Text = "Este CNPJ/CPF não está cadastrado ou a senha está incorreta !!!"
                                    lbl_mensagem_2.Text = ""
                                    img_btn_Fechar_Mensagem.Visible = "True"
                                    img_btn_sair_Mensagem.Visible = "False"
                                    btn_Confirma_Exclusao.Visible = "False"
                                    btn_Nao_Confirma.Visible = "False"
                                    MPE_Login.Show()
                                    txtCaptcha.Text = ""

                                End If

                                objCmd.Connection.Close()

                                'fechando
                                dr.Close()
                                dr = Nothing
                                objConn.Close()
                                objConn = Nothing

                            End If

                        Catch ex As Exception
                            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                            lbl_mensagem_2.Text = ex.Message
                            img_btn_Fechar_Mensagem.Visible = "True"
                            img_btn_sair_Mensagem.Visible = "False"
                            btn_Confirma_Exclusao.Visible = "False"
                            btn_Nao_Confirma.Visible = "False"
                            MPE_Login.Show()

                        End Try


                    Else

                        lbl_mensagem_1.Text = "Informe seus dados corretamente !!!"
                        lbl_mensagem_2.Text = ""
                        img_btn_Fechar_Mensagem.Visible = "true"
                        img_btn_sair_Mensagem.Visible = "false"
                        btn_Confirma_Exclusao.Visible = "false"
                        btn_Nao_Confirma.Visible = "false"
                        MPE_Login.Show()
                        txtCaptcha.Text = ""

                    End If


                End If

            End If


        End If
    End Sub
 
    Protected Sub img_btn_Fechar_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_Fechar_Mensagem.Click
        MPE_Login.Hide()
    End Sub
   
End Class
