﻿Imports System.Data
Imports MySql.Data.MySqlClient
Imports System.Web
Imports System.Web.UI.ScriptReferenceCollection
Partial Class Cad_Servico_Material
    Inherits System.Web.UI.Page
    Dim objConn As MySqlConnection
    Dim objDt As MySqlDataAdapter
    Dim ds As DataSet
    Dim objCmd As MySqlCommand
    Dim dr As MySqlDataReader
    Dim strDt, strReader As String
    Dim CodPrestador As Integer
    Dim m_perfil As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        txt_descricao.Attributes.Add("onfocus", String.Format("RecebeFoco_Pesquisa('{0}');", txt_descricao.ClientID))
        txt_descricao.Attributes.Add("onblur", String.Format("PerdeFoco_Pesquisa('{0}');", txt_descricao.ClientID))

        CodPrestador = Session("CodPrestador")
        If Not Page.IsPostBack Then
            Verifica_Acesso()
            If m_perfil <> "Administrador" Then
                lnk_Menu_Email.Visible = "False"
                lnk_Menu_Usuario.Visible = "False"
            End If
        Else
            Dim strDt As String
            Dim descricao As String

            descricao = ""
            If txt_descricao.Text <> "Digite aqui o Material/Serviço a pesquisar" Then
                descricao = txt_descricao.Text
            End If
            Try
                strDt = "select SM_ID, SM_Codigo, SM_Descricao, SM_Prestador, SM_Fornecedor, SM_Situacao "
                strDt = strDt & "FROM cad_servico_material "
                strDt = strDt & "WHERE "
                strDt = strDt & "cad_servico_material.SM_Descricao LIKE '%" & descricao & "%' "
                strDt = strDt & " order by cad_servico_material.SM_Descricao"
                SqlServico_Material.SelectCommand = strDt
            Catch ex As Exception
                lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
                lbl_mensagem_2.Text = ex.Message
                img_btn_Fechar_Mensagem.Visible = "true"
                img_btn_sair_Mensagem.Visible = "false"
                btn_Confirma_Exclusao.Visible = "false"
                btn_Nao_Confirma.Visible = "false"
                MPE_SM.Show()
            End Try
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
            MPE_SM.Show()
        End Try

    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Select Case e.Row.RowType
            Case DataControlRowType.DataRow

                Dim situacao As String = CType(e.Row.Cells(2).Text, String)
                Dim strimage As String

                situacao = DataBinder.Eval(e.Row.DataItem, "SM_Situacao").ToString()

                strimage = ""
                Select Case situacao
                    Case "Ativo"
                        strimage = "~/Imagens/Icones/Yes.ico"
                    Case "Inativo"
                        strimage = "~/Imagens/Icones/No.ico"
                End Select
                Dim imgSIT_SM As WebControls.Image = e.Row.FindControl("imgSIT_SM")
                imgSIT_SM.ImageUrl = strimage
        End Select
        'If (e.Row.RowType = DataControlRowType.DataRow) Then
        'Dim MyButton As LinkButton = e.Row.FindControl("cmdDelete")
        'MyButton.Attributes.Add("onclick", "javascript:return " & "confirm('Confirma a exclusão do Serviço/Material " & DataBinder.Eval(e.Row.DataItem, "SM_Descricao") & " ?')")
        'End If
    End Sub
    Private Sub gridView1_PageIndexChanging(ByVal source As Object, ByVal e As GridViewPageEventArgs)
        GridView1.PageIndex = e.NewPageIndex
        GridView1.DataBind()
    End Sub
    Protected Sub ImgBtn_Pesquisar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImgBtn_Pesquisar.Click
        Dim strDt As String
        Dim descricao As String
        descricao = ""
        Try
            If txt_descricao.Text <> "Digite aqui o Material/Serviço a pesquisar" Then
                descricao = txt_descricao.Text
            End If
            strDt = "select SM_ID, SM_Codigo, SM_Descricao, SM_Prestador, SM_Fornecedor, SM_Situacao "
            strDt = strDt & "FROM cad_servico_material "
            strDt = strDt & "WHERE "
            strDt = strDt & "cad_servico_material.SM_Descricao LIKE '%" & descricao & "%' "
            strDt = strDt & " order by cad_servico_material.SM_Descricao"
            SqlServico_Material.SelectCommand = strDt
            GridView1.DataBind()
        Catch ex As Exception
            lbl_mensagem_1.Text = "Ocorreu uma falha de conexão com o banco de dados !!!"
            lbl_mensagem_2.Text = ex.Message
            img_btn_Fechar_Mensagem.Visible = "true"
            img_btn_sair_Mensagem.Visible = "false"
            btn_Confirma_Exclusao.Visible = "false"
            btn_Nao_Confirma.Visible = "false"
            MPE_SM.Show()
        End Try
    End Sub
    Protected Sub btn_cadastrar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_cadastrar.Click
        Response.Redirect("Servico_Material_Cad.aspx")
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

    Protected Sub lnk_Menu_Inicial_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnk_Menu_Inicial.Click
        Response.Redirect("Login_Cadastro.aspx")
        Response.End()
    End Sub
    Protected Sub img_btn_Fechar_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_Fechar_Mensagem.Click
        MPE_SM.Hide()
    End Sub

    Protected Sub img_btn_Sair_Mensagem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles img_btn_sair_Mensagem.Click
        Response.Redirect("Cadastro_Menu.aspx")
        Response.End()
    End Sub
  
End Class
