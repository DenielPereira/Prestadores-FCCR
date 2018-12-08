Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web.DynamicData
Imports System.Web.Routing
Imports System.Web
Imports System.Net.Mail

Partial Class Envio_de_Email
    Inherits System.Web.UI.Page
    Dim objConn As MySqlConnection
    Dim objDt As MySqlDataAdapter
    Dim ds As DataSet
    Dim objCmd As MySqlCommand
    Dim dr As MySqlDataReader
    Dim strDt, strReader As String
    Dim objEmail As System.Net.Mail.MailMessage
    Dim objSmtp As New System.Net.Mail.SmtpClient
    Dim CodPrestador As Integer
    Dim m_perfil As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        CodPrestador = Session("CodPrestador")
        Dim strDt As String
        Dim descricao As String
        If Not Page.IsPostBack Then
            Verifica_Acesso()
            strDt = "select A.Doc_Descricao, A.PrexDoc_Validade, B.Doc_Validade, B.Doc_Obrigatorio,C.Pre_Nome_Fantasia,C.Pre_Razao_Social,C.Pre_CNPJ,C.Pre_ID  "
            strDt = strDt & "FROM cad_prestadorxdocumento as A,cad_documento as B,cad_prestador as C "
            strDt = strDt & "WHERE "
            strDt = strDt & "A.Doc_ID=B.Doc_ID and A.Pre_ID=C.Pre_ID and B.Doc_Obrigatorio=1 and "
            strDt = strDt & "((B.Doc_Validade>0 and (A.PrexDoc_Validade<now() or A.PrexDoc_Validade is null)) or  (A.PrexDoc_Nome='')) " 'and A.Pre_ID=109 "
            strDt = strDt & " order by C.Pre_Razao_Social,C.Pre_ID,A.Doc_Descricao "

            strDt = "select C.Pre_ID,C.Pre_CNPJ,C.Pre_Razao_Social,count(A.Doc_Descricao) as Qtde "
            strDt = strDt & "FROM cad_prestadorxdocumento as A,cad_documento as B,cad_prestador as C "
            strDt = strDt & "WHERE "
            strDt = strDt & "A.Doc_ID=B.Doc_ID and A.Pre_ID=C.Pre_ID and B.Doc_Obrigatorio=1 and C.Pre_Email_AlertaDocto=1 and C.Pre_Desativado<>1 and "
            strDt = strDt & "((B.Doc_Validade>0 and (A.PrexDoc_Validade<now() or A.PrexDoc_Validade is null)) or  (A.PrexDoc_Nome='')) " 'and A.Pre_ID=109 "
            strDt = strDt & " group by C.Pre_Razao_Social,C.Pre_ID "
            strDt = strDt & " order by C.Pre_Razao_Social,C.Pre_ID "

            SqlDocumento.SelectCommand = strDt
        End If
    End Sub
    Private Sub Verifica_Acesso()

        'abrindo conexao
        objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("FCCR_Cadastro_MySQL_ConnectionString").ConnectionString)

        strReader = "SELECT "
        strReader = strReader & "cad_usuario.usu_id,"
        strReader = strReader & "cad_usuario.usu_codigo,"
        strReader = strReader & "cad_usuario.usu_senha, "
        strReader = strReader & "cad_usuario.usu_perfil "
        strReader = strReader & "FROM cad_usuario "
        strReader = strReader & "WHERE cad_usuario.usu_id=" & CodPrestador & " and cad_usuario.usu_senha='" & Session("PasPrestador") & "'"
        Try
            objCmd = New MySqlCommand(strReader, objConn)

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
            MPE_Email.Show()
        End Try
    End Sub

    Protected Sub btn_enviar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_enviar.Click
        Dim cmd As MySqlCommand
        Dim DR As MySqlDataReader

        Dim nomeRemetente As String
        Dim emailRemetente As String
        Dim senha As String
        Dim mpre_id As Integer

        nomeRemetente = "Fundação Cultural Cassiano Ricardo"
        emailRemetente = "naoresponda@fccr.com.br"
        senha = "wmsist@f33r"
        senha = "3m21l%FCCR"
        senha = "N@o%r35p0nd2!"


        Dim emailDestinatario As String
        Dim emailComCopia As String
        Dim emailComCopiaOculta As String

        emailDestinatario = ""
        emailComCopia = "naoresponda@fccr.com.br"
        emailComCopiaOculta = "naoresponda@fccr.com.br"

        'Host da porta SMTP
        Dim SMTP As String

        SMTP = "smtp.fccr.com.br"

        Dim assuntoMensagem As String
        Dim conteudoMensagem As String

        assuntoMensagem = "" 'Recuperação de Senha"
        conteudoMensagem = "" 'Recuperação de Senha"

        mpre_id = 0

        'abrindo conexao
        objConn = New MySqlConnection(ConfigurationManager.ConnectionStrings("fccr_cadastro_mysql_ConnectionString").ConnectionString)

        Try
            strReader = "select A.Doc_Descricao, A.PrexDoc_Validade, B.Doc_Validade, B.Doc_Obrigatorio,C.Pre_Nome_Fantasia,C.Pre_Email,C.Pre_Representante,C.Pre_ID "
            strReader = strReader & "FROM cad_prestadorxdocumento as A,cad_documento as B,cad_prestador as C "
            strReader = strReader & "WHERE "
            strReader = strReader & "A.Doc_ID=B.Doc_ID and A.Pre_ID=C.Pre_ID and B.Doc_Obrigatorio=1 and B.Doc_Validade>0 and A.PrexDoc_Validade<now() and A.Pre_ID=109 "
            strReader = strReader & " order by C.Pre_ID,A.Doc_Descricao "

            strReader = "select A.Doc_Descricao, A.PrexDoc_Validade, B.Doc_Validade, B.Doc_Obrigatorio,C.Pre_Nome_Fantasia,C.Pre_Email,C.Pre_Representante,C.Pre_ID,A.PrexDoc_Nome "
            strReader = strReader & "FROM cad_prestadorxdocumento as A,cad_documento as B,cad_prestador as C "
            strReader = strReader & "WHERE "
            strReader = strReader & "A.Doc_ID=B.Doc_ID and A.Pre_ID=C.Pre_ID and B.Doc_Obrigatorio=1 and C.Pre_Email_AlertaDocto=1 and C.Pre_Desativado<>1 and "
            strReader = strReader & "((B.Doc_Validade>0 and (A.PrexDoc_Validade<now() or A.PrexDoc_Validade is null)) or  (A.PrexDoc_Nome='')) " 'and A.Pre_ID=109 "
            strReader = strReader & " order by C.Pre_ID,A.Doc_Descricao "

            cmd = New MySqlCommand(strReader, objConn)
            cmd.Connection.Open()

            DR = cmd.ExecuteReader() '(CommandBehavior.SingleRow)

            conteudoMensagem = "Caro Prestador <br /> <br /> Mantenha seu cadastro atualizado. <br /> Providencie o(s) documento(s) abaixo que se encontra(m) vencido(s) ou ainda não está(ão) cadastrado(s) <br /> <br />"

            'Se existirem dados, as informações são repassadas para os Labels.
            While DR.Read

                emailDestinatario = DR("Pre_Email") 'txt_destino.Text '"ethikatecnologia@ethikatecnologia.com.br"

                If emailDestinatario <> "" Then

                    assuntoMensagem = "Atualização de Cadastro - " & DR("Pre_Representante")
                    lbl_Erro.Text = "Aguarde, enviando e-mail(s) para ... " & DR("Pre_Representante")
                    'conteudoMensagem = DR("Pre_Representante") & " o(s) documento(s) abaixo encontra(m)-se vencidos " & DR("Doc_Descricao") & " vencido em " & DR("PrexDoc_Validade")
                    If mpre_id = 0 Then
                        mpre_id = DR("Pre_ID")
                    End If
                    If mpre_id = DR("Pre_ID") And mpre_id <> 0 Then
                        'If IsDBNull(DR("PrexDoc_Validade")) Then
                        ' conteudoMensagem = conteudoMensagem & DR("Doc_Descricao") & " - sem data de validade " & "<br />"
                        'Else
                        '   If DR("PrexDoc_Validade") < Now() Then
                        'conteudoMensagem = conteudoMensagem & DR("Doc_Descricao") & " - vencido em " & DR("PrexDoc_Validade") & "<br />"
                        'Else
                        '   If DR("PrexDoc_Nome") = "" Then
                        'conteudoMensagem = conteudoMensagem & DR("Doc_Descricao") & " - pendente de cadastramento " & "<br />"
                        'End If
                        'End If
                        'End If
                        conteudoMensagem = conteudoMensagem & DR("Doc_Descricao") & " " & "<br />"
                    Else
                        If mpre_id <> DR("Pre_ID") Then

                            conteudoMensagem = conteudoMensagem & "<br />Atenciosamente, <br />Fundação Cultural Cassiano Ricardo"


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
                            objSmtp = New System.Net.Mail.SmtpClient(SMTP, 587)

                            'Alocamos o endereço do host para enviar os e-mails  
                            objSmtp.Credentials = New System.Net.NetworkCredential(emailRemetente, senha)
                            objSmtp.Host = SMTP
                            objSmtp.Port = 587

                            'Caso utilize conta de email do exchange da locaweb deve habilitar o SSL
                            'objEmail.EnableSsl = true;

                            'Enviamos o e-mail através do método .send()

                            Try
                                objSmtp.Send(objEmail)
                                'Response.Write("E-mail enviado com sucesso !")
                            Catch ex As Exception
                                'Response.Write("Ocorreram problemas no envio do e-mail. Erro = " & ex.Message)
                            End Try
                            'excluímos o objeto de e-mail da memória
                            objEmail.Dispose()
                            'anexo.Dispose();

                            mpre_id = DR("Pre_ID")
                            conteudoMensagem = ""
                            conteudoMensagem = "Caro Prestador <br /> <br /> Mantenha seu cadastro atualizado. <br /> Providencie o(s) documento(s) abaixo que se encontra(m) vencido(s) ou ainda não está(ão) cadastrado(s) <br /> <br />"


                        End If
                    End If


                End If
            End While

            'enviar ultimo registro
            If conteudoMensagem <> "" And emailDestinatario <> "" Then

                conteudoMensagem = conteudoMensagem & "<br />Atenciosamente, <br />Fundação Cultural Cassiano Ricardo"

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
                objSmtp = New System.Net.Mail.SmtpClient(SMTP, 587)

                'Alocamos o endereço do host para enviar os e-mails  
                objSmtp.Credentials = New System.Net.NetworkCredential(emailRemetente, senha)
                objSmtp.Host = SMTP
                objSmtp.Port = 587

                'Caso utilize conta de email do exchange da locaweb deve habilitar o SSL
                'objEmail.EnableSsl = true;

                'Enviamos o e-mail através do método .send()

                Try
                    objSmtp.Send(objEmail)
                    'Response.Write("E-mail enviado com sucesso !")
                Catch ex As Exception
                    'Response.Write("Ocorreram problemas no envio do e-mail. Erro = " & ex.Message)
                End Try
                'excluímos o objeto de e-mail da memória
                objEmail.Dispose()
                'anexo.Dispose();

                mpre_id = 0
                conteudoMensagem = ""

            End If

            DR.Close()
            DR.Dispose()
            cmd.Dispose()

            lbl_mensagem_1.Text = "E-mail(s) enviado(s) com sucesso !"
            lbl_mensagem_2.Text = ""
            img_btn_Fechar_Mensagem.Visible = "false"
            img_btn_sair_Mensagem.Visible = "true"
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Email.Show()


        Catch ex As Exception

            lbl_mensagem_1.Text = "Ocorreram problemas no envio do e-mail !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "false"
            img_btn_sair_Mensagem.Visible = "true"
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_Email.Show()

        End Try

    End Sub
    Protected Sub lnk_Menu_Inicial_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Inicial.Click
        Response.Redirect("Login_Cadastro.aspx")
        Response.End()
    End Sub

    Protected Sub lnk_Menu_Material_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Material.Click
        Response.Redirect("Servico_Material.aspx")
        Response.End()
    End Sub

    Protected Sub lnk_Menu_Documento_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Documento.Click
        Response.Redirect("Documento.aspx")
        Response.End()
    End Sub

    Protected Sub lnk_Menu_Prestador_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Prestador.Click
        Response.Redirect("Pesquisa_Prestador.aspx")
        Response.End()
    End Sub

    Protected Sub lnk_Menu_Email_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Email.Click
        Response.Redirect("Envio_de_Email.aspx")
        Response.End()
    End Sub

    Protected Sub lnk_Menu_Usuario_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Usuario.Click
        Response.Redirect("Usuario.aspx")
        Response.End()
    End Sub

    Protected Sub img_btn_Fechar_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_Fechar_Mensagem.Click
        MPE_Email.Hide()
    End Sub

    Protected Sub img_btn_Sair_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_sair_Mensagem.Click
        Response.Redirect("Cadastro_Menu.aspx")
        Response.End()
    End Sub
End Class
