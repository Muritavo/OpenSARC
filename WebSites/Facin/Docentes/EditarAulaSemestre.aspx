<%@ Page Language="C#" MasterPageFile="~/Master/Master.master" AutoEventWireup="true" 
CodeFile="EditarAulaSemestre.aspx.cs" Inherits="Docentes_EditarAula" 
Title="Sistema de Aloca��o de Recursos - FACIN" %>

<%@ Register Src="../Default/Aguarde.ascx" TagName="Aguarde" TagPrefix="uc1" %>

  <%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>
    
<%@ Import Namespace ="BusinessData.Util" %>
<%-- Add content controls here --%>


<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="cphTitulo">
<script  type="text/javascript" language="javascript">

function popitup(url) {
	newwindow=window.open(url,'name','width=400, height=300, menubar=no, resizable=no');
	if (window.focus) {newwindow.focus()}
	return false;
}

function popitup(url,h,w) {
	newwindow=window.open(url,'name','width='+h+', height='+w+', menubar=no, resizable=no');
	if (window.focus) {newwindow.focus()}
	return false;
}
</script>

<div align="left" class="ms-menutoolbar" style="width: 100%; height: 14px">
        <asp:Label ID="lblTitulo" runat="server" CssClass="ms-WPTitle" Text="Aulas"></asp:Label>
    </div>

    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
         <div align="left">
    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
        <ProgressTemplate>
            <uc1:Aguarde ID="Aguarde1" runat="server" />
        </ProgressTemplate>
    </asp:UpdateProgress>
             </div>
            
           <asp:Label ID="lblResultado" runat="server" CssClass="lblStatus" Text="" Visible="true">
           </asp:Label>
            <asp:CheckBox ID="chbAutoSave" runat="server" CssClass ="ms-toolbar" Text="Auto Save" 
                          EnableViewState="true"  Visible="false"/><div style="width: 244px; height: 30px">
                <asp:Button ID="btnExportarHTML" runat="server" CssClass="ms-toolbar" 
                            OnClick="btnExportarHTML_Click" Text="Exportar HTML" />
                
                <asp:Button ID="btnSalvarTudo" runat="server" CssClass="ms-toolbar" 
                        Text="Salvar Todos" OnClick="btnSalvarTudo_Click" />
            </div>
   
   
   <asp:DataGrid ID="dgAulas" 
                 runat="server"       
                 AutoGenerateColumns="False" 
                 Width="100%" 
                 HorizontalAlign="Center" 
                 OnItemDataBound="dgAulas_ItemDataBound" 
                 DataKeyField="Id" 
                 OnItemCommand="dgAulas_ItemCommand">
    
        <ItemStyle CssClass="ms-toolbar"  HorizontalAlign="Center"/>
        <HeaderStyle CssClass="ms-wikieditthird" HorizontalAlign="Center" />
        <Columns>
            
            <asp:TemplateColumn HeaderText="AulaId" Visible="False"> 
                <ItemTemplate>
                    <asp:Label ID="lblAulaId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
                                
            <asp:TemplateColumn HeaderText="Aula">
                <ItemTemplate>
                    <asp:Label ID="lblAula" runat="server"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle VerticalAlign="Middle" />
            </asp:TemplateColumn>
            
            <asp:TemplateColumn HeaderText="Dia">
                <ItemTemplate>
                    <asp:Label ID="lblDia" runat="server" Text='<%#(DataHelper.GetDia((DayOfWeek)((DateTime)DataBinder.Eval(Container.DataItem, "Data")).DayOfWeek))%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblDiaEdit" runat="server" Text='<%#(DataHelper.GetDia((DayOfWeek)((DateTime)DataBinder.Eval(Container.DataItem, "Data")).DayOfWeek))%>'></asp:Label>
                </EditItemTemplate>
            </asp:TemplateColumn>
            
            <asp:TemplateColumn HeaderText="Data" >
                <ItemTemplate>
                    <asp:Label ID="lblData" runat="server" Text='<%#((DateTime)DataBinder.Eval(Container.DataItem, "Data")).ToShortDateString()%>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateColumn>
                     
            <asp:TemplateColumn HeaderText="Hora">
                <ItemTemplate>
                    <asp:Label ID="lblHora" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Hora") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle VerticalAlign="Middle" />
            </asp:TemplateColumn>
            
            <asp:TemplateColumn HeaderText="Descri&#231;&#227;o">
                <ItemTemplate>
                    <asp:TextBox ID="txtDescricao" runat="server" CssClass="ms-toolbar" Height="38px"
                        Width="400px" TextMode="MultiLine" Text='<%#DataBinder.Eval(Container.DataItem, "DescricaoAtividade") %>'></asp:TextBox>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateColumn>
            
            <asp:TemplateColumn HeaderText="Atividade">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlAtividade" runat="server" CssClass="ms-toolbar" >
                    </asp:DropDownList>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateColumn>
            
            <asp:ButtonColumn CommandName="Select" Text="Selecionar"  HeaderText="Recursos Dispon�veis"></asp:ButtonColumn>
            
            <asp:TemplateColumn HeaderText="Recursos_Alocados_id"  Visible="false">
                <ItemTemplate>
                    <asp:Label ID="lblRecurosAlocadosId" runat="server" ></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
                                   
            <asp:TemplateColumn HeaderText="Recursos Alocados" >
                <ItemTemplate>
                    <asp:Label ID="lblRecurosAlocados" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn> 
            
            <asp:ButtonColumn CommandName="Trocar" Text="Trocar Recurso" ></asp:ButtonColumn>
            <asp:ButtonColumn CommandName="Transferir" Text="Transferir Recurso"></asp:ButtonColumn>
            <asp:ButtonColumn CommandName="Salvar" Text="Salvar"></asp:ButtonColumn>
            
            <asp:TemplateColumn HeaderText="CorDaData" Visible="False"> 
                <ItemTemplate>
                    <asp:Label ID="lblCorDaData" runat="server" ></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            
            <asp:TemplateColumn HeaderText="DescData" Visible="False"> 
                <ItemTemplate>
                    <asp:Label ID="lblDescData" runat="server" ></asp:Label>
                </ItemTemplate>
            </asp:TemplateColumn>
            
                   
        </Columns>
    </asp:DataGrid>
    
  <div align="right">
        <asp:Button ID="btnSalvarTudo2" runat="server" CssClass="ms-toolbar" Text="Salvar Todos"  
                    OnClick="btnSalvarTudo_Click"/>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="dgAulas" EventName="SelectedIndexChanged" />
        </Triggers>
    </asp:UpdatePanel>
   
  
</asp:Content>