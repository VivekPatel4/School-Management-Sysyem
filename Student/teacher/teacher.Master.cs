using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.teacher
{
    public partial class teacher : System.Web.UI.MasterPage
    {
        protected int LeaveUnreadCount = 0;
        protected int BirthdayCount = 0;
        protected DataTable LeaveResults = new DataTable();
        protected DataTable BirthdayResults = new DataTable();
        string connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                conn.Open();

                string leaveSql = @"
                SELECT leaves.id as lid, 
                       students.FirstName, 
                       students.LastName, 
                       students.stdid, 
                       leaves.PostingDate 
                FROM leaves 
                JOIN students ON leaves.stdid = students.id 
                WHERE leaves.IsRead = @IsRead";

                using (SqlCommand cmd = new SqlCommand(leaveSql, conn))
                {
                    cmd.Parameters.AddWithValue("@IsRead", 0);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(LeaveResults);
                        LeaveUnreadCount = LeaveResults.Rows.Count;
                    }
                }

                string currentMonthDay = DateTime.Now.ToString("MM-dd");
                string birthdaySql = "SELECT * FROM remainder WHERE FORMAT(wishyear, 'MM-dd') = @CurrentMonthDay";

                using (SqlCommand cmd = new SqlCommand(birthdaySql, conn))
                {
                    cmd.Parameters.AddWithValue("@CurrentMonthDay", currentMonthDay);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(BirthdayResults);
                        BirthdayCount = BirthdayResults.Rows.Count;
                    }
                }
            }

            if (!IsPostBack)
            {
                if (Session["tid"] == null)
                {
                    Response.Redirect("../teacher/login.aspx");
                }
                else
                {
                    Loaddata();
                }
            }
        }

        private void Loaddata()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string query = "SELECT FirstName, LastName,photo FROM teacher WHERE id = @tid";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@tid", Session["tid"]);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    Session["FirstName"] = reader["FirstName"].ToString();
                    Session["LastName"] = reader["LastName"].ToString();
                    lblstdDetails.Text = $"<p style='color:white; font-size: 15px;'>{reader["FirstName"]} {reader["LastName"]}</p>";
                }
                reader.Close();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("tid");
            Session.Remove("tlogin");
            Response.Redirect("../teacher/login.aspx");
        }
    }
}

