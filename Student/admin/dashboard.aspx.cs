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
    public partial class dashboard : System.Web.UI.Page
    {
        String connect = WebConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["alogin"] == null)
            {
                Response.Redirect("../admin/login.aspx");
            }
            else
            {
                string currentDate = DateTime.Now.ToString("yyyy-MM-dd");

                int StudentCount = GetStudentCount();
                int noLeaveCount = GetNoLeaveCount(currentDate);
                int LeaveCount = GetLeaveCount(currentDate);
                int TeacherCount = GetTeacherCount();
                int ClassCount = GetClassCount();
                int PendingCount = GetPendingCount();
                int DeclinedCount = GetDeclinedCount();
                int ApproveCount = GetApproveCount();
                int SubjectCount = GetSubjectCount();

                lblNoLeaveCount.Text = noLeaveCount.ToString();
                lblleavecount.Text = LeaveCount.ToString();
                lblStudentCount.Text = StudentCount.ToString();
                lblTeacherCount.Text = TeacherCount.ToString();
                lblClassCount.Text = ClassCount.ToString();
                lblDeclinedCount.Text = DeclinedCount.ToString();
                lblApproveCount.Text = ApproveCount.ToString();
                lblSubjectCount.Text=SubjectCount.ToString();
                lblPendingCount.Text = PendingCount.ToString();
            }
        }

        private int GetSubjectCount()
        {
            int SubjectCount = 0;
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = @"select COUNT(id) from subject";
                using (SqlCommand cmd = new SqlCommand(q, con))
                {
                    con.Open();
                    SubjectCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                return SubjectCount;

            }
        }

        private int GetApproveCount()
        {
            int ApproveCount = 0;
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = @"select COUNT(id) from leaves where Status=1";
                using (SqlCommand cmd = new SqlCommand(q, con))
                {
                    con.Open();
                    ApproveCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                return ApproveCount;
            }
        }

        private int GetDeclinedCount()
        {
            int DeclinedCount = 0;
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = @"select COUNT(id) from leaves where Status=2";
                using (SqlCommand cmd = new SqlCommand(q, con))
                {
                    con.Open();
                    DeclinedCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                return DeclinedCount;
            }
        }

        private int GetPendingCount()
        {
            int PendingCount = 0;
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = @"select COUNT(id) from leaves where Status=0";
                using (SqlCommand cmd = new SqlCommand(q, con))
                {
                    con.Open();
                    PendingCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                return PendingCount;
            }
        }

        private int GetClassCount()
        {
            int ClassCount = 0;
            using(SqlConnection con = new SqlConnection(connect))
            {
                string q = @"select COUNT(id) from departments";
                using(SqlCommand cmd=new SqlCommand(q, con))
                {
                    con.Open();
                    ClassCount=Convert.ToInt32(cmd.ExecuteScalar());
                }
                return ClassCount;
            }
        }

        private int GetTeacherCount()
        {
            int TeacherCount = 0;
            using(SqlConnection conn = new SqlConnection(connect))
            {
                string q = @"select COUNT(id) from teacher";
                using (SqlCommand cmd = new SqlCommand(q, conn))
                {
                    conn.Open();
                    TeacherCount=Convert.ToInt32(cmd.ExecuteScalar());
                }
                return TeacherCount;
            }
        }

        private int GetStudentCount()
        {
            int StudentCount = 0;
            using(SqlConnection conn = new SqlConnection(connect))
            {
                string q = @"select COUNT(id) from students";
                using(SqlCommand cmd = new SqlCommand(q, conn))
                {
                    conn.Open();
                    StudentCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
                return StudentCount;
            }
        }

        private int GetLeaveCount(string currentDate)
        {
            int LeaveCount = 0;
            using(SqlConnection conn = new SqlConnection(connect))
            {
                string query = @"SELECT COUNT(*) AS leaveCount FROM leaves 
                                  JOIN students ON leaves.stdid = students.id 
                                  WHERE @currentDate BETWEEN leaves.FromDate AND leaves.ToDate 
                                  AND leaves.status = 1 
                                  AND NOT EXISTS (
                                  SELECT 1 FROM leaves AS l2 
                                  WHERE l2.stdid = leaves.stdid 
                                  AND l2.status = 1 
                                  AND @currentDate BETWEEN l2.FromDate AND l2.ToDate 
                                  AND l2.id > leaves.id)";
                using(SqlCommand cmd = new SqlCommand(query,conn))
                {
                    cmd.Parameters.AddWithValue("@currentDate", currentDate);
                    conn.Open();
                    LeaveCount=Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            return LeaveCount;
        }

        private int GetNoLeaveCount(string currentDate)
        {
            int noLeaveCount = 0;

            using (SqlConnection conn = new SqlConnection(connect))
            {
                string query = @"
                SELECT COUNT(*) AS noLeaveCount 
                FROM students 
                LEFT JOIN leaves ON students.id = leaves.stdid 
                AND @currentDate BETWEEN leaves.FromDate AND leaves.ToDate 
                AND leaves.status = 1 
                WHERE (@currentDate NOT BETWEEN leaves.FromDate AND leaves.ToDate OR leaves.id IS NULL)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@currentDate", currentDate);
                    conn.Open();
                    noLeaveCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            return noLeaveCount;
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }


    }
}