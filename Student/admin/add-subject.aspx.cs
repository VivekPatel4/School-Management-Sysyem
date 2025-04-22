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
    public partial class add_subject : System.Web.UI.Page
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
            }
        }

        protected void LinkButtonLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("alogin");
            Response.Redirect("../admin/login.aspx");
        }

        protected void btnsubject_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                String q = "insert into subject(SubjectName,SubjectShortName,SubjectCode,CreationDate) values('" + txtsubname.Text + "','" + txtshortform.Text + "','" + txtcode.Text + "',GETDATE())";
                SqlCommand cmd = new SqlCommand(q, con);
                con.Open();
                int r = cmd.ExecuteNonQuery();
                if (r == 0)
                {
                    ErrorPanel.Visible = true;
                    ErrorMessage.Text = "Subject Not Insert Please Try again";
                }
                else
                {
                    SuccessPanel.Visible = true;
                    SuccessMessage.Text = "<script> alert('Subject Add successfully.')</script>" + "Subject Add successfully";
                }
                con.Close();
                Clear();
            }
        }

        private void Clear()
        {
            txtsubname.Text=String.Empty;
            txtshortform.Text=String.Empty;
            txtcode.Text=String.Empty;  
        }
    }
}