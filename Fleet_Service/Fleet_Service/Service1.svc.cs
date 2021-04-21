using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Web;

namespace Fleet_Service
{
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Required)]
    public class Service1 : IService1
    {
        string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataTable dt;
        string file_name = "";
        string filePath = "";

        public RespLogin login(string email, string pass)
        {
            try
            {
                con = new SqlConnection(constr);
                cmd = new SqlCommand("usp_driverLogin", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@iDEmail", email);
                cmd.Parameters.AddWithValue("@iDPass", pass);
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);
                if(dt.Rows.Count > 0)
                {
                    return new RespLogin
                    {
                        d_id = dt.Rows[0]["d_id"].ToString(),
                        message = "Login successful"
                    };
                }
                else
                {
                    return new RespLogin
                    {
                        d_id = "0",
                        message = "Invalid email id or password"
                    };
                }
            }
            catch (Exception ex)
            {
                return new RespLogin
                {
                    d_id = "0",
                    message = ex.ToString()
                };
            }
        }
        public List<Delivery> getDeliveries(string d_id)
        {
            List<Delivery> list = new List<Delivery>();
            try
            {
                con = new SqlConnection(constr);
                cmd = new SqlCommand("usp_get_deliveries", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@iDid", Convert.ToInt32(d_id));
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);
                if(dt.Rows.Count > 0)
                {
                    for(int i=0;i<dt.Rows.Count;i++)
                    {
                        Delivery d = new Delivery
                        {
                           delv_id = Convert.ToInt32(dt.Rows[i]["delv_id"]),
                           v_id = Convert.ToInt32(dt.Rows[i]["v_id"]),
                           v_name = dt.Rows[i]["v_name"].ToString(),
                           delv_date = dt.Rows[i]["delv_date"].ToString(),
                           delv_desc = dt.Rows[i]["delv_desc"].ToString(),
                           delv_lat = Convert.ToDouble(dt.Rows[i]["delv_lat"]),
                           delv_lon = Convert.ToDouble(dt.Rows[i]["delv_lon"]),
                           delv_kms = Convert.ToDouble(dt.Rows[i]["delv_kms"]),
                           delv_address = dt.Rows[i]["delv_address"].ToString(),
                           delv_source = dt.Rows[i]["delv_source"].ToString(),
                           message = "Success"
                        };
                        list.Add(d);
                    }
                }
                return list;
            }
            catch(Exception ex)
            {
                Delivery d = new Delivery
                {
                   message = ex.ToString()
                };
                list.Add(d);
                return list;
            }
        }
        public RespMessage upload(Document doc)
        {     
            try
            {

                Random r = new Random();
                file_name = r.Next(200, 10000).ToString();

                byte[] imagebytes = Convert.FromBase64String(doc.delv_img);
                filePath = HttpContext.Current.Server.MapPath("~/Images/" + Path.GetFileName(file_name) + ".jpg");
                string path = "Images/" + Path.GetFileName(file_name) + ".jpg";
                File.WriteAllBytes(filePath, imagebytes);

                con = new SqlConnection(constr);
                if (con.State != ConnectionState.Open)
                    con.Open();

                cmd = new SqlCommand("update delivery_master set delv_img=@img where delv_id=@id", con);
                cmd.Parameters.AddWithValue("@id", doc.delv_id);
                cmd.Parameters.AddWithValue("@img", path);
                int result = (int)cmd.ExecuteNonQuery();
                con.Close();
                if (result == 1)
                    return new RespMessage { message = "Document uploaded" };
                else
                    return new RespMessage { message = doc.delv_img };
            }
            catch (Exception ex)
            {
                return new RespMessage
                {
                    message = ex.ToString()
                };
            }
        }

        public RespMessage updateDelivery(string delv_id, string v_id)
        {
            try
            {
                con = new SqlConnection(constr);
                cmd = new SqlCommand("usp_update_status", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@iDelvId", Convert.ToInt32(delv_id));
                cmd.Parameters.AddWithValue("@iVid", Convert.ToInt32(v_id));
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);
                if(dt.Rows.Count > 0)
                {
                    string message = dt.Rows[0]["message"].ToString();
                    if (message.Trim() == "Success")
                        return new RespMessage { message = "Status updated" };
                    else
                        return new RespMessage { message = "Something went wrong" };
                }
                return new RespMessage { message = "Something went wrong" };
              
            }
            catch(Exception ex)
            {
                return new RespMessage { message = ex.ToString()};
            }
        }

        public RespMessage updateLocation(string d_id, string lat, string lon)
        {
            try
            {
                con = new SqlConnection(constr);
                cmd = new SqlCommand("usp_update_location", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@iDid", Convert.ToInt32(d_id));
                cmd.Parameters.AddWithValue("@iLat", Convert.ToDouble(lat));
                cmd.Parameters.AddWithValue("@iLon", Convert.ToDouble(lon));
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                    return new RespMessage { message = dt.Rows[0]["message"].ToString() };
                else
                    return new RespMessage { message = "Something went wrong" };
            }
            catch(Exception ex)
            {
                return new RespMessage { message = ex.ToString() };
            }
        }
    }
}
