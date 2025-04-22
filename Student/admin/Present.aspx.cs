using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.admin
{
    public partial class Present : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["alogin"] == null)
                {
                    Response.Redirect("../admin/login.aspx");
                }
                else
                {
                    LoadPresentData();
                }
            }
        }

        private void LoadPresentData()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                TimeZoneInfo indianZone = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");

                DateTime currentDateTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, indianZone);

                string currentDate = currentDateTime.ToString("yyyy-MM-dd");

                string q = @"SELECT students.id,
                           students.photo,
                           students.FirstName,
                           students.LastName,
                           students.stdid 
                           FROM students LEFT JOIN leaves ON students.id = leaves.stdid 
                           AND @currentDate BETWEEN leaves.FromDate 
                           AND leaves.ToDate AND leaves.Status = 1 
                           WHERE (@currentDate NOT BETWEEN leaves.FromDate AND leaves.ToDate OR leaves.id IS NULL)";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@currentDate", currentDate);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt=new DataTable();
                sda.Fill(dt);
                rptpresent.DataSource= dt;
                rptpresent.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected string GetImageUrl(string photo)
        {
            if (!string.IsNullOrEmpty(photo))
            {
                return ResolveUrl(photo);
            }
            return ResolveUrl("~/admin/images/no_image.png");
        }
    }
}