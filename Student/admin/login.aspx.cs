using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class login : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["alogin"] != null)
            {
                Response.Redirect("dashboard.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string encryptedPassword = EncryptPassword(password);
            using (SqlConnection conn = new SqlConnection(connect))
            {
                string sql = "SELECT UserName, Password FROM admin WHERE UserName = @username AND Password = @password";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@password", encryptedPassword);

                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        
                        Session["alogin"] = username;
                        Response.Redirect("dashboard.aspx");
                    }
                    else
                    {
                        
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Invalid Details');", true);
                    }
                }
            }
        }

        private string EncryptPassword(string password)
        {
            return password;
        }
    }
    }
