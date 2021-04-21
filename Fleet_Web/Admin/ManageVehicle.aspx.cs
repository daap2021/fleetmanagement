using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageVehicle : System.Web.UI.Page
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
            cmd = new SqlCommand("usp_get_vehicleMaster", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iVid", Convert.ToInt32("0"));
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if(dt.Rows.Count > 0)
            {
                gvVehicle.DataSource = dt;
                gvVehicle.DataBind();
            }
            else
            {
                gvVehicle.DataSource = null;
                gvVehicle.DataBind();
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
    protected void gvVehicle_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string v_id = e.CommandArgument.ToString();
        if (e.CommandName == "EditTable")
            Response.Redirect("AddVehicle.aspx?action=edit&v_id=" + v_id);
        else
            deleteVehicle(v_id);
    }

    private void deleteVehicle(string v_id)
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_delete_vehicleMaster", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iVid", Convert.ToInt32(v_id));
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
                fillGridView();
            else
                Response.Write("<script>alert('Something went wrong')</script>");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}