using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace Student.user
{
    public partial class TimeTable : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sid"] == null)
            {
                Response.Redirect("../user/login.aspx");
            }
            else
            {
                LoadSchedule();
            }
        }

        private void LoadSchedule()
        {
            string studentId = Session["sid"]?.ToString();

            using (SqlConnection con = new SqlConnection(connect))
            {
                string query = @"
                    SELECT 
                        t.FirstName +' '+t.LastName AS TeacherName, 
                        s.Subject, 
                        s.Class,
                        s.IsAttendanceActive,
                        CONVERT(VARCHAR, s.StartTime, 100) AS StartTime, 
                        CONVERT(VARCHAR, s.EndTime, 100) AS EndTime
                    FROM Schedule s
                    INNER JOIN Teacher t ON s.TeacherID = t.id
                    INNER JOIN Students st ON s.Class = st.Department
                    WHERE st.id = @StudentID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@StudentID", studentId);
                    con.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        StudentScheduleRepeater.DataSource = dt;
                        StudentScheduleRepeater.DataBind();
                    }
                }
            }
        }

        protected void btnMarkAttendance_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string className = btn.CommandArgument;

            if (!string.IsNullOrEmpty(className))
            {
                Response.Redirect($"../user/match-face.aspx?class={className}");
            }
            else
            {
                Response.Write("<script>alert('Class name is missing.');</script>");
            }
        }
    }
}