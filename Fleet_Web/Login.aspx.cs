using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{

    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;


    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        try
        {
            
            string username = txtUsername.Text.ToString();
            string password = txtPass.Text.ToString();

            con = new SqlConnection(constr);
            cmd = new SqlCommand("select * from admin_master where username=@username and password=@pass", con);
            cmd.Parameters.AddWithValue("@username", username);
            cmd.Parameters.AddWithValue("@pass", password);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                Session["uname"] = username;
                Response.Redirect("Admin/Dashboard.aspx");
                lblError.Visible = false;
            }
            else
                lblError.Visible = true;
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
}