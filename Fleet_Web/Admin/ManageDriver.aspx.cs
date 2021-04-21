using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageDriver : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            fillGridView();
    }

    private void fillGridView()
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_get_driverMaster", con);
            cmd.Parameters.AddWithValue("@iDriverId", 0);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if(dt.Rows.Count > 0)
            {
                gvDriver.DataSource = dt;
                gvDriver.DataBind();
            }
            else
            {
                gvDriver.DataSource = null;
                gvDriver.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void gvDriver_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string d_id = e.CommandArgument.ToString();
        if (e.CommandName == "EditTable")
            Response.Redirect("AddDriver.aspx?action=edit&d_id=" + d_id);
        else
            deleteDriver(d_id);
    }

    private void deleteDriver(string d_id)
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_delete_driverMaster", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iDriverId", Convert.ToInt32(d_id));
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
                fillGridView();
            else
                Response.Write("<script>alert('Something went wrong')</script>");
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
}