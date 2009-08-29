<%-- $Id$ --%>

<%@ Page Language="C#" MasterPageFile="~/Master/Master.master" AutoEventWireup="true" 
CodeFile="Default.aspx.cs" Inherits="_Default"  %>
<%-- Add content controls here --%>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphTitulo">
    <div align="left" class="ms-menutoolbar" style="width: 100%; height: 14px">
        <asp:Label ID="lblLogin" runat="server" CssClass="ms-WPTitle" Text="ENTRAR"></asp:Label></div>
    <table style="width: 100%">
        <tr>
            <td align="center"  valign="top" colspan="2" style="text-align: left">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center" class="ms-toolbar" style="font-size: 42px; width: 248px;" 
                valign="top">
                <span style="font-size: medium; background-color: #FFFFFF">Bem-vindo ao OpenSARC!</span></td>
            <td align="center" class="ms-toolbar" style="font-size: 42px" valign="top">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
        </tr>
        <tr>
            <td align="center" class="ms-toolbar" 
                style="text-align: justify; width: 248px;" valign="top">
                <p style="padding: 4px; margin: 4px; height: 124px; width: 389px; text-align: left">
                    O OpenSARC � um sistema para aloca��o de recursos computacionais. Al�m da 
                    solicita��o de recursos durante o per�odo de planejamento semestral, o sistema 
                    permite agendar eventos, consultar datas de avalia��es e trocar e transferir 
                    recursos durante todo o ano.<br />
                    <br />
                    O OpenSARC � <i>software</i> livre. Caso deseje participar, reclamar ou dar 
                    sugest�es, visite <a href="http://opensarc.sourceforge.net" target="_projeto">http://opensarc.sourceforge.net</a>.<br />
                    <br />
                    Em especial, aguardamos volunt�rios interessados em utilizar o sistema como 
                    estudo de caso para suas disciplinas de desenvolvimento de <i>software</i>.</p>
            </td>
            <td align="center" class="ms-toolbar" 
                style="font-size: 42px; text-align: center;" valign="top">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                <asp:Login ID="loginEntrada" runat="server" CssClass="ms-toolbar" FailureText="Matr�cula ou senha inv�lida. "
                    Font-Bold="False" LoginButtonText="Entrar" PasswordLabelText="Senha:" PasswordRequiredErrorMessage="Senha n�o pode ser nula."
                    RememberMeText="Lembrar de mim da pr�xima vez." UserNameLabelText="Matr�cula:"
                    UserNameRequiredErrorMessage="Matr�cula n�o pode ser nula." Width="360px" 
                            DestinationPageUrl="~/Default/SelecionarCalendario.aspx" 
                            OnLoginError="loginEntrada_LoginError" 
                            TitleText="Entre com sua matr�cula e senha no OpenSARC:" AccessKey="M" BorderPadding="3" 
                            >
                    <TitleTextStyle CssClass="ms-toolbar" Font-Bold="False" Font-Names="Verdana"
                        Font-Size="12px" />
                    <CheckBoxStyle CssClass="ms-toolbar" />
                    <InstructionTextStyle CssClass="ms-toolbar" />
                    <TextBoxStyle CssClass="ms-toolbar" Width="200px" />
                    <LoginButtonStyle CssClass="ms-toolbar" />
                    <LabelStyle CssClass="ms-toolbar" />
                </asp:Login>
                    </ContentTemplate>
                </asp:UpdatePanel>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
