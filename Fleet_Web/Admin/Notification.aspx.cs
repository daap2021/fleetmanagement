using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Notification : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataSet ds;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            getReminderDetails();
    }

    private void getReminderDetails()
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_reminder", con);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);
            if(ds.Tables.Count > 0)
            {
                gvInsurance.DataSource = ds.Tables[0];
                gvInsurance.DataBind();
                gvService.DataSource = ds.Tables[1];
                gvService.DataBind();
            }
            else
            {
                gvInsurance.DataSource = null;
                gvInsurance.DataBind();
                gvService.DataSource = null;
                gvService.DataBind();
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
}