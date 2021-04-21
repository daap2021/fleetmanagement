using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AddDriver : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
    string operation;
    string d_id;

    protected void Page_Load(object sender, EventArgs e)
    {
       
        operation = Request.QueryString["action"].ToString();
        if (operation.Trim() == "edit")
        {
            d_id = Request.QueryString["d_id"].ToString(); 
            if(!IsPostBack)
                getDriverDetails(d_id);
        }       
    }

   
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(constr);

            string password = generatePassword(6);

            if (operation.Trim() == "edit"){
                cmd = new SqlCommand("usp_update_driverMaster", con);
                cmd.Parameters.AddWithValue("iDid", Convert.ToInt32(d_id));
                cmd.Parameters.AddWithValue("@iFname", txtFname.Text.ToString());
                cmd.Parameters.AddWithValue("@iLname", txtLname.Text.ToString());
                cmd.Parameters.AddWithValue("@iContact", txtMobile.Text.ToString());
            }
            else
            {
                cmd = new SqlCommand("usp_save_driverMaster", con);
                cmd.Parameters.AddWithValue("@iFname", txtFname.Text.ToString());
                cmd.Parameters.AddWithValue("@iLname", txtLname.Text.ToString());
                cmd.Parameters.AddWithValue("@iEmail", txtEmail.Text.ToString());
                cmd.Parameters.AddWithValue("@iPass",password);
                cmd.Parameters.AddWithValue("@iContact", txtMobile.Text.ToString());
            }
            cmd.CommandType = CommandType.StoredProcedure;
            
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                string message = dt.Rows[0]["message"].ToString();
                Response.Write("<script>alert('" + message + "')</script>");
                if (message.Trim().Equals("Success"))
                {
                    Response.Redirect("ManageDriver.aspx");
                    if (operation.Trim() == "edit")
                    {

                        sendMail(txtEmail.Text.ToString(), password);
                    }
                }
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }

    private void sendMail(string email, string password)
    {
        try
        {

            MailMessage mail = new MailMessage();
            SmtpClient SmtpServer = new SmtpClient("demoproject.in");
            mail.From = new MailAddress("test@demoproject.in");
            mail.To.Add(email);
            mail.Subject = "Password";
            mail.Body = "Your password is:" + password;
            SmtpServer.Port = 25;
            SmtpServer.Credentials = new System.Net.NetworkCredential("test@demoproject.in", "Password@123");
            SmtpServer.Send(mail);
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }

    private void getDriverDetails(string d_id)
    {
        try
        {
            lblTitle.Text = "Edit Driver";
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_get_driverMaster", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iDriverId", Convert.ToInt32(d_id));
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if(dt.Rows.Count > 0)
            {
                txtEmail.Enabled = false;
                txtFname.Text = dt.Rows[0]["d_fname"].ToString();
                txtLname.Text = dt.Rows[0]["d_lname"].ToString();
                txtEmail.Text = dt.Rows[0]["d_email"].ToString();
                txtMobile.Text = dt.Rows[0]["d_contact"].ToString();
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }


    private string generatePassword(int length)
    {
        var chars = "QWERTYUIOPLKJHGFDSAZXCVBNMqwertyuioplkjhgfdsazxcvbnm0987654321";
        var stringargs = new char[length];
        var random = new Random();
        for (int i = 0; i < stringargs.Length; i++)
        {
            stringargs[i] = chars[random.Next(chars.Length)];
        }
        return new String(stringargs);
    }
}