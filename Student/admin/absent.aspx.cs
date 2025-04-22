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
    public partial class absent : System.Web.UI.Page
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
                    LoadAbsentData();
                }
            }
        }

        private void LoadAbsentData()
        {
            using(SqlConnection con = new SqlConnection(connect))
            {
                TimeZoneInfo indianZone = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");

                DateTime currentDateTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, indianZone);

                string currentDate = currentDateTime.ToString("yyyy-MM-dd");

                string q = @"SELECT students.id, 
                        students.photo, 
                        students.FirstName, 
                        students.LastName, 
                        students.stdid, 
                        leaves.LeaveType, 
                        leaves.FromDate, 
                        leaves.ToDate 
                FROM leaves 
                JOIN students ON leaves.stdid = students.id 
                WHERE @currentDate BETWEEN leaves.FromDate AND leaves.ToDate 
                    AND leaves.Status = 1 
                    AND NOT EXISTS (
                        SELECT 1 FROM leaves AS l2 
                        WHERE l2.stdid = leaves.stdid 
                            AND l2.status = 1 
                            AND @currentDate BETWEEN l2.FromDate AND l2.ToDate 
                            AND l2.id > leaves.id
                    )";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@currentDate", currentDate);
                con.Open();
                SqlDataAdapter sda=new SqlDataAdapter(cmd);
                DataTable dt=new DataTable();
                sda.Fill(dt);
                rptabsent.DataSource = dt;
                rptabsent.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected String GetImageUrl(String photo)
        {
            if (!String.IsNullOrEmpty(photo))
            {
                return ResolveUrl(photo);
            }
            return ResolveUrl("~/admin/images/no_image.png");
        }
    }
}