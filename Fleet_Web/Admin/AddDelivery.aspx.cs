using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AddDelivery : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillDriverDropdown();
            fillVehicleDropdown();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_save_deliveryMaster", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iDid", ddDriver.SelectedValue);
            cmd.Parameters.AddWithValue("@iVid", ddVehicle.SelectedValue);
            cmd.Parameters.AddWithValue("@iDdate", txtDate.Text);
            cmd.Parameters.AddWithValue("@iDdesc", txtDesc.Text);
            cmd.Parameters.AddWithValue("@iDlat", Convert.ToDouble(txtLat.Text));
            cmd.Parameters.AddWithValue("@iDlon", Convert.ToDouble(txtLon.Text));
            cmd.Parameters.AddWithValue("@iDkms", Convert.ToDouble(txtKms.Text));
            cmd.Parameters.AddWithValue("@iDAddr", txtAddress.Text);
            cmd.Parameters.AddWithValue("@iPickup", txtPickup.Text);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if(dt.Rows.Count > 0)
            {
                string message = dt.Rows[0]["message"].ToString();
                Response.Write("<script>alert('" + message + "')</script>");
                if (message.Trim().Equals("Success"))
                    Response.Redirect("ManageDelivery.aspx");
            }

        }
        catch(Exception ex)
        {
            throw ex;
        }
    }

    private void fillDriverDropdown()
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_ddl_driver", con);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddDriver.DataValueField = "d_id";
                ddDriver.DataTextField = "d_name";
                ddDriver.DataSource = dt;
                ddDriver.DataBind();                
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    private void fillVehicleDropdown()
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_ddl_vehicle", con);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddVehicle.DataValueField = "v_id";
                ddVehicle.DataTextField = "v_name";
                ddVehicle.DataSource = dt;
                ddVehicle.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void imgCal_Click(object sender, ImageClickEventArgs e)
    {
        cal.Visible = true;
    }
    protected void cal_SelectionChanged(object sender, EventArgs e)
    {
        txtDate.Text = cal.SelectedDate.ToShortDateString(); // just use this method to get dd/MM/yyyy  
        cal.Visible = false;
    }
}