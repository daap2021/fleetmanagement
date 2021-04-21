using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AddVehicle : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
    string operation;
    string v_id;

    protected void Page_Load(object sender, EventArgs e)
    {
        operation = Request.QueryString["action"].ToString();
        if (operation.Trim() == "edit")
        {
            v_id = Request.QueryString["v_id"].ToString();
            if (!IsPostBack)
                getVehicleDetails(v_id);
        }   
    }


    protected void btnSumbit_Click(object sender, EventArgs e)
    {
        try
        {
            double kms = Convert.ToDouble(txtKms.Text.ToString());
            double s_kms = Convert.ToDouble(txtSkms.Text.ToString());

            if (s_kms < kms)
            {
                Response.Write("<script>alert('Next service kms cannot be less than current kms')</script>");
                return;
            }

            con = new SqlConnection(constr);

            if (operation.Trim() == "edit") {
                cmd = new SqlCommand("usp_update_vehicleMaster", con);
                cmd.Parameters.AddWithValue("@iVid", Convert.ToInt32(v_id));
            }
            else
                cmd = new SqlCommand("usp_save_vehicleMaster", con);

            
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iVname", txtName.Text);
            cmd.Parameters.AddWithValue("@iVnumber", txtNumber.Text);
            cmd.Parameters.AddWithValue("@iVkm", Convert.ToDouble(txtKms.Text));
            cmd.Parameters.AddWithValue("@iVskm", Convert.ToDouble(txtSkms.Text));
            cmd.Parameters.AddWithValue("@iVins", txtDate.Text);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                string message = dt.Rows[0]["message"].ToString();
                Response.Write("<script>alert('" + message + "')</script>");
                if (message.Trim().Equals("Success"))
                    Response.Redirect("ManageVehicle.aspx");   
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }

    private void getVehicleDetails(string v_id)
    {
        try
        {
            lblTitle.Text = "Edit Vehicle";
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_get_vehicleMaster", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iVid", Convert.ToInt32(v_id));
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                txtName.Text = dt.Rows[0]["v_name"].ToString();
                txtNumber.Text = dt.Rows[0]["v_number"].ToString();
                txtKms.Text = dt.Rows[0]["v_kms"].ToString();
                txtSkms.Text = dt.Rows[0]["v_skms"].ToString();
                txtDate.Text = dt.Rows[0]["v_insurance"].ToString();
            }
        }
        catch(Exception ex)
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