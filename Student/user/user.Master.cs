using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Student.admin;

namespace Student.user
{
    public partial class user : System.Web.UI.MasterPage
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadData();
        }

        private void LoadData()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string query = "SELECT FirstName, LastName, stdid,photo FROM students WHERE id = @sid";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@sid", Session["sid"]);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    Session["FirstName"] = reader["FirstName"].ToString();
                    Session["LastName"] = reader["LastName"].ToString();
                    lblstdDetails.Text = $"<p style='color:white; font-size: 15px;'>{reader["FirstName"]} {reader["LastName"]}</p><span style='color: white; font-weight: bold; font-size: 20px;'>{reader["stdid"]}</span>";
                }
                reader.Close();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("sid");
            Session.Remove("stdlogin");
            Response.Redirect("../user/login.aspx");

        }

    }
}