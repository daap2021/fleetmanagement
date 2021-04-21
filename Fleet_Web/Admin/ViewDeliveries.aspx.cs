using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ViewDeliveries : System.Web.UI.Page
{
    string constr = System.Configuration.ConfigurationManager.ConnectionStrings["connect"].ToString();
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
            cmd = new SqlCommand("select d.delv_id,concat(dm.d_fname,dm.d_lname) as d_name,v.v_name,v.v_number,d.delv_date,d.delv_date,d.[delv_kms],d.[delv_address],d.[delv_img] from delivery_master d inner join driver_master dm on d.d_id = dm.d_id inner join vehicle_master v on d.v_id = v.v_id where d.delv_status = 1", con);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                gvDelv.DataSource = dt;
                gvDelv.DataBind();
            }
            else
            {
                gvDelv.DataSource = null;
                gvDelv.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void gvDelv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string delv_img = e.CommandArgument.ToString();
        if (e.CommandName == "ViewTable")
            if(delv_img.Equals(""))
                Response.Write("<script>alert('No image found')</script>");
           else
               Response.Redirect("http://demoproject.in/fleet_service/" + delv_img);
    }

}