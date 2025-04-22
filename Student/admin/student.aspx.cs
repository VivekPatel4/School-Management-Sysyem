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
    public partial class student : System.Web.UI.Page
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
                BindStudentData();
            }
        }

        private void BindStudentData()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("select * from students", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                StudentRepeater.DataSource = dt;
                StudentRepeater.DataBind();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void AddStudentbtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("add-student.aspx");
        }

        protected void StudentRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                int sid = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"edit-student.aspx?studentid={sid}");
            }
            else if (e.CommandName == "Delete")
            {
                SqlConnection con = new SqlConnection(connect);
                SqlCommand cmd = new SqlCommand("delete from students where id=@id", con);
                cmd.Parameters.AddWithValue("@id", e.CommandArgument);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                if (r == 0)
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Student Not Deleted Please Try Again";
                }
                else
                {
                    SuccessPanel.Visible = true;
                    SuccessMessage.Text = "<script> alert('Student deleted successfully.')</script>" + "Student deleted successfully.";
                }
                BindStudentData();
                con.Close();
            }
            else if (e.CommandName == "Deactivate")
            {
                int sid = Convert.ToInt32(e.CommandArgument);
                UpdateStudentStatus(sid, false);
            }
            else if (e.CommandName == "Activate")
            {
                int sid = Convert.ToInt32(e.CommandArgument);
                UpdateStudentStatus(sid, true);
            }
            else if(e.CommandName == "View")
            {
                int sid= Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"view-student.aspx?studentid={sid}");
            }
        }

        private void UpdateStudentStatus(object sid, bool isActive)
        {
            SqlConnection conn = new SqlConnection(connect);
            string q = "UPDATE students SET Status = @Status WHERE id = @id";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.Parameters.AddWithValue("@Status", isActive);
            cmd.Parameters.AddWithValue("@id", sid);
            conn.Open();
            int r = cmd.ExecuteNonQuery();

            if (r > 0)
            {
                SuccessPanel.Visible = true;
                SuccessMessage.Text = isActive ? "Student activated successfully." : "Student deactivated successfully.";
            }
            else
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Error updating student status.";
            }

            BindStudentData();
        }

        protected string GetImageUrl(string photo)
        {
            if (!string.IsNullOrEmpty(photo))
            {
                return ResolveUrl(photo);
            }
            return ResolveUrl("~/admin/images/no_image.png");
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
                ? "return confirm('Are you sure you want to inactive this student?');"
                : "return confirm('Are you sure you want to active this student?');";
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

        
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("birthdate.aspx");
        }
    }
}