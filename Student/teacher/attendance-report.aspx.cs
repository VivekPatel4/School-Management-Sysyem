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
    public partial class attendance_report : System.Web.UI.Page
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
                    Loadstudent();
                    LoadClasses();
                }
            }
        }

        private void LoadClasses()
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT DISTINCT Class FROM attendance", conn);
                SqlDataReader dr = cmd.ExecuteReader();

                ddlClass.DataSource = dr;
                ddlClass.DataTextField = "Class";
                ddlClass.DataValueField = "Class";
                ddlClass.DataBind();
            }
        }

        private void Loadstudent()
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT id, FirstName + ' ' + LastName AS FullName FROM students", conn);
                SqlDataReader dr = cmd.ExecuteReader();

                ddlStudents.DataSource = dr;
                ddlStudents.DataTextField = "FullName";
                ddlStudents.DataValueField = "id";
                ddlStudents.DataBind();
            }
        }

        protected void btnFetch_Click(object sender, EventArgs e)
        {
            string studentId = ddlStudents.SelectedValue;
            string className = ddlClass.SelectedValue;

            using (SqlConnection conn = new SqlConnection(connect))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"
                SELECT FirstName, LastName, Class, status, date, dayname
                FROM attendance
                WHERE student_id = @studentId AND Class = @className
                ORDER BY date DESC", conn);

                cmd.Parameters.AddWithValue("@studentId", studentId);
                cmd.Parameters.AddWithValue("@className", className);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptAttendance.DataSource = dt;
                    rptAttendance.DataBind();
                }
                else
                {
                    rptAttendance.DataSource = null;
                    rptAttendance.DataBind();
                }
            }
        }
    }
}