using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace Student.admin
{
    public partial class teacher : System.Web.UI.Page
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
                    BindTeacherData();
                }
            }
        }

        private void BindTeacherData()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("select * from teacher", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                TeacherRepeater.DataSource = dt;
                TeacherRepeater.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void AddTeachertbtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("add-teacher.aspx");
        }

        protected void TeacherRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                int tid = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"edit-teacher.aspx?teacherid={tid}");
            }
            else if (e.CommandName == "Delete")
            {
                SqlConnection con = new SqlConnection(connect);
                SqlCommand cmd = new SqlCommand("delete from teacher where id=@id", con);
                cmd.Parameters.AddWithValue("@id", e.CommandArgument);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                if (r == 0)
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Teacher Not Deleted Please Try Again";
                }
                else
                {
                    SuccessPanel.Visible = true;
                    SuccessMessage.Text = "<script> alert('Teacher deleted successfully.')</script>" + "Teacher deleted successfully.";
                }
                BindTeacherData();
                con.Close();
            }
            else if (e.CommandName == "Deactivate")
            {
                int tid = Convert.ToInt32(e.CommandArgument);
                UpdateStudentStatus(tid, false);
            }
            else if (e.CommandName == "Activate")
            {
                int tid = Convert.ToInt32(e.CommandArgument);
                UpdateStudentStatus(tid, true);
            }
            else if (e.CommandName == "View")
            {
                int tid = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"view-teacher.aspx?teacherid={tid}");
            }
        }

        private void UpdateStudentStatus(object tid, bool isActive)
        {
            SqlConnection conn = new SqlConnection(connect);
            string q = "UPDATE teacher SET Status = @Status WHERE id = @id";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.Parameters.AddWithValue("@Status", isActive);
            cmd.Parameters.AddWithValue("@id", tid);
            conn.Open();
            int r = cmd.ExecuteNonQuery();

            if (r > 0)
            {
                SuccessPanel.Visible = true;
                SuccessMessage.Text = isActive ? "Teacher activated successfully." : "Teacher deactivated successfully.";
            }
            else
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Error updating Teacher status.";
            }

            BindTeacherData();
        }
        protected string GetImageUrl(string photo)
        {
            if (!string.IsNullOrEmpty(photo))
            {
                return ResolveUrl(photo);
            }
            return ResolveUrl("~/admin/images/teacher/no_image.png");
        }

        protected string GetStatusButtonCssClass(object status)
        {
            bool isActive = Convert.ToBoolean(status);
            return isActive ? "btn btn-sm btn-danger" : "btn btn-sm btn-success";
        }

        protected string GetStatusCommandName(object status)
        {
            bool isActive = Convert.ToBoolean(status);
            return isActive ? "Deactivate" : "Activate";
        }

        protected string GetStatusOnClientClick(object status)
        {
            bool isActive = Convert.ToBoolean(status);
            return isActive
                ? "return confirm('Are you sure you want to inactive this Teacher?');"
                : "return confirm('Are you sure you want to active this Teacher?');";
        }

        protected string GetStatusIconClass(object status)
        {
            bool isActive = Convert.ToBoolean(status);
            return isActive ? "fa fa-times-circle" : "fa fa-check";
        }

        protected string GetStatusIconStyle(object status)
        {
            bool isActive = Convert.ToBoolean(status);
            return isActive ? "color:red" : "color:green";
        }
    }
}