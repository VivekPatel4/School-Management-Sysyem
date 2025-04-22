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
    public partial class today_hostel : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (Session["alogin"] == null)
                {
                    Response.Redirect("../admin/login.aspx");
                }
                else
                {
                    LoadTodayData();
                }
            }
        }

        private void LoadTodayData()
        {
            using(SqlConnection con=new SqlConnection(connect))
            {
                TimeZoneInfo indianZone = TimeZoneInfo.FindSystemTimeZoneById("India Standard Time");

                DateTime currentDateTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, indianZone);

                string currentDate = currentDateTime.ToString("yyyy-MM-dd");

                String q = @"SELECT leaves.id as lid,
                             students.photo,
                            students.FirstName,
                            students.LastName,
                            students.stdid,
                            students.id,
                            leaves.LeaveType,
                            leaves.PostingDate,
                            leaves.Status FROM leaves JOIN students ON leaves.stdid = students.id 
                            WHERE leaves.Status = @status AND ToDate = @currentdate ORDER BY lid DESC";
                SqlCommand cmd=new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@currentdate", currentDate);
                cmd.Parameters.AddWithValue("@status", 1);
                con.Open();
                SqlDataAdapter sda=new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                rpttoday.DataSource= dt;
                rpttoday.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }
        protected String GetImageUrl(String photo)
        {
            if(!String.IsNullOrEmpty(photo))
            {
                return ResolveUrl(photo);
            }
              return ResolveUrl("~/admin/images/no_image.png");
        }
    }
}