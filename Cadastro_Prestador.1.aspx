<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Cadastro_Prestador.aspx.vb" Inherits="Cadastro_Prestador" MaintainScrollPositionOnPostback="True" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>
<html>

<head id="Head1" runat="server">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
  <link href="~/Styles/tabs.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
    crossorigin="anonymous">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
    crossorigin="anonymous">
  <title>FCCR - Prestadores de Serviços</title>
</head>

<body style="overflow-x: hidden;">
  <form id="Form1" name="form1" runat="server">

    <asp:ToolkitScriptManager runat="Server" EnablePartialRendering="true" ID="ToolkitScriptManager1" ScriptMode="Release" />

    <div class="row bg-logo px-2">
      <div class="text-center mb-3 mt-3 w-100">
        <asp:Label ID="lbl_Titulo35" runat="server" CssClass="display-4">Prestadores de Serviços</asp:Label>
        <br />
        <asp:Label ID="lbl_Titulo" runat="server" CssClass="lead">Fundação Cultural Cassiano Ricardo</asp:Label>
      </div>
    </div>

    <div class="d-flex justify-content-center">
      <hr class="align-self-center w-90" />
    </div>

    <asp:Label runat="server" ID="CurrentTab" />
    <asp:Label runat="server" ID="Messages" />

    <asp:TextBox ID="txt_CNPJ" runat="server" CssClass="campo" Enabled="False" ReadOnly="True" Visible="False"></asp:TextBox>
		<asp:Label ID="lbl_TipoEmpresa" runat="server" Font-Size="Small" Visible="False"></asp:Label>
		<asp:TextBox ID="txt_ID" runat="server" CssClass="campo" Enabled="False" ReadOnly="True" Visible="False" ></asp:TextBox>
		<asp:TextBox ID="txt_novo" runat="server" CssClass="campo" Enabled="False" ReadOnly="True" Visible="False" ></asp:TextBox>
		<asp:Label ID="lbl_Identificacao" runat="server"></asp:Label>

    <asp:TabContainer runat="server" ScrollBars="Auto" ID="Tabs" ActiveTabIndex="1" Visible="true" Enabled="true"
      BorderStyle="None" EnableTheming="true" CssClass="MyTabStyle">

      <asp:TabPanel ID="TabPanel_0" runat="server" HeaderText="Categoria" Enabled="true" Visible="true">
        <HeaderTemplate>
          <i class="far fa-building"></i>
        </HeaderTemplate>
        <ContentTemplate>

          <asp:Panel ID="Pn_Categoria" runat="server" CssClass="row align-items-center justify-content-center text-center mx-0">

            <div class="container">
              <div class="card py-2 w-60 mx-auto">
                <asp:Label ID="lbl_Titulo8" runat="server" Font-Size="Medium">Cadastro</asp:Label>
                <hr class="w-90 align-self-center">
                <asp:Label ID="lbl_Titulo9" runat="server" Font-Size="Small">Comece o cadastro informando qual é sua
                  categoria</asp:Label>

                <div class="card-body py-2 px-5">

                  <asp:RadioButtonList ID="rb_pessoa" runat="server" AutoPostBack="True" CssClass="row justify-content-center w-100"
                    RepeatDirection="Horizontal">
                    <asp:ListItem Value="PJ">Sou Pessoa Jurídica</asp:ListItem>
                    <asp:ListItem Value="PF">Sou Pessoa Física</asp:ListItem>
                  </asp:RadioButtonList>

                  <div class="input-group mb-3">
                    <div class="input-group-prepend">
                      <asp:Label ID="lbl_Titulo2" runat="server" CssClass="input-group-text">CNPJ</asp:Label>
                    </div>
                    <asp:TextBox ID="txt_cad_CNPJ" runat="server" CssClass="ph-center form-control" ForeColor="Black"
                      MaxLength="18" placeholder="Digite apenas os números"></asp:TextBox>
                  </div>

                  <div class="input-group mb-3">
                    <div class="input-group-prepend">
                      <asp:Label ID="lbl_Titulo5" runat="server" CssClass="input-group-text">CPF</asp:Label>
                    </div>
                    <asp:TextBox ID="txt_cad_CPF" runat="server" CssClass="ph-center form-control" ForeColor="Black"
                      MaxLength="14" placeholder="Digite apenas os números"></asp:TextBox>
                  </div>

                  <div class="row">
                    <div class="col-3">
                      <h6>Categoria :</h6>
                    </div>
                    <div class="col-9">
                      <asp:RadioButtonList ID="RB_TipoEmpresa" runat="server" AutoPostBack="True" CssClass="text-left">
                        <asp:ListItem Value="1">Associações e Cooperativas</asp:ListItem>
                        <asp:ListItem Value="2">Empresa de Pequeno Porte (EPP)</asp:ListItem>
                        <asp:ListItem Value="3">Empresa Individual</asp:ListItem>
                        <asp:ListItem Value="4">Empresa Ltda</asp:ListItem>
                        <asp:ListItem Value="5">Empresa Individual de Responsabilidade Limitada</asp:ListItem>
                        <asp:ListItem Value="6">Micro Empreendedor Individual ( M.E.I. )</asp:ListItem>
                        <asp:ListItem Value="7">Micro Empresa ( M.E. )</asp:ListItem>
                        <asp:ListItem Value="8">Sociedade Anônima (SA)</asp:ListItem>
                        <asp:ListItem Value="9">Sociedade Simples (SS)</asp:ListItem>
                        <asp:ListItem Value="10">Pessoa Física</asp:ListItem>
                      </asp:RadioButtonList>
                    </div>
                    <div class="col-6 text-left">
                      <h6>Participa de Licitação :</h6>
                    </div>
                    <div class="col-6">
                      <asp:RadioButtonList ID="RB_Licitacao" runat="server" CssClass="row justify-content-start"
                        AutoPostBack="True" RepeatDirection="Horizontal">
                        <asp:ListItem Value="Sim">Sim</asp:ListItem>
                        <asp:ListItem Value="Nao">Não</asp:ListItem>
                      </asp:RadioButtonList>
                    </div>
                    <div class="col-12 text-left">
                      <h6>Trabalho oferecido :</h6>
                    </div>
                    <div class="col-12 text-left">
                      <asp:RadioButtonList ID="RB_Categoria" runat="server" CssClass="row justify-content-center"
                        RepeatDirection="Horizontal">
                        <asp:ListItem Value="1">Serviços Artísticos</asp:ListItem>
                        <asp:ListItem Value="2">Bens e outros serviços</asp:ListItem>
                      </asp:RadioButtonList>
                    </div>
                    <div class="col-12">
                      <asp:Button ID="Imgbtn_Continuar_0" runat="server" CssClass="btn btn-primary w-50 align-self-center"
                        CausesValidation="False" Text="Continuar" />
                    </div>

                    <asp:Label ID="lbl_Erro" runat="server" Font-Size="Large" ForeColor="#CC0000"></asp:Label>
										<asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" Font-Size="Medium" ForeColor="#CC0000"
										 Visible="False">Clique aqui</asp:LinkButton>
										<asp:Label ID="Label571" runat="server" Font-Size="Medium" ForeColor="#CC0000" Visible="False">
											para retornar a tela
											de Login</asp:Label>
										<asp:Label ID="Label19" runat="server" Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                  </div>
                </div>
              </div>
            </div>

          </asp:Panel>

        </ContentTemplate>
      </asp:TabPanel>


      <!-- IDENTIFICAÇÃO PESSOA JURIDICA -->


      <asp:TabPanel runat="server" HeaderText="Identificação" ID="TabPanel_11" Enabled="False" Visible="true">

        <HeaderTemplate>
          <i class="far fa-id-card"></i>
        </HeaderTemplate>
        <ContentTemplate>

          <asp:Panel ID="Panel1" runat="server" CssClass="row align-items-center justify-content-center text-center mx-0">

            <div class="container">
              <div class="card py-2 w-60 mx-auto">


                <div class="titulo">
                  <asp:Label ID="Label1" runat="server">Identificação </asp:Label>
                </div>
                <hr class="w-90  align-self-center" />
                <small>
                  <asp:Label ID="Label3" runat="server">Agora precisamos de algumas informações sobre sua
                    empresa</asp:Label>
                </small>

                <div class="card-body py-2 px-5 mt-2">

                  <div class="input-group-txt-lg">

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Razão Social</span>
                      </div>
                      <asp:TextBox ID="txt_Razao_Social" runat="server" CssClass="ph-center form-control" MaxLength="70"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui sua Razão Social"
                        placeholder="Qual a razão social da empresa?"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Nome Fantasia</span>
                      </div>
                      <asp:TextBox ID="txt_Nome_Fantasia" runat="server" CssClass="ph-center form-control" MaxLength="25"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui seu Nome Fantasia caso tenha"
                        placeholder="Qual o nome fantasia da empresa?"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Inscrição Estadual</span>
                      </div>
                      <asp:TextBox ID="txt_IEstadual" runat="server" CssClass="ph-center form-control" MaxLength="20"
                        ToolTip="Se não tiver uma, digite ISENTO." placeholder="Qual a Inscrição Estadual da empresa?"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Inscrição Municipal</span>
                      </div>
                      <asp:TextBox ID="txt_IMunicipal" runat="server" CssClass="ph-center form-control" MaxLength="20"
                        ToolTip="Se não tiver uma, digite ISENTO." placeholder="Qual a Inscrição Municipal da empresa?"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Cidade</span>
                      </div>
                      <asp:TextBox ID="txt_IM_Cidade" runat="server" CssClass="ph-center form-control" MaxLength="50"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui a cidade de sua Inscrição Municipal"
                        placeholder="Qual a cidade da Inscrição Municipal?"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">UF</span>
                      </div>
                      <asp:DropDownList ID="ddl_IM_UF" runat="server" CssClass="ph-center form-control" ToolTip="Informe aqui o Estado de sua Inscrição Municipal">
                        <asp:ListItem Value="Selecione " disabled> Selecione uma opção</asp:ListItem>
                        <asp:ListItem Value="DF">DISTRITO FEDERAL</asp:ListItem>
                        <asp:ListItem Value="AC">ACRE</asp:ListItem>
                        <asp:ListItem Value="AL">ALAGOAS</asp:ListItem>
                        <asp:ListItem Value="AP">AMAPÁ</asp:ListItem>
                        <asp:ListItem Value="AM">AMAZONAS</asp:ListItem>
                        <asp:ListItem Value="BA">BAHIA</asp:ListItem>
                        <asp:ListItem Value="CE">CEARÁ</asp:ListItem>
                        <asp:ListItem Value="ES">ESPÍRITO SANTO</asp:ListItem>
                        <asp:ListItem Value="GO">GOIÁS</asp:ListItem>
                        <asp:ListItem Value="MA">MARANHÃO</asp:ListItem>
                        <asp:ListItem Value="MT">MATO GROSSO</asp:ListItem>
                        <asp:ListItem Value="MS">MATO GROSSO DO SUL</asp:ListItem>
                        <asp:ListItem Value="MG">MINAS GERAIS</asp:ListItem>
                        <asp:ListItem Value="PR">PARANÁ</asp:ListItem>
                        <asp:ListItem Value="PB">PARAÍBA</asp:ListItem>
                        <asp:ListItem Value="PA">PARÁ</asp:ListItem>
                        <asp:ListItem Value="PE">PERNAMBUCO</asp:ListItem>
                        <asp:ListItem Value="PI">PIAUÍ</asp:ListItem>
                        <asp:ListItem Value="RJ">RIO DE JANEIRO</asp:ListItem>
                        <asp:ListItem Value="RN">RIO GRANDE DO NORTE</asp:ListItem>
                        <asp:ListItem Value="RS">RIO GRANDE DO SUL</asp:ListItem>
                        <asp:ListItem Value="RO">RONDÔNIA</asp:ListItem>
                        <asp:ListItem Value="RR">RORAIMA</asp:ListItem>
                        <asp:ListItem Value="SC">SANTA CATARINA</asp:ListItem>
                        <asp:ListItem Value="SE">SERGIPE</asp:ListItem>
                        <asp:ListItem Value="SP">SÃO PAULO</asp:ListItem>
                        <asp:ListItem Value="TO">TOCANTINS</asp:ListItem>
                      </asp:DropDownList>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Cod. CNAE</span>
                      </div>
                      <asp:TextBox ID="txt_CNAE_Codigo" runat="server" CausesValidation="True" CssClass="ph-center form-control"
                        MaxLength="9" ToolTip="Informe aqui o CPF do CNAE da Empresa" placeholder="Código CNAE principal da empresa"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Descrição CNAE</span>
                      </div>
                      <asp:TextBox ID="txt_CNAE_Descricao" runat="server" CssClass="ph-center form-control" MaxLength="150"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe a descrição do CNAE principal da empresa"
                        placeholder="Descrição do CNAE principal da empresa"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Representante</span>
                      </div>
                      <asp:TextBox ID="txt_Representante" runat="server" CssClass="ph-center form-control" align=" midlle"
                        MaxLength="50" onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o nome do Requesentante Legal da Empresa"
                        placeholder="Nome completo do representante legal da empresa"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Cargo</span>
                      </div>
                      <asp:TextBox ID="txt_Representante_Cargo" runat="server" CssClass="ph-center form-control"
                        MaxLength="40" onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o cargo do Requesentante Legal da Empresa"
                        placeholder="Qual o cargo do representante?"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">CPF</span>
                      </div>
                      <asp:TextBox ID="txt_CPF" runat="server" CausesValidation="True" CssClass="ph-center form-control"
                        MaxLength="20" ToolTip="Informe aqui o CPF do Requesentante Legal da Empresa" placeholder="CPF do representante legal"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">RG</span>
                      </div>
                      <asp:TextBox ID="txt_RG" runat="server" CssClass="ph-center form-control" MaxLength="20" onkeyup="this.value=this.value.toUpperCase();"
                        ToolTip="Informe aqui o RG do Requesentante Legal da Empresa" placeholder="RG do representante legal"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Nacionalidade</span>
                      </div>
                      <asp:TextBox ID="txt_Nacionalidade" runat="server" CssClass="ph-center form-control" MaxLength="30"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui a nacionalidade do Requesentante Legal da Empresa"
                        placeholder="Nacionalidade do representante legal"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Estado Civil</span>
                      </div>
                      <asp:DropDownList ID="ddl_Representante_EstadoCivil" runat="server" ToolTip="Informe aqui o estado civil do Requesentante Legal da Empresa"
                        CssClass="ph-center form-control select-color">
                        <asp:ListItem Value=" Selecione " selected disabled> Selecione uma opção</asp:ListItem>
                        <asp:ListItem>SOLTEIRO</asp:ListItem>
                        <asp:ListItem>CASADO</asp:ListItem>
                        <asp:ListItem>DIVORCIADO</asp:ListItem>
                        <asp:ListItem>VIÚVO</asp:ListItem>
                      </asp:DropDownList>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Profissão</span>
                      </div>
                      <asp:TextBox ID="txt_Representante_Profissao" runat="server" CssClass="ph-center form-control"
                        MaxLength="50" onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui a profissão do Representante Legal da Empresa"
                        placeholder="Qual a profissão do representante?"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">E-mail</span>
                      </div>
                      <asp:TextBox ID="txt_Representante_Email" runat="server" CssClass="ph-center form-control"
                        MaxLength="50" placeholder="E-mail de contato da empresa" data-toggle="popover" title="Atenção!"
                        data-content="Esse e-mail vai servir como meio de contato com a Fundação Cultural Cassiano Ricardo."></asp:TextBox>
                    </div>


                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Senha</span>
                      </div>
                      <asp:TextBox ID="txt_Senha" runat="server" CssClass="ph-center form-control" MaxLength="10"
                        ToolTip="Informe aqui sua senha com no mínimo 6 caracteres ( números e/ou letras)" type="password"
                        placeholder="Escolha uma senha"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Confirme a senha</span>
                      </div>
                      <asp:TextBox ID="txt_Confirma_Senha" runat="server" CssClass="ph-center form-control" MaxLength="10"
                        ToolTip="Redigite a senha para confirmá-la" type="password" placeholder="Repita a senha"></asp:TextBox>
                    </div>

                    <asp:Button ID="Imgbtn_Voltar_11" runat="server" CausesValidation="False" Text="Sessão Anterior"
                      CssClass="btn btn-primary" />
                    <asp:Button ID="Imgbtn_Continuar_11" runat="server" CausesValidation="False" Text="Proxima Sessão"
                      CssClass="btn btn-primary" />

                    <asp:Label ID="lbl_Error_ID" runat="server" Visible="False"></asp:Label>
                    <div class="input-group-txt-lg"></div>
                  </div>
                </div>
              </div>

          </asp:Panel>

        </ContentTemplate>
      </asp:TabPanel>

      <!-- IDENTIFICAÇÃO PESSOA FISICA -->

      <asp:TabPanel ID="TabPanel_12" runat="server" HeaderText="Categoria" Enabled="false" Visible="false">
        <HeaderTemplate>
          <i class="far fa-user"></i>
        </HeaderTemplate>
        <ContentTemplate>

          <asp:Panel ID="Pn_ID_PF" runat="server" CssClass="row align-items-center justify-content-center text-center mx-0">

            <div class="container">
              <div class="card py-2 w-60 mx-auto">
                <div class="titulo">
                  <asp:Label ID="Label4" runat="server">Identificação</asp:Label>

                </div>
                <hr class="w-90  align-self-center" />
                <small>
                  <asp:Label ID="Label7" runat="server">Agora precisamos de algumas informações sobre você</asp:Label>
                </small>

                <div class="card-body py-2 px-5 mt-2">

                  <div class="input-group-txt-lg">
                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Nome</span>
                      </div>
                      <asp:TextBox ID="txt_PF_Nome" runat="server" CssClass="ph-center form-control" MaxLength="70"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui seu Nome" placeholder="Como você se chama?">
                      </asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">RG</span>
                      </div>
                      <asp:TextBox ID="txt_PF_RG" runat="server" CssClass="ph-center form-control" MaxLength="20"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o RG do Requesentante Legal da Empresa"
                        placeholder="Qual o seu RG?"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">PIS/PASEP</span>
                      </div>
                      <asp:TextBox ID="txt_PF_PISPASEP" runat="server" CssClass="ph-center form-control" MaxLength="14"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o PIS/PASEP" placeholder="Informe o seu PIS/PASEP"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">NIT</span>
                      </div>
                      <asp:TextBox ID="txt_PF_NIT" runat="server" CssClass="ph-center form-control" MaxLength="14"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o NIT" placeholder="Informe o seu NIT"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Nacionalidade</span>
                      </div>
                      <asp:TextBox ID="txt_PF_Nacionalidade" runat="server" CssClass="ph-center form-control" MaxLength="30"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui a nacionalidade do Requesentante Legal da Empresa"
                        placeholder="Qual a sua nacionalidade?"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Estado Civil</span>
                      </div>
                      <asp:DropDownList ID="ddl_PF_EstadoCivil" runat="server" ToolTip="Informe aqui o estado civil do Requesentante Legal da Empresa"
                        CssClass="ph-center form-control select-color">
                        <asp:ListItem Value=" Selecione " disabled selected> Qual é o seu estado civil?</asp:ListItem>
                        <asp:ListItem>SOLTEIRO</asp:ListItem>
                        <asp:ListItem>CASADO</asp:ListItem>
                        <asp:ListItem>DIVORCIADO</asp:ListItem>
                        <asp:ListItem>VIÚVO</asp:ListItem>
                      </asp:DropDownList>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Profissão</span>
                      </div>
                      <asp:TextBox ID="txt_PF_Profissao" runat="server" CssClass="ph-center form-control required"
                        MaxLength="50" onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui a profissão do Requesentante Legal da Empresa"
                        placeholder="Qual a sua profissão?"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Senha</span>
                      </div>
                      <asp:TextBox ID="txt_Senha0" runat="server" type="password" CssClass="ph-center form-control"
                        MaxLength="10" ToolTip="Informe aqui sua senha com no mínimo 6 caracteres ( números e/ou letras)"
                        placeholder="Escolha a sua senha"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Confirmação</span>
                      </div>
                      <asp:TextBox ID="txt_Confirma_Senha0" runat="server" type="password" CssClass="ph-center form-control required"
                        MaxLength="10" ToolTip="Redigite a senha para confirmá-la" placeholder="Repita a senha escolhida"></asp:TextBox>
                    </div>

                    <asp:Button ID="Imgbtn_Voltar_12" runat="server" Text="Sessão Anterior" CausesValidation="False"
                      CssClass="btn btn-primary" />
                    <asp:Button ID="Imgbtn_Continuar_12" runat="server" Text="Próxima Sessão" CausesValidation="False"
                      CssClass="btn btn-primary" />

                    <asp:Label ID="lbl_Error_ID0" runat="server" Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                  </div>
                </div>
              </div>
            </div>
          </asp:Panel>
        </ContentTemplate>
      </asp:TabPanel>

      <!-- CONTATO -->

      <asp:TabPanel ID="TabPanel_2" runat="server" HeaderText="Categoria" Enabled="false" Visible="true">
        <HeaderTemplate>
          <i class="fas fa-mail-bulk"></i>
        </HeaderTemplate>
        <ContentTemplate>

          <asp:Panel ID="Pn_Contato" runat="server" CssClass="row align-items-center justify-content-center text-center mx-0">
            <div class="container">

              <div class="card py-2 w-60 mx-auto">
                <div class="titulo">
                  <asp:Label ID="Label8" runat="server" Font-Size="Medium">Dados
                    para contato</asp:Label>
                </div>
                <hr class="w-90  align-self-center" />
                <small>
                  <asp:Label ID="Label9" runat="server" Font-Size="Small">Agora
                    precisamos dos dados para
                    contato</asp:Label>
                </small>
                <div class="card-body py-2 px-5 mt-2">

                  <div class="input-group-txt-lg">
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text">C.E.P.</span>
                      </div>
                      <asp:TextBox ID="txt_CEP" runat="server" CssClass="ph-center form-control" MaxLength="10" ToolTip="Digite aqui o código de endereçamento postal e em seguida clique no botão pesqiusar."
                        placeholder="Qual o CEP do endereço de correspondencia?" data-toggle="tooltip" data-placement="top"></asp:TextBox>
                      <div class="input-group-append">
                        <asp:Button ID="btn_CEP" runat="server" CausesValidation="False" CssClass="btn btn-secondary"
                          Text="&#xf002;" style="font-family: 'Font Awesome 5 Free' !important; font-weight: 900;" />
                      </div>
                    </div>

                    <div class="text-center text-muted mb-2">
                      <small>A gente vai preencher alguns campos de endereço pra você ;)</small>
                    </div>

                    <asp:RequiredFieldValidator ID="RV_CEP" runat="server" ControlToValidate="txt_CEP" ErrorMessage="Informe o CEP"
                      style="display:none;">*</asp:RequiredFieldValidator>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Endereço</span>
                      </div>
                      <asp:TextBox ID="txt_Endereco" runat="server" CssClass="ph-center form-control" MaxLength="100"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o endereço da empresa"
                        placeholder="Informe aqui o endereço da empresa"></asp:TextBox>
                    </div>

                    <asp:RequiredFieldValidator ID="RV_Endereco" runat="server" ControlToValidate="txt_Endereco"
                      ErrorMessage="Informe o Endereço" style="display:none;">*</asp:RequiredFieldValidator>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Número</span>
                      </div>
                      <asp:TextBox ID="txt_Numero" runat="server" CssClass="ph-center form-control" MaxLength="10"
                        ToolTip="Informe aqui o número do endereço da empresa" placeholder="Informe aqui o número do endereço da empresa"></asp:TextBox>
                    </div>

                    <asp:RequiredFieldValidator ID="RV_Numero" runat="server" ControlToValidate="txt_Numero"
                      ErrorMessage="Informe o Número" style="display:none;">*</asp:RequiredFieldValidator>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Complemento</span>
                      </div>
                      <asp:TextBox ID="txt_Complemento" runat="server" CssClass="ph-center form-control" MaxLength="50"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o complemento do endereço da empresa se houver : bloco, andar, sala, etc."
                        placeholder="Informe aqui o complemento do endereço da empresa"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Bairro</span>
                      </div>
                      <asp:TextBox ID="txt_Bairro" runat="server" CssClass="ph-center form-control" MaxLength="50"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o bairro da empresa"
                        placeholder="Informe aqui o bairro da empresa"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Cidade</span>
                      </div>
                      <asp:TextBox ID="txt_Cidade" runat="server" CssClass="ph-center form-control" MaxLength="50"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui a cidade da empresa"
                        placeholder="Informe aqui a cidade da empresa"></asp:TextBox>
                    </div>

                    <asp:RequiredFieldValidator ID="RV_Cidade" runat="server" ControlToValidate="txt_Cidade"
                      ErrorMessage="Informe a Cidade" style="display:none;">*</asp:RequiredFieldValidator>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">UF</span>
                      </div>
                      <asp:DropDownList ID="ddl_UF" runat="server" ToolTip="Informe aqui a Unidade da Federação da empresa"
                        CssClass="ph-center form-control">
                        <asp:ListItem Value="Selecione"> Selecione uma opção</asp:ListItem>
                        <asp:ListItem Value="DF">DISTRITO FEDERAL</asp:ListItem>
                        <asp:ListItem Value="AC">ACRE</asp:ListItem>
                        <asp:ListItem Value="AL">ALAGOAS</asp:ListItem>
                        <asp:ListItem Value="AP">AMAPÁ</asp:ListItem>
                        <asp:ListItem Value="AM">AMAZONAS</asp:ListItem>
                        <asp:ListItem Value="BA">BAHIA</asp:ListItem>
                        <asp:ListItem Value="CE">CEARÁ</asp:ListItem>
                        <asp:ListItem Value="ES">ESPÍRITO SANTO</asp:ListItem>
                        <asp:ListItem Value="GO">GOIÁS</asp:ListItem>
                        <asp:ListItem Value="MA">MARANHÃO</asp:ListItem>
                        <asp:ListItem Value="MT">MATO GROSSO</asp:ListItem>
                        <asp:ListItem Value="MS">MATO GROSSO DO SUL</asp:ListItem>
                        <asp:ListItem Value="MG">MINAS GERAIS</asp:ListItem>
                        <asp:ListItem Value="PR">PARANÁ</asp:ListItem>
                        <asp:ListItem Value="PB">PARAÍBA</asp:ListItem>
                        <asp:ListItem Value="PA">PARÁ</asp:ListItem>
                        <asp:ListItem Value="PE">PERNAMBUCO</asp:ListItem>
                        <asp:ListItem Value="PI">PIAUÍ</asp:ListItem>
                        <asp:ListItem Value="RJ">RIO DE JANEIRO</asp:ListItem>
                        <asp:ListItem Value="RN">RIO GRANDE DO NORTE</asp:ListItem>
                        <asp:ListItem Value="RS">RIO GRANDE DO SUL</asp:ListItem>
                        <asp:ListItem Value="RO">RONDÔNIA</asp:ListItem>
                        <asp:ListItem Value="RR">RORAIMA</asp:ListItem>
                        <asp:ListItem Value="SC">SANTA CATARINA</asp:ListItem>
                        <asp:ListItem Value="SE">SERGIPE</asp:ListItem>
                        <asp:ListItem Value="SP">SÃO PAULO</asp:ListItem>
                        <asp:ListItem Value="TO">TOCANTINS</asp:ListItem>
                      </asp:DropDownList>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Telefone 1</span>
                      </div>
                      <asp:TextBox ID="txt_Telefone" runat="server" CssClass="ph-center form-control" MaxLength="25"
                        ToolTip="Informe aqui o DDD e o telefone da empresa" ValidateRequestMode="Enabled" placeholder="Informe aqui o DDD e o telefone da empresa"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Telefone 2</span>
                      </div>
                      <asp:TextBox ID="txt_Telefone_1" runat="server" CssClass="ph-center form-control" MaxLength="25"
                        ToolTip="Informe aqui o DDD e o telefone da empresa" placeholder="Informe aqui outro DDD e otelefone da empresa"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Celular</span>
                      </div>
                      <asp:TextBox ID="txt_Celular" runat="server" CssClass="ph-center form-control" MaxLength="25"
                        ToolTip="Informe aqui o DDD e o celular da empresa" placeholder="Informe aqui o DDD e o celular da empresa"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">WhatsApp Corp.</span>
                      </div>
                      <asp:TextBox ID="txt_WhatsApp" runat="server" CssClass="ph-center form-control" MaxLength="25"
                        ToolTip="Informe aqui o DDD e o celular da empresa" placeholder="Informe aqui outro DDD e o celular da empresa"></asp:TextBox>
                    </div>

                    <!-- FIXME: o email do usuário já foi solicitado na tela anteior. 
                      Recomendo tirar esses campos daqui ou retirar da outra tela -->

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">E-mail 1</span>
                      </div>
                      <asp:TextBox ID="txt_Email" runat="server" CssClass="ph-center form-control" MaxLength="50"
                        ToolTip="Informe aqui o endereço de email da empresa - ATENÇÃO !!! Este será o email de contato com a Fundação Cultural "
                        placeholder="Informe o email de contato da empresa"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">E-mail 2</span>
                      </div>
                      <asp:TextBox ID="txt_Email_1" runat="server" CssClass="ph-center form-control" MaxLength="50"
                        ToolTip="Informe aqui o endereço de email da empresa - ATENÇÃO !!! Este será o email de contato com a Fundação Cultural "
                        placeholder="Informe outro email de contato da empresa"></asp:TextBox>
                    </div>

                    <asp:RequiredFieldValidator ID="RV_Email" runat="server" ControlToValidate="txt_Email" ErrorMessage="Informe o email"
                      style="display:none;">*</asp:RequiredFieldValidator>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Website</span>
                      </div>
                      <asp:TextBox ID="txt_Site" runat="server" CssClass="ph-center form-control" MaxLength="50"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o endereço da home page empresa se houver"
                        placeholder="A sua empresa possui um site?"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Pessoa de Contato</span>
                      </div>
                      <asp:TextBox ID="txt_Pessoa_Contato" runat="server" CssClass="ph-center form-control" MaxLength="50"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o nome da pessoa de contato"
                        placeholder="Informe aqui o nome da pessoa de contato"></asp:TextBox>
                    </div>

                    <asp:Button ID="Imgbtn_Voltar_2" runat="server" CssClass="btn btn-primary" CausesValidation="False"
                      Text="Sessão Anterior" />
                    <asp:Button ID="Imgbtn_Continuar_2" runat="server" CssClass="btn btn-primary" CausesValidation="False"
                      Text="Proxima Sessão" />

                    <asp:Label ID="lbl_erro_contato" runat="server" Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                  </div>
                </div>
              </div>

            </div>
          </asp:Panel>

        </ContentTemplate>
      </asp:TabPanel>

      <!-- DADOS BANCARIOS -->

      <asp:TabPanel ID="TabPanel_3" runat="server" HeaderText="Categoria" Enabled="false" Visible="true">
        <HeaderTemplate>
          <i class="fas fa-money-check-alt"></i>
        </HeaderTemplate>
        <ContentTemplate>

          <div class="row align-items-center justify-content-center text-center mx-0">

            <div class="container">

              <div class="card py-2 w-60 mx-auto">
                <div class="titulo">
                  <asp:Label ID="Label10" runat="server" Font-Size="Medium">Dados Bancários</asp:Label>
                </div>
                <hr class="w-90  align-self-center" />
                <small>
                  <asp:Label ID="Label11" runat="server">Agora informe seus dados bancários</asp:Label>
                </small>
                <div class="card-body py-2 px-5 mt-2">

                  <div class="input-group-txt-lg">
                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Banco</span>
                      </div>
                      <asp:TextBox ID="txt_Banco_Codigo" runat="server" CssClass="ph-center form-control" MaxLength="3"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o código do banco"
                        placeholder="Informe aqui o código do banco"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Agência</span>
                      </div>
                      <asp:TextBox ID="txt_Banco_Agencia" runat="server" CssClass="ph-center form-control" MaxLength="6"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o código da agência"
                        placeholder="Informe aqui o código da agência"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Conta</span>
                      </div>
                      <asp:TextBox ID="txt_Banco_Conta" runat="server" CssClass="ph-center form-control" MaxLength="10"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o número da conta bancária"
                        placeholder="Informe aqui o número da conta bancária"></asp:TextBox>
                    </div>

                    <div class="input-group mb-3">
                      <div class="input-group-prepend">
                        <span class="input-group-text">Tipo de Conta</span>
                      </div>
                      <asp:DropDownList ID="ddl_Banco_TipoConta" runat="server" ToolTip="Informe aqui o tipo de conta"
                        CssClass="ph-center form-control">
                        <asp:ListItem Value=" Selecione "> Selecione uma opção</asp:ListItem>
                        <asp:ListItem>CORRENTE</asp:ListItem>
                        <asp:ListItem Value="POUPANCA">POUPANÇA</asp:ListItem>
                      </asp:DropDownList>
                    </div>

                    <asp:Button ID="Imgbtn_Voltar_3" runat="server" CssClass="btn btn-primary" CausesValidation="False"
                      Text="Sessão Anterior" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="Imgbtn_Continuar_3" runat="server" CssClass="btn btn-primary" CausesValidation="False"
                      Text="Proxima Sessão" />

                    <asp:Label ID="lbl_Error_Banco" runat="server" Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </ContentTemplate>
      </asp:TabPanel>

      <!-- TODO: descobrir o que é esse trecho de codigo abaixo -->

      <asp:TabPanel runat="server" ID="TabPanel_X" HeaderText="Materiais" Enabled="false" Visible="false">
        <ContentTemplate>
          <table width="100%">
            <tr>
              <td width="20px">&#160;</td>
              <td align="center" colspan="2" style="font-weight: bold">Informe, um a um, os prestadores de serviços de
                sua
                empresa.<br />
                Caso o próprio Representante Legal seja um dos Prestadores,&#160;
                <asp:LinkButton ID="Lnkbtn_01" runat="server" CausesValidation="False" ForeColor="#3333CC">clique
                  aqui</asp:LinkButton>&#160; para cadastrá-lo como um Prestador de Serviço<br />
                Para alterar os dados de um Prestador já cadastrado, clique na imagem&#160;&#160;
                <asp:Image ID="Image4" runat="server" ImageUrl="~/Imagens/Botoes/botao_editar.gif" />&#160;&#160;
                referente ao
                prestador.<td>&nbsp;</td>
            <tr>
              <td width="20px">&nbsp;</td>
              <td align="center" colspan="2" style="font-weight: bold">Os campos assinalados com (*) são de
                preenchimento
                obrigatório.</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td width="20px">&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td width="20px">&nbsp;</td>
              <td colspan="2">
                <asp:GridView ID="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False" BorderColor="Gainsboro"
                  BorderStyle="Solid" BorderWidth="1px" CellPadding="6" DataKeyNames="PrexPre_ID" DataSourceID="SqlPrexPre"
                  OnRowCommand="GridView2_RowCommand" OnRowDataBound="GridView2_RowDataBound" Width="100%" GridLines="None">
                  <AlternatingRowStyle BackColor="#EBEBEB" />
                  <Columns>
                    <asp:TemplateField ShowHeader="False">
                      <ItemTemplate>
                        <asp:LinkButton ID="cmdDelete20" runat="server" CausesValidation="false" CommandArgument='<%# Eval("PrexPre_ID") %>'
                          CommandName="Delete20" Text="&lt;IMG src=&quot;Imagens/botoes/botao_editar.gif&quot;  border=&quot;0&quot;&gt;">
                        </asp:LinkButton>
                      </ItemTemplate>
                      <ItemStyle HorizontalAlign="Center" Width="30px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Nome" SortExpression="PrexPre_Nome">
                      <ItemTemplate>
                        <asp:Label ID="Label52" runat="server" Text='<%# Bind("PrexPre_Nome") %>'></asp:Label>
                      </ItemTemplate>
                      <ItemStyle Width="250px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Serviços" SortExpression="PrexPre_Servicos">
                      <ItemTemplate>
                        <asp:Label ID="Label55" runat="server" Text='<%# Bind("PrexPre_Servicos") %>'></asp:Label>
                      </ItemTemplate>
                      <ItemStyle Width="80px" />
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                      <ItemTemplate>
                        <asp:LinkButton ID="cmdDelete23" runat="server" CausesValidation="false" CommandArgument='<%# Eval("PrexPre_ID") %>'
                          CommandName="Delete" Text="&lt;IMG src=&quot;Imagens/Botoes/Botao_apagar.gif&quot; border=&quot;0&quot; &gt;">
                        </asp:LinkButton>
                      </ItemTemplate>
                      <ItemStyle Width="30px" />
                    </asp:TemplateField>
                  </Columns>
                  <HeaderStyle BackColor="WhiteSmoke" />
                  <PagerStyle BackColor="WhiteSmoke" />
                  <RowStyle BackColor="Transparent" ForeColor="Transparent" />
                  <SelectedRowStyle BackColor="Transparent" ForeColor="Transparent" />
                </asp:GridView>
              </td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td width="20px">&nbsp;</td>
              <td colspan="2">
                <table width="100%">
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Nome :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Nome" runat="server" CssClass="ph-center form-control" MaxLength="70"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o nome do Prestador de Serviço"
                        Width="400px"></asp:TextBox>
                      &nbsp;<asp:Label ID="Label57" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>R.G. :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_RG" runat="server" CssClass="ph-center form-control" MaxLength="20"
                        ToolTip="Informe aqui o RG do Prestador de Serviço"></asp:TextBox>
                      &nbsp;<asp:Label ID="Label58" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>C.P.F. :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_CPF" runat="server" CausesValidation="True" CssClass="ph-center form-control"
                        MaxLength="20" ToolTip="Informe aqui o CPF do Prestador de Serviço"></asp:TextBox>
                      &nbsp;<asp:Label ID="Label59" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Nacionalidade :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Nacionalidade" runat="server" CssClass="ph-center form-control"
                        MaxLength="30" onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui a nacionalidade do Prestador de Serviço"></asp:TextBox>
                      &nbsp;<asp:Label ID="Label60" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Estado Civil :</td>
                    <td>
                      <asp:DropDownList ID="ddl_Prestador_EstadoCivil" runat="server" ToolTip="Informe aqui o Estado Civil do Prestador de Serviço"
                        Width="250px" CssClass="ph-center form-control" Height="30px">
                        <asp:ListItem Value=" "> Selecione uma opção</asp:ListItem>
                        <asp:ListItem>SOLTEIRO</asp:ListItem>
                        <asp:ListItem>CASADO</asp:ListItem>
                        <asp:ListItem>DIVORCIADO</asp:ListItem>
                        <asp:ListItem>VIÚVO</asp:ListItem>
                      </asp:DropDownList>
                      &nbsp;<asp:Label ID="Label61" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Profissão :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Profissao" runat="server" CssClass="ph-center form-control"
                        MaxLength="50" onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui a Profissão do Prestador de Serviço"></asp:TextBox>
                      <br />
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>C.E.P. :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_CEP" runat="server" CssClass="ph-center form-control" MaxLength="10"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o código de endereçamento postal e em seguida clique no botão Pesquisar CEP para o preenchimento automático do Endereço, Bairro, Cidade e UF."></asp:TextBox>
                      &nbsp;&nbsp;<asp:Label ID="Label62" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                      &nbsp;&nbsp;
                      <asp:Button ID="btn_CEP_Prestador" runat="server" CausesValidation="False" Height="20px" Text="Pesquisar CEP" />
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Endereço :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Endereco" runat="server" CssClass="ph-center form-control"
                        MaxLength="100" onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o endereço do Prestador de Serviço"
                        Width="400px"></asp:TextBox>
                      &nbsp;<asp:Label ID="Label63" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Número :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Numero" runat="server" CssClass="ph-center form-control" MaxLength="10"
                        ToolTip="Informe aqui o número do endereço do Prestador de Serviço" Width="250px"></asp:TextBox>
                      &nbsp;<asp:Label ID="Label64" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Complemento :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Complemento" runat="server" CssClass="ph-center form-control"
                        MaxLength="50" onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o complemento do endereço do Prestador de Serviço se houver : bloco, andar, sala, etc."></asp:TextBox>
                      <br />
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Bairro :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Bairro" runat="server" CssClass="ph-center form-control" MaxLength="50"
                        onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o bairro do Prestador de Serviço"
                        Width="350px"></asp:TextBox>
                      &nbsp;<asp:Label ID="Label65" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Cidade :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Municipio" runat="server" CssClass="ph-center form-control"
                        MaxLength="50" onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui a cidade do Prestador de Serviço"></asp:TextBox>
                      &nbsp;<asp:Label ID="Label66" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>UF :</td>
                    <td>
                      <asp:DropDownList ID="ddl_Prestador_UF" runat="server" CssClass="ph-center form-control" ToolTip="Informe aqui a Unidade da Federação do Prestador de Serviço"
                        Width="180px">
                        <asp:ListItem Value=" ">&nbsp; Selecione uma opção</asp:ListItem>
                        <asp:ListItem Value="DF">DISTRITO FEDERAL</asp:ListItem>
                        <asp:ListItem Value="AC">ACRE</asp:ListItem>
                        <asp:ListItem Value="AL">ALAGOAS</asp:ListItem>
                        <asp:ListItem Value="AP">AMAPÁ</asp:ListItem>
                        <asp:ListItem Value="AM">AMAZONAS</asp:ListItem>
                        <asp:ListItem Value="BA">BAHIA</asp:ListItem>
                        <asp:ListItem Value="CE">CEARÁ</asp:ListItem>
                        <asp:ListItem Value="ES">ESPÍRITO SANTO</asp:ListItem>
                        <asp:ListItem Value="GO">GOIÁS</asp:ListItem>
                        <asp:ListItem Value="MA">MARANHÃO</asp:ListItem>
                        <asp:ListItem Value="MT">MATO GROSSO</asp:ListItem>
                        <asp:ListItem Value="MS">MATO GROSSO DO SUL</asp:ListItem>
                        <asp:ListItem Value="MG">MINAS GERAIS</asp:ListItem>
                        <asp:ListItem Value="PR">PARANÁ</asp:ListItem>
                        <asp:ListItem Value="PB">PARAÍBA</asp:ListItem>
                        <asp:ListItem Value="PA">PARÁ</asp:ListItem>
                        <asp:ListItem Value="PE">PERNAMBUCO</asp:ListItem>
                        <asp:ListItem Value="PI">PIAUÍ</asp:ListItem>
                        <asp:ListItem Value="RJ">RIO DE JANEIRO</asp:ListItem>
                        <asp:ListItem Value="RN">RIO GRANDE DO NORTE</asp:ListItem>
                        <asp:ListItem Value="RS">RIO GRANDE DO SUL</asp:ListItem>
                        <asp:ListItem Value="RO">RONDÔNIA</asp:ListItem>
                        <asp:ListItem Value="RR">RORAIMA</asp:ListItem>
                        <asp:ListItem Value="SC">SANTA CATARINA</asp:ListItem>
                        <asp:ListItem Value="SE">SERGIPE</asp:ListItem>
                        <asp:ListItem Value="SP">SÃO PAULO</asp:ListItem>
                        <asp:ListItem Value="TO">TOCANTINS</asp:ListItem>
                      </asp:DropDownList>
                      &nbsp;<asp:Label ID="Label67" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Telefone :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Telefone" runat="server" CssClass="ph-center form-control"
                        MaxLength="25" ToolTip="Informe aqui o DDD e o telefone do Prestador de Serviço"></asp:TextBox>
                      <br />
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Celular :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Celular" runat="server" CssClass="ph-center form-control"
                        MaxLength="25" ToolTip="Informe aqui o DDD e o celular do Prestador de Serviço"></asp:TextBox>
                      <br />
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>E-mail :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Email" runat="server" CssClass="ph-center form-control" MaxLength="50"
                        ToolTip="Informe aqui o endereço de email do Prestador de Serviço"></asp:TextBox>
                      <br />
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Serviços :</td>
                    <td>
                      <asp:TextBox ID="txt_Prestador_Servico" runat="server" CssClass="ph-center form-control"
                        MaxLength="100" onkeyup="this.value=this.value.toUpperCase();" ToolTip="Informe aqui o(s) serviço(s) prestado(s) separados por ;"
                        Width="400px"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>
                      <asp:ImageButton ID="btn_Salvar_Prestador" runat="server" CausesValidation="False" ImageUrl="~/Imagens/Botoes/Botao_SalvarAzul.gif" />
                      &nbsp;
                      <asp:Button ID="btn_Salvar_Prestadorx" runat="server" BackColor="#3366FF" BorderStyle="Solid"
                        BorderWidth="1px" CausesValidation="False" ForeColor="White" Text="S A L V A R" Visible="False" />
                      &nbsp;&nbsp;<asp:Label ID="lbl_erro_prestador" runat="server" Font-Size="Medium" ForeColor="#CC0000"
                        Visible="False"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>
                      <asp:TextBox ID="txt_erro_prestador" runat="server" BorderColor="White" BorderStyle="None"
                        Font-Size="Medium" ForeColor="Red" Height="50px" MaxLength="1000" ReadOnly="True" Rows="3"
                        TextMode="MultiLine" Width="90%"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td align="left">
                      <asp:TextBox ID="txt_prexpre_registro" runat="server" BackColor="White" BorderStyle="None"
                        CssClass="campo" ForeColor="White" MaxLength="10" Width="119px"></asp:TextBox>
                      <asp:TextBox ID="TextBox6" runat="server" BackColor="White" BorderStyle="None" CssClass="campo"
                        ForeColor="White" MaxLength="300" Width="57px"></asp:TextBox>
                      <asp:TextBox ID="TextBox7" runat="server" BackColor="White" BorderStyle="None" CssClass="campo"
                        ForeColor="White" MaxLength="300" Width="57px"></asp:TextBox>
                      <asp:ImageButton ID="Imgbtn_Continuar_X" runat="server" CausesValidation="False" ImageUrl="~/Imagens/Botoes/Botao_Continuar_Cadastro.gif" />
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                </table>
              </td>
              <td>&nbsp;</td>
            </tr>
            </td>
            </tr>
          </table>
        </ContentTemplate>

      </asp:TabPanel>

      <!-- MATERIAIS -->

      <asp:TabPanel runat="server" ID="TabPanel_4" HeaderText="Materiais" Enabled="false" Visible="true">
        <HeaderTemplate>
          <i class="fas fa-box-open"></i>
        </HeaderTemplate>
        <ContentTemplate>

          <div class="row align-items-center justify-content-center text-center mx-0">

            <div class="container">

              <div class="card py-2 w-80 mx-auto">
                <div class="titulo">
                  <asp:Label ID="Label577" runat="server">Materiais</asp:Label>
                </div>
                <hr class="w-90  align-self-center" />
                <small>
                  <p>Marque os materiais que podem ser fornecidos, clicando na descrição do material.
                    Se o material não constar na lista e desejar
                    cadastrar,
                    preencha o campo abaixo
                    e clique no botão de adição</p>
                </small>


                Material :
                <asp:TextBox ID="txtdescservico" runat="server" CausesValidation="True" CssClass="ph-center form-control"
                  MaxLength="250" onkeyup="this.value=this.value.toUpperCase();" Rows="1"></asp:TextBox>

                <asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False" ImageUrl="~/Imagens/Botoes/botao_mais.gif" />

                <asp:DataGrid ID="Datagrid2" runat="server" AllowSorting="True" AutoGenerateColumns="False" CssClass="table"
                  CellPadding="6" DataKeyField="PrexSM_ID" OnDeleteCommand="DataGrid2_DeleteCommand" OnItemDataBound="DataGrid2_ItemDataBound"
                  PageSize="100">
                  <AlternatingItemStyle BackColor="#E6E6E6" />
                  <Columns>
                    <asp:TemplateColumn HeaderText="Lista dos Materiais">
                      <ItemTemplate>
                        <asp:LinkButton ID="LnkBtnDel3" runat="server" CausesValidation="False" CommandName="Delete"
                          Height="10px" Text='<%# DataBinder.Eval(Container, "DataItem.SM_Descricao") %>' ToolTip="Marcar/Desmarcar este material da minha lista">
                        </asp:LinkButton>
                      </ItemTemplate>
                      <HeaderStyle Width="90%" />
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                      <ItemTemplate>
                        <asp:CheckBox ID="ckitem" runat="server" AutoPostBack="True" Checked='<%# DataBinder.Eval(Container, "DataItem.SM_Selecao") %>'
                          Enabled="false" />
                      </ItemTemplate>
                    </asp:TemplateColumn>
                  </Columns>
                  <EditItemStyle VerticalAlign="Middle" />
                  <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                  <HeaderStyle BackColor="WhiteSmoke" ForeColor="White" HorizontalAlign="Center" Height="30px" />
                  <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small"
                    Font-Strikeout="False" Font-Underline="False" VerticalAlign="Middle" HorizontalAlign="Left" />
                  <PagerStyle BackColor="WhiteSmoke" HorizontalAlign="Center" Mode="NumericPages" NextPageText="Posterior"
                    PrevPageText="Anterior" />
                  <SelectedItemStyle BackColor="#008A8C" ForeColor="White" />
                </asp:DataGrid>

                <asp:Button ID="Imgbtn_Voltar_4" runat="server" BackColor="#00554F" CausesValidation="False" ForeColor="White"
                  Height="40px" Text="RETORNAR" Width="150px" />

                <asp:Button ID="Imgbtn_Continuar_4" runat="server" BackColor="#00554F" CausesValidation="False"
                  ForeColor="White" Height="40px" Text="CONTINUAR" Width="150px" />

                <asp:TextBox ID="txtcodservico" runat="server" BackColor="White" BorderStyle="None" ForeColor="White"
                  Width="30px"></asp:TextBox>
              </div>
            </div>
        </ContentTemplate>
      </asp:TabPanel>

      <!-- SERVIÇOS -->

      <asp:TabPanel runat="server" ID="TabPanel_5" HeaderText="Serviços" Enabled="false" Visible="true">
        <HeaderTemplate>
          <i class="fas fa-wrench"></i>
        </HeaderTemplate>
        <ContentTemplate>

          <asp:Label ID="Label578" runat="server" Font-Size="Medium">Serviços</asp:Label>
          >Marque os serviços que podem ser
          fornecidos,
          clicando na descrição do serviço.</td>
          Se o serviço não constar na lista e desejar
          cadastrar,
          preencha o campo abaixo e
          clique no botão de adição
          Serviço :
          <asp:TextBox ID="txtdescservico1" runat="server" CausesValidation="True" CssClass="ph-center form-control"
            Height="20px" MaxLength="250" onkeyup="this.value=this.value.toUpperCase();" Rows="1"></asp:TextBox>
          &nbsp;&nbsp;
          <asp:ImageButton ID="ImageButton31" runat="server" CausesValidation="False" ImageUrl="~/Imagens/Botoes/botao_mais.gif" />

          <asp:DataGrid ID="Datagrid3" runat="server" AllowSorting="True" AutoGenerateColumns="False" BackColor="White"
            BorderColor="Gainsboro" BorderStyle="Solid" BorderWidth="1px" CellPadding="6" DataKeyField="PrexSM_ID"
            OnDeleteCommand="DataGrid3_DeleteCommand" OnItemDataBound="DataGrid3_ItemDataBound" PageSize="100" Width="90%"
            GridLines="None">
            <AlternatingItemStyle BackColor="#EEEEEE" />
            <Columns>
              <asp:TemplateColumn HeaderText="Lista dos Serviços">
                <ItemTemplate>
                  <asp:LinkButton ID="LnkBtnDel31" runat="server" CausesValidation="False" CommandName="Delete" Height="10px"
                    Text='<%# DataBinder.Eval(Container, "DataItem.SM_Descricao") %>' ToolTip="Marcar/Desmarcar este material da minha lista"
                    Width="90%"></asp:LinkButton>
                </ItemTemplate>
                <HeaderStyle Width="90%" />
              </asp:TemplateColumn>
              <asp:TemplateColumn>
                <ItemTemplate>
                  <asp:CheckBox ID="ckitem" runat="server" AutoPostBack="True" Checked='<%# DataBinder.Eval(Container, "DataItem.SM_Selecao") %>'
                    Enabled="false" />
                </ItemTemplate>
              </asp:TemplateColumn>
            </Columns>
            <EditItemStyle VerticalAlign="Middle" />
            <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
            <HeaderStyle BackColor="White" ForeColor="White" HorizontalAlign="Center" Height="25px" />
            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Size="Small" Font-Strikeout="False"
              Font-Underline="False" VerticalAlign="Middle" HorizontalAlign="Left" />
            <PagerStyle BackColor="WhiteSmoke" HorizontalAlign="Center" Mode="NumericPages" NextPageText="Posterior"
              PrevPageText="Anterior" />
            <SelectedItemStyle BackColor="#008A8C" ForeColor="White" />
          </asp:DataGrid>

          <asp:Button ID="Imgbtn_Voltar_5" runat="server" BackColor="#00554F" CausesValidation="False" ForeColor="White"
            Height="40px" Text="RETORNAR" Width="150px" />
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <asp:Button ID="Imgbtn_Continuar_5" runat="server" BackColor="#00554F" CausesValidation="False" ForeColor="White"
            Height="40px" Text="CONTINUAR" Width="150px" />

          <asp:TextBox ID="TextBox5" runat="server" BackColor="White" BorderStyle="None" ForeColor="White" Width="30px"></asp:TextBox>


        </ContentTemplate>
      </asp:TabPanel>
      <asp:TabPanel runat="server" ID="TabPanel_Y" HeaderText="YYY" Enabled="false" Visible="false">
        <ContentTemplate>
          <table width="100%">
            <tr>
              <td></td>
              <td align="center" colspan="2" style="font-weight: bold">Os documentos abaixo são de preenchimento
                obrigatório
                de
                acordo com sua categoria.<br />
                Para fazer o Upload e completar as informações, clique na imagem&#160;&#160;
                <asp:Image ID="Image3" runat="server" ImageUrl="~/Imagens/Botoes/botao_editar.gif" />&#160;&#160;
                referente ao
                documento.<br />
                Se desejar incluir um documento a mais, selecione-o da lista de Tipos de Documentos e preencha os
                demais
                campos.<br />
              <td></td>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td></td>
              <td colspan="2">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" BorderColor="Gainsboro"
                  BorderStyle="Solid" BorderWidth="1px" CellPadding="1" DataKeyNames="PrexDoc_ID" DataSourceID="SqlPrexDoc"
                  OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound" Width="100%">
                  <AlternatingRowStyle BackColor="White" />
                  <Columns>
                    <asp:TemplateField ShowHeader="False">
                      <ItemTemplate>
                        <asp:LinkButton ID="cmdDelete1" runat="server" CausesValidation="false" CommandArgument='<%# Eval("PrexDoc_ID") %>'
                          CommandName="Delete1" HeaderText="Documento" SortExpression="Doc_Descricao" Text='<%# Bind("Doc_Descricao") %>'
                          ToolTip="Editar as informações deste documento">
                        </asp:LinkButton>
                      </ItemTemplate>
                      <ItemStyle HorizontalAlign="Left" Width="40%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Complemento" SortExpression="PrexDoc_Observacao">
                      <ItemTemplate>
                        <asp:Label ID="Label41" runat="server" Text='<%# Bind("PrexDoc_Observacao") %>'></asp:Label>
                      </ItemTemplate>
                      <ItemStyle Width="240px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Emitido em" SortExpression="PrexDoc_Emissao">
                      <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("PrexDoc_Emissao", "{0:d}") %>'></asp:Label>
                      </ItemTemplate>
                      <ItemStyle Width="80px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Válido até" SortExpression="PrexDoc_Validade">
                      <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("PrexDoc_Validade", "{0:d}") %>'></asp:Label>
                      </ItemTemplate>
                      <ItemStyle Width="80px" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                      <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("PrexDoc_Nome", "{0}") %>'
                          Target="_blank" Text="&lt;IMG src=&quot;Imagens/botoes/search16_h.gif&quot;  border=&quot;0&quot;&gt;"
                          ToolTip="Visualizar o Documento"></asp:HyperLink>
                      </ItemTemplate>
                      <ItemStyle Font-Bold="False" Font-Size="Small" Width="30px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="PrexDoc_Situacao" HeaderText="Situação" Visible="False" />
                    <asp:TemplateField HeaderText="Situação">
                      <ItemTemplate>
                        <asp:ImageButton ID="ImgSIT" runat="server" CausesValidation="False" ImageAlign="Middle" />
                      </ItemTemplate>
                      <HeaderStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                  </Columns>
                  <HeaderStyle BackColor="WhiteSmoke" />
                  <PagerStyle BackColor="WhiteSmoke" />
                  <RowStyle BackColor="Transparent" ForeColor="Transparent" />
                  <SelectedRowStyle BackColor="Transparent" ForeColor="Transparent" />
                </asp:GridView>
              </td>
              <td>&nbsp;
              </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;
              </td>
              <td>&nbsp;
              </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td colspan="2">
                <table width="100%">
                  <tr>
                    <td>&nbsp;
                    </td>
                    <td>Tipo de Documento :
                    </td>
                    <td>
                      <asp:DropDownList ID="ddlDocumento" runat="server" AutoPostBack="True" DataSourceID="SqlDocumento"
                        DataTextField="Doc_Descricao" DataValueField="Doc_ID" Height="25px" Width="400px">
                      </asp:DropDownList>
                      &nbsp;
                      <asp:Label ID="Label69" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                      &nbsp;&nbsp;
                    </td>
                    <td>&nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td>&nbsp;
                    </td>
                    <td>Complemento :
                    </td>
                    <td>
                      <asp:TextBox ID="txt_prexdoc_obs" runat="server" CssClass="campo" MaxLength="300" onkeyup="this.value=this.value.toUpperCase();"
                        ToolTip="Informe aqui alguma observação complementar referente ao documento."></asp:TextBox>
                    </td>
                    <td>&nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td>&nbsp;
                    </td>
                    <td>Descritivo :
                    </td>
                    <td>
                      <asp:TextBox ID="txt_prexdoc_ajuda" runat="server" CssClass="campo" Height="60px" MaxLength="300"
                        onkeyup="this.value=this.value.toUpperCase();" ReadOnly="True" Rows="5" TextMode="MultiLine"
                        ToolTip="Informe aqui alguma observação complementar referente ao documento."></asp:TextBox>
                      &nbsp;
                      <br />
                      <asp:HyperLink ID="hpl_modelo" runat="server" Target="_blank"> Clique aqui para
                        visualizar o Modelo
                      </asp:HyperLink>
                    </td>
                    <td>&nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td>&nbsp;
                    </td>
                    <td>&nbsp;
                    </td>
                    <td>
                      <asp:TextBox ID="txtmodelo" runat="server" CssClass="campo" MaxLength="100" ToolTip="Informe aqui a Data de Emissão do Documento"
                        Visible="False" Width="68px"></asp:TextBox>
                      <asp:TextBox ID="txt_prexdoc_doc" runat="server" CssClass="campo" Enabled="False" MaxLength="300"
                        onkeyup="this.value=this.value.toUpperCase();" Visible="False" Width="116px"></asp:TextBox>
                    </td>
                    <td>&nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td>&nbsp;
                    </td>
                    <td>Emissão :
                    </td>
                    <td>
                      <asp:TextBox ID="txt_prexdoc_emissao" runat="server" CssClass="campo" MaxLength="10" ToolTip="Informe aqui a Data de Emissão do Documento"
                        Width="119px"></asp:TextBox>
                      &nbsp;&nbsp;
                      <asp:Label ID="Label68" runat="server" ForeColor="#FF3300" Text=" * "></asp:Label>
                      (dd/mm/aaaa)
                      <asp:Label ID="lbl_Validade" runat="server" Text="Validade :" Visible="False"></asp:Label>
                      &nbsp;&nbsp;<asp:TextBox ID="txt_prexdoc_validade" runat="server" CssClass="campo" MaxLength="10"
                        ToolTip="Informe aqui a Data de Validade do documento se houver, caso contrário, deixe em branco."
                        Visible="False" Width="119px"></asp:TextBox>
                      &nbsp;&nbsp;<asp:Label ID="lbl_Validade_Formato" runat="server" Text="(dd/mm/aaaa)" Visible="False"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Selecione o arquivo :</td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;
                      <asp:FileUpload ID="PrexDoc_Nome" runat="server" ToolTip="Selecione aqui o documento a enviar" />
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>Tamanho máximo permitido do documento a enviar é de 800kbytes.<br />
                      Permitidos somente documentos nos formatos&nbsp; PDF.</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>
                      <asp:Label ID="lbl_data_upload" runat="server" Font-Overline="False" Font-Size="Small"
                        Font-Strikeout="False" ForeColor="Black"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>
                      <asp:TextBox ID="txt_prexdoc_registro" runat="server" BackColor="White" BorderStyle="None"
                        CssClass="campo" ForeColor="White" MaxLength="10" Width="119px"></asp:TextBox>
                      <asp:TextBox ID="txt_prexdoc_nome" runat="server" BackColor="White" BorderStyle="None" CssClass="campo"
                        ForeColor="White" MaxLength="300" Width="57px"></asp:TextBox>
                      <asp:TextBox ID="txt_dias_validade" runat="server" BackColor="White" BorderStyle="None" CssClass="campo"
                        ForeColor="White" MaxLength="300" Width="57px"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>
                      <asp:ImageButton ID="btn_Salvar_Documento" runat="server" CausesValidation="False" ImageUrl="~/Imagens/Botoes/Botao_SalvarAzul.gif" />
                      &nbsp;&nbsp;&nbsp;
                      <asp:ImageButton ID="btn_Excluir_Documento" runat="server" CausesValidation="False" ImageUrl="~/Imagens/Botoes/Botao_SalvarAzul.gif"
                        Visible="False" />
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>
                      <asp:Label ID="lbl_erro_documento" runat="server" Font-Size="Medium" ForeColor="#CC0000" Visible="False"></asp:Label>
                      <asp:Label ID="lbl_Error" runat="server" Font-Size="Medium" ForeColor="#CC0000"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>
                      <asp:TextBox ID="txt_erro_documento" runat="server" BorderColor="White" BorderStyle="None"
                        Font-Size="Medium" ForeColor="Red" Height="56px" MaxLength="1000" ReadOnly="True" Rows="3"
                        TextMode="MultiLine" Width="85%"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td align="center" colspan="2">
                      <asp:ImageButton ID="Imgbtn_Voltar_Y" runat="server" CausesValidation="False" ImageUrl="~/Imagens/Botoes/Botao_Continuar_Cadastro.gif" />
                      <asp:ImageButton ID="Imgbtn_Continuar_Y" runat="server" CausesValidation="False" ImageUrl="~/Imagens/Botoes/Botao_Continuar_Cadastro.gif" />
                    </td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                </table>
              </td>
              <td>&nbsp;</td>
            </tr>
            </td>
            </tr>
          </table>
        </ContentTemplate>
      </asp:TabPanel>

      <!-- DECLARAÇÃO -->

      <asp:TabPanel runat="server" ID="TabPanel_6" HeaderText="DECLARAÇÃO" Enabled="false" Visible="true">
        <HeaderTemplate>
          <i class="fas fa-file-contract"></i>
        </HeaderTemplate>
        <ContentTemplate>
          <table width="100%">
            <tr>
              <td width="10%">&#160;</td>
              <td width="80%" align="center">
                <asp:Panel ID="Panel3" runat="server" BorderStyle="Solid" BorderWidth="1px" Width="75%">
                  <table width="100%">
                    <tr>
                      <td colspan="2">
                        <asp:Label ID="Label12" runat="server" Font-Size="Medium">Declaração</asp:Label>
                      </td>
                    </tr>
                    <tr>
                      <td background="Imagens/Backgrounds/LinhaS.gif" colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="2" style="font-weight: bold; font-size: medium; font-style: normal">DECLARO, nos
                        termos da
                        recomendação contida no PPIC nº. 59/07 da 7º Promotoria
                        de Justiça da Comarca de São José dos Campos e nos termos da Resolução nº 07/05,
                        atualizada pelas Resoluções nº. 09/05 e 21/06, todas do Conselho Nacional de
                        Justiça, que: Esta empresa não possui sócio que seja cônjuge, companheiro ou
                        parente em linha reta ou colateral até o terceiro grau, de quaisquer pessoas
                        ocupantes dos cargos de Prefeito, Vice-Prefeito, Secretários Municipais, Chefe
                        de Gabinete, Vereadores ou de Cargos de Direção, chefia ou de assessoramento da
                        Prefeitura ou desta Fundação Cultural Cassiano Ricardo, de igual forma se
                        compromete a não vir a contratar empregado nas mesmas condições. </td>
                    </tr>
                    <tr>
                      <td colspan="2" style="font-weight: bold; font-size: medium; font-style: normal">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="2" style="font-weight: bold; font-size: medium; font-style: normal">
                        <asp:CheckBox ID="chk_aceite" runat="server" AutoPostBack="True" Text="  Li e estou de acordo" />
                      </td>
                    </tr>
                    <tr>
                      <td colspan="2" style="font-weight: bold; font-size: medium; font-style: normal">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="2" style="font-weight: bold; font-size: medium; font-style: normal">
                        <asp:Button ID="Imgbtn_Voltar_6" runat="server" BackColor="#00554F" CausesValidation="False"
                          ForeColor="White" Height="40px" Text="RETORNAR" Width="150px" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="Imgbtn_Finalizar" runat="server" BackColor="#00554F" CausesValidation="False"
                          ForeColor="White" Height="40px" Text="FINALIZAR" Width="150px" />
                      </td>
                    </tr>
                    <tr>
                      <td colspan="2" style="font-weight: bold; font-size: medium; font-style: normal">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="2" style="font-weight: bold; font-size: medium; font-style: normal">
                        <asp:Label ID="lbl_Confirmar" runat="server" Font-Size="Medium" ForeColor="#CC0000"></asp:Label>
                      </td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td align="left">&nbsp;</td>
                    </tr>
                </asp:Panel>
          </table>
          </td>
          </tr>


          <table width="100%">
            <tr>
              <td width="20px">&#160;</td>
              <td>&#160;</td>
              <td>&#160;</td>
              <td>&#160;</td>
            </tr>
            <tr>
              <td width="20px">&#160;</td>
              <td align="center" colspan="2">&nbsp;</td>
              <td>&#160;</td>
            </tr>
          </table>
        </ContentTemplate>
      </asp:TabPanel>



    </asp:TabContainer>


    </td>
    <td>&nbsp;</td>
    </tr>

    <tr>
      <td width="20px">&nbsp;</td>
      <td colspan="2" style="margin-left: 40px">
        <asp:Panel ID="pnlMensagem_Cadastro" runat="server" CssClass="popUpStyle" Width="550px" Style="display: none;">
          <table align="center" bgcolor="#FFFF99" frame="border" border="0" cellpadding="1" cellspacing="1" rules="none"
            width="100%">
            <tr>
              <td>&nbsp;</td>
              <td align="right">&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td align="center">
                <asp:Label ID="Label13" runat="server" Font-Size="Medium" ForeColor="Black" Text="ATENÇÃO !!!"></asp:Label>
              </td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td align="center">
                <!-- os botoes abaixo sao somente para o popup funcionar corretamente-->
                <asp:Button ID="Button4" runat="server" Text="..." Style="display: none;" />
                <asp:Button ID="Button5" runat="server" Text="..." Style="display: none;" />
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbl_mensagem_cadastro" runat="server" Font-Size="Medium" ForeColor="Black"></asp:Label>
              </td>
              <td>&nbsp;</td>
            </tr>

            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td align="center">
                <asp:Button ID="Imgbtn_Fechar_Mensagem" runat="server" BackColor="#00554F" CausesValidation="False"
                  ForeColor="White" Height="35px" Text="FECHAR" Visible="False" Width="150px" />
                <asp:Button ID="Imgbtn_Sair_Mensagem" runat="server" BackColor="#00554F" CausesValidation="False"
                  ForeColor="White" Height="35px" Text="FECHAR" Visible="False" Width="150px" />
              </td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td align="center">
                <asp:Button ID="Imgbtn_Sim_Mensagem" runat="server" BackColor="#00554F" CausesValidation="False"
                  ForeColor="White" Height="35px" Text="S I M" Visible="False" Width="150px" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Imgbtn_Nao_Mensagem" runat="server" BackColor="#00554F" CausesValidation="False"
                  ForeColor="White" Height="35px" Text="N Â O" Visible="False" Width="150px" />
              </td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table>
        </asp:Panel>
        <asp:ModalPopupExtender ID="MPE_Cadastro" runat="server" BackgroundCssClass="popUpStyle1" PopupControlID="pnlMensagem_Cadastro"
          DynamicServicePath="" Enabled="True" TargetControlID="Button4" CancelControlID="Button5" OkControlID="Button4" />
      </td>
      <td>&nbsp;</td>
    </tr>


    <tr>
      <td width="20px">&nbsp;</td>
      <td align="center" colspan="2">

        <asp:Label ID="lbl_cod_tipoempresa" runat="server" BackColor="White" ForeColor="Black" Visible="False"></asp:Label>
        <asp:Label ID="lbl_cod_tipoprestador" runat="server" BackColor="White" ForeColor="Black" Visible="False"></asp:Label>
      </td>
      <td>&nbsp;</td>
    </tr>


    <tr>
      <td width="20px">&nbsp;</td>
      <td colspan="2" align="center">&nbsp;

      </td>
      <td>&nbsp;</td>
    </tr>


    <tr>
      <td width="20px">&nbsp;</td>
      <td>&nbsp;</td>
      <td>


        <asp:ValidationSummary ID="VS_01" runat="server" DisplayMode="List" ShowMessageBox="True" ShowSummary="False" />
      </td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td width="20px">&nbsp;</td>
      <td>&nbsp;</td>
      <td>


        <asp:SqlDataSource ID="SqlPrexDoc" runat="server" ConnectionString="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString %>"
          OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT tmp_prestadorxdocumento.PrexDoc_ID, tmp_prestadorxdocumento.Pre_ID, tmp_prestadorxdocumento.Pre_CNPJ, tmp_prestadorxdocumento.Doc_ID, tmp_prestadorxdocumento.Doc_Descricao, tmp_prestadorxdocumento.PrexDoc_Emissao, tmp_prestadorxdocumento.PrexDoc_Validade, tmp_prestadorxdocumento.PrexDoc_Nome, tmp_prestadorxdocumento.PrexDoc_Observacao, tmp_prestadorxdocumento.PrexDoc_Situacao, tmp_prestadorxdocumento.PrexDoc_Informacoes, cad_documento.Doc_Obrigatorio, cad_documento.Doc_Modelo FROM tmp_prestadorxdocumento INNER JOIN cad_documento ON tmp_prestadorxdocumento.Doc_ID = cad_documento.Doc_ID WHERE (tmp_prestadorxdocumento.Pre_CNPJ = @Pre_CNPJ)"
          ProviderName="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString.ProviderName %>" DeleteCommand="DELETE FROM tmp_prestadorxdocumento WHERE PrexDoc_ID = @original_PrexDoc_ID and Doc_Obrigatorio=2"
          InsertCommand="INSERT INTO [tmp_prestadorxdocumento] ([Pre_ID], [Pre_CNPJ], [Doc_ID], [Doc_Descricao], [PrexDoc_Emissao], [PrexDoc_Validade], [PrexDoc_Nome], [PrexDoc_Observacao], [PrexDoc_Situacao], [PrexDoc_Informacoes]) VALUES (@Pre_ID, @Pre_CNPJ, @Doc_ID, @Doc_Descricao, @PrexDoc_Emissao, @PrexDoc_Validade, @PrexDoc_Nome, @PrexDoc_Observacao, @PrexDoc_Situacao, @PrexDoc_Informacoes)"
          UpdateCommand="UPDATE [tmp_prestadorxdocumento] SET [Pre_ID] = @Pre_ID, [Pre_CNPJ] = @Pre_CNPJ, [Doc_ID] = @Doc_ID, [Doc_Descricao] = @Doc_Descricao, [PrexDoc_Emissao] = @PrexDoc_Emissao, [PrexDoc_Validade] = @PrexDoc_Validade, [PrexDoc_Nome] = @PrexDoc_Nome, [PrexDoc_Observacao] = @PrexDoc_Observacao, [PrexDoc_Situacao] = @PrexDoc_Situacao, [PrexDoc_Informacoes] = @PrexDoc_Informacoes WHERE [PrexDoc_ID] = @original_PrexDoc_ID">
          <SelectParameters>
            <asp:ControlParameter ControlID="txt_CNPJ" Name="Pre_CNPJ" PropertyName="Text" Type="String" />
          </SelectParameters>
          <DeleteParameters>
            <asp:Parameter Name="original_PrexDoc_ID" Type="Int32" />
          </DeleteParameters>
          <UpdateParameters>
            <asp:Parameter Name="Pre_ID" Type="Int32" />
            <asp:Parameter Name="Pre_CNPJ" Type="String" />
            <asp:Parameter Name="Doc_ID" Type="Int32" />
            <asp:Parameter Name="Doc_Descricao" Type="String" />
            <asp:Parameter Name="PrexDoc_Emissao" Type="DateTime" />
            <asp:Parameter Name="PrexDoc_Validade" Type="DateTime" />
            <asp:Parameter Name="PrexDoc_Nome" Type="String" />
            <asp:Parameter Name="PrexDoc_Observacao" Type="String" />
            <asp:Parameter Name="PrexDoc_Situacao" Type="String" />
            <asp:Parameter Name="PrexDoc_Informacoes" Type="String" />
            <asp:Parameter Name="original_PrexDoc_ID" Type="Int32" />
          </UpdateParameters>
          <InsertParameters>
            <asp:Parameter Name="Pre_ID" Type="Int32" />
            <asp:Parameter Name="Pre_CNPJ" Type="String" />
            <asp:Parameter Name="Doc_ID" Type="Int32" />
            <asp:Parameter Name="Doc_Descricao" Type="String" />
            <asp:Parameter Name="PrexDoc_Emissao" Type="DateTime" />
            <asp:Parameter Name="PrexDoc_Validade" Type="DateTime" />
            <asp:Parameter Name="PrexDoc_Nome" Type="String" />
            <asp:Parameter Name="PrexDoc_Observacao" Type="String" />
            <asp:Parameter Name="PrexDoc_Situacao" Type="String" />
            <asp:Parameter Name="PrexDoc_Informacoes" Type="String" />
          </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDocumento" runat="server" ConnectionString="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString %>"
          SelectCommand="SELECT Doc_ID, Doc_Descricao, Doc_Validade, Doc_Onde_Obter, Doc_Prestador, Doc_Fornecedor, Doc_Situacao FROM cad_documento WHERE (Doc_Prestador = 1) order by  Doc_Descricao"
          ProviderName="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString.ProviderName %>"></asp:SqlDataSource>


        <asp:SqlDataSource ID="SqlPrexPre" runat="server" ConnectionString="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString %>"
          OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM tmp_prestadorxprestador WHERE (Pre_CNPJ = @Pre_CNPJ) ORDER BY PrexPre_Nome"
          ProviderName="<%$ ConnectionStrings:FCCR_Cadastro_MySQL_ConnectionString.ProviderName %>" DeleteCommand="DELETE FROM tmp_prestadorxprestador WHERE PrexPre_ID = @original_PrexPre_ID"
          InsertCommand="INSERT INTO [tmp_prestadorxprestador] ([Pre_ID], [Pre_CNPJ], [PrexPre_Nome], [PrexPre_RG], [PrexPre_CPF], [PrexPre_Nacionalidade], [PrexPre_Estado_Civil], [PrexPre_Profissao], [PrexPre_Endereco], [PrexPre_Numero], [PrexPre_Complemento], [PrexPre_Bairro], [PrexPre_CEP], [PrexPre_Municipio], [PrexPre_UF], [PrexPre_Telefone], [PrexPre_Celular], [PrexPre_Email], [PrexPre_Servicos]) VALUES (@Pre_ID, @Pre_CNPJ, @PrexPre_Nome, @PrexPre_RG, @PrexPre_CPF, @PrexPre_Nacionalidade, @PrexPre_Estado_Civil, @PrexPre_Profissao, @PrexPre_Endereco, @PrexPre_Numero, @PrexPre_Complemento, @PrexPre_Bairro, @PrexPre_CEP, @PrexPre_Municipio, @PrexPre_UF, @PrexPre_Telefone, @PrexPre_Celular, @PrexPre_Email, @PrexPre_Servicos)"
          UpdateCommand="UPDATE [tmp_prestadorxprestador] SET [Pre_ID] = @Pre_ID, [Pre_CNPJ] = @Pre_CNPJ, [PrexPre_Nome] = @PrexPre_Nome, [PrexPre_RG] = @PrexPre_RG, [PrexPre_CPF] = @PrexPre_CPF, [PrexPre_Nacionalidade] = @PrexPre_Nacionalidade, [PrexPre_Estado_Civil] = @PrexPre_Estado_Civil, [PrexPre_Profissao] = @PrexPre_Profissao, [PrexPre_Endereco] = @PrexPre_Endereco, [PrexPre_Numero] = @PrexPre_Numero, [PrexPre_Complemento] = @PrexPre_Complemento, [PrexPre_Bairro] = @PrexPre_Bairro, [PrexPre_CEP] = @PrexPre_CEP, [PrexPre_Municipio] = @PrexPre_Municipio, [PrexPre_UF] = @PrexPre_UF, [PrexPre_Telefone] = @PrexPre_Telefone, [PrexPre_Celular] = @PrexPre_Celular, [PrexPre_Email] = @PrexPre_Email, [PrexPre_Servicos] = @PrexPre_Servicos WHERE [PrexPre_ID] = @original_PrexPre_ID">
          <SelectParameters>
            <asp:ControlParameter ControlID="txt_CNPJ" Name="Pre_CNPJ" PropertyName="Text" Type="String" />
          </SelectParameters>
          <DeleteParameters>
            <asp:Parameter Name="original_PrexPre_ID" Type="Int32" />
          </DeleteParameters>
          <UpdateParameters>
            <asp:Parameter Name="Pre_ID" Type="Int32" />
            <asp:Parameter Name="Pre_CNPJ" Type="String" />
            <asp:Parameter Name="PrexPre_Nome" Type="String" />
            <asp:Parameter Name="PrexPre_RG" Type="String" />
            <asp:Parameter Name="PrexPre_CPF" Type="String" />
            <asp:Parameter Name="PrexPre_Nacionalidade" Type="String" />
            <asp:Parameter Name="PrexPre_Estado_Civil" Type="String" />
            <asp:Parameter Name="PrexPre_Profissao" Type="String" />
            <asp:Parameter Name="PrexPre_Endereco" Type="String" />
            <asp:Parameter Name="PrexPre_Numero" Type="String" />
            <asp:Parameter Name="PrexPre_Complemento" Type="String" />
            <asp:Parameter Name="PrexPre_Bairro" Type="String" />
            <asp:Parameter Name="PrexPre_CEP" Type="String" />
            <asp:Parameter Name="PrexPre_Municipio" Type="String" />
            <asp:Parameter Name="PrexPre_UF" Type="String" />
            <asp:Parameter Name="PrexPre_Telefone" Type="String" />
            <asp:Parameter Name="PrexPre_Celular" Type="String" />
            <asp:Parameter Name="PrexPre_Email" Type="String" />
            <asp:Parameter Name="PrexPre_Servicos" Type="String" />
            <asp:Parameter Name="original_PrexPre_ID" Type="Int32" />
          </UpdateParameters>
          <InsertParameters>
            <asp:Parameter Name="Pre_ID" Type="Int32" />
            <asp:Parameter Name="Pre_CNPJ" Type="String" />
            <asp:Parameter Name="PrexPre_Nome" Type="String" />
            <asp:Parameter Name="PrexPre_RG" Type="String" />
            <asp:Parameter Name="PrexPre_CPF" Type="String" />
            <asp:Parameter Name="PrexPre_Nacionalidade" Type="String" />
            <asp:Parameter Name="PrexPre_Estado_Civil" Type="String" />
            <asp:Parameter Name="PrexPre_Profissao" Type="String" />
            <asp:Parameter Name="PrexPre_Endereco" Type="String" />
            <asp:Parameter Name="PrexPre_Numero" Type="String" />
            <asp:Parameter Name="PrexPre_Complemento" Type="String" />
            <asp:Parameter Name="PrexPre_Bairro" Type="String" />
            <asp:Parameter Name="PrexPre_CEP" Type="String" />
            <asp:Parameter Name="PrexPre_Municipio" Type="String" />
            <asp:Parameter Name="PrexPre_UF" Type="String" />
            <asp:Parameter Name="PrexPre_Telefone" Type="String" />
            <asp:Parameter Name="PrexPre_Celular" Type="String" />
            <asp:Parameter Name="PrexPre_Email" Type="String" />
            <asp:Parameter Name="PrexPre_Servicos" Type="String" />
          </InsertParameters>
        </asp:SqlDataSource>
        <asp:Timer ID="Timer1" runat="server" Enabled="False" Interval="5000">
        </asp:Timer>
      </td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td width="20px">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    </table>

    <div class="text-center">
      <p class="mb-0">Já tem uma conta?</p>
      <asp:Button runat="server" CausesValidation="False" Text=" Entre aqui." CssClass="btn btn-link" ID="Imgbtn_Cancelar"></asp:Button>
    </div>

  </form>
  <footer class="bg-green h-20 footer mt-3 position-relative">
    <div class="text-center brands">
      <a href="http://facebook.com/fccrsjc" target="_blank">
        <i class="fab fa-facebook"></i>
      </a>
      <a href="http://instagram.com/fccrsjc" target="_blank">
        <i class="fab fa-instagram"></i>
      </a>
      <a href="http://twitter.com/fccrsjc" target="_blank">
        <i class="fab fa-twitter"></i>
      </a>
      <a href="http://youtube.com/fccrsjc" target="_blank">
        <i class="fab fa-youtube"></i>
      </a>
    </div>
    <div class="text-center text-light mt-2 copy">
      <p>
        &copy;2018 <a href="http://fccr.sp.gov.br" target="_blank">Fundação Cultural Cassiano Ricardo </a>
      </p>
    </div>
  </footer>
  <script src="https://www.google.com/recaptcha/api.js?onload=renderRecaptcha&render=explicit" async defer></script>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
    crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
    crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
    crossorigin="anonymous"></script>
  <script type="text/javascript" src="/js/tabs.js"></script>
  <script type="text/javascript" src="/js/functions.js"></script>
  <script>
    $(function () {
      $('[data-toggle="popover"]').popover({
        trigger: 'focus'
      })
      $('[data-toggle="tooltip"]').tooltip({
        trigger: 'hover',
        placement: 'top'
      })
    })
  </script>
</body>

</html>