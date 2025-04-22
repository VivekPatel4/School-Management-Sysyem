using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Student.teacher
{
    public partial class schedule : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["tid"] == null)
                {
                    Response.Redirect("../teacher/login.aspx");
                }
                else
                {
                    LoadSchedule();
                }
            }
        }

        private void LoadSchedule()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = "SELECT s.Subject, s.Class, CONVERT(VARCHAR, s.StartTime, 100) AS StartTime, CONVERT(VARCHAR, s.EndTime, 100) AS EndTime " +
                           "FROM Schedule s " +
                           "WHERE s.TeacherID = @TeacherID " +
                           "ORDER BY s.StartTime";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@TeacherID", Session["tid"]);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                repeaterSchedule.DataSource = dt;
                repeaterSchedule.DataBind();
            }
        }


        public int count(string className)
        {
            int totalStudents = 0;

            string query = "SELECT COUNT(*) FROM dbo.students WHERE Department = @ClassName";

            using (SqlConnection conn = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ClassName", className);
                conn.Open();

                totalStudents = (int)cmd.ExecuteScalar();
            }

            return totalStudents;
        }


        protected void btnShowStudents_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string className = btn.CommandArgument;

            DataTable dtStudents = GetStudentsByClass(className);

            repeaterStudents.DataSource = dtStudents;
            repeaterStudents.DataBind();

            panelStudents.Visible = true;
        }

        private DataTable GetStudentsByClass(string className)
        {
            DataTable dt = new DataTable();
            string query = "SELECT stdid,FirstName +' '+ LastName As StudentName, EmailId FROM dbo.students WHERE Department = @ClassName";

            using (SqlConnection conn = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ClassName", className);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(dt);
            }

            return dt;
        }

        protected void invisible_Click(object sender, EventArgs e)
        {
            panelStudents.Visible = false;
        }

        protected void timerRefresh_Tick(object sender, EventArgs e)
        {
            string className = ViewState["CurrentClass"] as string;
            if (!string.IsNullOrEmpty(className))
            {
                LoadAttendanceData(className);
            }
        }

        protected void btnStartAttendance_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string className = btn.CommandArgument;
            ViewState["CurrentClass"] = className; 
            hfClassName.Value = className;

            string updateQuery = "UPDATE Schedule SET IsAttendanceActive = 1 WHERE Class = @Class";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.AddWithValue("@Class", className);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadAttendanceData(className);
        }

        private void LoadAttendanceData(string className)
        {
            string studentQuery = "SELECT stdid, FirstName + ' ' + LastName AS StudentName, status, Class " +
                                  "FROM attendance " +
                                  "WHERE Class = @Class AND D = CAST(GETDATE() AS DATE)";

            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(studentQuery, con))
                {
                    cmd.Parameters.AddWithValue("@Class", className);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }
            repeaterAttendance.DataSource = dt;
            repeaterAttendance.DataBind();
            panelAttendance.Visible = true;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "openPopup", "openAttendancePopup();", true);
        }

        protected void btnEndAttendance_Click(object sender, EventArgs e)
        {
            timerRefresh.Enabled = false;
            string className = hfClassName.Value;

            string query = "UPDATE Schedule SET IsAttendanceActive = 0 WHERE Class = @Class";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Class", className);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            LoadSchedule();
        }
    }
}