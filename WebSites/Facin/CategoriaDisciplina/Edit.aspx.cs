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
using BusinessData.Entities;
using BusinessData.BusinessLogic;
using System.Security;
using System.Collections.Generic;

public partial class CategoriaDisciplina_Edit: System.Web.UI.Page
{
    CategoriaRecursoBO crBo = new CategoriaRecursoBO();

    protected void Page_Load(object sender, EventArgs e)
    {
        //Se n�o for postback, ou seja, se estiver carregando normalmente a p�gina,
        if (!IsPostBack)
        {
            if (Request.QueryString["GUID"] != null)
            {

                try
                {
                    CategoriaDisciplinaBO boCategoriaDisciplina = new CategoriaDisciplinaBO();

                    try
                    {
                        //Caso haja a querystring, popula o gridview com as "categoriarecurso"s existentes do banco
                        CategoriaDisciplina cat = boCategoriaDisciplina.GetCategoriaDisciplina(new Guid(Request.QueryString["GUID"]));
                        txtDescricao.Text = cat.Descricao;
                        grvListaCatDisciplina.DataSource = crBo.GetCategoriaRecurso();
                        grvListaCatDisciplina.DataBind();

                        //e, para cada linha de CategoriaRecurso, testa se ela j� existia no momento em que a CategoriaDisciplina
                        //foi criada(basta testar se ela existe dentro das atuais, que � o que o foreach faz)
                        //caso positivo, popula o textbox com o valor da prioridade que existia.
                        for (int i = 0; i < grvListaCatDisciplina.Rows.Count; i++)
                        {
                            Guid id = (Guid)grvListaCatDisciplina.DataKeys[i].Value;
                            foreach (KeyValuePair<CategoriaRecurso, double> kvp in cat.Prioridades)
                            {
                                try
                                {
                                    if (id == kvp.Key.Id)
                                    {
                                        ((TextBox)(grvListaCatDisciplina.Rows[i].FindControl("txtPrioridade"))).Text = kvp.Value.ToString();
                                        break;
                                    }
                                }
                                catch (Exception ex)
                                {
                                    Response.Redirect("~/Default/Erro.aspx?Erro=" + ex.Message);
                                }
                            }
                        }
                    }
                    catch (FormatException ex)
                    {
                        Response.Redirect("~/CategoriaDisciplina/List.aspx");
                    }


                }
                catch (BusinessData.DataAccess.DataAccessException)
                {
                    Response.Redirect("~/CategoriaDisciplina/List.aspx");
                }
            }
                //Se n�o houver Query String significa q essa p�gina n serve pra nada! Volta pra que lista, que
                //serve pra alguma coisa
            else
            {
                Response.Redirect("~/CategoriaDisciplina/List.aspx");
            }
        }
    }

    //Caso a edi��o seja confirmada...
    protected void btnConfirmar_Click(object sender, EventArgs e)
    {
        Dictionary<CategoriaRecurso, double> prioridades = new System.Collections.Generic.Dictionary<CategoriaRecurso, double>();

        //Recria o dicion�rio com os valores modificados(ou n�o) do gridview
        for (int i = 0; i < grvListaCatDisciplina.DataKeys.Count; i++)
        {
            try
            {
                Guid id = (Guid)grvListaCatDisciplina.DataKeys[i].Value;
                CategoriaRecurso cat = crBo.GetCategoriaRecursoById(id);
                if (cat != null)
                {

                    double p = Convert.ToDouble(((TextBox)(grvListaCatDisciplina.Rows[i].FindControl("txtPrioridade"))).Text);

                    prioridades.Add(cat, p);
                }
                else Response.Redirect("~/Default/Erro.aspx?Erro=" + "Categoria n�o existente.");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Default/Erro.aspx?Erro=" + ex.Message);
            }

        }

        //Cria-se, ent�o, uma nova inst�ncia de CategoriaDisciplina, com o ID original, o nome que pode(ou n�o) ter sido mudado pelo usu�rio
        //e o dicion�rio criado anteriormente contendo todos os novos valores
        CategoriaDisciplina cd = CategoriaDisciplina.GetCategoriaDisciplina(new Guid(Request.QueryString["GUID"]), txtDescricao.Text, prioridades);

        try
        {
            CategoriaDisciplinaBO cdBo = new CategoriaDisciplinaBO();
            //Manda fazer o update, finalmente
            cdBo.UpdateCategoriaDisciplina(cd);
            Response.Redirect("~/CategoriaDisciplina/List.aspx");            
        }
        catch (BusinessData.DataAccess.DataAccessException ex)
        {
            Response.Redirect("~/Default/Erro.aspx?Erro=" + ex.Message);
        }
        catch (SecurityException ex)
        {
            Response.Redirect("~/Default/Erro.aspx?Erro=" + ex.Message);
        }
    }

    protected void lbtnVoltar_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/CategoriaDisciplina/List.aspx");
    }
}
