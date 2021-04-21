using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Signup : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(constr);

            cmd = new SqlCommand("select * from user_master where u_email=@email", con);
            cmd.Parameters.AddWithValue("@email", txtEmail.Text);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                Response.Write("<script>alert('Email id already taken')</script>");
            }
            else
            {
                if (con.State != ConnectionState.Open)
                    con.Open();
                cmd = new SqlCommand("insert into user_master values (@name,@email,@pass,@contact)", con);
                cmd.Parameters.AddWithValue("@name", txtFname.Text);
                cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@pass", txtPass.Text);
                cmd.Parameters.AddWithValue("@contact", txtContact.Text);
                int result = cmd.ExecuteNonQuery();
                if (result == 1)
                    Response.Write("<script>alert('Signup successfully');" +
                         "window.location ='Login.aspx';</script>");
                else
                    Response.Write("<script>alert('Something went wrong')</script>");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}