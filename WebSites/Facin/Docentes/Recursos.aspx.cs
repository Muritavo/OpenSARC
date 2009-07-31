using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using BusinessData.BusinessLogic;
using System.Collections.Generic;
using BusinessData.Entities;

public partial class Docentes_Recursos : System.Web.UI.Page
{
    RecursosBO controleRecursos = new RecursosBO();
    AlocacaoBO alocBO = new AlocacaoBO();
    AulaBO aulaBO = new AulaBO();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PopulaDDLCategoriaRecursos();
            ddlRecurso.Items.Add("Selecione");

            if (Session["AppState"] != null && ((AppState)Session["AppState"]) == AppState.Admin)
            {
                Server.Transfer("~/Default/Erro.aspx?Erro=O sistema est� bloqueado.");
            }
            else
            {
                if (Session["Calendario"] == null)
                {
                    Response.Redirect("../Default/SelecionarCalendario.aspx");
                }

                if (Request.QueryString["AulaId"] != String.Empty)
                {
                    Guid aulaId = new Guid(Request.QueryString["AulaId"]);
                    DateTime data = Convert.ToDateTime(Session["DataAula"]);
                    string horario = (string)Session["Horario"];

                    List<Recurso> recAlocados = alocBO.GetRecursoAlocadoByAula(data, horario, aulaId);
                    LBoxAlocados.DataSource = recAlocados;
                    LBoxAlocados.DataTextField = "Descricao";
                    LBoxAlocados.DataValueField = "Id";
                    LBoxAlocados.DataBind();
                }

            }
        }
    }

    private void PopulaDDLCategoriaRecursos()
    {
        CategoriaRecursoBO controleCategorias = new CategoriaRecursoBO();
        ddlCategoriaRecurso.DataSource = controleCategorias.GetCategoriaRecurso();
        ddlCategoriaRecurso.DataTextField = "Descricao";
        ddlCategoriaRecurso.DataValueField = "Id";
        ddlCategoriaRecurso.DataBind();
        ddlCategoriaRecurso.Items.Insert(0, "Selecione");
    }

    protected void ddlCategoriaRecurso_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCategoriaRecurso.SelectedIndex != 0)
        {
            DateTime data = Convert.ToDateTime(Session["DataAula"]);
            string horario = (string)Session["Horario"];
            Guid catRecId = new Guid(ddlCategoriaRecurso.SelectedValue);
            

            List<Recurso> listaRecursos = controleRecursos.GetRecursosDisponiveis(data, horario, catRecId);
            ddlRecurso.DataSource = listaRecursos;
            ddlRecurso.DataTextField = "Descricao";
            ddlRecurso.DataValueField = "Id";

            ddlRecurso.DataBind();
            ddlRecurso.Items.Insert(0, "Selecione");

            ddlCategoriaRecurso.SelectedValue = Convert.ToString(catRecId);

            ddlRecurso.Enabled = true;
        }
        else
        {
            lblStatus.Text = "";
            ddlRecurso.SelectedIndex = 0;
            ddlRecurso.Enabled = false;
        }
    }
    
    protected void btnAdicionar_Click(object sender, EventArgs e)
    {
        if (ddlRecurso.SelectedIndex != 0)
        {
            DateTime data = Convert.ToDateTime(Session["DataAula"]);
            string horario = (string)Session["Horario"];
            Guid aulaId = new Guid(Request.QueryString["AulaId"]);
            Guid recId = new Guid(ddlRecurso.SelectedValue);

            Aula aula = aulaBO.GetAulaById(aulaId);
            Recurso rec = controleRecursos.GetRecursoById(recId);
            Alocacao aloc = new Alocacao(rec,data,horario,aula,null);
            alocBO.UpdateAlocacao(aloc);

            List<Recurso> recAlocados = alocBO.GetRecursoAlocadoByAula(data, horario, aulaId);
            LBoxAlocados.DataSource = recAlocados;
            LBoxAlocados.DataTextField = "Descricao";
            LBoxAlocados.DataValueField = "Id";
            LBoxAlocados.DataBind();

            ddlCategoriaRecurso.SelectedIndex = 0;
            ddlRecurso.SelectedIndex = 0;
            ddlRecurso.Enabled = false;

            lblStatus.Text = "Recurso adicionado com sucesso.";
        }
        else
        {
            lblStatus.Text = "N�o � poss�vel adicionar este recurso.";
        }
        
    }

    private void FechaJanela()
    {
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "fecha", "window.close()", true);
    }

    protected void btnConfirmar_Click(object sender, EventArgs e)
    {
        FechaJanela();
    }

    protected void btnLiberar_Click(object sender, EventArgs e)
    {
        if (LBoxAlocados.SelectedValue != "")
        {
            DateTime data = Convert.ToDateTime(Session["DataAula"]);
            string horario = (string)Session["Horario"];
            Guid recId = new Guid(LBoxAlocados.SelectedValue);

            Recurso rec = controleRecursos.GetRecursoById(recId);
            Alocacao aloc = new Alocacao(rec, data, horario, null, null);
            alocBO.UpdateAlocacao(aloc);

            LBoxAlocados.Items.RemoveAt(LBoxAlocados.SelectedIndex);

            lblStatus.Text = "Recurso liberado!";
            ddlCategoriaRecurso.SelectedIndex = 0;
            ddlRecurso.SelectedIndex = 0;
            ddlRecurso.Enabled = false;
        }
        else
        {
            lblStatus.Text = "Selecione um recurso para liber�-lo!";
        }
    }
}
