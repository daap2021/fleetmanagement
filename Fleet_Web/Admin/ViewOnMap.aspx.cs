using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Test_Admin_Default : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            fillDropDown();
    }

    private void fillDropDown()
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_ddl_driver", con);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if(dt.Rows.Count > 0)
            {
                
                ddDriver.DataValueField = "d_id";
                ddDriver.DataTextField = "d_name";
                ddDriver.DataSource = dt;
                ddDriver.DataBind();
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }

   
    void viewAll()
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_get_driver_location", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iDid", 6);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                rptMarkers.DataSource = dt;
                rptMarkers.DataBind();
            }
            else
            {
                rptMarkers.DataSource = null;
                rptMarkers.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        try
        {
            int d_id = Convert.ToInt32(ddDriver.SelectedValue);
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_get_driver_location", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iDid", d_id);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                rptMarkers.DataSource = dt;
                rptMarkers.DataBind();
            }
            else
            {
                rptMarkers.DataSource = null;
                rptMarkers.DataBind();
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
}