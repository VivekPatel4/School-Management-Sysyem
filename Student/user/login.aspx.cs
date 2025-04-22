using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Google.Apis.Auth;
using System.Threading.Tasks;

namespace Student
{
    public partial class login : System.Web.UI.Page
    {
        string connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string credential = Request.Form["credential"];
                if (!string.IsNullOrEmpty(credential))
                {
                    try
                    {
                        var payload = GoogleJsonWebSignature.ValidateAsync(credential).Result;
                        string email = payload.Email;
                        
                        // Use the same login logic but with Google email
                        string sql = "SELECT EmailId, Status, id FROM students WHERE EmailId=@email";
                        using (SqlConnection conn = new SqlConnection(connect))
                        {
                            using (SqlCommand cmd = new SqlCommand(sql, conn))
                            {
                                cmd.Parameters.AddWithValue("@email", email);
                                conn.Open();
                                SqlDataReader reader = cmd.ExecuteReader();

                                if (reader.HasRows)
                                {
                                    while (reader.Read())
                                    {
                                        int status = Convert.ToInt32(reader["Status"]);
                                        int userId = Convert.ToInt32(reader["id"]);

                                        if (status == 0)
                                        {
                                            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('In-Active Account. Please contact administrator!');", true);
                                        }
                                        else
                                        {
                                            Session["sid"] = userId;
                                            Session["stdlogin"] = email;
                                            ScriptManager.RegisterStartupScript(this, GetType(), "success", 
                                                "alert('Login successful!'); window.location.href='leave.aspx';", true);
                                        }
                                    }
                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", 
                                        "alert('This Google account is not registered as a student. Please use your registered email.');", true);
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Google Sign-In failed. Please try again.');", true);
                    }
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            string sql = "SELECT EmailId, Password, Status, id FROM students WHERE EmailId=@username AND Password=@password";
            using (SqlConnection conn = new SqlConnection(connect))
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@password", password);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            int status = Convert.ToInt32(reader["Status"]);
                            int userId = Convert.ToInt32(reader["id"]);


                            if (status == 0)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('In-Active Account. Please contact your administrator!');", true);

                            }
                            else
                            {
                                Session["sid"] = userId;
                                Session["stdlogin"] = username;
                                Response.Redirect("leave.aspx");
                            }
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid Details');", true);
                    }
                }
            }
        }
    }
}