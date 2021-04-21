using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageDelivery : System.Web.UI.Page
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
            cmd = new SqlCommand("usp_get_deliveryMaster", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iDelvId", 0);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                gvDelivery.DataSource = dt;
                gvDelivery.DataBind();
            }
            else
            {
                gvDelivery.DataSource = null;
                gvDelivery.DataBind();
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }

    protected void gvDelivery_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int delv_id = Convert.ToInt32(e.CommandArgument);
            con = new SqlConnection(constr);
            if (con.State != ConnectionState.Open)
                con.Open();
            cmd = new SqlCommand("delete from delivery_master where delv_id = @delv_id", con);
            cmd.Parameters.AddWithValue("@delv_id", delv_id);
            int result = cmd.ExecuteNonQuery();
            if (result == 1)
                fillGridView();
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }


}