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
    public partial class subject : System.Web.UI.Page
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
                    BindSubjectData();
                }
            }
        }

        private void BindSubjectData()
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM subject", con))
                {
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        SubjectRepeater.DataSource = dt;
                        SubjectRepeater.DataBind();
                    }
                }
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void SubjectRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {

                int subjectId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"edit-subject.aspx?subid={subjectId}");
            }
            else if (e.CommandName == "Delete")
            {

                using (SqlConnection conn = new SqlConnection(connect))
                {
                    string query = "DELETE FROM subject WHERE id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", e.CommandArgument);
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            SuccessPanel.Visible = true;
                            SuccessMessage.Text = "<script> alert('Subject deleted successfully.')</script>" + "Subject deleted successfully.";
                        }
                        else
                        {
                            ErrorPanel.Visible = true;
                            ErrorMessage.Text = "Error deleting Subject.";
                        }

                        BindSubjectData();
                        conn.Close();
                    }
                }
            }
        }

        protected void AddSubjectButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("add-subject.aspx");
        }
    }
}