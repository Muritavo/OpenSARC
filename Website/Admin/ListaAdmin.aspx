<%@ Page Language="C#" MasterPageFile="~/Master/Master.master" AutoEventWireup="true" CodeFile="ListaAdmin.aspx.cs" Inherits="Default_ListaAdmin" Title="Sistema de Aloca��o de Recursos Computacionais - FACIN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphTitulo" Runat="Server">
    <div align = left class="ms-menutoolbar" style="width: 100%; height: 14px">
        <asp:Label ID="lblTitulo" runat="server" CssClass="ms-WPTitle" Text="LISTA DE ADMINS"></asp:Label>
    </div>
    Usu�rios com permiss�o de admin:<br />
    <asp:CheckBoxList ID="cblAdmins" runat="server" BackColor="White" BorderColor="White"
        CssClass="ms-toolbar">
    </asp:CheckBoxList><br />
    Usu�rios com permiss�o de secret�rio:<br />
    <asp:CheckBoxList ID="cblSecretarios" runat="server" BackColor="White" BorderColor="White"
        CssClass="ms-toolbar">
    </asp:CheckBoxList><br />
    <asp:Button ID="btnExcluir" runat="server" CssClass="ms-toolbar" OnClick="btnExcluir_Click"
        Text="Exclu�r Selecionados" /><br />
    <asp:Label ID="lblStatus" runat="server" CssClass="lblstatus" Text="Label" Visible="False"></asp:Label>
    <br />
    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="ms-toolbar" OnClick="LinkButton1_Click">
Voltar</asp:LinkButton>
</asp:Content>

