using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.SqlServer.Server;
using System.Windows.Controls.Primitives;
using System.Windows.Controls;

namespace Student.admin
{
    public partial class schedule : System.Web.UI.Page
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
                    LoadTeacher();
                    LoadClass();
                    LoadScheduleData();

                    for (int hour = 1; hour <= 12; hour++)
                    {
                        ddlStartHours.Items.Add(new ListItem(hour.ToString("D2"), hour.ToString()));
                        ddlEndHours.Items.Add(new ListItem(hour.ToString("D2"), hour.ToString()));
                    }


                    for (int minute = 0; minute < 60; minute += 5)
                    {
                        ddlStartMinutes.Items.Add(new ListItem(minute.ToString("D2"), minute.ToString()));
                        ddlEndMinutes.Items.Add(new ListItem(minute.ToString("D2"), minute.ToString()));
                    }
                }
            }
        }

        private void LoadScheduleData()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                String q = @"SELECT s.id, t.FirstName + ' ' + t.LastName AS TeacherName, s.Subject, s.Class,
                             CONVERT(VARCHAR, s.StartTime, 100) AS StartTime,
                             CONVERT(VARCHAR, s.EndTime, 100) AS EndTime         
                           FROM
                             Schedule s
                           INNER JOIN
                             teacher t ON s.TeacherID = t.id
                           ORDER BY
                             s.StartTime";

                SqlCommand cmd = new SqlCommand(q, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ScheduleRepeater.DataSource = dt;
                ScheduleRepeater.DataBind();
            }
        }

        private void LoadClass()
        {
            using (SqlConnection conn = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("select * from departments", conn);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "DepartmentName";
                ddlClass.DataBind();
            }
        }

        private void LoadTeacher()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string q = "SELECT *, FirstName + ' ' + LastName AS FullName FROM teacher";
                SqlCommand cmd = new SqlCommand(q, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ddlTeacher.DataSource = dt;
                ddlTeacher.DataValueField = "id";
                ddlTeacher.DataTextField = "FullName";
                ddlTeacher.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }
        protected void ddlTeacher_SelectedIndexChanged(object sender, EventArgs e)
        {
            string teacherId = ddlTeacher.SelectedValue;

            if (!string.IsNullOrEmpty(teacherId))
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    string query = "SELECT subject FROM teacher WHERE id = @id";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@id", teacherId);
                    con.Open();
                    object subject = cmd.ExecuteScalar();
                    con.Close();

                    if (subject != null)
                    {
                        txtSubject.Text = subject.ToString();
                    }
                    else
                    {
                        txtSubject.Text = "";
                    }
                }
            }
            else
            {
                txtSubject.Text = "";
            }
        }

        protected void btnAddSchedule_Click(object sender, EventArgs e)
        {
            try
            {

                int teacherID = Convert.ToInt32(ddlTeacher.SelectedValue);
                string subject = txtSubject.Text;
                string className = ddlClass.SelectedValue;


                string startTime = $"{ddlStartHours.SelectedValue}:{ddlStartMinutes.SelectedValue} {ddlStartAmPm.SelectedValue}";
                TimeSpan start = DateTime.Parse(startTime).TimeOfDay;


                string endTime = $"{ddlEndHours.SelectedValue}:{ddlEndMinutes.SelectedValue} {ddlEndAmPm.SelectedValue}";
                TimeSpan end = DateTime.Parse(endTime).TimeOfDay;


                if (start >= end)
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Start time must be earlier than end time.";
                    return;
                }


                string query = "INSERT INTO Schedule (TeacherID, Subject, Class, StartTime, EndTime) VALUES (@TeacherID, @Subject, @Class, @StartTime, @EndTime)";
                using (SqlConnection con = new SqlConnection(connect))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@TeacherID", teacherID);
                        cmd.Parameters.AddWithValue("@Subject", subject);
                        cmd.Parameters.AddWithValue("@Class", className);
                        cmd.Parameters.AddWithValue("@StartTime", start);
                        cmd.Parameters.AddWithValue("@EndTime", end);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }


                SuccessPanel.Visible = true;
                SuccessMessage.Text = "Schedule added successfully.";
                LoadScheduleData();
                ClearForm();
            }
            catch (Exception ex)
            {

                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Error: " + ex.Message;
            }
        }

        private void ClearForm()
        {
            ddlTeacher.SelectedIndex = 0;
            txtSubject.Text = string.Empty;
            ddlClass.SelectedIndex = 0;
            ddlStartHours.SelectedIndex = 0;
            ddlStartMinutes.SelectedIndex = 0;
            ddlStartAmPm.SelectedIndex = 0;
            ddlEndHours.SelectedIndex = 0;
            ddlEndMinutes.SelectedIndex = 0;
            ddlEndAmPm.SelectedIndex = 0;
        }

        protected void ScheduleRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName == "Delete")
            {
                SqlConnection con = new SqlConnection(connect);
                SqlCommand cmd = new SqlCommand("delete from Schedule where id=@id", con);
                cmd.Parameters.AddWithValue("@id", e.CommandArgument);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                if (r == 0)
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Schedule Not Deleted Please Try Again";
                }
                else
                {
                    SuccessPanel.Visible = true;
                    SuccessMessage.Text =  "Schedule deleted successfully.";
                }
                LoadScheduleData();
                con.Close();
            }
        }
    }
}