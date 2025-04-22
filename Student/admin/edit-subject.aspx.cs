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
    public partial class edit_subject : System.Web.UI.Page
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
                    if (int.TryParse(Request.QueryString["subid"], out int subjectId))
                    {
                        LoadSubjectData(subjectId);
                    }
                    else
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Invalid subject ID.";
                    }
                }
            }
        }

        private void LoadSubjectData(int subjectId)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                string query = "SELECT SubjectName, SubjectShortName, SubjectCode FROM subject WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", subjectId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtsubname.Text = reader["SubjectName"].ToString();
                    txtshortform.Text = reader["SubjectShortName"].ToString();
                    txtcode.Text = reader["SubjectCode"].ToString();
                }
                else
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Subject data not found.";
                }
                con.Close();
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnsubject_Click(object sender, EventArgs e)
        {
            if (int.TryParse(Request.QueryString["subid"], out int subjectId))
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    string q = "UPDATE subject SET SubjectName = @SubjectName, SubjectShortName = @SubjectShortName, SubjectCode = @SubjectCode WHERE id = @id";
                    SqlCommand cmd = new SqlCommand(q, con);

                    cmd.Parameters.AddWithValue("@SubjectName", txtsubname.Text.Trim());
                    cmd.Parameters.AddWithValue("@SubjectShortName", txtshortform.Text.Trim());
                    cmd.Parameters.AddWithValue("@SubjectCode", txtcode.Text.Trim());
                    cmd.Parameters.AddWithValue("@id", subjectId);

                    con.Open();
                    int r = cmd.ExecuteNonQuery();

                    if (r > 0)
                    {
                        SuccessPanel.Visible = true;
                        SuccessMessage.Text = "<script> alert('Subject updated successfully.')</script>" + "Subject updated successfully.";
                    }
                    else
                    {
                        ErrorPanel.Visible = true;
                        ErrorMessage.Text = "Error updating Subject.";
                    }
                    con.Close();
                }
            }
            else
            {
                ErrorPanel.Visible = true;
                ErrorMessage.Text = "Invalid Subject ID.";
            }
        }
    }
}