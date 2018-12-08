Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Imports System.Web.DynamicData
Imports System.Web.Routing
Imports System.Net.Mail
Partial Class Enviar_Senha
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
        txt_CPF.Attributes.Add("onfocus", String.Format("RecebeFoco_CPF('{0}');", txt_CPF.ClientID))
        txt_CPF.Attributes.Add("onblur", String.Format("PerdeFoco_CPF('{0}');", txt_CPF.ClientID))
        txt_Email.Attributes.Add("onfocus", String.Format("RecebeFoco('{0}');", txt_Email.ClientID))
        txt_Email.Attributes.Add("onblur", String.Format("PerdeFoco('{0}');", txt_Email.ClientID))


        'txt_CNPJ.Attributes.Add("onKeyPress", "javascript:MascaraCNPJ(txt_CNPJ)")
        txt_CNPJ.Attributes.Add("onkeyup", "javascript:formatar(this, '##.###.###/####-##')")
        txt_CNPJ.Attributes.Add("onBlur", "javascript:ValidarCNPJ(txt_CNPJ)")
        txt_CPF.Attributes.Add("onkeyup", "javascript:formatar(this, '###.###.###-##')")
        txt_CPF.Attributes.Add("onBlur", "javascript:valida_cpf(txt_CPF)")

        ' If txt_CNPJ.Text <> "Digite aqui apenas se você for pessoa jurídica" Then
        '     txt_CPF.Text = "Digite aqui apenas se você for pessoa física"
        '     'txt_CPF.Enabled = "false"
        ' End If
        ' If txt_CPF.Text <> "Digite aqui apenas se você for pessoa física" Then
        '     txt_CNPJ.Text = "Digite aqui apenas se você for pessoa jurídica"
        '     'txt_CNPJ.Enabled = "false"
        ' End If

    End Sub

    Private Sub Enviar_senha()
        Dim cmd As MySqlCommand
        Dim DR As MySqlDataReader

        Dim nomeRemetente As String
        Dim emailRemetente As String
        Dim senha As String

        nomeRemetente = "nome do remetente"
        emailRemetente = "naoresponda@fccr.com.br"
        senha = "wmsist@f33r"
        senha = "3m21l%FCCR"
        senha = "N@o%r35p0nd2!"

        Dim emailDestinatario As String
        Dim emailComCopia As String
        Dim emailComCopiaOculta As String

        emailComCopia = "naoresponda@fccr.com.br"
        emailComCopiaOculta = "naoresponda@fccr.com.br"

        Email = Trim(txt_CNPJ.Text) & txt_CPF.Text

        'Host da porta SMTP
        Dim SMTP As String

        SMTP = "smtp.fccr.com.br"

        Dim assuntoMensagem As String
        Dim conteudoMensagem As String

        assuntoMensagem = "Recuperação de Senha"
        conteudoMensagem = "Recuperação de Senha"

        'abrindo conexao
        objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("fccr_cadastro_mysql_ConnectionString").ConnectionString)

        Try

            strReader = "SELECT cad_prestador.Pre_ID,cad_prestador.Pre_CNPJ,cad_prestador.Pre_Senha,cad_prestador.Pre_Email,cad_prestador.Pre_Razao_Social from cad_prestador WHERE "
            strReader = strReader & "cad_prestador.Pre_CNPJ='" & Email & "'" ' AND cad_prestador.Pre_Senha='" & senha & "' "
            cmd = New MySqlCommand(strReader, objConn)
            cmd.Connection.Open()
            DR = cmd.ExecuteReader() '(CommandBehavior.SingleRow)

            'Se existirem dados, as informações são repassadas para os Labels.
            If DR.Read Then

                emailDestinatario = txt_Email.Text 'DR("Pre_Email") 'txt_destino.Text '"ethikatecnologia@ethikatecnologia.com.br"
                conteudoMensagem = "Prezado(a) " & DR("Pre_Razao_Social") & " sua senha de acesso atual é : " & DR("Pre_Senha")
                'Cria objeto com dados do e-mail.
                objEmail = New System.Net.Mail.MailMessage()

                'Define o Campo From e ReplyTo do e-mail.
                objEmail.From = New System.Net.Mail.MailAddress("<" & emailRemetente & ">")
                'objEmail.ReplyTo = New System.Net.Mail.MailAddress("Nome <email@seudominio.com.br>")

                'Define os destinatários do e-mail.
                objEmail.To.Add("<" & emailDestinatario & ">")

                'Define a prioridade do e-mail.
                objEmail.Priority = System.Net.Mail.MailPriority.Normal

                'Define o formato do e-mail HTML (caso não queira HTML alocar valor false)
                objEmail.IsBodyHtml = True

                'Define o título do e-mail.
                objEmail.Subject = assuntoMensagem

                'Define o corpo do e-mail.
                objEmail.Body = "<b>" & conteudoMensagem & "</b>"

                'Para evitar problemas com caracteres "estranhos", configuramos o Charset para "ISO-8859-1"
                objEmail.SubjectEncoding = System.Text.Encoding.GetEncoding("ISO-8859-1")
                objEmail.BodyEncoding = System.Text.Encoding.GetEncoding("ISO-8859-1")

                'Cria objeto com os dados do SMTP
                objSmtp = New System.Net.Mail.SmtpClient(SMTP, 587) '465) '587)

                'Alocamos o endereço do host para enviar os e-mails  
                objSmtp.Credentials = New System.Net.NetworkCredential(emailRemetente, senha)
                objSmtp.Host = SMTP
                objSmtp.Port = 587 ' 465 '587

                'Caso utilize conta de email do exchange da locaweb deve habilitar o SSL
                'objEmail.EnableSsl = true;

                'Enviamos o e-mail através do método .send()

                Try
                    objSmtp.Send(objEmail)
                    'Response.Write("E-mail enviado com sucesso !!!")

                    lbl_mensagem_1.Text = "E-mail enviado com sucesso !!!"
                    lbl_mensagem_2.Text = ""
                    img_btn_Fechar_Mensagem.Visible = "true"
                    img_btn_sair_Mensagem.Visible = "false"
                    btn_Confirma_Exclusao.Visible = "false"
                    btn_Nao_Confirma.Visible = "false"
                    MPE_Senha.Show()
                Catch ex As Exception

                    lbl_mensagem_1.Text = "Ocorreram problemas no envio do e-mail !!!"
                    lbl_mensagem_2.Text = ex.Message
                    img_btn_Fechar_Mensagem.Visible = "true"
                    img_btn_sair_Mensagem.Visible = "false"
                    btn_Confirma_Exclusao.Visible = "false"
                    btn_Nao_Confirma.Visible = "false"
                    MPE_Senha.Show()
                End Try
                'excluímos o objeto de e-mail da memória
                objEmail.Dispose()
                'anexo.Dispose();

            End If

            DR.Close()
            DR.Dispose()
            cmd.Dispose()

        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreram problemas no envio do e-mail !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Senha.Show()

        End Try


    End Sub
    Protected Sub LinkButton4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton4.Click
        Session("CNPJPrestador") = "0"

        Session("DocPrestador") = "0"

        Response.Redirect("Login_Cadastro.aspx")
        Response.End()
    End Sub

    Protected Sub btn_entrar_senha_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_entrar_senha.Click
        Dim m_mei, m_cat As Integer
        Dim m_codigo As String
        'pegando dados
        Email = txt_CNPJ.Text
        Senha = txt_Email.Text

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
                MPE_Senha.Show()
                txtCaptcha.Text = ""

            Else
                Dim TestValue As String = txtCaptcha.Text.Trim.ToUpper(System.Globalization.CultureInfo.CreateSpecificCulture("en-US"))
                If 1 = 1 Then 'StrComp(TestValue, Session("ASPCAPTCHA").ToString.Trim, CompareMethod.Text) = 0 Then
                    'lblResult.Text = "CAPTCHA PASSED"
                    'lblResult.ForeColor = Drawing.Color.Green
                    If m_codigo <> "" Then
                        'pegando dados

                        Senha = txt_Email.Text
                        Try


                            'abrindo conexao
                            objConn1 = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                            'verifica se é administrador/gerente
                            strReader = "SELECT "
                            strReader = strReader & "cad_usuario.usu_id,"
                            strReader = strReader & "cad_usuario.usu_codigo,"
                            strReader = strReader & "cad_usuario.usu_senha "
                            strReader = strReader & "FROM cad_usuario "
                            strReader = strReader & "WHERE cad_usuario.usu_codigo='" & m_codigo & "'" ' and cad_usuario.usu_senha='" & Senha & "' "


                            objCmd1 = New MySqlCommand(strReader, objConn1)

                            'criar datareader
                            objCmd1.Connection.Open()
                            dr1 = objCmd1.ExecuteReader()

                            'se achar
                            If dr1.Read Then
                                Session("CodPrestador") = dr1("usu_id")
                                Session("PasPrestador") = txt_Email.Text
                                objCmd1.Connection.Close()
                                objConn1.Close()
                                objConn1 = Nothing
                                Enviar_senha()
                            Else

                                'abrindo conexao
                                objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

                                'verificar se ja existe
                                strReader = "SELECT cad_prestador.Pre_ID,cad_prestador.Pre_CNPJ,cad_prestador.Pre_Senha,cad_prestador.Pre_TipoEmpresa,cad_prestador.Pre_Perfil_Usuario from cad_prestador WHERE "
                                strReader = strReader & "cad_prestador.Pre_CNPJ='" & m_codigo & "'" ' AND cad_prestador.Pre_Senha='" & Senha & "' "
                                objCmd = New MySqlCommand(strReader, objConn)

                                'criar datareader
                                objCmd.Connection.Open()
                                dr = objCmd.ExecuteReader()

                                'se achar
                                If dr.Read Then
                                    Session("CodPrestador") = dr("Pre_ID")
                                    Session("DocPrestador") = m_codigo
                                    Session("PasPrestador") = txt_Email.Text
                                    Session("Perfil") = dr("Pre_Perfil_Usuario")
                                    If Not IsDBNull(dr("Pre_TipoEmpresa")) Then
                                        m_cat = dr("Pre_TipoEmpresa")
                                    Else
                                        m_cat = 0
                                    End If
                                    'fechando

                                    If Not IsDBNull(dr(4)) Then


                                        objCmd.Connection.Close()
                                        objConn.Close()
                                        objConn = Nothing

                                        Enviar_senha()

                                    End If

                                Else

                                    lbl_mensagem_1.Text = "Este CNPJ/CPF não está cadastrado !!!"
                                    lbl_mensagem_2.Text = ""
                                    img_btn_Fechar_Mensagem.Visible = "true"
                                    img_btn_sair_Mensagem.Visible = "false"
                                    btn_Confirma_Exclusao.Visible = "false"
                                    btn_Nao_Confirma.Visible = "false"
                                    MPE_Senha.Show()
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
                            img_btn_Fechar_Mensagem.Visible = "true"
                            img_btn_sair_Mensagem.Visible = "false"
                            btn_Confirma_Exclusao.Visible = "false"
                            btn_Nao_Confirma.Visible = "false"
                            MPE_Senha.Show()
                        End Try

                    Else

                        lbl_mensagem_1.Text = "Informe seus dados corretamente !!!"
                        lbl_mensagem_2.Text = ""
                        img_btn_Fechar_Mensagem.Visible = "true"
                        img_btn_sair_Mensagem.Visible = "false"
                        btn_Confirma_Exclusao.Visible = "false"
                        btn_Nao_Confirma.Visible = "false"
                        MPE_Senha.Show()

                        txtCaptcha.Text = ""

                    End If


                End If

            End If

        End If
    End Sub
    Protected Sub img_btn_Fechar_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_Fechar_Mensagem.Click
        MPE_Senha.Hide()
    End Sub

End Class
